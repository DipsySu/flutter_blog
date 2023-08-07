import 'package:flutter_test/flutter_test.dart';
import 'package:test_plugins/test_plugins.dart';
import 'package:test_plugins/test_plugins_platform_interface.dart';
import 'package:test_plugins/test_plugins_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestPluginsPlatform
    with MockPlatformInterfaceMixin
    implements TestPluginsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TestPluginsPlatform initialPlatform = TestPluginsPlatform.instance;

  test('$MethodChannelTestPlugins is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTestPlugins>());
  });

  test('getPlatformVersion', () async {
    TestPlugins testPluginsPlugin = TestPlugins();
    MockTestPluginsPlatform fakePlatform = MockTestPluginsPlatform();
    TestPluginsPlatform.instance = fakePlatform;

    expect(await testPluginsPlugin.getPlatformVersion(), '42');
  });
}
