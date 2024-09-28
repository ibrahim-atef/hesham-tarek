import 'package:equatable/equatable.dart';

import 'user.dart';

class Material extends Equatable {
  final int? id;
  final User? user;
  final int? userId;
  final String? name;

  const Material({this.id, this.user, this.userId, this.name});

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json['Id'] as int?,
        user: json['User'] == null
            ? null
            : User.fromJson(json['User'] as Map<String, dynamic>),
        userId: json['userId'] as int?,
        name: json['Name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'User': user?.toJson(),
        'userId': userId,
        'Name': name,
      };

  @override
  List<Object?> get props => [id, user, userId, name];
}
