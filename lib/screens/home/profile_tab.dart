import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../auth/signin.dart';
import '../../controller/user_controller.dart';
import 'Settings_tab.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = UserController().getCurrentUserData();
  }

  void _refreshUser() {
    setState(() {
      _userFuture = UserController().getCurrentUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF4A8BFE)));
        }

        final user = snapshot.data;
        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Unable to load profile data."),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  ),
                  child: const Text("Log In Again"),
                ),
              ],
            ),
          );
        }

        return Container(
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              // BLUE HEADER SECTION
              Container(
                width: double.infinity,
                color: const Color(0xFF4A8BFE),
                padding: const EdgeInsets.only(top: 60, bottom: 24),
                child: Column(
                  children: [
                    // AVATAR
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFFD1D5DB),
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // USER INFO
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      '${user.email}\n${user.number}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 12),

                    // KYC BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: user.kycVerified ? const Color(0xFF22C55E) : Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            user.kycVerified ? Icons.check : Icons.hourglass_empty,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.kycVerified ? 'KYC Verified' : 'Pending Verification',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // MENU LIST SECTION
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ACCOUNT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                      const SizedBox(height: 12),

                      // ACCOUNT SETTINGS BOX
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
                        ),
                        child: Column(
                          children: [
                            _buildMenuRow(
                              'Edit Profile',
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SettingsTab()),
                                );
                                if (result == true) {
                                  _refreshUser(); // Refresh if data was updated
                                }
                              },
                            ),
                            const Divider(height: 1, color: Color(0xFFE0E0E0)),
                            _buildMenuRow(
                              'KYC Documents',
                              badge: user.kycVerified ? 'Verified' : 'Pending',
                              badgeColor: user.kycVerified ? const Color(0xFF22C55E) : Colors.orange,
                            ),
                            const Divider(height: 1, color: Color(0xFFE0E0E0)),
                            _buildMenuRow('Switch Roles'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      const Text('SUPPORT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                      const SizedBox(height: 12),

                      // SUPPORT BOX
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
                        ),
                        child: Column(
                          children: [
                            _buildMenuRow('Help & FAQs'),
                            const Divider(height: 1, color: Color(0xFFE0E0E0)),
                            _buildMenuRow('Contact Support'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // LOG OUT BUTTON
                      GestureDetector(
                        onTap: () async {
                          await UserController().logout();
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SignInScreen()),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Log Out', style: TextStyle(color: Color(0xFFDC2626), fontSize: 14, fontWeight: FontWeight.bold)),
                              Icon(Icons.chevron_right, color: Color(0xFFDC2626)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuRow(String title, {String? badge, Color? badgeColor, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A))),
            Row(
              children: [
                if (badge != null)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(
                          badge == 'Verified' ? Icons.check : Icons.hourglass_empty,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                const Icon(Icons.chevron_right, color: Color(0xFF1A1A1A)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
