import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple/Alertbox/snackBarAlert.dart';
import 'package:simple/Bloc/Contact/contact_bloc.dart';
import 'package:simple/ModelClass/Events/getEventModel.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
import 'package:simple/Reusable/text_styles.dart';
import 'package:simple/UI/buttomnavigationbar/buttomnavigation.dart';

class EventsPage extends StatelessWidget {
  final bool isDarkMode;
  const EventsPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactDentalBloc()..add(EventDental()),
      child: EventsPageView(isDarkMode: isDarkMode),
    );
  }
}

class EventsPageView extends StatefulWidget {
  final bool isDarkMode;
  const EventsPageView({super.key, required this.isDarkMode});

  @override
  State<EventsPageView> createState() => _EventsPageViewState();
}

class _EventsPageViewState extends State<EventsPageView> {
  GetEventModel getEventModel = GetEventModel();
  String? errorMessage;
  bool eventLoad = true;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final Color placeholderColor = Colors.grey.shade200;
  final Color placeholderTextColor = Colors.black54;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousImage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _pageController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _nextImage(int length) {
    if (_currentPage < length - 1) {
      setState(() => _currentPage++);
      _pageController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = widget.isDarkMode ? greyColor : whiteColor;
    final appBarBackgroundColor =
    widget.isDarkMode ? appBarBackgroundColordark : appPrimaryColor;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
                (route) => false,
          );
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
              Text('PAUL DENTAL CARE', style: MyTextStyle.f20(whiteColor)),
            ],
          ),
        ),
        body: BlocBuilder<ContactDentalBloc, dynamic>(
          buildWhen: (previous, current) {
            if (current is GetEventModel) {
              getEventModel = current;
              if (current.errorResponse?.errors?.isNotEmpty == true) {
                errorMessage =
                    current.errorResponse!.errors!.first.message ?? "Something went wrong";
                showToast(errorMessage!, context, color: false);
              } else if (current.success == true &&
                  current.data?.status == true) {
                // Success: no toast needed
              } else {
                showToast(current.message ?? "Something went wrong", context, color: false);
              }
              setState(() => eventLoad = false);
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return mainContainer(context);
          },
        ),
      ),
    );
  }

  Widget mainContainer(BuildContext context) {
    if (eventLoad) {
      return const Center(
        child: SpinKitChasingDots(color: appPrimaryColor, size: 30),
      );
    }

    if (getEventModel.data == null || getEventModel.data!.events?.isEmpty == true) {
      return Center(
        child: Text(
          "No Events found !!!",
          style: MyTextStyle.f16(appPrimaryColor, weight: FontWeight.w500),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: getEventModel.data!.events!.asMap().entries.map((entry) {
          final index = entry.key;
          final e = entry.value;
          final List<String> eventImages = e.images ?? [];

          return Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: "${e.bannerImage}",
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                          const Icon(Icons.error, size: 30, color: appHomeTextColor),
                          progressIndicatorBuilder: (_, __, ___) =>
                          const SpinKitCircle(color: appPrimaryColor, size: 30),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('${e.title}', style: MyTextStyle.f20(titleColor)),
                      const SizedBox(height: 6),
                      Text('Date: ${e.eventDate}', style: MyTextStyle.f16(textColor)),
                      const SizedBox(height: 6),
                      Text('${e.description}', style: MyTextStyle.f14(descriptionColor)),

                      if (eventImages.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text('Event Images', style: MyTextStyle.f16(textColor)),
                        const SizedBox(height: 10),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: eventImages.length,
                                onPageChanged: (i) => setState(() => _currentPage = i),
                                itemBuilder: (_, i) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: eventImages[i],
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) => Container(
                                        color: placeholderColor,
                                        child: Center(
                                          child: Text(
                                            'Image not found',
                                            style: TextStyle(color: placeholderTextColor),
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder: (_, __, ___) =>
                                      const SpinKitCircle(color: appPrimaryColor, size: 30),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (_currentPage > 0)
                              Positioned(
                                left: 0,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios, color: iconColorevents),
                                  onPressed: _previousImage,
                                ),
                              ),
                            if (_currentPage < eventImages.length - 1)
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios, color: iconColorevents),
                                  onPressed: () => _nextImage(eventImages.length),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
