import 'package:flutter_test/flutter_test.dart';
import 'package:content_share/content_share.dart';
import 'package:content_share/content_share_platform_interface.dart';
import 'package:content_share/content_share_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockContentSharePlatform 
    with MockPlatformInterfaceMixin
    implements ContentSharePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> shareText({required String title, String? body}) {
    throw UnimplementedError();
  }
}

void main() {
  final ContentSharePlatform initialPlatform = ContentSharePlatform.instance;

  test('$MethodChannelContentShare is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelContentShare>());
  });

  test('getPlatformVersion', () async {
    ContentShare contentSharePlugin = ContentShare();
    MockContentSharePlatform fakePlatform = MockContentSharePlatform();
    ContentSharePlatform.instance = fakePlatform;
  
    expect(await contentSharePlugin.getPlatformVersion(), '42');
  });
}
