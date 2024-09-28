import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/packages/presentation/views/widgets/package_view_body.dart';

class PackageView extends StatelessWidget {
  const PackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Packages"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: const PackageViewBody(),
      // floatingActionButton: WhatsappFloatingWidget(),
    );
  }
}
