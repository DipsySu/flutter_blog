
import 'test_plugins_platform_interface.dart';

class TestPlugins {
  Future<String?> getPlatformVersion() {
    return TestPluginsPlatform.instance.getPlatformVersion();
  }
}
