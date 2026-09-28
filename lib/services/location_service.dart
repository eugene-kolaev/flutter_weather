import 'package:geolocator/geolocator.dart';

/// Результат попытки получить геопозицию.
sealed class LocationResult {
  const LocationResult();
}

class LocationSuccess extends LocationResult {
  final double latitude;
  final double longitude;
  const LocationSuccess(this.latitude, this.longitude);
}

class LocationFailure extends LocationResult {
  final LocationError error;
  const LocationFailure(this.error);
}

enum LocationError {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  timeout,
  unknown,
}

class LocationService {
  LocationService._();

  static Future<LocationResult> getCurrent() async {
    // 1. GPS включён?
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationFailure(LocationError.serviceDisabled);
    }

    // 2. Разрешение
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const LocationFailure(LocationError.permissionDenied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return const LocationFailure(LocationError.permissionDeniedForever);
    }

    // 3. Получаем позицию
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 10));

      return LocationSuccess(position.latitude, position.longitude);
    } catch (_) {
      return const LocationFailure(LocationError.timeout);
    }
  }
}