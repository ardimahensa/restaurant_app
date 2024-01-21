import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:makan_bang/helper/date_time_helper.dart';

import '../helper/background_service_helper.dart';
import '../helper/local_storage_helper.dart';
import '../helper/notification_helper.dart';

class DailyController extends GetxController {
  final RxBool _isScheduled = false.obs;

  bool get isScheduled => _isScheduled.value;

  @override
  void onInit() {
    super.onInit();
    loadScheduledStatus();
    configureBackgroundService();
    configureNotificationHelper();
  }

  Future<void> loadScheduledStatus() async {
    final bool savedStatus =
        await SharedPreferencesHelper.getDailyReminderStatus();
    _isScheduled.value = savedStatus;
    update();
  }

  Future<void> saveScheduledStatus(bool value) async {
    _isScheduled.value = value;
    await SharedPreferencesHelper.saveDailyReminderStatus(value);
  }

  Future<void> configureBackgroundService() async {
    BackgroundService().initializeIsolate();
  }

  Future<void> configureNotificationHelper() async {
    await NotificationHelper().initNotifications();
    NotificationHelper().configureSelectNotificationSubject();
  }

  Future<void> toggleDailyNotification() async {
    final newValue = !_isScheduled.value;
    final success = await scheduledNews(newValue);
    if (success) {
      await saveScheduledStatus(newValue);

      if (newValue) {
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        await AndroidAlarmManager.cancel(1);
      }
    }
  }

  Future<bool> scheduledNews(bool value) async {
    _isScheduled.value = value;
    await saveScheduledStatus(value);
    return true;
  }
}
