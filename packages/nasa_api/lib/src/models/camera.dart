class Camera {
  const Camera({
    required this.id,
    required this.name,
    required this.roverId,
    required this.fullName,
  });

  final int id;
  final String name;
  final int roverId;
  final String fullName;

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        id: json["id"],
        name: json["name"],
        roverId: json["rover_id"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rover_id": roverId,
        "full_name": fullName,
      };
}
