import 'package:equatable/equatable.dart';

import 'lesson_api_dto.dart';

class CourseDetail extends Equatable {
  final int? id;
  final int? materialId;
  final dynamic material;
  final String? name;
  final String? description;
  final String? encryptionCode;
  final DateTime? date;
  final int? price;
  final int? lessonPriority;
  final bool? isBought;
  final dynamic trainerName;
  final int? studentsNo;
  final List<LessonApiDto>? lessonApiDto;

  const CourseDetail({
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

  factory CourseDetail.fromJson(Map<String, dynamic> json) => CourseDetail(
        id: json['Id'] as int?,
        materialId: json['MaterialId'] as int?,
        material: json['Material'] as dynamic,
        name: json['Name'] as String?,
        description: json['Description'] as String?,
        encryptionCode: json['EncryptionCode'] as String?,
        date: json['Date'] == null
            ? null
            : DateTime.parse(json['Date'] as String),
        price: json['price'] as int?,
        lessonPriority: json['LessonPriority'] as int?,
        isBought: json['IsBought'] as bool?,
        trainerName: json['TrainerName'] as dynamic,
        studentsNo: json['StudentsNo'] as int?,
        lessonApiDto: (json['LessonApiDto'] as List<dynamic>?)
            ?.map((e) => LessonApiDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'MaterialId': materialId,
        'Material': material,
        'Name': name,
        'Description': description,
        'EncryptionCode': encryptionCode,
        'Date': date?.toIso8601String(),
        'price': price,
        'LessonPriority': lessonPriority,
        'IsBought': isBought,
        'TrainerName': trainerName,
        'StudentsNo': studentsNo,
        'LessonApiDto': lessonApiDto?.map((e) => e.toJson()).toList(),
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
