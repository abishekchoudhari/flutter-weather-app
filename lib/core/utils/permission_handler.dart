import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> checkAndRequestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }
}
