import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'content_share_platform_interface.dart';

/// An implementation of [ContentSharePlatform] that uses method channels.
class MethodChannelContentShare extends ContentSharePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('content_share');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> shareText({required String title,String? body,String? chooserTitle = "Select Application"}) async {
    if (title.isEmpty) {
      throw FlutterError('Title cannot be null');
    }
    final result = await methodChannel.invokeMethod('share', <String, dynamic>{
      'title': title,
      'text': body,
      'chooserTitle' : chooserTitle
    });
    return result;
  }


}
