import 'package:dio/dio.dart';
import 'package:location/location.dart';

class UVService {
  final String openUVKey;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Location location = Location();

  UVService(this.openUVKey);

  Future<LocationData> getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.denied) {
        return null;
      }
    }
    LocationData locationData;
    try {
      locationData = await location.getLocation();
      print(locationData.latitude);
    } catch (e) {
      print(e);
    }

    return locationData;
  }

  getUVFromLocation(String lat, String lng) async {
    try {
      Response response = await Dio().get("https://api.openuv.io/api/v1/uv",
          queryParameters: {'lat': lat, 'lng': lng},
          options: Options(headers: {"x-access-token": openUVKey}));

      return response.data['result'];
    } catch (e) {
      print(e);
    }
  }
}
