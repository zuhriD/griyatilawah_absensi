import 'package:griyatilawah_absesnsi/src/services/notifi_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callBackDispatcher() {
//  make variable to get time 5 minute later
  DateTime time = DateTime.now().add(Duration(minutes: 2));
  Workmanager().executeTask((task, inputData) {
    NotificationService().showNotification(
        title: 'Absensi Griya Tilawah', body: 'Waktu Absensi');
    return Future.value(true);
  });
}

void registerNotification() {
  Workmanager().initialize(
    callBackDispatcher,
    isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    "1",
    "notificationTask",
    frequency: const Duration(days: 1),
  );
}
