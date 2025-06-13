import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple/UI/Home_screen/dailyappointments.dart';
import 'package:simple/UI/Home_screen/welcomecarosel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple/Alertbox/snackBarAlert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/Bloc/Contact/contact_bloc.dart';
import 'package:simple/ModelClass/ShareReview/postReviewModel.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple/Reusable/text_styles.dart';
import 'package:simple/UI/buttomnavigationbar/buttomnavigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:simple/ModelClass/Home/getHomeModel.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  const HomeScreen({super.key, required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactDentalBloc(),
      child: HomeScreenView(
      ),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({
    super.key,
  });

  @override
  HomeScreenViewState createState() => HomeScreenViewState();
}

class HomeScreenViewState extends State<HomeScreenView> {
  GetHomeModel getHomeModel = GetHomeModel();
  PostReviewModel postReviewModel=PostReviewModel();
  bool homeLoad = false;
  int _currentIndex=0;
  bool reviewLoad=false;
  String? errorMessage;
  List<String> currentCarouselImages = [];
  final PageController _carouselPageController = PageController();
  final PageController _testimonialsPageController = PageController(); // New controller for testimonials

  Timer? _carouselTimer;
  Timer? _testimonialsTimer;
  bool _hasStartedAutoScrolls = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  int _selectedStars = 5;


  @override
  void initState() {
    super.initState();
    context.read<ContactDentalBloc>().add(HomeDental());
    homeLoad = true;
  }

  void _startSlideshowAutoScroll() {
    _carouselTimer?.cancel();
    final slideshowLength = getHomeModel.data?.slideshow?.length ?? 0;
    if (slideshowLength > 0) {
      _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_carouselPageController.hasClients) {
          int nextPage = _carouselPageController.page!.round() + 1;
          if (nextPage >= slideshowLength) {
            nextPage = 0;
          }
          _carouselPageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _startTestimonialsAutoScroll() {
    _testimonialsTimer?.cancel();
    final reviewsLength = getHomeModel.data?.reviews?.length ?? 0;
    if (reviewsLength > 0) {
      _testimonialsTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_testimonialsPageController.hasClients) {
          int nextPage = _testimonialsPageController.page!.round() + 1;
          if (nextPage >= reviewsLength) {
            nextPage = 0;
          }
          _testimonialsPageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _testimonialsTimer?.cancel();
    _carouselPageController.dispose();
    _testimonialsPageController.dispose();
    _fullNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  bool feedLoad = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    Widget mainContainer() {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            WelcomeSectionWithCarousel(
              getHomeModel: getHomeModel,
              homeLoad: homeLoad,
              size: size,
              backgroundColor: lightBackground,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
            const SizedBox(height: 20),
            TransformingDentalHealthSection(
                getHomeModel:getHomeModel,
                homeLoad:homeLoad,
                backgroundColor:lightBackgroundlight,
                textColor: textColor,
                secondaryTextColor:secondaryTextColor,
                purpleColor:purpleColor,
            ),
            const SizedBox(height: 20),
            buildOurTeamSection(lightBackground, textColor, secondaryTextColor,
                darkModeBannerColor),
            const SizedBox(height: 40),
            buildShareReviewButton(lightBackground, darkModeBannerColor),
            const SizedBox(height: 40),
            buildWhatOurClientsSaySection(
                lightBackground, whiteBackground, textColor,
                secondaryTextColor),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
                (route) => false,
          );
          return false;// Prevent default back action
        },
        child:Scaffold(
            backgroundColor: scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: appBarBackgroundColor,
              title: Row(
                children: [
                  Image.asset(Images.logo1, height: 50, width: 50),
                  const SizedBox(width: 10),
                  Text(
                    'PAUL DENTAL CARE',
                    style:MyTextStyle.f20(
                      whiteColor,
                    ),
                  ),
                ],
              ),
            ),

            body: BlocBuilder<ContactDentalBloc, dynamic>(
              buildWhen: ((previous, current) {
                debugPrint("current:$current");
                if (current is GetHomeModel) {
                  getHomeModel = current;
                  if (current.errorResponse != null) {
                    if (current.errorResponse!.errors != null &&
                        current.errorResponse!.errors!.isNotEmpty) {
                      errorMessage = current.errorResponse!.errors![0].message ??
                          "Something went wrong";
                    } else {
                      errorMessage = "Something went wrong";
                    }
                    showToast("$errorMessage", context, color: false);
                    setState(() {
                      homeLoad = false;
                    });
                  } else if (getHomeModel.success == true) {
                    if (getHomeModel.data?.status == true) {
                      setState(() {
                        homeLoad = false;
                        if (!_hasStartedAutoScrolls) {
                          _startSlideshowAutoScroll();
                          _startTestimonialsAutoScroll();
                          _hasStartedAutoScrolls = true;
                        }
                      });
                    } else if (getHomeModel.data?.status == false) {
                      debugPrint("getHomeModel:${getHomeModel.message}");
                      setState(() {
                        showToast("${getHomeModel.message}", context,
                            color: false);
                        homeLoad = false;
                      });
                    }
                  }
                  return true;
                }
                if (current is PostReviewModel) {
                  postReviewModel = current;
                  if (current.errorResponse != null) {
                    if (current.errorResponse!.errors != null &&
                        current.errorResponse!.errors!.isNotEmpty) {
                      errorMessage = current.errorResponse!.errors![0].message ??
                          "Something went wrong";
                    } else {
                      errorMessage = "Something went wrong";
                    }
                    showToast("$errorMessage", context, color: false);
                    setState(() {
                      reviewLoad = false;
                    });
                  } else if (postReviewModel.status == true)
                  {
                        showToast("${postReviewModel.message}", context, color: true);
                        setState(() {
                          context.read<ContactDentalBloc>().add(HomeDental());
                          reviewLoad = false;
                          homeLoad = false;
                          Navigator.pop(context);
                        });
                  }
                  else if (postReviewModel.status == false) {
                    showToast("${postReviewModel.message}", context, color: false);
                    setState(() {
                      reviewLoad = false;
                    });
                  }
                  return true;
                }
                return false;
              }),
              builder: (context, dynamic) {
                if (homeLoad) {
                  return const Center(
                    child: SpinKitChasingDots(color: appPrimaryColor, size: 50), // <--- Your custom loader
                  );
                }
                return mainContainer();
              },
            ),
            )
    );
  }

  Widget buildOurTeamSection(Color backgroundColor, Color textColor,
      Color secondaryTextColor, Color purpleColor) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 2,
                color: purpleColor, // Purple line from the image, now dynamic
                margin: const EdgeInsets.only(right: 8.0),
              ),
              Text(
                'Expert Doctors',
                style: MyTextStyle.f16(
                  purpleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'Our Team',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              color: textColor,
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '${getHomeModel.data?.teamDescription}',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              color: secondaryTextColor,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          LayoutBuilder(
            builder: (context, constraints) {
              final team = getHomeModel.data?.teamMembers ?? [];
              if (team.isEmpty) {
                return Center(child: Text("No team data available"));
              }

              if (constraints.maxWidth > 700) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: team.map((member) {
                    return Expanded(
                      child: buildDoctorCard(
                        member.image ?? '',
                        member.name ?? '',
                        member.post ?? '',
                        textColor,
                        secondaryTextColor,
                      ),
                    );
                  }).toList(),
                );
              } else if (constraints.maxWidth > 400) {
                return Column(
                  children: [
                    Row(
                      children: team.take(2).map((member) {
                        return Expanded(
                          child: buildDoctorCard(
                            member.image ?? '',
                            member.name ?? '',
                            member.post ?? '',
                            textColor,
                            secondaryTextColor,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    if (team.length > 2)
                      buildDoctorCard(
                        team[2].image ?? '',
                        team[2].name ?? '',
                        team[2].post ?? '',
                        textColor,
                        secondaryTextColor,
                      ),
                  ],
                );
              } else {
                return Column(
                  children: team.map((member) {
                    return Column(
                      children: [
                        buildDoctorCard(
                          member.image ?? '',
                          member.name ?? '',
                          member.post ?? '',
                          textColor,
                          secondaryTextColor,
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDoctorCard(String imageUrl,
      String name,
      String specialization,
      Color textColor,
      Color secondaryTextColor,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300,
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'Image not found',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              );
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: 300,
                color: Colors.grey[100],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: MyTextStyle.f18(
            textColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          specialization,
          style: MyTextStyle.f14(
            secondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildShareReviewButton(Color dialogFieldFillColor, Color purpleColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ElevatedButton(
        onPressed: () {
          showReviewDialog(context, dialogFieldFillColor, purpleColor);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: purpleColor, // Purple button color, now dynamic
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize:
          const Size(double.infinity, 50), // Make button full width
        ),
        child: Text(
          'Share Review',
          style: MyTextStyle.f18(
            whiteColor,
          ),
        ),
      ),
    );
  }

  void showReviewDialog(BuildContext context, Color dialogFieldFillColor,
      Color purpleColor) {

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context2) {
        return  BlocProvider(
            create: (context) => ContactDentalBloc(),
            child: BlocProvider.value(
            value: BlocProvider.of<ContactDentalBloc>(context, listen: false),
              child: StatefulBuilder(
                builder: (context, setState)
                {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero, // Remove default padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: dialogBackgroundColor, // Use dynamic color
                    content: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width *
                            0.9, // 90% of screen width
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          // Wrap with Form for validation
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel,
                                      color: dialogLabelColor), // Use dynamic color
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                              ),
                              Text(
                                'Share Review',
                                style: MyTextStyle.f24(
                                  dialogTextColor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Full Name Text Field
                              TextFormField(
                                controller: _fullNameController,
                                style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    color: dialogTextColor
                                ), // Text color in field
                                decoration: InputDecoration(
                                  labelText: 'Full Name*',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Times New Roman',
                                      color: dialogLabelColor),
                                  filled: true,
                                  fillColor:
                                  dialogFieldFillColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none, // No border
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: purpleColor,
                                        width: 2
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your full name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              // Star Rating Dropdown
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: dialogFieldFillColor, // Use dynamic color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: _selectedStars,
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: dialogLabelColor),
                                    // Use dynamic color
                                    onChanged: (int? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          _selectedStars = newValue;
                                        });
                                      }
                                    },
                                    items: List.generate(5, (index) {
                                      final int starValue = 5 - index;
                                      return DropdownMenuItem<int>(
                                        value: starValue,
                                        child: Row(
                                          children:
                                          List.generate(starValue, (starIndex) {
                                            return const Icon(Icons.star,
                                                color: Colors.amber, size: 24);
                                          }),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _reviewController,
                                maxLines: 4,
                                style: MyTextStyle.f16(
                                  dialogTextColor,
                                  weight: FontWeight.normal
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Review',
                                  labelStyle: MyTextStyle.f20(
                                    dialogLabelColor,
                                  ),
                                  // Use dynamic color
                                  filled: true,
                                  fillColor:
                                  dialogFieldFillColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none, // No border
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: purpleColor,
                                        width:
                                        2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your review';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              // Submit Button
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      purpleColor,
                                      purpleColor.withOpacity(0.7)
                                    ], // Purple gradient, now dynamic
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<ContactDentalBloc>().add(ReviewDental(_fullNameController.text.trim(),_reviewController.text.trim(),_selectedStars.toString()));
                                      reviewLoad=true;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: MyTextStyle.f18(
                                      whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
           ),
        );
      },
    );
  }

  Widget buildWhatOurClientsSaySection(Color backgroundColor,
      Color cardBackgroundColor, Color textColor, Color secondaryTextColor) {
    final reviews = getHomeModel.data?.reviews;
    if (reviews == null || reviews.isEmpty) {
      return const SizedBox();
    }
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'What Our Clients Say',
            style: MyTextStyle.f36(textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _testimonialsPageController, // Changed to testimonialsPageController
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final testimonial = reviews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: buildSmallTestimonialCard(
                    testimonial,
                    cardBackgroundColor,
                    textColor,
                    secondaryTextColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _testimonialsPageController, // Changed to testimonialsPageController
            count: reviews.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: appPrimaryColor,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildSmallTestimonialCard(Reviews testimonial,
      Color cardBackgroundColor, Color textColor, Color secondaryTextColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor, // Use dynamic color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center, // Center content vertically
        crossAxisAlignment:
        CrossAxisAlignment.center, // Center content horizontally
        children: [
          Text(
            testimonial.name??'nullable',
            style:MyTextStyle.f18(
              textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < (testimonial.rating ?? 0).toInt()
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            testimonial.review??'null',
            style:MyTextStyle.f14(
              secondaryTextColor,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
