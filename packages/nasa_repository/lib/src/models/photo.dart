import 'package:nasa_repository/nasa_repository.dart';

class Photo {
  const Photo({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
    required this.rover,
  });

  final int id;
  final int sol;
  final Camera camera;
  final String imgSrc;
  final DateTime earthDate;
  final Rover rover;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        sol: json["sol"],
        camera: Camera.fromJson(json["camera"]),
        imgSrc: json["img_src"],
        earthDate: DateTime.parse(json["earth_date"]),
        rover: Rover.fromJson(json["rover"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sol": sol,
        "camera": camera.toJson(),
        "img_src": imgSrc,
        "earth_date":
            "${earthDate.year.toString().padLeft(4, '0')}-${earthDate.month.toString().padLeft(2, '0')}-${earthDate.day.toString().padLeft(2, '0')}",
        "rover": rover.toJson(),
      };

  @override
  String toString() {
    return 'Photo(id: $id, sol: $sol, camera: $camera, imgSrc: $imgSrc, earthDate: $earthDate, rover: $rover)';
  }
}
