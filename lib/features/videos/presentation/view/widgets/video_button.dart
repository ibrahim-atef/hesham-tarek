import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';

class VideoButton extends StatelessWidget {
  const VideoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 110.h,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border:
            Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              height: 90.h,
              width: 112.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/package.jfif'))),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    child: Text(
                      "1. Difference Between Instance Pr and Type Pr 2 | r...",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Preview",
                              style: TextStyles.semiNormalBlack15,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
