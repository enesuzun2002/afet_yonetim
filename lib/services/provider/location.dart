import 'package:afet_yonetim/model/location.dart';
import 'package:afet_yonetim/services/api/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = Provider<LocationAPI>((ref) => LocationAPI(ref));

final locationDataProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(locationProvider).getLocations();
});

final locationSetProvider =
    FutureProvider.autoDispose.family<void, LocationModel>((ref, model) async {
  return ref.watch(locationProvider).setLocation(model);
});

final gnssLocationProvider = FutureProvider<Position>((ref) async {
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  final permissionStatus = await geolocator.checkPermission();

  if (permissionStatus == LocationPermission.denied) {
    await geolocator.requestPermission();
  }

  if (permissionStatus == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied, cannot get user location.');
  }

  if (permissionStatus == LocationPermission.denied ||
      permissionStatus == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are denied, cannot get user location.');
  }

  final position = await geolocator.getCurrentPosition();
  return position;
});
