import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 20),

          /// 🔹 Pricing Banner
          _pricingBanner(),

          const SizedBox(height: 30),

          /// 🔹 Same Day
          _pricingSection(
            title: "Same Day Luggage Storage",
            prices: const {
              "Large / Med": "\$10.00",
              "Small Carry on": "\$7.00",
              "Small / Personal / Back Packs": "\$6.00",
            },
          ),

          const SizedBox(height: 30),

          /// 🔹 Multiple Day
          _pricingSection(
            title: "Multiple Day Luggage Storage",
            prices: const {
              "Large / Med": "\$8.00",
              "Small Carry on": "\$6.00",
              "Small / Personal / Back Packs": "\$6.00",
            },
          ),

          const SizedBox(height: 30),

          /// 🔹 Monthly
          _pricingSection(
            title: "Monthly Luggage Storage",
            prices: const {
              "Large / Med": "\$8.00",
              "Small Carry on": "\$6.00",
              "Small / Personal / Back Packs": "\$6.00",
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ---------------- PRICING BANNER ----------------

  Widget _pricingBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          const Expanded(
            child: Text(
              "Luggage Storage\nPricing",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.monetization_on_outlined,
              color: Color(0xFF2E3F55),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- PRICING SECTION ----------------

  Widget _pricingSection({
    required String title,
    required Map<String, String> prices,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Section Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE9E6F6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// Table Header
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Type",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "Price Per Bag",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Price Rows
        ...prices.entries.map(
              (entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                Text(
                  entry.value,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}