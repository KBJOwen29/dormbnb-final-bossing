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

      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          // Background shadow
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              // FIX: Wrapped color and boxShadow inside BoxDecoration
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    // FIX: Updated to withValues
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 24, right: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
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
                          // FIX: Changed Container to SizedBox
                          const SizedBox(height: 50, width: 50),
                          const Icon(Icons.search, size: 28),
                          if (_currentIndex == 0)
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  // FIX: Updated to withValues
                                  color: const Color(0xFF4A8BFE).withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          if(_currentIndex == 0)
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4A8BFE),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      label: '',
                    ),

                    // SAVED TAB
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.bookmarks_outlined, size: 28),
                      activeIcon: Icon(Icons.bookmarks, size: 28, color: Color(0xFF4A8BFE)),
                      label: '',
                    ),

                    // MESSAGES TAB
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.email_outlined, size: 28),
                      activeIcon: Icon(Icons.email, size: 28, color: Color(0xFF4A8BFE)),
                      label: '',
                    ),

                    // PROFILE TAB
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline, size: 28),
                      activeIcon: Icon(Icons.person, size: 28, color: Color(0xFF4A8BFE)),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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