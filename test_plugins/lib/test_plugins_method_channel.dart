import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'test_plugins_platform_interface.dart';

/// An implementation of [TestPluginsPlatform] that uses method channels.
class MethodChannelTestPlugins extends TestPluginsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('test_plugins');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
