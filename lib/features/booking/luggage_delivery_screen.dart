import 'package:flutter/material.dart';

class LuggageDeliveryScreen extends StatefulWidget {
  const LuggageDeliveryScreen({super.key});

  @override
  State<LuggageDeliveryScreen> createState() =>
      _LuggageDeliveryScreenState();
}

class _LuggageDeliveryScreenState
    extends State<LuggageDeliveryScreen> {

  int selectedTab = 0;

  String pickupOption = "OTHER";
  String dropoffOption = "OTHER";

  String pickupAddress = "";
  String dropoffAddress = "";

  DateTime? pickupDate;
  TimeOfDay? pickupTime;

  DateTime? dropDate;
  TimeOfDay? dropTime;

  int largeQty = 0;
  int smallCarryQty = 0;
  int smallPersonalQty = 0;

  final String hmlAddress =
      "TLH Location - B Terminal Level 1 Orlando, FL, 32827";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Luggage Delivery",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
            )
          ],
        ),
        child: SizedBox(
          height: 55,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.calculate_outlined),
            label: const Text("Calculate Order Total"),
            style: ElevatedButton.styleFrom(
              backgroundColor: _canCalculate()
                  ? const Color(0xFF2E3F55)
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: _canCalculate() ? () {} : null,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _modernTabs(),
            const SizedBox(height: 24),

            if (selectedTab == 0) _pickupTab(),
            if (selectedTab == 1) _dropTab(),
            if (selectedTab == 2) _luggageTab(),
          ],
        ),
      ),
    );
  }

  // ---------------- MODERN TABS ----------------

  Widget _modernTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _tabButton("Pick-up", 0, Icons.upload_outlined),
          _tabButton("Drop-off", 1, Icons.download_outlined),
          _tabButton("Luggage", 2, Icons.luggage_outlined),
        ],
      ),
    );
  }

  Widget _tabButton(String text, int index, IconData icon) {
    bool active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF2E3F55) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color: active ? Colors.white : Colors.grey),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  color: active ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PICKUP TAB ----------------

  Widget _pickupTab() {
    return _sectionCard(
      icon: Icons.upload_outlined,
      title: "Pick-up Details",
      child: Column(
        children: [
          _dropdownField(
            value: pickupOption,
            label: "Pickup Type",
            onChanged: (val) =>
                setState(() => pickupOption = val!),
          ),
          const SizedBox(height: 16),
          pickupOption == "HML"
              ? _infoBox(hmlAddress)
              : _textField("Pickup Address",
                  (v) => pickupAddress = v),
          const SizedBox(height: 16),
          _dateField(true),
          const SizedBox(height: 16),
          _timeField(true),
        ],
      ),
    );
  }

  // ---------------- DROP TAB ----------------

  Widget _dropTab() {
    return _sectionCard(
      icon: Icons.download_outlined,
      title: "Drop-off Details",
      child: Column(
        children: [
          _dropdownField(
            value: dropoffOption,
            label: "Drop-off Type",
            onChanged: (val) =>
                setState(() => dropoffOption = val!),
          ),
          const SizedBox(height: 16),
          dropoffOption == "HML"
              ? _infoBox(hmlAddress)
              : _textField("Drop-off Address",
                  (v) => dropoffAddress = v),
          const SizedBox(height: 16),
          _dateField(false),
          const SizedBox(height: 16),
          _timeField(false),
        ],
      ),
    );
  }

  // ---------------- LUGGAGE ----------------

  Widget _luggageTab() {
    return _sectionCard(
      icon: Icons.luggage_outlined,
      title: "Luggage Quantity",
      child: Column(
        children: [
          _modernQty("Large / Med", largeQty,
                  (v) => setState(() => largeQty = v)),
          _modernQty("Small Carry", smallCarryQty,
                  (v) => setState(() => smallCarryQty = v)),
          _modernQty("Backpacks", smallPersonalQty,
                  (v) => setState(() => smallPersonalQty = v)),
        ],
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget _sectionCard(
      {required IconData icon,
        required String title,
        required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2E3F55)),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _dropdownField({
    required String value,
    required String label,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: _inputDecoration(label),
      items: const [
        DropdownMenuItem(
            value: "OTHER", child: Text("Other location")),
        DropdownMenuItem(
            value: "HML", child: Text("HML Location")),
      ],
      onChanged: onChanged,
    );
  }

  Widget _textField(String label, Function(String) onChanged) {
    return TextField(
      decoration: _inputDecoration(label),
      onChanged: onChanged,
    );
  }

  Widget _dateField(bool isPickup) {
    DateTime? date = isPickup ? pickupDate : dropDate;

    return TextFormField(
      readOnly: true,
      decoration: _inputDecoration(
          date == null
              ? "Select Date"
              : "${date.day}/${date.month}/${date.year}")
          .copyWith(prefixIcon:
      const Icon(Icons.calendar_today_outlined)),
      onTap: () async {
        DateTime? selected = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );

        if (selected != null) {
          setState(() {
            if (isPickup) {
              pickupDate = selected;
            } else {
              dropDate = selected;
            }
          });
        }
      },
    );
  }

  Widget _timeField(bool isPickup) {
    TimeOfDay? time = isPickup ? pickupTime : dropTime;

    return TextFormField(
      readOnly: true,
      decoration: _inputDecoration(
          time == null ? "Select Time" : time.format(context))
          .copyWith(
          prefixIcon:
          const Icon(Icons.access_time_outlined)),
      onTap: () async {
        TimeOfDay? selected =
        await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now());

        if (selected != null) {
          setState(() {
            if (isPickup) {
              pickupTime = selected;
            } else {
              dropTime = selected;
            }
          });
        }
      },
    );
  }

  Widget _modernQty(
      String title, int qty, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F2F6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: qty > 0
                      ? () => onChanged(qty - 1)
                      : null,
                ),
                Text(qty.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      onChanged(qty + 1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEF4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined,
              size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  bool _canCalculate() {
    bool hasLuggage =
        largeQty > 0 || smallCarryQty > 0 || smallPersonalQty > 0;

    bool pickupValid = pickupOption == "HML"
        ? true
        : pickupAddress.trim().isNotEmpty;

    bool dropValid = dropoffOption == "HML"
        ? true
        : dropoffAddress.trim().isNotEmpty;

    return pickupDate != null &&
        pickupTime != null &&
        dropDate != null &&
        dropTime != null &&
        pickupValid &&
        dropValid &&
        hasLuggage;
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF6F7FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
  }
}
