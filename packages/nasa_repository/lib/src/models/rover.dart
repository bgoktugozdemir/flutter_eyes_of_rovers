import 'package:equatable/equatable.dart';

class Rover extends Equatable {
  const Rover({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
  });

  final int id;
  final String name;
  final DateTime landingDate;
  final DateTime launchDate;
  final String status;

  factory Rover.fromJson(Map<String, dynamic> json) => Rover(
        id: json["id"],
        name: json["name"],
        landingDate: DateTime.parse(json["landing_date"]),
        launchDate: DateTime.parse(json["launch_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "landing_date":
            "${landingDate.year.toString().padLeft(4, '0')}-${landingDate.month.toString().padLeft(2, '0')}-${landingDate.day.toString().padLeft(2, '0')}",
        "launch_date":
            "${launchDate.year.toString().padLeft(4, '0')}-${launchDate.month.toString().padLeft(2, '0')}-${launchDate.day.toString().padLeft(2, '0')}",
        "status": status,
      };

  @override
  List<Object> get props => [id, name, landingDate, launchDate, status];
}
