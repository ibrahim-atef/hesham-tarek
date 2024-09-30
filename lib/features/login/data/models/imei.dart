import 'package:equatable/equatable.dart';

class Imei extends Equatable {
  final int? id;
  final String? imei;

  const Imei({this.id, this.imei});

  factory Imei.fromJson(Map<String, dynamic> json) => Imei(
        id: json['Id'] as int?,
        imei: json['IMEI'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'IMEI': imei,
      };

  @override
  List<Object?> get props => [id, imei];
}
