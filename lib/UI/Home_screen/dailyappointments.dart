import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import for SpinKit
import 'package:simple/ModelClass/Home/getHomeModel.dart'; // Ensure this path is correct
import 'package:simple/Reusable/text_styles.dart'; // Ensure this path is correct
import 'package:simple/Reusable/color.dart'; // Ensure this path is correct

class TransformingDentalHealthSection extends StatelessWidget {
  final GetHomeModel? getHomeModel;
  final bool homeLoad; // Add this parameter to receive loading status
  final Color backgroundColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color purpleColor;

  const TransformingDentalHealthSection({
    Key? key,
    required this.getHomeModel,
    required this.homeLoad, // Make sure to require this
    required this.backgroundColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.purpleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (homeLoad) {
      // Show loader when data is being fetched for this section
      return Container(
        height: 200, // Give it a fixed height or min-height for the loader
        alignment: Alignment.center,
        color: backgroundColor,
        child: const SpinKitChasingDots(color: appPrimaryColor, size: 30),
      );
    } else if (getHomeModel?.data == null ||
        (getHomeModel?.data?.appointmentCount == null && getHomeModel?.data?.clientCount == null)) {
      // Show a message if no data is found for this section (after loading)
      return Container(
        padding: const EdgeInsets.all(32.0),
        color: backgroundColor,
        alignment: Alignment.center,
        child: Text(
          "No stats data available.",
          style: MyTextStyle.f16(
            secondaryTextColor,
            weight: FontWeight.w500,
          ),
        ),
      );
    } else {
      // Display the actual content when data is loaded
      return Container(
        padding: const EdgeInsets.all(32.0),
        color: backgroundColor,
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
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatCard(
                              '${getHomeModel?.data?.appointmentCount ?? '0'}',
                              'Daily appointments',
                            ),
                            const SizedBox(height: 24),
                            // _buildStatCard(
                            //   '${getHomeModel?.data?.clientCount ?? '0'}',
                            //   'Happy Clients',
                            // ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      _buildStatCard(
                        '${getHomeModel?.data?.appointmentCount ?? '0'}',
                        'Daily appointments',
                      ),
                      const SizedBox(height: 24),
                      // _buildStatCard(
                      //   '${getHomeModel?.data?.clientCount ?? '0'}',
                      //   'Happy Clients',
                      // ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      );
    }
  }

  Widget _buildStatCard(String number, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: MyTextStyle.f58(
            blueColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: MyTextStyle.f26(
            purpleColor,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}