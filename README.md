# hesham_tarek

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Notes 
landing page is home page
password is numbers
forget password = backend - disapear for now
language = backend

zoomout = !video cropping

thubnail when pause 
scroll video numbers
next video from current 


download video offline on the application
Alert for errors 



// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hesham_tarek/core/custom/content_button.dart';
import 'package:hesham_tarek/core/custom/custom_text_field.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';

class CourseViewBody extends StatefulWidget {
  final List<CourseList> courseList;
  const CourseViewBody({super.key, required this.courseList});

  @override
  State<CourseViewBody> createState() => _CourseViewBodyState();
}

class _CourseViewBodyState extends State<CourseViewBody> {
  List<String> items = ['All', 'Online', 'Offline', 'Hybrid', "Free"];
  int selectedIndex = 0;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 22, 16, 22),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: CustomTextField(
                hint: "Search Courses",
                controller: searchController,
              ),
            ),
            // Filter Buttons
            Container(
              margin: EdgeInsets.only(bottom: 12, top: 8),
              width: double.infinity,
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
                          item,
                          style: GoogleFonts.openSans(
                            color: selectedIndex == index
                                ? Colors.black
                                : Color(0xff2a2a2a),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            selectedIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Course List
            if (items[selectedIndex] == "All")
              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.w),
                    child: ContentButton(courseList: widget.courseList[index]),
                  );
                },
                itemCount: widget.courseList.length,
              )
            else if (items[selectedIndex] == "Free")
              // Replace with specific widget or content for "Free" filter
              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemBuilder: (context, index) {
                  // Filter your course list for "Free" courses
                  final freeCourses = widget.courseList
                      .where((course) => course.price == 0)
                      .toList();
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.w),
                    child: ContentButton(courseList: freeCourses[index]),
                  );
                },
                itemCount: widget.courseList
                    .where((course) => course.price == 0)
                    .length,
              )
          ],
        ),
      ),
    );
  }
}



--------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoId;
  const VideoPlayerView({
    super.key,
    required this.videoId,
  });

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        isLive: false,
        forceHD: false,
        hideThumbnail: true,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen != _isFullScreen) {
        setState(() {
          _isFullScreen = _controller.value.isFullScreen;
          _updateSystemUI();
        });
      }
    });
  }

  void _updateSystemUI() {
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: const Text("Course Video"),
            ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controller),
            controller: _controller,
            actionsPadding: const EdgeInsets.only(left: 16.0),
            bottomActions: [
              CurrentPosition(),
              SizedBox(width: 10),
              ProgressBar(isExpanded: true),
              SizedBox(width: 10),
              RemainingDuration(),
              FullScreenButton(),
            ],
          );
        },
        itemCount: 1,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
      ),
    );
  }
}

---------------------------------------------------------------- Video tile without video duration

Pasted content
4.63 KB • 135 extracted lines

Formatting may be inconsistent from source.

import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/video/presentation/view/video_player.dart';

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class VideoTile extends StatelessWidget {
  final String videoTitle;
  final String videoDesc;
  final String videoTime;
  final String videoThumbnail;
  final int? videoId;

  const VideoTile({
    Key? key,
    required this.videoTitle,
    required this.videoTime,
    required this.videoDesc,
    required this.videoThumbnail,
    required this.videoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1), // Orange border
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Video Thumbnail
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://img.youtube.com/vi/$videoThumbnail/0.jpg',
                      ), // Replace with actual thumbnail
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Video time overlay
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      videoTime.substring(0, 2),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video title
                  Text(
                    videoTitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  // Buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Download button

                      SizedBox(width: 8),
                      // Preview button
                      ElevatedButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: VideoWidget(
                                videoId: videoThumbnail,
                                title: videoTitle,
                                videoDesc: videoDesc),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary, // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Preview",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


---------------------------------before screen protect
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/theme/theme.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/home/data/repos/course_repo_implementation.dart';
import 'package:hesham_tarek/features/home/presentation/views/home_nav_bar.dart';
import 'package:hesham_tarek/features/login/bloc/login_cubit/login_cubit.dart';
import 'package:hesham_tarek/features/login/data/repos/login_repo_implementation.dart';
import 'package:hesham_tarek/features/login/presentation/views/login_view.dart';
import 'package:hesham_tarek/features/my_courses/bloc/cubit/course_detail_cubit.dart';
import 'package:hesham_tarek/features/my_courses/data/repo/course_detail_repo_implementation.dart';
import 'package:hesham_tarek/features/profile/presentation/views/profile_screen_view.dart';
import 'package:hesham_tarek/features/register/presentation/views/register_view.dart';
import 'package:hesham_tarek/features/splash/presentation/views/splash_screen_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/bank_card_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/bank_transfer_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/instapay_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/pay_at_office_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/subscription_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/vodafone_cash_view.dart';
import 'package:screen_protector/screen_protector.dart';
void main() async {
  await dotenv.load(fileName: '.env');
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => LoginCubit(getIt.get<LoginRepoImplementation>())),
        BlocProvider(
            create: (_) =>
                CourseListCubit(getIt.get<CourseRepoImplementation>())),
        BlocProvider(
            create: (_) =>
                CourseDetailCubit(getIt.get<CourseDetailRepoImplementation>())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        ensureScreenSize: true,
        builder: (context, child) {
          return MaterialApp(
            // Default locale
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            initialRoute: "/",
            routes: {
              "/": (context) => const SplashScreenView(),
              "/register": (context) => const RegisterView(),
              "/login": (context) => const LoginView(),
              "/home": (context) => const HomeNavBar(),
              "/subscription": (context) => const Subscription(),
              "/subscription/instapay": (context) => const Instapay(),
              "/subscription/vodafone": (context) => const VodafoneCashView(),
              "/subscription/bankcard": (context) => const BankCardView(),
              "/subscription/bankTransfer": (context) =>
                  const BankTransferView(),
              "/subscription/payAtOffice": (context) => const PayAtOfficeView(),
              "/profile": (context) => const ProfileScreenView(),
              // "/courses": (context) => const CourseView(),
              // "/videos": (context) => const VideoScreenView(),
            },
          );
        },
      ),
    );
  }
}
---------------------------------------------Video player before fix 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;
  final String videoDesc;
  final String title;

  VideoWidget(
      {required this.videoId, required this.title, required this.videoDesc});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen != _isFullscreen) {
        setState(() {
          _isFullscreen = _controller.value.isFullScreen;

          if (_isFullscreen) {
            // Hide status bar and navigation bar
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

            // Set landscape orientation
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
            ]);
          } else {
            // Show status bar and navigation bar
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

            // Set portrait orientation
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // Reset UI mode and orientation when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Force portrait mode on back press
        if (_isFullscreen) {
          _controller.toggleFullScreenMode();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: !_isFullscreen
            ? AppBar(
                title: Text(widget.title),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )),
              )
            : null,
        body: SingleChildScrollView(
          child: Container(
            color: _isFullscreen ? Colors.black : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isFullscreen) SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    // width: !_isFullscreen ? screenWidth : screenWidth - 400,
                    height: !_isFullscreen
                        ? 270
                        : screenHeight -
                            screenHeight *
                                0.2, // Adjust the video height as needed
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        print('Player is ready.');
                      },
                    ),
                  ),
                ),
                if (_isFullscreen) SizedBox(height: 40),
                if (!_isFullscreen) SizedBox(height: 40),
                if (!_isFullscreen) // Only show title if not in fullscreen
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                if (!_isFullscreen)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(widget.videoDesc),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
--------------------------------------- Course view 
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
      ButtonSegment(value: "Files", label: Text(S.of(context).Files))
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 3, color: Colors.white),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: 355,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://adlink2019-001-site58.etempurl.com/lessonimg/${widget.courseList.id}.jpg',
                        ), // Replace with actual thumbnail
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 8.h, right: 8.w, left: 16.w, bottom: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.courseList.name ?? "",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 4.h, right: 8.w, left: 16.w, bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).Price,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(width: 7),
                Text("${widget.courseList.price.toString()} EGP",
                    style: TextStyles.mediumGrey17),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 4.h, right: 8.w, left: 16.w, bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/studentsNo.svg"),
                SizedBox(width: 7),
                Text("${widget.courseList.studentsNo.toString()}",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                SizedBox(width: 7),
                Text(S.of(context).Student, style: TextStyles.mediumGrey17),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 5.w),
                child: Image.asset('assets/images/image.png', height: 36.h),
              ),
              Text(widget.courseList.trainerName ?? "",
                  style: TextStyles.mediumGrey17),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CourseSegmentedButton(
              segments: segments,
              selectedSegment: selectedSegment,
              onSelectionChanged: _updateSelectedSegment,
            ),
          ),
          if (selectedSegment.contains("About"))
            Container(
              alignment: Alignment.topLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
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
                  SizedBox(
                    height: 50,
                  )
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
                  // if (widget.courseList.isBought == true) {
                  return Stack(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ListView.builder(
                        shrinkWrap:
                            true, // Ensure the ListView doesn't expand infinitely
                        physics:
                            NeverScrollableScrollPhysics(), // Disable internal scrolling
                        itemCount: state.courseDetail.lessonApiDto!
                            .length, // Replace with actual list length
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: VideoTile(
                              isBought: widget.courseList.isBought!,
                              index: index,
                              allVideos: state.courseDetail.lessonApiDto,
                              videoDesc: state.courseDetail.description ??
                                  "", // Replace with actual title
                              videoTitle: state.courseDetail
                                      .lessonApiDto![index].contentName ??
                                  "", // Replace with actual title
                              videoPrice: state.courseDetail
                                      .lessonApiDto![index].contentPrice ??
                                  0, // Replace with actual title

                              // Replace with actual time
                              videoId: state.courseDetail.lessonApiDto![index]
                                      .contentUrl ??
                                  "", // Replace with actual thumbnail
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/subscription");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              height: 50,
                              child: Text(
                                S.of(context).SubscribetoseealltheVideos,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ))
                  ]);
                  // }
                  // else {
                  //   return SizedBox(
                  //     height: 400,
                  //     child: Column(
                  //       children: [
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.symmetric(horizontal: 18.0),
                  //           child: ListView.builder(
                  //             shrinkWrap: true,
                  //             physics: NeverScrollableScrollPhysics(),
                  //             itemCount: state.courseDetail.lessonApiDto
                  //                     ?.where((lesson) =>
                  //                         lesson.contentPrice == 0.0)
                  //                     .length ??
                  //                 0,
                  //             itemBuilder: (context, index) {
                  //               final freeLessons = state
                  //                   .courseDetail.lessonApiDto
                  //                   ?.where(
                  //                       (lesson) => lesson.contentPrice == 0.0)
                  //                   .toList();
                  //               if (freeLessons == null ||
                  //                   freeLessons.isEmpty) {
                  //                 return SizedBox.shrink();
                  //               }
                  //               final lesson = freeLessons[index];
                  //               return Padding(
                  //                 padding:
                  //                     const EdgeInsets.symmetric(vertical: 4.0),
                  //                 child: VideoTile(
                  //                   isBought: widget.courseList.isBought!,
                  //                   index: index,
                  //                   allVideos: state.courseDetail.lessonApiDto,
                  //                   videoDesc:
                  //                       state.courseDetail.description ?? "",
                  //                   videoTitle: lesson.contentName ?? "",
                  //                   videoId: lesson.contentUrl ?? "",
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             Navigator.pushNamed(context, "/subscription");
                  //           },
                  //           child: Container(
                  //             margin: EdgeInsets.symmetric(horizontal: 16),
                  //             width: double.infinity,
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(12),
                  //               color: Theme.of(context).colorScheme.primary,
                  //             ),
                  //             height: 50,
                  //             child: Text(
                  //               S.of(context).SubscribetoseealltheVideos,
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }
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
            )
        ],
      ),
    );
  }
}
