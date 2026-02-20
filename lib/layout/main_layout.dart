import 'dart:ui';
import 'package:flutter/material.dart';

import '../features/help/help_screen.dart';
import '../features/orders/orders_screen.dart';
import '../widgets/location_header.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/location_drawer.dart';
import '../features/home/home_screen.dart';
import '../features/pricing/pricing_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  int currentIndex = 0;
  String selectedLocation = "Orlando";

  String getSubtitle(String location) {
    switch (location) {
      case "Atlanta":
        return "Hartsfield-Jackson Atlanta International Airport";
      case "Miami / Bayside":
        return "401 Biscayne Blvd, Miami, FL, USA";
      default:
        return "HML Counter inside MCO Airport - B Terminal Level 1 (B38)";
    }
  }

  ////////////////////////////////////////////////////////////
  /// 🔥 Modern Blur Sidebar
  ////////////////////////////////////////////////////////////

  void _openLocationSidebar() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Location",
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, __, ___) {
        return Stack(
          children: [

            /// 🔹 Blur Background
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
            ),

            /// 🔹 Sliding Panel
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: LocationDrawer(
                    currentLocation: selectedLocation,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value is String) {
        setState(() {
          selectedLocation = value;
        });
      }
    });
  }

  ////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      body: SafeArea(
        child: Column(
          children: [

            /// 🔹 Location Header (Now Opens Blur Sidebar)
            Padding(
              padding: const EdgeInsets.all(20),
              child: LocationHeader(
                title: selectedLocation,
                subtitle: getSubtitle(selectedLocation),
                onTap: _openLocationSidebar,
              ),
            ),

            /// 🔹 Content Switch
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: const [
                  HomeScreen(),
                  PricingScreen(),
                  OrdersScreen(),
                  HelpScreen(),
                ],
              ),
            ),
          ],
        ),
      ),

      /// 🔹 Bottom Navigation
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}