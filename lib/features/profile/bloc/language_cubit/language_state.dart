import 'package:equatable/equatable.dart';

// Define the LanguageState with a function to update a string
class LanguageState extends Equatable {
  final String languageCode;
  final Function(String) updateLanguageCode;

  const LanguageState({
    required this.languageCode,
    required this.updateLanguageCode,
  });

  @override
  List<Object?> get props => [languageCode];
}
