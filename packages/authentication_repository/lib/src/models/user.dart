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

  factory User.empty() => _empty;

  /// The current user's id.
  final String id;

  /// The current user's email address.
  final String? email;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == _empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != _empty;

  /// Empty user which represents an unauthenticated user.
  static const _empty = User(id: 'id');

  @override
  List<Object?> get props => [id, email, name, photo];
}
