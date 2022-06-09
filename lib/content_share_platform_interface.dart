import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'content_share_method_channel.dart';

abstract class ContentSharePlatform extends PlatformInterface {
  /// Constructs a ContentSharePlatform.
  ContentSharePlatform() : super(token: _token);

  static final Object _token = Object();

  static ContentSharePlatform _instance = MethodChannelContentShare();

  /// The default instance of [ContentSharePlatform] to use.
  ///
  /// Defaults to [MethodChannelContentShare].
  static ContentSharePlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ContentSharePlatform] when
  /// they register themselves.
  static set instance(ContentSharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> shareText({required String title,String? body}) {
    throw UnimplementedError('shareText() has not been implemented.');
  }

}
