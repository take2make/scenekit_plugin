#import "ScenekitPlugin.h"
#if __has_include(<scenekit_plugin/scenekit_plugin-Swift.h>)
#import <scenekit_plugin/scenekit_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "scenekit_plugin-Swift.h"
#endif

@implementation ScenekitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftScenekitPlugin registerWithRegistrar:registrar];
}
@end
