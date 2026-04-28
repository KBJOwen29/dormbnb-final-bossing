/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormbnb/models/dorm_model.dart';
import 'package:flutter/foundation.dart';

class DormController {
  static final DormController instance = DormController._internal();
  DormController._internal();
  factory DormController() => instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DormModel>> getAllDorms() async {
    try {
      QuerySnapshot snapshot = await _db.collection('dorms').get();
      return snapshot.docs.map((doc) {
        return DormModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      debugPrint("Error fetching dorms: $e");
      return [];
    }
  }

  Future<List<DormModel>> getDormsByAmenities(List<String> amenities) async {
    try {
      // If the list is empty, return all dorms or an empty list depending on your preference.
      if (amenities.isEmpty) return [];

      QuerySnapshot snapshot = await _db
          .collection('dorms')
          .where('amenities', arrayContainsAny: amenities) // Matches any in the list
          .get();

      return snapshot.docs.map((doc) {
        return DormModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      debugPrint("Error fetching dorms by amenities: $e");
      return [];
    }
  }

  Future<String> createDorm({
    required String name,
    required String address,
    required String distanceToMseuf,
    required String genderPolicy,
    String description = 'No description',
    double singleRoomPrice = 0.0,
    double doubleRoomPrice = 0.0,
    double bedSpacePrice = 0.0,
    double securityDeposit = 0.0,
    int numOfBeds = 0,
    List<String> amenities = const [],
    List<String> requiredDocs = const [],
  }) async {
    try {
      DocumentReference docRef = _db.collection('dorms').doc();

      DormModel newDorm = DormModel(
        id: docRef.id,
        name: name,
        address: address,
        distanceToMseuf: distanceToMseuf,
        genderPolicy: genderPolicy,
        description: description,
        singleRoomPrice: singleRoomPrice,
        doubleRoomPrice: doubleRoomPrice,
        bedSpacePrice: bedSpacePrice,
        securityDeposit: securityDeposit,
        numOfBeds: numOfBeds,
        rating: 0.0,
        numOfRating: 0,
        amenities: amenities,
        requiredDocs: requiredDocs,
      );

      await docRef.set({
        ...newDorm.toMap(),
        'id': docRef.id,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      debugPrint("Error creating dorm: $e");
      rethrow;
    }
  }
}