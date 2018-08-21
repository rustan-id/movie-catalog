import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:movie_catalog/models/movie.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  String fileName = 'test.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/$fileName');
  }

}