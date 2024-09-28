import 'dart:ui';

import 'package:flutter/material.dart';

class InnerBlurContainer extends StatelessWidget {
  final double width;
  final double height;
  final double blurSigma;
  final Widget child;

  const InnerBlurContainer({
    super.key,
    required this.width,
    required this.height,
    required this.blurSigma,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0), // Optional: Rounded corners
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1), // Adjust opacity as needed
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                color: Colors.transparent, // Required for the blur effect
              ),
            ),
          ),
          // Foreground content
          Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(0.01), // Adjust overlay color as needed
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff000000).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16)),
                height: height,
                width: double.infinity,
                child: child,
              )),
        ],
      ),
    );
  }
}
