#import "TestPluginsPlugin.h"

@implementation TestPluginsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"test_plugins"
            binaryMessenger:[registrar messenger]];
  TestPluginsPlugin* instance = [[TestPluginsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"vibrate" isEqualToString:call.method]) {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
