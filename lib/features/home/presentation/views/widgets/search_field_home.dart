import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class SearchFieldHome extends StatefulWidget {
  final Function(String) onChanged;

  const SearchFieldHome({
    super.key,
    required this.onChanged,
  });

  @override
  State<SearchFieldHome> createState() => _SearchFieldHomeState();
}

class _SearchFieldHomeState extends State<SearchFieldHome> {
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onSubmitted: (value) {
        _focusNode.unfocus();
      },
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: Container(
          width: 48.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: const Color(0xffF9FAFB),
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(12)),
            border: Border.all(color: const Color(0xff2C4649), width: 1),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
        hintText: S.of(context).Search,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xff2C4649),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xff2C4649),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xff2C4649),
            width: 1,
          ),
        ),
      ),
    );
  }
}
