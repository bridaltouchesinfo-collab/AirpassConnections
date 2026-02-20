import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 20),

        /// 🔹 Tab Bar
        TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF2E3F55),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF2E3F55),
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(
              icon: Icon(Icons.notifications_outlined),
              text: "Notifications",
            ),
            Tab(
              icon: Icon(Icons.lock_outline),
              text: "Privacy",
            ),
            Tab(
              icon: Icon(Icons.description_outlined),
              text: "Terms",
            ),
            Tab(
              icon: Icon(Icons.support_agent_outlined),
              text: "Support",
            ),
          ],
        ),

        /// 🔹 Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _NotificationTab(),
              _PrivacyTab(),
              _TermsTab(),
              _SupportTab(),
            ],
          ),
        ),

        /// 🔹 App Version (Subtle)
        const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
            "App Version 1.0.1",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////
// 🔔 Notification Tab
//////////////////////////////////////////////////////////////////

class _NotificationTab extends StatefulWidget {
  const _NotificationTab();

  @override
  State<_NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<_NotificationTab> {

  bool orderUpdates = true;
  bool promotions = false;
  bool reminders = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [

        _switchTile(
          "Order Updates",
          "Receive updates about your orders",
          orderUpdates,
              (value) => setState(() => orderUpdates = value),
        ),

        _switchTile(
          "Promotions",
          "Special offers and discounts",
          promotions,
              (value) => setState(() => promotions = value),
        ),

        _switchTile(
          "Reminders",
          "Pickup and delivery reminders",
          reminders,
              (value) => setState(() => reminders = value),
        ),
      ],
    );
  }

  Widget _switchTile(
      String title,
      String subtitle,
      bool value,
      Function(bool) onChanged,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        activeColor: const Color(0xFF2E3F55),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
// 🔐 Privacy Tab
//////////////////////////////////////////////////////////////////

class _PrivacyTab extends StatelessWidget {
  const _PrivacyTab();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Text(
          "Your privacy is important to us.\n\n"
              "We collect minimal data required to process "
              "your luggage booking and ensure secure transactions.\n\n"
              "Your data will never be sold or shared without consent.",
          style: TextStyle(height: 1.6),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
// 📜 Terms Tab
//////////////////////////////////////////////////////////////////

class _TermsTab extends StatelessWidget {
  const _TermsTab();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Text(
          "By using this app, you agree to our terms and conditions.\n\n"
              "• All bookings must be valid.\n"
              "• Service fees apply.\n"
              "• Cancellation policy may apply.\n\n"
              "Please read carefully before confirming your order.",
          style: TextStyle(height: 1.6),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
// 📞 Support Tab
//////////////////////////////////////////////////////////////////

class _SupportTab extends StatelessWidget {
  const _SupportTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [

        _supportCard(
          icon: Icons.phone,
          title: "Call Support",
          subtitle: "+1 800 123 4567",
        ),

        _supportCard(
          icon: Icons.email,
          title: "Email Support",
          subtitle: "support@airpassconnections.com",
        ),

        _supportCard(
          icon: Icons.chat,
          title: "Live Chat",
          subtitle: "Chat with our support team",
        ),
      ],
    );
  }

  Widget _supportCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2E3F55)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}