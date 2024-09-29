import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/my_courses/bloc/cubit/course_detail_cubit.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/widgets/course_segmented_button.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/widgets/video_tile.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class CourseDetailsViewBody extends StatefulWidget {
  final CourseList courseList;

  const CourseDetailsViewBody({super.key, required this.courseList});

  @override
  State<CourseDetailsViewBody> createState() => _CourseDetailsViewBodyState();
}

class _CourseDetailsViewBodyState extends State<CourseDetailsViewBody> {
  Set<String> selectedSegment = {"Videos"};

  void _updateSelectedSegment(Set<String> newSelection) {
    setState(() {
      selectedSegment = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ButtonSegment<String>> segments = [
      ButtonSegment(value: "About", label: Text(S.of(context).About)),
      ButtonSegment(value: "Videos", label: Text(S.of(context).Videos)),
      // ButtonSegment(value: "Files", label: Text(S.of(context).Files))
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 3, color: Colors.white),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://adlink2019-001-site58.etempurl.com/lessonimg/${widget.courseList.id}.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.h, right: 8.w, left: 16.w, bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.courseList.name ?? "",
                          style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.favorite_border,
                      //       color: Colors.red),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.h, right: 8.w, left: 16.w, bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).Price,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      const SizedBox(width: 7),
                      Text("${widget.courseList.price.toString()} EGP",
                          style: TextStyles.mediumGrey17),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.h, right: 16.w, left: 16.w, bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/videoNo.svg",
                            width: 20,
                          ),
                          const SizedBox(width: 7),
                          BlocBuilder<CourseDetailCubit, CourseDetailState>(
                              builder: (context, state) {
                            if (state is CourseDetailSuccess) {
                              return Text(
                                  state.courseDetail.lessonApiDto!.length
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black));
                            } else {
                              return Text("",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black));
                            }
                          }),
                          const SizedBox(width: 7),
                          Text(S.of(context).Videos,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/rateNo.svg",
                            width: 20,
                          ),
                          const SizedBox(width: 7),
                          Text("5.0",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 5.w),
                      child:
                          Image.asset('assets/images/image.png', height: 36.h),
                    ),
                    Text(widget.courseList.trainerName ?? "",
                        style: TextStyles.mediumGrey17),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: CourseSegmentedButton(
                    segments: segments,
                    selectedSegment: selectedSegment,
                    onSelectionChanged: _updateSelectedSegment,
                  ),
                ),
                if (selectedSegment.contains("About"))
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                            widget.courseList.description ??
                                S.of(context).Nodescription,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black)),
                        const SizedBox(height: 50),
                      ],
                    ),
                  )
                else if (selectedSegment.contains("Videos"))
                  BlocBuilder<CourseDetailCubit, CourseDetailState>(
                    builder: (context, state) {
                      if (state is CourseDetailFailure) {
                        return Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16),
                          child: Text("No Videos",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        );
                      } else if (state is CourseDetailSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    state.courseDetail.lessonApiDto!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: VideoTile(
                                      isBought: widget.courseList.isBought!,
                                      index: index,
                                      allVideos:
                                          state.courseDetail.lessonApiDto,
                                      videoDesc:
                                          state.courseDetail.description ?? "",
                                      videoTitle: state
                                              .courseDetail
                                              .lessonApiDto![index]
                                              .contentName ??
                                          "",
                                      videoPrice: state
                                              .courseDetail
                                              .lessonApiDto![index]
                                              .contentPrice ??
                                          0,
                                      videoId: state
                                              .courseDetail
                                              .lessonApiDto![index]
                                              .contentUrl ??
                                          "",
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                else if (selectedSegment.contains("Files"))
                  BlocBuilder<CourseDetailCubit, CourseDetailState>(
                    builder: (context, state) {
                      if (state is CourseDetailFailure) {
                        return Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16),
                          child: Text("No Files",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        );
                      } else if (state is CourseDetailSuccess) {
                        return Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16),
                          child: Text("Files Found",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
              ],
            ),
          ),
          // Fixed button at the bottom
          // if (widget.courseList.isBought == false)
          //   Align(
          //     alignment: Alignment.bottomCenter,
          //     child:  )
        ],
      ),
    );
  }
}
