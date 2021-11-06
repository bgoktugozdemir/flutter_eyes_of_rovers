import 'dart:convert';

import 'package:nasa_repository/nasa_repository.dart';

MarsPhotos marsPhotosFromJson(String str) =>
    MarsPhotos.fromJson(json.decode(str));

String marsPhotosToString(MarsPhotos data) => json.encode(data.toJson());

class MarsPhotos {
  const MarsPhotos({
    required this.photos,
  });

  final List<Photo> photos;

  factory MarsPhotos.fromJson(Map<String, dynamic> json) => MarsPhotos(
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
