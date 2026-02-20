import 'package:flutter/material.dart';

import '../../widgets/priceRowWidget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  final TextEditingController orderController = TextEditingController();
  bool showOrder = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// 🔹 Sticky Track Section
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Track Your Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: orderController,
                      decoration: InputDecoration(
                        hintText: "Enter Order Number",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: orderController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              orderController.clear();
                              showOrder = false;
                            });
                          },
                        )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// Track Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E3F55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (orderController.text.isNotEmpty) {
                          setState(() {
                            showOrder = true;
                          });
                        }
                      },
                      child: const Text("Track"),
                    ),
                  ),

                  const SizedBox(width: 8),

                  /// Clear Button
                  if (showOrder)
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showOrder = false;
                            orderController.clear();
                          });
                        },
                        child: const Text(
                          "Clear",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        /// 🔹 Scrollable Card Area
        Expanded(
          child: showOrder
              ? SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: _orderDetailCard(),
          )
              : const Center(
            child: Text(
              "Enter order number to track",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  // ================= ORDER CARD =================

  Widget _orderDetailCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${orderController.text}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: const Text(
                  "Confirmed",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Customer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text("Test User"),
          const Text("88123456789"),
          const Text("testuser@hotmail.com"),

          const SizedBox(height: 20),

          _infoBox(
            title: "HML Pick Up Service",
            subtitle:
            "Mar 20, 2018 - 03:30 PM\nOrlando International Airport (MCO)",
          ),

          const SizedBox(height: 15),

          _infoBox(
            title: "HML Drop Off Service",
            subtitle:
            "Mar 25, 2018 - 02:30 PM\nOrlando International Airport (MCO)",
          ),

          const SizedBox(height: 20),

          const Divider(),
          PriceRow(title: "Large / Med Bags",price:"\$16.00",isTotal: false,),
          PriceRow(title:"Handling Fee", price: "\$20.00",isTotal: false,),
          PriceRow(title: "Discount",price:"-\$34.00",isTotal: false,),
          PriceRow(title: "Sales Tax (7%)",price: "\$4.62",isTotal: false,),


          const Divider(height: 30),
          PriceRow(title: "Total Amount",price:   "\$70.62",   isTotal: true,),


        ],
      ),
    );
  }

  Widget _infoBox({
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F4FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }


}