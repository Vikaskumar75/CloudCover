import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation()async {
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}
