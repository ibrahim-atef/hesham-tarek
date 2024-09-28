import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/books/presentation/view/book_screen_view.dart';
import 'package:hesham_tarek/features/files/presentation/view/files_screen_view.dart';
import 'package:hesham_tarek/features/home/presentation/views/widgets/gradient_container.dart';
import 'package:hesham_tarek/features/projects/presentation/view/projects_screen_view.dart';
import 'package:hesham_tarek/features/videos/presentation/view/video_screen_view.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class ContentSelection extends StatelessWidget {
  const ContentSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GradientButton(
          svgImage: 'assets/icons/books_button.svg',
          buttonText: S.of(context).Books,
          route: const BookScreenView(),
        ),
        GradientButton(
          svgImage: 'assets/icons/files_button.svg',
          buttonText: S.of(context).Files,
          route: const FilesScreenView(),
        ),
        GradientButton(
          svgImage: 'assets/icons/projects_button.svg',
          buttonText: S.of(context).Projects,
          route: const ProjectsScreenView(),
        ),
        GradientButton(
          svgImage: 'assets/icons/videos_button.svg',
          buttonText: S.of(context).Videos,
          route: const VideoScreenView(),
        ),
      ],
    );
  }
}
