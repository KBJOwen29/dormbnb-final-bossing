import 'dart:ui';
import 'package:flutter/material.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background matching design
      body: Stack(
        children: [
          // 1. TOP BLURRY BACKGROUND
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Image.asset(
              'lib/assets/images/LandingScreenBackground.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withValues(alpha: 0.8),
              height: 160,
            ),
          ),

          // 2. FOREGROUND CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // APP BAR / BACK BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF4A8BFE), size: 20),
                    label: const Text('Back', style: TextStyle(color: Color(0xFF4A8BFE), fontSize: 16)),
                  ),
                ),

                // TITLE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Billing History',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, fontFamily: 'Nunito', color: Color(0xFF1A1A1A)),
                  ),
                ),
                const SizedBox(height: 24),

                // SCROLLABLE LIST
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        // BLUE CURRENT LEASE CARD
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A8BFE),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: const Color(0xFF4A8BFE).withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Current Lease - Marigold Blue Dormitory', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  const Text('₱ 3,500', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
                                  const SizedBox(height: 4),
                                  const Text('Monthly · Next Due: May 28, 2026', style: TextStyle(color: Colors.white70, fontSize: 10)),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: const Color(0xFF4A8BFE),
                                          elevation: 0,
                                          minimumSize: const Size(0, 30),
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        ),
                                        child: const Text('Pay Now', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          side: const BorderSide(color: Colors.white),
                                          minimumSize: const Size(0, 30),
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        ),
                                        child: const Text('Download Receipt', style: TextStyle(fontSize: 10)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // Watermark Icon
                              const Positioned(
                                right: 0,
                                top: 20,
                                child: Icon(Icons.location_on, size: 60, color: Colors.white24),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // PAYMENT HISTORY CARD
                        _buildWhiteCard(
                          title: 'Payment History',
                          child: _buildTransactionRow('April 28, 2026', 'Monthly Rent', '₱ 3,500', 'Paid', const Color(0xFF22C55E)),
                        ),
                        const SizedBox(height: 16),

                        // UPCOMING BILLS CARD
                        _buildWhiteCard(
                          title: 'Upcoming Bills',
                          child: _buildTransactionRow('May 28, 2026', 'Monthly Rent', '₱ 3,500', 'Upcoming', const Color(0xFFF59E0B)), // Orange/Yellow
                        ),
                        const SizedBox(height: 16),

                        // SAVED PAYMENT METHODS CARD
                        _buildWhiteCard(
                          title: 'Saved Payment Methods',
                          child: Column(
                            children: [
                              _buildPaymentMethodRow(Icons.phone_iphone, 'GCash - 09XX XXX 1234', 'Primary'),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1, color: Color(0xFFE0E0E0))),
                              _buildPaymentMethodRow(Icons.credit_card, 'Debit Card - 1234 XXXX XXXX 7890', 'Secondary'),
                              const SizedBox(height: 16),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF4A8BFE),
                                  side: const BorderSide(color: Color(0xFF4A8BFE)),
                                  minimumSize: const Size(double.infinity, 40),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: const Text('+ Add Payment Method', style: TextStyle(fontSize: 12)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HELPER WIDGETS
  Widget _buildWhiteCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTransactionRow(String date, String subtitle, String price, String status, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: Color(0xFF888888))),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
              child: Text(status, style: TextStyle(color: statusColor, fontSize: 8, fontWeight: FontWeight.bold)),
            )
          ],
        )
      ],
    );
  }

  Widget _buildPaymentMethodRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1A1A1A), size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
              Text(subtitle, style: const TextStyle(fontSize: 9, color: Color(0xFF888888))),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Edit', style: TextStyle(fontSize: 10, color: Color(0xFF4A8BFE))),
        )
      ],
    );
  }
}