import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesham_tarek/features/profile/bloc/language_cubit/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit()
      : super(LanguageState(
            languageCode: "English", // Default language
            updateLanguageCode: (String _) {})) {
    // Update the function when the cubit is created
    _loadUserLanguage();
  }

  Future<void> _loadUserLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode =
        prefs.getString('lang') ?? "English"; // Default to English
    emit(LanguageState(
      languageCode: savedLanguageCode,
      updateLanguageCode: _updateLanguageCode,
    ));
  }

  // Function to update languageCode and emit the new state
  void _updateLanguageCode(String newCode) {
    emit(LanguageState(
      languageCode: newCode,
      updateLanguageCode:
          _updateLanguageCode, // Ensure the function remains the same
    ));
  }

  // Public method to allow the state to be updated
  void changeLanguage(String newCode) {
    state.updateLanguageCode(newCode); // Calls the function from the state
  }
}
