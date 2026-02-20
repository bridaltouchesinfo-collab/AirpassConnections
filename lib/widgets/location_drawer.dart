import 'package:flutter/material.dart';

class LocationDrawer extends StatefulWidget {
  final String currentLocation;

  const LocationDrawer({
    super.key,
    required this.currentLocation,
  });

  @override
  State<LocationDrawer> createState() => _LocationDrawerState();
}

class _LocationDrawerState extends State<LocationDrawer> {
  late String selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F7FA),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 25),

            /// 🔹 Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    size: 22,
                    color: Color(0xFF1F2C44),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Select Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2C44),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// 🔹 Location Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _locationCard(
                    "Orlando",
                    "HML Counter inside MCO Airport - B Terminal Level 1 (B38)",
                  ),
                  _locationCard(
                    "Atlanta",
                    "Hartsfield-Jackson Atlanta International Airport",
                  ),
                  _locationCard(
                    "Miami / Bayside",
                    "401 Biscayne Blvd, Miami, FL, USA",
                  ),
                ],
              ),
            ),

            /// 🔹 App Version (Subtle)
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "Version 1.0.1",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// Premium Location Card
  ////////////////////////////////////////////////////////////

  Widget _locationCard(String title, String subtitle) {
    final bool isSelected = selectedLocation == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocation = title;
        });

        Future.delayed(const Duration(milliseconds: 180), () {
          Navigator.pop(context, title);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2E3F55)
              : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [

            /// Icon Circle
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.15)
                    : const Color(0xFFF0F2F5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.apartment_outlined,
                size: 20,
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF2E3F55),
              ),
            ),

            const SizedBox(width: 16),

            /// Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none, // 👈 force remove underline
                      color:
                      isSelected ? Colors.white : const Color(0xFF1F2C44),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      decoration: TextDecoration.none, // 👈 force remove underline
                      color: isSelected
                          ? Colors.white70
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            /// Check Indicator
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSelected ? 1 : 0,
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}