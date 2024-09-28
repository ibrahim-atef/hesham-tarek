import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/books/presentation/view/widgets/book_content.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class BookScreenView extends StatelessWidget {
  const BookScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Books),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const BookContent(),
      // floatingActionButton: WhatsappFloatingWidget(),
    );
  }
}
