import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    //final timeZoneName = DateTime.now().timeZoneName; // Captura o timeZone do dispositivo
    final timeZoneName = 'America/Detroit';
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}