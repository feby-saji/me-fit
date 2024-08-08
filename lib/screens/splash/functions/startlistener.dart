import 'package:me_fit/Models/channel_manager.dart';
import 'package:me_fit/screens/steps/steps_page.dart';

startListener() {
  ChannelManager().eventChannel.receiveBroadcastStream().listen((stepCount) {
    print("Step count received: $stepCount");
    onStepCount(stepCount);
  }, onError: (error) {
    print("Error receiving step count: $error");
  });
}
