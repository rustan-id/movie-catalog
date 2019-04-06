import 'dart:async';
import 'dart:collection';

import 'package:movie_catalog/services/storage_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:movie_catalog/bloc/bloc_provider.dart';
import 'package:movie_catalog/services/movie_service.dart';
import 'package:movie_catalog/models/movie.dart';

class SuggestionsBloc extends BlocBase {
  /// The [BehaviorSubject] is a [StreamController]
  /// The controller has the suggestions for the user
  BehaviorSubject<List<Movie>> _suggestionsController = new BehaviorSubject();

  /// The [Sink] is the input for the [_suggestionsController]
  Sink<List<Movie>> get suggestionsIn => _suggestionsController.sink;

  /// The [Stream] is the output for the [_suggestionsController]
  Stream<List<Movie>> get suggestionsOut => _suggestionsController.stream;

  // /// [PublishSubject] is the same as a [StreamController] but from the rxDart library
  // PublishSubject<MovieType> _fetchNextPageController = new PublishSubject();

  // /// The [Sink] is the input to increment the [_latestMoviesPage] or [_popularMoviesPage]
  // Sink<MovieType> get fetchNextPageIn => _fetchNextPageController.sink;

  /// Keeps track of the latest movies
  List<Movie> _suggestions = [];

  final MovieService _movieService = new MovieService();
  final StorageService _storageService = new StorageService();

  /// Keeps track if there is already a handle request in progress to protect from to many requests
  bool loading = false;

  SuggestionsBloc() {
    getSuggestions();
  }

  void dispose() {
    _suggestionsController.close();
  }

  void getSuggestions() async {
    loading = true;
    List<Movie> fetchedMovies;
    List<Movie> likedMovies = await _storageService.readFile();
    List<int> movieIds = likedMovies.map((movie) => movie.id).toList();

    fetchedMovies =
        await _movieService.fetchAllSuggestions(http.Client(), movieIds);
    _suggestions = UnmodifiableListView<Movie>(fetchedMovies);

    suggestionsIn.add(_suggestions);
  }
}
