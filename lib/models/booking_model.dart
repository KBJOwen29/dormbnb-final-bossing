/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String userId;
  final String dormId;
  final String status;
  final double rent;
  final DateTime moveInDate;
  final DateTime nextDueDate;
  final String ref;

  BookingModel({
    required this.id,
    required this.userId,
    required this.dormId,
    required this.status,
    required this.rent,
    required this.moveInDate,
    required this.nextDueDate,
    required this.ref,
  });

  static const String active = 'active';
  static const String pending = 'pending';
  static const String cancelled = 'cancelled';
  static const String completed = 'completed';

  factory BookingModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BookingModel(
      id: documentId,
      userId: map['userId'] ?? '',
      dormId: map['dormId'] ?? '',
      status: map['status'] ?? 'pending',
      rent: (map['rent'] ?? 0.0).toDouble(),
      moveInDate: (map['moveInDate'] as Timestamp).toDate(),
      nextDueDate: (map['nextDueDate'] as Timestamp).toDate(),
      ref: map['ref'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dormId': dormId,
      'status': status,
      'rent': rent,
      'moveInDate': moveInDate,
      'nextDueDate': nextDueDate,
      'ref': ref,
    };
  }
}