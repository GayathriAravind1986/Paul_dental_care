import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Your reusable imports
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/text_styles.dart';
import 'package:simple/ModelClass/Home/getHomeModel.dart'; // Ensure this path is correct

class WelcomeSectionWithCarousel extends StatefulWidget {
  final GetHomeModel? getHomeModel;
  final bool homeLoad;
  final Size size;
  final Color backgroundColor;
  final Color textColor;
  final Color secondaryTextColor;

  const WelcomeSectionWithCarousel({
    Key? key,
    required this.getHomeModel,
    required this.homeLoad,
    required this.size,
    required this.backgroundColor,
    required this.textColor,
    required this.secondaryTextColor,
  }) : super(key: key);

  @override
  State<WelcomeSectionWithCarousel> createState() => _WelcomeSectionWithCarouselState();
}

class _WelcomeSectionWithCarouselState extends State<WelcomeSectionWithCarousel> {
  late PageController _carouselPageController;
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();
    _carouselPageController = PageController();
    // Start auto-scroll immediately if data is already available on initState (e.g., hot restart)
    if (widget.getHomeModel?.data?.slideshow != null && (widget.getHomeModel?.data?.slideshow?.length ?? 0) > 1) {
      _startSlideshowAutoScroll();
    }
  }

  @override
  void didUpdateWidget(covariant WelcomeSectionWithCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Condition to start/restart auto-scroll:
    // 1. Data was null or empty, and now it's available and has more than 1 item.
    // 2. The slideshow content itself has changed (e.g., different length).
    final bool newSlideshowAvailable = widget.getHomeModel?.data?.slideshow != null && (widget.getHomeModel!.data!.slideshow!.length ?? 0) > 1;
    final bool oldSlideshowNotAvailableOrDifferent =
        oldWidget.getHomeModel?.data?.slideshow == null ||
            (oldWidget.getHomeModel!.data!.slideshow!.length ?? 0) <= 1 ||
            (widget.getHomeModel!.data!.slideshow!.length != oldWidget.getHomeModel!.data!.slideshow!.length);

    if (newSlideshowAvailable && oldSlideshowNotAvailableOrDifferent) {
      _startSlideshowAutoScroll();
    } else if (widget.homeLoad == true && oldWidget.homeLoad == false) {
      // If it transitions back to loading (unlikely for this widget to go back to true homeLoad), cancel any timer
      _carouselTimer?.cancel();
    }
  }

  void _startSlideshowAutoScroll() {
    _carouselTimer?.cancel(); // Cancel any existing timer to prevent multiple timers

    final slideshowLength = widget.getHomeModel?.data?.slideshow?.length ?? 0;

    if (slideshowLength > 1) { // Only start if there's more than one image to scroll meaningfully
      _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_carouselPageController.hasClients) {
          int nextPage = _carouselPageController.page!.round() + 1;
          if (nextPage >= slideshowLength) {
            nextPage = 0; // Loop back to the first page
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

  @override
  void dispose() {
    _carouselPageController.dispose();
    _carouselTimer?.cancel(); // Ensure the timer is cancelled to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.homeLoad) {
      return const SpinKitChasingDots(color: appPrimaryColor, size: 30);
    } else if (widget.getHomeModel?.data == null || widget.getHomeModel!.data!.slideshow == null || widget.getHomeModel!.data!.slideshow!.isEmpty) {
      return Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        alignment: Alignment.center,
        child: Text(
          "No Images found !!!",
          style: MyTextStyle.f16(
            appPrimaryColor,
            weight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            color: widget.backgroundColor,
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _carouselPageController,
                    itemCount: widget.getHomeModel!.data!.slideshow!.length,
                    itemBuilder: (context, index) {
                      final slideshowItem = widget.getHomeModel!.data!.slideshow![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: "${slideshowItem.image}",
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  size: 30,
                                  color: appHomeTextColor,
                                ),
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                const SpinKitCircle(color: appPrimaryColor, size: 30),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    slideshowItem.title ?? '',
                                    style: MyTextStyle.f24(whiteColor, weight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    slideshowItem.subtitle ?? '',
                                    style: MyTextStyle.f14(whiteColor, weight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SmoothPageIndicator(
                  controller: _carouselPageController,
                  count: widget.getHomeModel!.data!.slideshow!.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: appPrimaryColor,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            color: widget.backgroundColor,
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 2,
                      color: dynamicPurple,
                      margin: const EdgeInsets.only(right: 8.0),
                    ),
                    Text(
                      'We are Here',
                      style: MyTextStyle.f16(
                        dynamicPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome To Our Clinic',
                  style: MyTextStyle.f48(
                    widget.textColor,
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
                                  style: MyTextStyle.f16(
                                    widget.secondaryTextColor,
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
                                  style: MyTextStyle.f16(
                                    widget.secondaryTextColor,
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
                            style: MyTextStyle.f16(
                              widget.secondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'We are committed to delivering exceptional dental care with a focus on comfort and patient satisfaction. Our state-of-the-art facility, combined with a compassionate team, ensures a stress-free and pleasant experience for every visit. Whether you need preventive care, restorative treatment, or a confidence-boosting smile makeover, we’re here to help you achieve optimal oral health.',
                            style: MyTextStyle.f16(
                              widget.secondaryTextColor,
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
  }
}
