/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

class DormModel {
  final String id;
  final String name;
  final String address;
  final String distanceToMseuf;
  final String genderPolicy;
  final String description;
  final double singleRoomPrice;
  final double doubleRoomPrice;
  final double bedSpacePrice;
  final double securityDeposit;
  final int numOfBeds;
  final double rating;
  final int numOfRating;
  final List<String> amenities;
  final List<String> requiredDocs;

  DormModel({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceToMseuf,
    required this.genderPolicy,
    this.description = 'No description.',
    this.singleRoomPrice = 0.0, // Defaulted
    this.doubleRoomPrice = 0.0, // Defaulted
    this.bedSpacePrice = 0.0,   // Defaulted
    this.securityDeposit = 0.0, // Defaulted
    this.numOfBeds = 0,         // Defaulted
    this.rating = 0.0,          // Defaulted
    this.numOfRating = 0,       // Defaulted
    this.amenities = const [],  // Defaulted to empty list
    this.requiredDocs = const [],
  });

  static const String maleOnly = 'Male Only';
  static const String femaleOnly = 'Female Only';
  static const String maleFemale = 'Male & Female';

  static const String wifi = 'Wifi';
  static const String aircon = 'Air Conditioning';
  static const String privateCr = 'Private CR';
  static const String sharedKitchen = 'Shared Kitchen';
  static const String cctv = 'CCTV';
  static const String hotShower = 'Hot Shower';
  static const String securedGate = 'Secured Gate';
  static const String parking = 'Parking';
  static const String studyArea = 'Study Area';
  static const String laundryArea = 'Laundry Area';

  static const String leaseAuthority = 'Property Title / Lease Authority';
  static const String fireSafetyCert = 'Fire Safety Certificate';
  static const String permit = "Business Permit / Mayor's Permit";

  factory DormModel.fromMap(Map<String, dynamic> map, String documentId) {
    return DormModel(
      id: documentId,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      distanceToMseuf: map['distanceToMseuf'] ?? '',
      genderPolicy: map['genderPolicy'] ?? '',
      description: map['description'] ?? 'No description.',
      singleRoomPrice: (map['singleRoomPrice'] ?? 0.0).toDouble(),
      doubleRoomPrice: (map['doubleRoomPrice'] ?? 0.0).toDouble(),
      bedSpacePrice: (map['bedSpacePrice'] ?? 0.0).toDouble(),
      securityDeposit: (map['securityDeposit'] ?? 0.0).toDouble(),
      numOfBeds: map['numOfBeds'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      numOfRating: map['numOfRating'] ?? 0,
      amenities: List<String>.from(map['amenities'] ?? []),
      requiredDocs: List<String>.from(map['requiredDocs'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'distanceToMseuf': distanceToMseuf,
      'genderPolicy': genderPolicy,
      'description': description,
      'singleRoomPrice': singleRoomPrice,
      'doubleRoomPrice': doubleRoomPrice,
      'bedSpacePrice': bedSpacePrice,
      'securityDeposit': securityDeposit,
      'numOfBeds': numOfBeds,
      'rating': rating,
      'numOfRating': numOfRating,
      'amenities': amenities,
      'requiredDocs': requiredDocs,
    };
  }
}