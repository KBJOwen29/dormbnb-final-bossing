import 'dart:ui';
import 'package:flutter/material.dart';

class LandlordMessagesTab extends StatelessWidget {
  const LandlordMessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BACKGROUND
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Image.asset(
            'lib/assets/images/LandingScreenBackground.png',
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.white.withValues(alpha: 0.6), height: 180),
        ),

        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Messages',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, fontFamily: 'Nunito', color: Color(0xFF1A1A1A)),
                ),
              ),

              // CHAT LIST
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildChatItem('JD', 'Juan Dela Cruz', 'Interested po ako sa Marigold Blue Dorm. Pwede po ba viewing?', '10:30 AM', unreadCount: 1, color: const Color(0xFF4A8BFE)),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),
                      _buildChatItem('MC', 'Maria Clara', 'Tanong ko lang po if available pa yung single room...', 'Yesterday', color: const Color(0xFFFACC15)),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),
                      _buildChatItem('RA', 'Ricardo Agusto', 'Nag-send na po ako ng proof of payment for reservation.', 'Monday', color: const Color(0xFF22C55E)),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),
                      _buildChatItem('icon', 'DormBNB Support', 'Reminder: Complete your property details to attract more students.', 'Apr 20', isIcon: true, color: const Color(0xFF4A8BFE)),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),

                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: Text('No more messages', style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatItem(String init, String name, String msg, String time, {int unreadCount = 0, bool isIcon = false, required Color color}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: color,
        child: isIcon
            ? const Icon(Icons.location_on, color: Colors.white)
            : Text(init, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1A1A1A))),
      subtitle: Text(msg, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF888888))),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(fontSize: 10, color: Color(0xFF888888))),
          if (unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Color(0xFF4A8BFE), shape: BoxShape.circle),
              child: Text(unreadCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ]
        ],
      ),
      onTap: () {
        // Future: Navigate to Chat Detail
      },
    );
  }
}
