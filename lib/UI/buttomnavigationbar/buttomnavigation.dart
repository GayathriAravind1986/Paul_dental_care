import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/UI/Event_Screen/events.dart';
import 'package:simple/UI/Home_screen/home_screen.dart';
import 'package:simple/UI/awareness_screen/awareness.dart';
import 'package:simple/UI/contact_screen/contact_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(
      isDarkMode: false,
    ),
    EventsPage(
      isDarkMode: false,
    ),
    AwarenessPage(
      isDarkMode: false,
    ),
    ContactScreen(
      isDarkMode: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
        onWillPop: () async {
          if (_currentIndex != 0) {
            // If not on home screen, switch to home tab instead of exiting
            setState(() => _currentIndex = 0);
            return false;
          } else {
            // On home screen - check if we can pop any routes
            if (Navigator.of(context).canPop()) {
              return true; // Allow normal back navigation
            } else {
              // At root home screen - show exit confirmation
              final shouldExit = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Exit App"),
                  content: const Text("Are you sure you want to exit?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true); // Close dialog
                        SystemNavigator.pop(); // Exit app
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
              return shouldExit ?? false;
            }
          }
        },
        child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          isDarkMode: isDarkMode,
        ),
      )
    );
    // );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDarkMode;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isDarkMode,
  });

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
    BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Awareness'),
    BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: isDarkMode ? Colors.amber : appPrimaryColor,
      unselectedItemColor:
          isDarkMode ? Colors.grey[600] : blackColor.withOpacity(0.5),
      backgroundColor: isDarkMode ? Colors.grey[800] : whiteColor,
      onTap: onTap,
      items: navItems,
    );
  }
}
