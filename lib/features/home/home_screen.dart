import 'package:flutter/material.dart';
import '../booking/luggage_delivery_screen.dart';
import '../../widgets/service_card.dart';
import '../../widgets/location_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 20),

          /// 🔹 Main Booking Card
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LuggageDeliveryScreen(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
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
                  const Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Book Luggage\nDelivery Services",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2C44),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Travel light, we'll take the weight",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Image.asset(
                      "lib/assets/images/booknow_icon.png", // ✅ fixed path
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// 🔹 Service Buttons
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final services = [
                {
                  "icon": Icons.work_outline,
                  "title":
                  "Large Group\nLuggage Service",
                },
                {
                  "icon": Icons.search,
                  "title":
                  "Lost Luggage\nRetrieval",
                },
                {
                  "icon":
                  Icons.inventory_2_outlined,
                  "title":
                  "Team/Sports\nLuggage",
                },
              ];

              return ServiceCard(
                icon:
                services[index]["icon"] as IconData,
                title:
                services[index]["title"] as String,
              );
            },
          ),

          const SizedBox(height: 30),

          /// 🔹 Locations Section
          const Text(
            "The Luggage Hub Locations",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2C44),
            ),
          ),

          const SizedBox(height: 15),

          const LocationTile(
            title:
            "Orlando International Airport (MCO)",
            subtitle:
            "Terminal B - Level 1, Next to Dollar Car Rental",
          ),
          const LocationTile(
            title:
            "Bayside Marketplace - Downtown Miami",
            subtitle:
            "401 Biscayne Blvd, Miami, FL 33132",
          ),
          const LocationTile(
            title:
            "Downtown Atlanta (Near Hartsfield-Jackson Atlanta International Airport)",
            subtitle: "ATL Airport",
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}