// @dart=2.9
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:the_movie_app_by_myself/data/models/movie_model_impl.dart';
import 'package:the_movie_app_by_myself/persistence/hive_constants.dart';

import 'data/vos/actor_vo.dart';
import 'data/vos/collection_vo.dart';
import 'data/vos/date_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/movie_vo.dart';
import 'data/vos/production_company_vo.dart';
import 'data/vos/production_country_vo.dart';
import 'data/vos/spoken_language_vo.dart';
import 'pages/home_page.dart';


void main()async {

  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
//Hive.registerAdapter(BaseActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
//Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MovieModelImpl(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //   visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

