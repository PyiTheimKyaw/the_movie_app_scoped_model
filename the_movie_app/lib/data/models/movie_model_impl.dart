import 'package:stream_transform/stream_transform.dart';
import 'package:the_movie_app_by_myself/data/models/movie_model.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/genre_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
import 'package:the_movie_app_by_myself/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_app_by_myself/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:the_movie_app_by_myself/persistence/daos/actor_dao.dart';
import 'package:the_movie_app_by_myself/persistence/daos/genre_dao.dart';
import 'package:the_movie_app_by_myself/persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel {
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal() {
    getNowPlayingMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getActors(1);
    getActorsFromDatabase();
    getGenres();
    getGenresFromDatabase();
  }

  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  ///Dao
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  ///Home Page State
  List<MovieVO>? mNowPlayingMovies;
  List<MovieVO>? mPopularMovies;
  List<MovieVO>? mTopRatedMovies;
  List<MovieVO>? mMoviesByGenre;
  List<GenreVO>? mGenresList;
  List<ActorVO>? mActors;

  ///Movie Details Page State Variables
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;

  ///Network
  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies?.map((movie) {
            movie.isNowPlaying = true;
            movie.isPopular = false;
            movie.isTopRated = false;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(nowPlayingMovies);
      mNowPlayingMovies = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies?.map((movie) {
            movie.isNowPlaying = false;
            movie.isPopular = true;
            movie.isTopRated = false;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(popularMovies);
      mPopularMovies = popularMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies?.map((movie) {
            movie.isNowPlaying = false;
            movie.isPopular = false;
            movie.isTopRated = true;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(topRatedMovies);
      mTopRatedMovies = topRatedMovies;
      notifyListeners();
    });
  }

  @override
  void getActors(int page) {
    _dataAgent.getActors(1).then((actors) async {
      mActorDao.saveAllActors(actors ?? []);
      mActors = actors;
      notifyListeners();
      return Future.value(actors);
    });
  }

  @override
  void getGenres() {
    _dataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres ?? []);
      mGenresList = genres;
      getMoviesByGenre(genres?.first.id ?? 0);
      notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  void getMoviesByGenre(int genreId) {
    _dataAgent.getMoviesByGenre(genreId).then((moviesList) {
      mMoviesByGenre = moviesList;
      notifyListeners();
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
    _dataAgent.getCreditsByMovie(movieId).then((castAndCrew){
      cast = castAndCrew.first;
      crew = castAndCrew[1];
      notifyListeners();
    });
  }

  @override
  void getMovieDetails(int movieId) {
    _dataAgent.getMovieDetails(movieId).then((movie) async {
      mMovieDao.saveSingleMovie(movie!);
      movieDetails=movie;
      notifyListeners();
      return Future.value(movie);
    });
  }

  ///Database
  @override
  void getActorsFromDatabase() {
    mActors = mActorDao.getAllActors();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    mGenresList = mGenreDao.getAllGenres();
    notifyListeners();
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    movieDetails=mMovieDao.getMovieById(movieId);
    notifyListeners();
  }

  @override
  void getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies())
        .listen((nowPlayingMovies) {
      mNowPlayingMovies = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies())
        .listen((popularMovies) {
      mPopularMovies = popularMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies())
        .listen((topRatedMovies) {
      mTopRatedMovies = topRatedMovies;
      notifyListeners();
    });
  }
}
