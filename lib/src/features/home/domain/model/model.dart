import 'dart:io';

class LocationData {
  final double latitude;
  final double longitude;
  final File photo;
  final String udid;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.photo,
    required this.udid,
  });

  Map<String, dynamic> toJson() => {
        'Latitude': latitude,
        'Longitude': longitude,
        'Photo': photo.path,
        'UDID': udid,
      };
}

class NotificationData {
  final bool enable;

  NotificationData({required this.enable});

  Map<String, dynamic> toJson() => {
        'Enable': enable,
      };
}
