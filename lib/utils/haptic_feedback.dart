import 'package:haptic_feedback/haptic_feedback.dart';

class HapticsHelper {
  HapticsHelper._();

  static bool? _canVibrate;

  static Future<void> vibrate(HapticsType hapticsType) async {
    _canVibrate ??= await Haptics.canVibrate();

    if (_canVibrate ?? false) {
      await Haptics.vibrate(hapticsType);
    }
  }
}