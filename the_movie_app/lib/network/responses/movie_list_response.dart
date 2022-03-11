import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_app_by_myself/data/vos/date_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
part 'movie_list_response.g.dart';
@JsonSerializable()
class MovieListResponse{
  @JsonKey(name: 'dates')
  DateVO? dates;
  @JsonKey(name: 'results')
  List<MovieVO>? results;
  @JsonKey(name: 'page')
  int? page;

  MovieListResponse(this.dates, this.results, this.page);

  factory MovieListResponse.fromJson(Map<String,dynamic> json) => _$MovieListResponseFromJson(json);
  Map<String,dynamic> toJson() => _$MovieListResponseToJson(this);

}