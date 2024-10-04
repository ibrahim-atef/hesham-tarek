import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hesham_tarek/features/profile/bloc/language_cubit/language_cubit.dart';
import 'package:hesham_tarek/features/profile/bloc/language_cubit/language_state.dart';
import 'package:radio_group_v2/utils/radio_group_decoration.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';
import 'package:radio_group_v2/widgets/views/radio_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LanguageToggle extends StatelessWidget {
  LanguageToggle({super.key});
  RadioGroupController myController = RadioGroupController();
  Future<void> saveUserLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return RadioGroup(
        controller: myController,
        onChanged: (value) {
          if (value != null) {
            // Update the language using LanguageCubit
            context.read<LanguageCubit>().changeLanguage(value);
            saveUserLanguage(value);
          }
        },
        values: const ["English", "العربية"],
        indexOfDefault: state.languageCode == "English" ? 0 : 1,
        orientation: RadioGroupOrientation.horizontal,
        decoration: RadioGroupDecoration(
          spacing: 10.0,
          labelStyle: GoogleFonts.openSans(
            color: Colors.black,
          ),
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    });
  }
}
