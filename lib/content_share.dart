

import 'package:flutter/foundation.dart';

import 'content_share_platform_interface.dart';

class ContentShare {

  /// Shares a message or/and link url with app chooser.
  ///
  /// - Title: Is the [title] of the message. Used as email subject if sharing
  /// with mail apps. The [title] cannot be null.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - ChooserTitle (Just for Android): Is the [chooserTitle] of the app
  Future<bool?> share(
      {required String title,
        String? text,
        String? linkUrl,
        String? chooserTitle}) async {
    assert(title.isNotEmpty);
    return ContentSharePlatform.instance.shareText(title: title,body: text);
  }


  /// Shares a local file with the app chooser.
  ///
  /// - Title: It's the [title] of the message. Used as email subject if sharing
  /// with mail apps. The [title] cannot be null.
  /// - Text: It's the [text] of the message.
  /// - FilePath: It's the [filePath] to include with the message.
  /// - ChooserTitle (Just for Android): It's the [chooserTitle] of the app
  /// chooser popup. If null, the system default title will be used.
  /// - FileType (Just for Android): It's the [fileType] that will be sent in the
  /// chooser popup. If null, the system default title will be used.
  Future<void> shareFile({required String title,
    String? text,
    required String filePath,
    String? chooserTitle}) async {
    assert(title.isNotEmpty);
    await ContentSharePlatform.instance.shareFile(
      title: title,
      body: text ?? "",
      filePath: filePath,
    );
  }


  Future<String?> getPlatformVersion() {
    return ContentSharePlatform.instance.getPlatformVersion();
  }
}
