class MaskStore {
  final String name;
  final String address;
  double distance;
  final String remainStatus;
  final double latitude;
  final double longitude;

  MaskStore({
    required this.name,
    required this.address,
    required this.distance,
    required this.remainStatus,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'distance': distance,
      'remainStatus': remainStatus,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory MaskStore.fromMap(Map<String, dynamic> map) {
    return MaskStore(
      name: map['name'] as String,
      address: map['address'] as String,
      distance: map['distance'] as double,
      remainStatus: map['remainStatus'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  @override
  String toString() {
    return 'MaskStore{name: $name, address: $address, distance: $distance, remainStatus: $remainStatus, latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaskStore &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          distance == other.distance &&
          remainStatus == other.remainStatus &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      distance.hashCode ^
      remainStatus.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
}
