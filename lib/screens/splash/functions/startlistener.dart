import 'package:me_fit/Models/channel_manager.dart';

import '../../home/functions/step count.dart';

startListener() {
  print('starting step count listener');
  ChannelManager().eventChannel.receiveBroadcastStream().listen((stepCount) {
    // print("Step count received: $stepCount");
    // onStepCountDebouncer(stepCount);
    onStepCountDebouncer(stepCount);
  }, onError: (error) {
    print("Error receiving step count: $error");
  });
}
