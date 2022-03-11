// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
// import 'package:the_movie_app_by_myself/network/dataagents/movie_data_agent.dart';
//
// import '../api_constants.dart';
//
// class DioMovieDataAgentImpl extends MovieDataAgent {
//   @override
//   Future<List<MovieVO>?> getNowPlayingMovies(int page) {
//     Map<String, String> queryParameters = {
//       PARAM_API_KEY: API_KEY,
//       PARAM_LANGUAGE: LANGUAGE_EN_US,
//       PARAM_PAGE: page.toString(),
//     };
//     return Dio()
//         .get("$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
//             queryParameters: queryParameters)
//         .then((value) {
//       debugPrint("Now Playing Movies ================> ${value.toString()}");
//     }).catchError((error) {
//       debugPrint("Error ============> ${error.toString()}");
//     });
//   }
// }
