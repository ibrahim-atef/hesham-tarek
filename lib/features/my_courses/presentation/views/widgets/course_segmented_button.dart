import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';

class CourseSegmentedButton extends StatefulWidget {
  final List<ButtonSegment<String>> segments;
  final Set<String> selectedSegment;
  final void Function(Set<String>) onSelectionChanged;

  const CourseSegmentedButton({
    super.key,
    required this.segments,
    required this.selectedSegment,
    required this.onSelectionChanged,
  });

  @override
  State<CourseSegmentedButton> createState() => _CourseSegmentedButtonState();
}

class _CourseSegmentedButtonState extends State<CourseSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: SegmentedButton<String>(
        emptySelectionAllowed: false,
        showSelectedIcon: false,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xffE5E7EB), width: 1))),
          textStyle: WidgetStatePropertyAll(TextStyles.semiBold17),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff2C4649);
            } else {
              return const Color(0xfffafafa);
            }
          }),
        ),
        segments: widget.segments,
        selected: widget.selectedSegment,
        onSelectionChanged: (Set<String> value) {
          widget.onSelectionChanged(value);
        },
      ),
    );
  }
}
