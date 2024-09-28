import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookContent extends StatelessWidget {
  const BookContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.76, // Adjust the aspect ratio
        ),
        itemCount: 8, // Number of books (replace with your data)
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              width: 150.w,
              height: 200.h,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/icons/book.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(
                        -10, 10), // Shadow to the left and slightly down
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Stack(
                children: [
                  // Book background
                  // Book title
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Text(
                      'Book Title', // Replace with your book titles
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // You can add more details here (e.g., author name)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
