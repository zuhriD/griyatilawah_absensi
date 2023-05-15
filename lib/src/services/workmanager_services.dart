import 'package:griyatilawah_absesnsi/src/services/notifi_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callBackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    NotificationService().showNotification(
        title: "Jangan Lupa Absensi",
        body: "Yuk! Lihat jadwal yang belum absen");
    return Future.value(true);
  });
}

void registerNotification() {
  Workmanager().initialize(
    callBackDispatcher,
    isInDebugMode: true,
  );
  Workmanager().registerOneOffTask(
    "1",
    "notificationTask",
    initialDelay: const Duration(seconds: 5),
  );
}
