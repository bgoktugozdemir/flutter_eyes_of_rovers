import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: 'id');

  /// The current user's id.
  final String id;

  /// The current user's email address.
  final String? email;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != empty;

  @override
  List<Object?> get props => [id, email, name, photo];
}
