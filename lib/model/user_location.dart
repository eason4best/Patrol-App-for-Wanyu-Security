class UserLocation {
  final double? lat;
  final double? lng;
  final bool? locationServiceEnabled;
  final bool? hasLocationPermission;
  UserLocation({
    this.lat,
    this.lng,
    this.locationServiceEnabled,
    this.hasLocationPermission,
  });

  UserLocation copyWith({
    double? lat,
    double? lng,
    bool? locationServiceEnabled,
    bool? hasLocationPermission,
  }) {
    return UserLocation(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      locationServiceEnabled:
          locationServiceEnabled ?? this.locationServiceEnabled,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
    );
  }
}
