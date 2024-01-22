import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:helloflutter/utils/background_service.dart';
import 'package:helloflutter/utils/date_time_helper.dart';

class AlarmProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('alarm activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        // const Duration(seconds: 4),
        3,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(3);
    }
  }
}
