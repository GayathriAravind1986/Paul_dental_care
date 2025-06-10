import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple/Alertbox/snackBarAlert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/Bloc/Contact/contact_bloc.dart';
import 'package:simple/Bloc/demo/demo_bloc.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
// import 'package:simple/ModelClass/Home/getHomeModel.dart';
import 'package:simple/Reusable/readmore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple/UI/Home_screen/testimonial.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:simple/ModelClass/Home/getHomeModel.dart';
import 'package:simple/Api/apiprovider.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  const HomeScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactDentalBloc(),
      child: HomeScreenView(
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class HomeScreenView extends StatefulWidget
{
  final bool isDarkMode;
  const HomeScreenView({
    super.key,
    required this.isDarkMode,
  });

  @override
  HomeScreenViewState createState() => HomeScreenViewState();
}

class HomeScreenViewState extends State<HomeScreenView>
{
  GetHomeModel getHomeModel = GetHomeModel(success: true,data:null,message: ' ');
  bool homeLoad=false;
  String? errorMessage;
  final PageController _carouselPageController = PageController(initialPage: 0);
  final PageController _newsEventsPageController = PageController(initialPage: 0);
  final PageController _smallTestimonialsPageController = PageController(initialPage: 0);
  final PageController _largeTestimonialPageController = PageController(initialPage: 0);

  Timer? _carouselTimer;
  Timer? _newsEventsTimer;
  Timer? _smallTestimonialsTimer;
  Timer? _largeTestimonialTimer;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  int _selectedStars = 5;

  final List<String> carouselImages = [
    Images.carousel1,
    Images.carousel2,
    Images.carousel3,
  ];

  final List<Map<String, String>> newsEvents = [
    {
      'image': Images.newsEvent1,
      'title': 'Testing',
      'date': '2025-03-20',
      'description':
      'This is a description for the first news event. It provides more details about the testing event that happened on this date.',
    },
    {
      'image': Images.newsEvent2,
      'title': 'Testing 2',
      'date': '2025-03-21',
      'description':
      'This is the description for the second news event. It elaborates on the details of Testing 2, providing context and outcomes.',
    },
  ];

  final List<Testimonial> testimonials = [
    Testimonial(
      clientName: 'Sonia',
      stars: 3,
      shortQuote: '',
      longReview:
      'I was struggling with missing teeth for years, which affected my confidence and ability to eat comfortably. Thanks to the expert care at Paul Dental Care, I got my teeth attached seamlessly. The procedure was smooth, painless, and the results are amazing! Now, I can smile and eat without any worries. Truly life-changing dental care!',
      // clientImagePath: Images.client1, // Assuming a client image for the large card
    ),
    Testimonial(
      clientName: 'Selvam',
      stars: 5,
      shortQuote: '"Best dental clinic"',
      longReview:
      'Best dental clinic. The staff is very friendly and the doctors are highly skilled. I highly recommend Paul Dental Care for all your dental needs.',
    ),
    Testimonial(
      clientName: 'இராஜகுமார்', // Rajakumar
      stars: 4,
      shortQuote: '"Doctor interaction and quality of care are good"',
      longReview:
      'Doctor interaction and quality of care are good. The clinic is clean and well-maintained. I had a pleasant experience during my visit.',
    ),
    // Add more testimonials if needed
  ];

  @override
  void initState() {
    super.initState();
    _startCarouselTimer();
    _startNewsEventsTimer();
    _startSmallTestimonialsTimer();
    _startLargeTestimonialTimer();
    context.read<ContactDentalBloc>().add(HomeDental());
    homeLoad = true;
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_carouselPageController.hasClients) {
        int nextPage = _carouselPageController.page!.toInt() + 1;
        if (nextPage >= carouselImages.length) {
          nextPage = 0; // Loop back to the first page
        }
        _carouselPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void _startNewsEventsTimer() {
    _newsEventsTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (_newsEventsPageController.hasClients) {
        int nextPage = _newsEventsPageController.page!.toInt() + 1;
        if (nextPage >= newsEvents.length) {
          nextPage = 0; // Loop back to the first page
        }
        _newsEventsPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void _startSmallTestimonialsTimer() {
    _smallTestimonialsTimer =
        Timer.periodic(const Duration(seconds: 6), (timer) {
          if (_smallTestimonialsPageController.hasClients) {
            int nextPage = _smallTestimonialsPageController.page!.toInt() + 1;
            if (nextPage >= testimonials.length) {
              nextPage = 0; // Loop back to the first page
            }
            _smallTestimonialsPageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          }
        });
  }

  void _startLargeTestimonialTimer() {
    _largeTestimonialTimer =
        Timer.periodic(const Duration(seconds: 8), (timer) {
          if (_largeTestimonialPageController.hasClients) {
            int nextPage = _largeTestimonialPageController.page!.toInt() + 1;
            // Assuming the large testimonial carousel only has one item for now,
            // or you'd add more long reviews to the 'testimonials' list.
            // For demonstration, we'll loop through all testimonials for the large card.
            if (nextPage >= testimonials.length) {
              nextPage = 0; // Loop back to the first page
            }
            _largeTestimonialPageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          }
        });
  }

  @override
  void dispose() {
    _carouselPageController.dispose();
    _newsEventsPageController.dispose();
    _smallTestimonialsPageController.dispose();
    _largeTestimonialPageController.dispose();
    _carouselTimer?.cancel();
    _newsEventsTimer?.cancel();
    _smallTestimonialsTimer?.cancel();
    _largeTestimonialTimer?.cancel();
    _fullNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }


  bool feedLoad = false;

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // Define colors based on dark mode state
    final Color scaffoldBackgroundColor =
    widget.isDarkMode ? Colors.grey[900]! : whiteColor;
    final Color appBarBackgroundColor =
    widget.isDarkMode ? const Color(0xFF424242) : appPrimaryColor;
    final Color textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor =
    widget.isDarkMode ? Colors.grey[400]! : Colors.grey;
    final Color cardBackgroundColor =
    widget.isDarkMode ? Colors.grey[800]! : const Color(0xFFF8F5FB);
    final Color lightBackground =
    widget.isDarkMode ? Colors.grey[850]! : const Color(0xFFF8F5FB);
    final Color whiteBackground =
    widget.isDarkMode ? Colors.grey[900]! : Colors.white;
    // Modified: purple elements should appear in lightBlueAccent in dark mode.
    final Color darkModeBannerColor =
    widget.isDarkMode ? Colors.lightBlueAccent : Colors.purple;
    // New combined section for carousel and clinic intro

    Widget mainContainer() {
      return SingleChildScrollView(
        // Added SingleChildScrollView here for the home content
        child: Column(
          children: [
            const SizedBox(height:30),
            buildWelcomeSectionWithCarousel(
                lightBackground, textColor, secondaryTextColor),
            const SizedBox(height: 20),
            buildTransformingDentalHealthSection(whiteBackground, textColor,
                secondaryTextColor, darkModeBannerColor),
            const SizedBox(height: 20),
            buildOurTeamSection(lightBackground, textColor, secondaryTextColor,
                darkModeBannerColor),
            const SizedBox(height: 40),
            buildShareReviewButton(lightBackground, darkModeBannerColor),
            const SizedBox(height: 40),
            buildWhatOurClientsSaySection(lightBackground, whiteBackground,
                textColor, secondaryTextColor),
            const SizedBox(height: 20),
            buildDetailedClientTestimonialSection(
                cardBackgroundColor, textColor, secondaryTextColor),
          ],
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          bool shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );
          if (shouldExit == true) {
            // Exit the app
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: appBarBackgroundColor,
            title: Row(
              children: [
                Image.asset(Images.logo1, height: 50, width: 50),
                const SizedBox(width: 10),
                Text(
                  'PAUL DENTAL CARE',
                  style: TextStyle(
                    fontFamily: 'Times New Roman', // Applied font family
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Use dynamic color
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white, // Always white for visibility
                ),
                onPressed: () {
                  setState(() {
                    //   widget.isDarkMode = !widget.isDarkMode; // Toggle dark mode
                  });
                },
              ),
            ],
          ),
          body: BlocBuilder<ContactDentalBloc, dynamic>(
            buildWhen: ((previous, current) {
              debugPrint("current:$current");
              // if (current is PutFeedBackModel) {
              //   putFeedBackModel = current;
              //   if (current.errorResponse != null) {
              //     if (current.errorResponse!.errors != null &&
              //         current.errorResponse!.errors!.isNotEmpty) {
              //       errorMessage = current.errorResponse!.errors![0].message ??
              //           "Something went wrong";
              //     } else {
              //       errorMessage = "Something went wrong";
              //     }
              //     showToast("$errorMessage", context, color: false);
              //     setState(() {
              //       feedLoad = false;
              //     });
              //   } else if (putFeedBackModel.success == true) {
              //     if (putFeedBackModel.data?.status == true) {
              //       debugPrint("putFeedBackModel:${putFeedBackModel.message}");
              //       setState(() {
              //         showToast("${putFeedBackModel.message}", context,
              //             color: true);
              //         feedLoad = false;
              //       });
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //           builder: (context) => const DashboardScreen(
              //             selectTab: 3,
              //           )));
              //     } else if (putFeedBackModel.data?.status == false) {
              //       debugPrint("putFeedBackModel:${putFeedBackModel.message}");
              //       setState(() {
              //         showToast("${putFeedBackModel.message}", context,
              //             color: false);
              //         feedLoad = false;
              //       });
              //     }
              //   }
              //   return true;
              // }
              return false;
            }),
            builder: (context, dynamic) {
              return mainContainer();
            },
          )),
    );
  }

  Widget buildWelcomeSectionWithCarousel(
      Color backgroundColor, Color textColor, Color secondaryTextColor) {
    // darkModeBannerColor is not directly passed here, but it's available in the class scope.
    // Ensure all references to Colors.purple are replaced with darkModeBannerColor
    final Color dynamicPurple =
    widget.isDarkMode ? Colors.lightBlueAccent : Colors.purple;

    return Column(
      children: [
        // Carousel part
        Container(
          // Added Container to set background color for the carousel area
          color: backgroundColor, // Set background color to match clinic intro
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _carouselPageController,
                  itemCount: carouselImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          carouselImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          // Add error handling for image loading if needed
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Text('Image not found',
                                    style: TextStyle(color: Colors.black54)),
                              ),
                            );
                          },
                        ),
                      ),
                      // CachedNetworkImage(
                      //   imageUrl:
                      //   "${getUserDetailsModel.data!.userDetails!.imageUrl}",
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      //   errorWidget: (context, url, error) {
                      //     return const Icon(
                      //       Icons.error,
                      //       size: 30,
                      //       color: appHomeTextColor,
                      //     );
                      //   },
                      //   progressIndicatorBuilder:
                      //       (context, url, downloadProgress) =>
                      //   const SpinKitCircle(
                      //       color: appPrimaryColor,
                      //       size: 30),
                      // )
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SmoothPageIndicator(
                controller: _carouselPageController,
                count: carouselImages.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: widget.isDarkMode
                      ? Colors.amber
                      : appPrimaryColor, // Adjust dot color
                ),
              ),
              const SizedBox(
                  height: 20), // Spacing between carousel and intro text
            ],
          ),
        ),

        // Clinic Intro part
        Container(
          color: backgroundColor, // Use dynamic color
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 2,
                    color:
                    dynamicPurple, // Changed from hardcoded Colors.purple
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                  Text(
                    'We are Here',
                    style: TextStyle(
                      fontFamily: 'Times New Roman', // Applied font family
                      color:
                      dynamicPurple, // Changed from hardcoded Colors.purple
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome To Our Clinic',
                style: TextStyle(
                  fontFamily: 'Times New Roman', // Applied font family
                  color: textColor, // Use dynamic color
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to our clinic, where your smile is our priority! Our experienced team is dedicated to providing gentle, high-quality dental care in a comfortable and friendly environment. Whether you\'re here for a routine check-up, cosmetic enhancement, or specialized treatment, we ensure a personalized experience that keeps your oral health at its best. Step in and let us brighten your smile today!',
                                style: TextStyle(
                                  fontFamily:
                                  'Times New Roman', // Applied font family
                                  color:
                                  secondaryTextColor, // Use dynamic color
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'We are committed to delivering exceptional dental care with a focus on comfort and patient satisfaction. Our state-of-the-art facility, combined with a compassionate team, ensures a stress-free and pleasant experience for every visit. Whether you need preventive care, restorative treatment, or a confidence-boosting smile makeover, we’re here to help you achieve optimal oral health.',
                                style: TextStyle(
                                  fontFamily:
                                  'Times New Roman', // Applied font family
                                  color:
                                  secondaryTextColor, // Use dynamic color
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to our clinic, where your smile is our priority! Our experienced team is dedicated to providing gentle, high-quality dental care in a comfortable and friendly environment. Whether you\'re here for a routine check-up, cosmetic enhancement, or specialized treatment, we ensure a personalized experience that keeps your oral health at its best. Step in and let us brighten your smile today!',
                          style: TextStyle(
                            fontFamily:
                            'Times New Roman', // Applied font family
                            color: secondaryTextColor, // Use dynamic color
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'We are committed to delivering exceptional dental care with a focus on comfort and patient satisfaction. Our state-of-the-art facility, combined with a compassionate team, ensures a stress-free and pleasant experience for every visit. Whether you need preventive care, restorative treatment, or a confidence-boosting smile makeover, we’re here to help you achieve optimal oral health.',
                          style: TextStyle(
                            fontFamily:
                            'Times New Roman', // Applied font family
                            color: secondaryTextColor, // Use dynamic color
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTransformingDentalHealthSection(Color backgroundColor,
      Color textColor, Color secondaryTextColor, Color purpleColor) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      color: backgroundColor, // Use dynamic color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 1, // Stats take less space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildStatCard(
                              '${getHomeModel.data?.appointmentCount}',
                              'Daily appointments'
                          ),
                          const SizedBox(height: 24),
                          buildStatCard(
                            '563',
                            'Happy Clients',
                          ), // Pass colors
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Single column layout for smaller screens
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    buildStatCard(
                      '${getHomeModel.data?.appointmentCount}',
                      'Daily appointments',
                    ),
                    const SizedBox(height: 24),
                    buildStatCard(
                      '563',
                      'Happy Clients',
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Reverted to simple Text widget, removing AnimatedCounter
  Widget buildStatCard(String number, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number, // Display the number directly
          style: const TextStyle(
            fontFamily: 'Times New Roman', // Applied font family
            color: Colors.blue, // Blue color for numbers as per image
            fontSize: 48,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color:Colors.purple,
            fontFamily: 'Times New Roman',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildServiceItem(String text, Color textColor, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle,
              color: iconColor, size: 20), // Purple checkmark icon, now dynamic
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Times New Roman', // Applied font family
                color: textColor, // Use dynamic color
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOurTeamSection(Color backgroundColor, Color textColor,
      Color secondaryTextColor, Color purpleColor) {
    return Container(
      color: backgroundColor, // Use dynamic color
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Expert Doctors" section
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
                style: TextStyle(
                  fontFamily: 'Times New Roman', // Applied font family
                  color: purpleColor, // Now dynamic
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // "Our Team" heading
          Text(
            'Our Team',
            style: TextStyle(
              fontFamily: 'Times New Roman', // Applied font family
              color: textColor, // Use dynamic color
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            'Our dedicated team of experienced dentists and caring staff is committed to providing top-quality dental care with a personal touch. From routine check-ups to advanced treatments, we ensure a comfortable and stress-free experience for every patient.',
            style: TextStyle(
              fontFamily: 'Times New Roman', // Applied font family
              color: secondaryTextColor, // Use dynamic color
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Doctor Profiles
          LayoutBuilder(
            builder: (context, constraints) {
              // Adjust breakpoint as needed
              if (constraints.maxWidth > 700) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: buildDoctorCard(
                            Images.drPaulRaj,
                            'Dr Paul Raj',
                            'BDS Implantologist',
                            textColor,
                            secondaryTextColor)), // Pass colors
                    const SizedBox(width: 20),
                    Expanded(
                        child: buildDoctorCard(
                            Images.drBalaKrishnan,
                            'Dr Bala Krishnan',
                            'MDS Oral Maxilo Facial Surgery',
                            textColor,
                            secondaryTextColor)), // Pass colors
                    const SizedBox(width: 20),
                    Expanded(
                        child: buildDoctorCard(
                            Images.drJenarthan,
                            'Dr Jenarthan',
                            'MDS Paedodontist',
                            textColor,
                            secondaryTextColor)), // Pass colors
                  ],
                );
              } else if (constraints.maxWidth > 400) {
                // Two columns for medium screens
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: buildDoctorCard(
                                Images.drPaulRaj,
                                'Dr Paul Raj',
                                'BDS Implantologist',
                                textColor,
                                secondaryTextColor)), // Pass colors
                        const SizedBox(width: 20),
                        Expanded(
                            child: buildDoctorCard(
                                Images.drBalaKrishnan,
                                'Dr Bala Krishnan',
                                'MDS Oral Maxilo Facial Surgery',
                                textColor,
                                secondaryTextColor)), // Pass colors
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildDoctorCard(
                        Images.drJenarthan,
                        'Dr Jenarthan',
                        'MDS Paedodontist',
                        textColor,
                        secondaryTextColor), // Pass colors
                  ],
                );
              } else {
                // Single column for small screens
                return Column(
                  children: [
                    buildDoctorCard(
                        Images.drPaulRaj,
                        'Dr Paul Raj',
                        'BDS Implantologist',
                        textColor,
                        secondaryTextColor), // Pass colors
                    const SizedBox(height: 20),
                    buildDoctorCard(
                        Images.drBalaKrishnan,
                        'Dr Bala Krishnan',
                        'MDS Oral Maxilo Facial Surgery',
                        textColor,
                        secondaryTextColor), // Pass colors
                    const SizedBox(height: 20),
                    buildDoctorCard(
                        Images.drJenarthan,
                        'Dr Jenarthan',
                        'MDS Paedodontist',
                        textColor,
                        secondaryTextColor), // Pass colors
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDoctorCard(String imagePath, String name, String specialization,
      Color textColor, Color secondaryTextColor) {
    return Column(
      children: [
        ClipRRect(
          borderRadius:
          BorderRadius.circular(12), // Rounded corners for doctor images
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 200, // Fixed height for doctor images
            width: double.infinity, // Take full width of its container
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Text('Image not found',
                      style: TextStyle(color: Colors.black54)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Times New Roman', // Applied font family
            color: textColor, // Use dynamic color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          specialization,
          style: TextStyle(
            fontFamily: 'Times New Roman', // Applied font family
            color: secondaryTextColor, // Use dynamic color
            fontSize: 14,
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
        child: const Text(
          'Share Review',
          style: TextStyle(
            fontFamily: 'Times New Roman', // Applied font family
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void showReviewDialog(
      BuildContext context, Color dialogFieldFillColor, Color purpleColor) {
    // Define colors for the dialog based on dark mode state
    final Color dialogBackgroundColor =
    widget.isDarkMode ? Colors.grey[800]! : Colors.white;
    final Color dialogTextColor =
    widget.isDarkMode ? Colors.white : Colors.black;
    final Color dialogLabelColor =
    widget.isDarkMode ? Colors.grey[400]! : Colors.grey;

    // A GlobalKey to manage the form state for validation
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use a StatefulBuilder inside the dialog to manage its internal state (like selected stars)
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero, // Remove default padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: dialogBackgroundColor, // Use dynamic color
              content: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width *
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
                          style: TextStyle(
                            fontFamily:
                            'Times New Roman', // Applied font family
                            color: dialogTextColor, // Use dynamic color
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Full Name Text Field
                        TextFormField(
                          controller: _fullNameController,
                          style: TextStyle(
                              fontFamily: 'Times New Roman',
                              color: dialogTextColor), // Text color in field
                          decoration: InputDecoration(
                            labelText: 'Full Name*',
                            labelStyle: TextStyle(
                                fontFamily: 'Times New Roman',
                                color: dialogLabelColor), // Use dynamic color
                            filled: true,
                            fillColor:
                            dialogFieldFillColor, // Use dynamic color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none, // No border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: purpleColor,
                                  width:
                                  2), // Purple border on focus, now dynamic
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
                                  color: dialogLabelColor), // Use dynamic color
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    // Use setState from StatefulBuilder
                                    _selectedStars = newValue;
                                  });
                                }
                              },
                              items: List.generate(5, (index) {
                                // Generate stars in descending order: 5, 4, 3, 2, 1
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
                        // Review Text Field
                        TextFormField(
                          controller: _reviewController,
                          maxLines: 4,
                          style: TextStyle(
                              fontFamily: 'Times New Roman',
                              color: dialogTextColor), // Text color in field
                          decoration: InputDecoration(
                            labelText: 'Review',
                            labelStyle: TextStyle(
                                fontFamily: 'Times New Roman',
                                color: dialogLabelColor), // Use dynamic color
                            filled: true,
                            fillColor:
                            dialogFieldFillColor, // Use dynamic color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none, // No border
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: purpleColor,
                                  width:
                                  2), // Purple border on focus, now dynamic
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
                                // Validate the form
                                // All fields are valid, proceed with submission
                                print('Full Name: ${_fullNameController.text}');
                                print('Stars: $_selectedStars');
                                print('Review: ${_reviewController.text}');
                                Navigator.of(context)
                                    .pop(); // Close the dialog after submission
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .transparent, // Make button transparent to show gradient
                              shadowColor: Colors.transparent, // No shadow
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontFamily:
                                'Times New Roman', // Applied font family
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
        );
      },
    );
  }


  Widget buildWhatOurClientsSaySection(Color backgroundColor,
      Color cardBackgroundColor, Color textColor, Color secondaryTextColor) {
    return Container(
      color: backgroundColor, // Use dynamic color
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the heading
        children: [
          Text(
            'What Our Clients Say',
            style: TextStyle(
              fontFamily: 'Times New Roman', // Applied font family
              color: textColor, // Use dynamic color
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200, // Height for the small testimonial cards
            child: PageView.builder(
              controller: _smallTestimonialsPageController,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: buildSmallTestimonialCard(
                      testimonial,
                      cardBackgroundColor,
                      textColor,
                      secondaryTextColor), // Pass colors
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SmoothPageIndicator(
              controller: _smallTestimonialsPageController,
              count: testimonials.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: widget.isDarkMode
                    ? Colors.amber
                    : Colors.black54, // Adjust dot color
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmallTestimonialCard(Testimonial testimonial,
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
            testimonial.clientName,
            style: TextStyle(
              fontFamily: 'Times New Roman', // Applied font family
              color: textColor, // Use dynamic color
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < testimonial.stars ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            testimonial.shortQuote,
            style: TextStyle(
              fontFamily: 'Times New Roman', // Applied font family
              color: secondaryTextColor, // Use dynamic color
              fontSize: 14,
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

  Widget buildDetailedClientTestimonialSection(
      Color cardBackgroundColor, Color textColor, Color secondaryTextColor) {
    return Container(
      color: widget.isDarkMode
          ? Colors.grey[900]
          : Colors.white, // Use dynamic color
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          SizedBox(
            height: 400, // Increased height for the large testimonial card
            child: PageView.builder(
              controller: _largeTestimonialPageController,
              itemCount: testimonials
                  .length, // Display all testimonials in this carousel
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: buildLargeTestimonialCard(
                      testimonial,
                      cardBackgroundColor,
                      textColor,
                      secondaryTextColor), // Pass colors
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SmoothPageIndicator(
              controller: _largeTestimonialPageController,
              count: testimonials.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: widget.isDarkMode
                    ? Colors.amber
                    : Colors.black54, // Adjust dot color
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLargeTestimonialCard(Testimonial testimonial,
      Color cardBackgroundColor, Color textColor, Color secondaryTextColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBackgroundColor, // Use dynamic color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (testimonial.clientImagePath != null)
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(30), // Adjusted for smaller radius
                  child: Image.asset(
                    testimonial.clientImagePath!,
                    fit: BoxFit.cover,
                    height: 60, // Adjusted height
                    width: 60, // Adjusted width
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to CircleAvatar with first letter if image fails to load
                      return CircleAvatar(
                        radius: 20, // Half of height/width for perfect circle
                        backgroundColor:
                        Colors.blue, // Example background color
                        child: Text(
                          testimonial.clientName.isNotEmpty
                              ? testimonial.clientName[0].toUpperCase()
                              : '', // Get first letter
                          style: const TextStyle(
                            fontFamily:
                            'Times New Roman', // Applied font family
                            color: Colors.white,
                            fontSize: 24, // Adjusted font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                )
              else // Fallback to CircleAvatar if clientImagePath is null
                CircleAvatar(
                  radius: 30, // Adjusted radius
                  backgroundColor: Colors.blue, // Example background color
                  child: Text(
                    testimonial.clientName.isNotEmpty
                        ? testimonial.clientName[0].toUpperCase()
                        : '', // Get first letter
                    style: const TextStyle(
                      fontFamily: 'Times New Roman', // Applied font family
                      color: Colors.white,
                      fontSize: 20, // Adjusted font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                // Wrap client name with Expanded to prevent overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.clientName,
                      style: TextStyle(
                        fontFamily: 'Times New Roman', // Applied font family
                        color: textColor, // Use dynamic color
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Paul Dental Care',
                      style: TextStyle(
                        fontFamily: 'Times New Roman', // Applied font family
                        color: secondaryTextColor, // Use dynamic color
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < testimonial.stars ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 24,
              );
            }),
          ),
          const SizedBox(height: 16),
          Icon(Icons.format_quote,
              color: secondaryTextColor,
              size: 30), // Quote icon, use dynamic color
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              testimonial.longReview,
              style: TextStyle(
                fontFamily: 'Times New Roman', // Applied font family
                color: secondaryTextColor, // Use dynamic color
                fontSize: 16,
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5, // Adjust as needed
            ),
          ),
        ],
      ),
    );
  }
}
