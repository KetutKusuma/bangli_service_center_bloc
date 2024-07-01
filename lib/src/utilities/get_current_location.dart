import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

Future<ReturnResponse<LatLng>> getCurrentLocation() async {
  try {
    Position position;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return ReturnResponse.success(
          "Izin lokasi ditolak",
          data: const LatLng(-8.46099054615932, 115.35236384469763),
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return ReturnResponse.success(
        "Izin lokasi ditolak selamanya",
        data: const LatLng(-8.46099054615932, 115.35236384469763),
      );
    }

    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(minutes: 1),
    );

    return ReturnResponse.success(
      "Sukses dapat lokasi",
      data: LatLng(position.latitude, position.longitude),
    );
  } catch (e) {
    return ReturnResponse.failed("Error catch get current location : $e",
        data: const LatLng(0, 0));
  }
}
