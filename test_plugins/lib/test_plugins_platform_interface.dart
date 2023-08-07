import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'test_plugins_method_channel.dart';

abstract class TestPluginsPlatform extends PlatformInterface {
  /// Constructs a TestPluginsPlatform.
  TestPluginsPlatform() : super(token: _token);

  static final Object _token = Object();

  static TestPluginsPlatform _instance = MethodChannelTestPlugins();

  /// The default instance of [TestPluginsPlatform] to use.
  ///
  /// Defaults to [MethodChannelTestPlugins].
  static TestPluginsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TestPluginsPlatform] when
  /// they register themselves.
  static set instance(TestPluginsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
