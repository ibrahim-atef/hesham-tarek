import 'package:equatable/equatable.dart';

import 'material.dart';

class CourseList extends Equatable {
  final int? id;
  final int? materialId;
  final Material? material;
  final String? name;
  final dynamic description;
  final String? encryptionCode;
  final DateTime? date;
  final int? price;
  final int? lessonPriority;
  final bool? isBought;
  final String? trainerName;
  final int? studentsNo;
  final List<dynamic>? lessonApiDto;

  const CourseList({
    this.id,
    this.materialId,
    this.material,
    this.name,
    this.description,
    this.encryptionCode,
    this.date,
    this.price,
    this.lessonPriority,
    this.isBought,
    this.trainerName,
    this.studentsNo,
    this.lessonApiDto,
  });

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        id: json['Id'] as int?,
        materialId: json['MaterialId'] as int?,
        material: json['Material'] == null
            ? null
            : Material.fromJson(json['Material'] as Map<String, dynamic>),
        name: json['Name'] as String?,
        description: json['Description'] as dynamic,
        encryptionCode: json['EncryptionCode'] as String?,
        date: json['Date'] == null
            ? null
            : DateTime.parse(json['Date'] as String),
        price: json['price'] as int?,
        lessonPriority: json['LessonPriority'] as int?,
        isBought: json['IsBought'] as bool?,
        trainerName: json['TrainerName'] as String?,
        studentsNo: json['StudentsNo'] as int?,
        lessonApiDto: json['LessonApiDto'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'MaterialId': materialId,
        'Material': material?.toJson(),
        'Name': name,
        'Description': description,
        'EncryptionCode': encryptionCode,
        'Date': date?.toIso8601String(),
        'price': price,
        'LessonPriority': lessonPriority,
        'IsBought': isBought,
        'TrainerName': trainerName,
        'StudentsNo': studentsNo,
        'LessonApiDto': lessonApiDto,
      };

  @override
  List<Object?> get props {
    return [
      id,
      materialId,
      material,
      name,
      description,
      encryptionCode,
      date,
      price,
      lessonPriority,
      isBought,
      trainerName,
      studentsNo,
      lessonApiDto,
    ];
  }
}
