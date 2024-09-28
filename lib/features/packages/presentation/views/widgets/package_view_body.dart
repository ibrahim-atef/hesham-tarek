// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:hesham_tarek/core/custom/custom_text_field.dart';

class PackageViewBody extends StatefulWidget {
  const PackageViewBody({super.key});

  @override
  State<PackageViewBody> createState() => _PackageViewBodyState();
}

class _PackageViewBodyState extends State<PackageViewBody> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 22, 16, 22),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: CustomTextField(
              hint: "Search Packages  ",
              controller: searchController,
            ),
          ),
          // ContentButton()
        ],
      ),
    );
  }
}
