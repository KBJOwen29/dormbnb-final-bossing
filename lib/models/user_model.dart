/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

import 'package:dormbnb/models/payment_record_model.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String number;
  final List<String> roles;
  final bool kycVerified;
  final List<String> bookings;
  final List<String> dormsOwned;
  final List<PaymentRecord> paymentsReceived;
  final List<PaymentRecord> pendingOrOverdue;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.number,
    this.roles = const ['dormer'],
    this.kycVerified = false,
    this.bookings = const [],
    this.dormsOwned = const [],
    this.paymentsReceived = const [],
    this.pendingOrOverdue = const [],
  });

  static const String dormer = 'dormer';
  static const String dormOwner = 'dorm owner';

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      number: map['number'] ?? '',
      roles: List<String>.from(map['roles'] ?? []),
      kycVerified: map['kycVerified'] ?? false,
      bookings: List<String>.from(map['bookings'] ?? []),
      dormsOwned: List<String>.from(map['dormsOwned'] ?? []),
      paymentsReceived: (map['paymentsReceived'] as List? ?? [])
          .map((p) => PaymentRecord.fromMap(p as Map<String, dynamic>))
          .toList(),
      pendingOrOverdue: (map['pendingOrOverdue'] as List? ?? [])
          .map((p) => PaymentRecord.fromMap(p as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'number': number,
      'roles': roles,
      'kycVerified': kycVerified,
      'bookings': bookings,
      'dormsOwned': dormsOwned,
      'paymentsReceived': paymentsReceived.map((p) => p.toMap()).toList(),
      'pendingOrOverdue': pendingOrOverdue.map((p) => p.toMap()).toList(),
    };
  }
}