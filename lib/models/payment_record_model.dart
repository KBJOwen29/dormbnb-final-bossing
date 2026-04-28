/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentRecord {
  final String userName;
  final String dormId;
  final String roomType;
  final double amount;
  final DateTime date;
  final String status;

  PaymentRecord({
    required this.userName,
    required this.dormId,
    required this.roomType,
    required this.amount,
    required this.date, // date paid if paymentReceived, deadline date if pending or overdue
    required this.status,
  });

  static const String received = 'received';
  static const String pending = 'pending';
  static const String overdue = 'overdue';

  factory PaymentRecord.fromMap(Map<String, dynamic> map) {
    return PaymentRecord(
      userName: map['userName'] ?? 'Unknown',
      dormId: map['dormId'] ?? '',
      roomType: map['roomType'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      date: (map['date'] as Timestamp).toDate(),
      status: map['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'dormId': dormId,
      'roomType': roomType,
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'status': status,
    };
  }
}