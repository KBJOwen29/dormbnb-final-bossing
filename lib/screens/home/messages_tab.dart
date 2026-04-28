import 'dart:ui';
import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

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
                      _buildChatItem('N', 'Nikki Marigold', 'Okay po, pwede kayong lumipat sa...', '2:14 PM', unreadCount: 2, color: const Color(0xFF4A8BFE)),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),
                      _buildChatItem('J', 'Jhane San Pascual', 'Thank you for your interest! We ha...', 'Yesterday', color: const Color(0xFF22C55E)),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),
                      _buildChatItem('icon', 'DormBNB Support', 'Your KYC has been approved! You ca...', 'Apr 22', isIcon: true, color: const Color(0xFF4A8BFE)),
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
    );
  }
}