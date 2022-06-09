import 'dart:async';
import 'dart:io';

import 'package:content_share/content_share.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _contentSharePlugin = ContentShare();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _contentSharePlugin.getPlatformVersion() ?? 'Unknown platform version';

      FilePickerResult? result = await FilePicker.platform.pickFiles();

     Future.delayed(const Duration(seconds:  3),(){
       if (result != null) {
         if (result.files.isEmpty) return;
         print("shobhit : file path :  ${result.files.single.path!}");
         _contentSharePlugin.shareFile(title: "dummy title", filePath: result.files.single.path!);
       } else {
         // User canceled the picker
         print("shobhit : this is called ");
       }
     });

      // Future.delayed(const Duration(seconds: 1),(){
      //   _contentSharePlugin.share(title: "item to share",text: "share kro mast rho...  \n"
      //       "link - https://www.youtube.com/watch?v=TZRpCGQsBCw");
      // });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
