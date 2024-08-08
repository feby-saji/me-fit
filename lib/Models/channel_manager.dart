import 'package:flutter/services.dart';

class ChannelManager {
  static final ChannelManager _instance = ChannelManager._internal();

  factory ChannelManager() => _instance;

  ChannelManager._internal();

  static const MethodChannel _methodChannel = MethodChannel('com.globslsoftlabs.me_fit/steps');

  static const EventChannel _eventChannel = EventChannel('com.globslsoftlabs.me_fit/stepcounter');

  MethodChannel get methodChannel => _methodChannel;

  EventChannel get eventChannel => _eventChannel;
}