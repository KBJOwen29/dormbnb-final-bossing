import 'package:flutter/material.dart';
import 'home/home_tab.dart';
import 'home/booking_tab.dart';  // NEW
import 'home/messages_tab.dart'; // NEW
import 'home/profile_tab.dart';  // NEW

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    BookingTab(),
    MessagesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _tabs[_currentIndex],

      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xFFF8F8F8), // Light grey for the bar background
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color(0xFF4A8BFE),
                unselectedItemColor: const Color(0xFFCCCCCC),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  // HOME TAB
                  BottomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(height: 40, width: 40),
                        const Icon(Icons.search, size: 28),
                        if (_currentIndex == 0)
                          Positioned(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A8BFE).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.bookmarks_outlined, size: 28),
                    activeIcon: Icon(Icons.bookmarks, size: 28),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.email_outlined, size: 28),
                    activeIcon: Icon(Icons.email, size: 28),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline, size: 28),
                    activeIcon: Icon(Icons.person, size: 28),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// PLACEHOLDER TAB WIDGETS
class SavedTabPlaceholder extends StatelessWidget {
  const SavedTabPlaceholder({super.key});
  @override Widget build(BuildContext context) => const Center(child: Text('Saved Tab Placeholder'));
}
class MessagesTabPlaceholder extends StatelessWidget {
  const MessagesTabPlaceholder({super.key});
  @override Widget build(BuildContext context) => const Center(child: Text('Messages Tab Placeholder'));
}
class ProfileTabPlaceholder extends StatelessWidget {
  const ProfileTabPlaceholder({super.key});
  @override Widget build(BuildContext context) => const Center(child: Text('Profile Tab Placeholder'));
}