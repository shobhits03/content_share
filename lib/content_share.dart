
import 'package:flutter/material.dart';

import 'content_share_platform_interface.dart';

class ContentShare {

  /// Shares a message or/and link url with app chooser.
  ///
  /// - Title: Is the [title] of the message. Used as email subject if sharing
  /// with mail apps. The [title] cannot be null.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - ChooserTitle (Just for Android): Is the [chooserTitle] of the app
  /// chooser popup. If null the system default title will be used.
  Future<bool?> share(
      {required String title,
        String? text,
        String? linkUrl,
        String? chooserTitle}) async {
    assert(title.isNotEmpty);
    return ContentSharePlatform.instance.shareText(title: title,body: text);
  }


  Future<String?> getPlatformVersion() {
    return ContentSharePlatform.instance.getPlatformVersion();
  }
}
