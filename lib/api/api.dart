import 'dart:convert';
import 'dart:developer';

import 'package:flutflix/constants.dart';
import 'package:flutflix/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const _topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
  static const _upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const _popularUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}';
  static Map<String, dynamic>? movieDetails = {};
  static const genresUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.apiKey}';
  static List watchList = [];

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> getFilteredMovies(int id) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&with_genres=$id'));

    if (response.statusCode == 200) {
      log("${json.decode(response.body)['results']}");
      final decodedData = json.decode(response.body)['results'] as List;

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<dynamic>> fetchGenres() async {
    final response = await http.get(Uri.parse(genresUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['genres'] as List;
      return decodedData;
    } else {
      throw Exception('Something happened');
    }
  }

  Future<Map<String, dynamic>?> fetchMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}?api_key=${Constants.apiKey}'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      movieDetails = decodedData;
      return movieDetails;
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> fetchSimilarMovies(int movie_id) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${movie_id}/similar?api_key=${Constants.apiKey}'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&query=$query'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;

      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }
}
