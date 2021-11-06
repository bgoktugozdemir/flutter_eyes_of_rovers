import 'dart:convert';

import 'package:nasa_api/nasa_api.dart';

QueryByEarthDate queryByEarthDateFromJson(String str) =>
    QueryByEarthDate.fromJson(json.decode(str));

String queryByEarthDateToJson(QueryByEarthDate data) =>
    json.encode(data.toJson());

class QueryByEarthDate {
  const QueryByEarthDate({
    required this.photos,
  });

  final List<Photo> photos;

  factory QueryByEarthDate.fromJson(Map<String, dynamic> json) =>
      QueryByEarthDate(
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
