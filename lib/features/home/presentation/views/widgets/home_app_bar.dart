import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/features/home/presentation/views/widgets/logo_plus_picture.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/app_bar.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Overlay Container
          Positioned.fill(
            child: Container(
              color: const Color(0xff2C4649)
                  .withOpacity(0.6), // Adjust opacity as needed
            ),
          ),
          // Content inside the AppBar
          const Align(
            alignment: Alignment.center,
            child: LogoPlusPicture(),
          ),
        ],
      ),
    );
  }
}
