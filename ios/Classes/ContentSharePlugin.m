#import "ContentSharePlugin.h"
#if __has_include(<content_share/content_share-Swift.h>)
#import <content_share/content_share-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "content_share-Swift.h"
#endif

@implementation ContentSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftContentSharePlugin registerWithRegistrar:registrar];
}
@end
