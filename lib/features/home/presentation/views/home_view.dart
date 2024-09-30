import 'dart:async';
import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/custom/content_button.dart';
import 'package:hesham_tarek/core/custom/whatsapp_floating_widget.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/courses/presentation/views/widgets/course_view_body.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/home/presentation/views/widgets/course_container.dart';
import 'package:hesham_tarek/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:hesham_tarek/features/home/presentation/views/widgets/search_field_home.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _searchQuery = '';
  final ScrollController _offersScrollController = ScrollController();
  final ScrollController _coursesScrollController = ScrollController();
  Timer? _offersScrollTimer;
  Timer? _coursesScrollTimer;
  Timer? _offersResumeTimer;
  Timer? _coursesResumeTimer;
  bool _isOffersUserScrolling = false;
  bool _isCoursesUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startOffersAutoScroll();
      _startCoursesAutoScroll();
    });
  }

  @override
  void dispose() {
    _offersScrollTimer?.cancel();
    _coursesScrollTimer?.cancel();
    _offersResumeTimer?.cancel();
    _coursesResumeTimer?.cancel();
    _offersScrollController.dispose();
    _coursesScrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    context
        .read<CourseListCubit>()
        .getCourseList(UserData().user?.id.toString() ?? "3411");
  }

  Future<void> _getData() async {
    context
        .read<CourseListCubit>()
        .getCourseList(UserData().user?.id.toString() ?? "3411");
  }

  void _startOffersAutoScroll() {
    _offersScrollTimer =
        Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_isOffersUserScrolling) {
        _smoothScroll(_offersScrollController);
      }
    });
  }

  void _startCoursesAutoScroll() {
    _coursesScrollTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isCoursesUserScrolling) {
        _smoothScroll(_coursesScrollController);
      }
    });
  }

  void _smoothScroll(ScrollController controller) {
    if (controller.hasClients) {
      final currentPosition = controller.offset;
      final maxScrollExtent = controller.position.maxScrollExtent;
      final newPosition = (currentPosition + 1) % (maxScrollExtent + 1);
      controller.jumpTo(newPosition);
    }
  }

  void _handleOffersUserScroll() {
    _isOffersUserScrolling = true;
    _offersScrollTimer?.cancel();
    _offersResumeTimer?.cancel();

    _offersResumeTimer = Timer(const Duration(seconds: 1), () {
      _isOffersUserScrolling = false;
      _startOffersAutoScroll();
    });
  }

  void _handleCoursesUserScroll() {
    _isCoursesUserScrolling = true;
    _coursesScrollTimer?.cancel();
    _coursesResumeTimer?.cancel();

    _coursesResumeTimer = Timer(const Duration(seconds: 1), () {
      _isCoursesUserScrolling = false;
      _startCoursesAutoScroll();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListCubit, CourseListState>(
      builder: (context, state) {
        if (state is CourseListSuccess) {
          return _buildSuccessView(state);
        } else if (state is CourseListLoading) {
          return _buildLoadingView();
        } else {
          print("OK");
          return Container(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: const SingleChildScrollView(
                // Make the content scrollable
                physics:
                    AlwaysScrollableScrollPhysics(), // Ensures that the scroll can happen even if the content doesn't fill the screen
                child: Column(
                  children: [
                    HomeAppBar(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text("Something went wrong"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSuccessView(CourseListSuccess state) {
    final filteredCourses = state.courseList
        .where((course) =>
            course.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
            false)
        .toList();

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          RefreshIndicator(
            onRefresh: _refreshData,
            child: Column(
              children: [
                const HomeAppBar(),
                Expanded(
                  child: _searchQuery.isEmpty
                      ? _buildHomeContent(state)
                      : _buildSearchResults(filteredCourses),
                ),
              ],
            ),
          ),
          Positioned(
            top: 135.h,
            left: 16.w,
            right: 16.w,
            child: SizedBox(
              height: 40.h,
              child: SearchFieldHome(onChanged: _onSearchChanged),
            ),
          ),
        ],
      ),
      floatingActionButton: WhatsappFloatingWidget(heroTag: "home"),
    );
  }

  // Widget _buildHomeContent(CourseListSuccess state) {
  //   return ListView(
  //     shrinkWrap: true,
  //     children: [
  //       SizedBox(height: 16.h),
  //       // const ContentSelection(),
  //       // SizedBox(height: 30.h),
  //       // _buildLatestOffers(),
  //       // SizedBox(height: 30.h),
  //       // CoursesAndSeeAll(courseList: state.courseList),
  //       // _buildCourseList(state.courseList),
  //       CourseViewBody(courseList: state.courseList)
  //     ],
  //   );
  // }

  Widget _buildHomeContent(CourseListSuccess state) {
    return CourseViewBody(courseList: state.courseList);
  }

  Widget _buildLatestOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            S.of(context).Latestoffers,
            style: TextStyles.mediumGrey17,
          ),
        ),
        SizedBox(
          height: 110.h,
          child: CarouselSlider.builder(
            itemCount: 10, // Adjust according to the number of offers
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 80.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF334155),
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1c2c2e),
                      Color.fromARGB(255, 152, 163, 165),
                    ],
                    stops: [0.0, 1],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '10% off! Offer ${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 120.h,
              enlargeCenterPage: true, // Makes the centered item larger
              enableInfiniteScroll: true, // Enables infinite scrolling
              autoPlay: true, // Automatic scrolling
              viewportFraction: 0.8, // Adjust the fraction of the item shown
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseList(List<dynamic> courseList) {
    return CarouselSlider.builder(
      itemCount: (courseList.length / 3).ceil(),
      itemBuilder: (context, index, realIndex) {
        return Row(
          children: List.generate(3, (i) {
            final courseIndex = index * 3 + i;
            if (courseIndex < courseList.length) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: CourseContainer(
                    image:
                        'http://adlink2019-001-site58.etempurl.com/lessonimg/${courseList[courseIndex].id.toString()}.jpg',
                    text: courseList[courseIndex].name ?? "",
                    status: S.of(context).Online,
                    courseList: courseList[courseIndex],
                  ),
                ),
              );
            } else {
              return const Expanded(child: SizedBox());
            }
          }),
        );
      },
      options: CarouselOptions(
        height: 250.h,
        viewportFraction: 0.9,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 7),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        autoPlayCurve: Curves.easeInOut,
        // enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildSearchResults(List<dynamic> filteredCourses) {
    return ListView.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: ContentButton(courseList: filteredCourses[index]),
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return const Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [HomeAppBar(), Center(child: CircularProgressIndicator())],
        ),
      ],
    );
  }
}
