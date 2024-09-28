import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectContent extends StatelessWidget {
  const ProjectContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 40.h,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Row(
        children: [
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Row(children: [
              Image.asset("assets/icons/pdf_icon.png"),
              const SizedBox(
                height: 8,
              ),
              const Expanded(
                child: Text(
                  "Design note",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Download",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[700],
                          ),
                        ),
                        Icon(
                          Icons.download_rounded,
                          color: Colors.blue[700],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
