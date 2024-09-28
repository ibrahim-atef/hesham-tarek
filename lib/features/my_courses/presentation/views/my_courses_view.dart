import 'package:flutter/material.dart';
import 'package:hesham_tarek/core/custom/whatsapp_floating_widget.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/widgets/my_course_view_body.dart';

class MyCourseView extends StatelessWidget {
  const MyCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyCourseViewBody(),
      floatingActionButton: WhatsappFloatingWidget(
        heroTag: "Mycourses",
      ),
    );
  }
}
