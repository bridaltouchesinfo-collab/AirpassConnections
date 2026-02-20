import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showArrow;

  const LocationHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [

            /// 🔹 Location Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.green,
              ),
            ),

            const SizedBox(width: 12),

            /// 🔹 Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Arrow (Optional)
            if (showArrow)
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}