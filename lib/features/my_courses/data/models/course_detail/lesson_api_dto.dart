import 'package:equatable/equatable.dart';

class LessonApiDto extends Equatable {
  final String? contentName;
  final int? contentType;
  final int? contentId;
  final double? contentPrice;
  final bool? isBought;
  final String? contentUrl;

  const LessonApiDto({
    this.contentName,
    this.contentType,
    this.contentId,
    this.contentPrice,
    this.isBought,
    this.contentUrl,
  });

  factory LessonApiDto.fromJson(Map<String, dynamic> json) => LessonApiDto(
        contentName: json['ContentName'] as String?,
        contentType: json['ContentType'] as int?,
        contentId: json['ContentId'] as int?,
        contentPrice: (json['ContentPrice'] as num?)?.toDouble(),
        isBought: json['IsBought'] as bool?,
        contentUrl: json['ContentUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ContentName': contentName,
        'ContentType': contentType,
        'ContentId': contentId,
        'ContentPrice': contentPrice,
        'IsBought': isBought,
        'ContentUrl': contentUrl,
      };

  @override
  List<Object?> get props {
    return [
      contentName,
      contentType,
      contentId,
      contentPrice,
      isBought,
      contentUrl,
    ];
  }
}
