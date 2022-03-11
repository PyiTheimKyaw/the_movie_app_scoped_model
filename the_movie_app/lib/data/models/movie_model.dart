import 'package:scoped_model/scoped_model.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/genre_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';

abstract class MovieModel extends Model {
  ///Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  void getGenres();
  void getMoviesByGenre(int genreId);
  void getActors(int page);
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);

  ///Database
  void getTopRatedMoviesFromDatabase();
  void getNowPlayingMoviesFromDatabase();
  void getPopularMoviesFromDatabase();
  void getGenresFromDatabase();
  void getActorsFromDatabase();
  void getMovieDetailsFromDatabase(int movieId);



}
