import 'dart:convert';

import 'package:nasa_api/nasa_api.dart';

QueryByMartianSol queryByMartianSolFromJson(String str) =>
    QueryByMartianSol.fromJson(json.decode(str));

String queryByMartianSolToJson(QueryByMartianSol data) =>
    json.encode(data.toJson());

class QueryByMartianSol {
  const QueryByMartianSol({
    required this.photos,
  });

  final List<Photo> photos;

  factory QueryByMartianSol.fromJson(Map<String, dynamic> json) =>
      QueryByMartianSol(
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
