import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_test/sharetest.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  handleClick(text, imagePath) async {
    final whatsappUrl =
        Uri.encodeFull("whatsapp://send?text=$text&image=$imagePath");
    // Uri.encodeFull("https://wa.me://send?text=$text&image=$imagePath");
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      print(
          "Could not launch WhatsApp. Make sure WhatsApp is installed on your device.");
    }
  }

  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    print("permision :- $status");
    if (status.isGranted) {
      print("Permission granted, you can now share the file");
      // Permission granted, you can now share the file
    } else {
      print("per:- ${status.isPermanentlyDenied}");
      // Permission denied, handle accordingly
      // if (status.isPermanentlyDenied) {
      print("Permission denied");
      // The user has permanently denied the permission, you can open app settings
      openAppSettings();
      // }
    }
  }

  ScreenshotController screenshotController = ScreenshotController();
  static const platform = MethodChannel('example.com/channel');
  int _counter = 0;
  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await platform.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      random = 0;
    }
    setState(() {
      _counter = random;
    });
  }

  static Future<String?> shareWhatsapp(String content,
      {String? imagePath}) async {
    final Map<String, dynamic> args;
    var data = platform;
    var _imagePath = imagePath;
    // if (Platform.isAndroid) {
    //   if (imagePath != null) {
    //     // var stickerFilename = "stickerAsset.png";
    //     // await reSaveImage(imagePath, stickerFilename);
    //     // _imagePath = stickerFilename;
    //     // print("path:- $_imagePath");
    //   }
    // }
    final file = File(imagePath ?? '');

    args = <String, dynamic>{"image": _imagePath, "content": content};
    final String? version = await data.invokeMethod('shareWhatsapp', args);
    Future.delayed(const Duration(seconds: 5))
        .then((value) => file.delete(recursive: false));
    // if (version != null) {
    //   await file.delete(recursive: false);
    // }

    return version;
  }

  static Future<String?> shareTelegram(String content,
      {String? imagePath}) async {
    final Map<String, dynamic> args;
    var data = platform;
    var _imagePath = imagePath;
    print("image path:- $_imagePath");
    var imgUri = Uri.parse("file://$_imagePath");
    print("path path:- $imgUri");
    // if (Platform.isAndroid) {
    //   if (imagePath != null) {
    //     var stickerFilename = "stickerAsset.png";
    //     await reSaveImage(imagePath, stickerFilename);
    //     _imagePath = stickerFilename;
    //   }
    // }
    // final file = File(imagePath ?? '');
    args = <String, dynamic>{"image": _imagePath, "content": content};
    final String? version = await data.invokeMethod('shareTelegram', args);
    // Future.delayed(const Duration(seconds: 5))
    //     .then((value) => file.delete(recursive: false));
    return version;
  }

  static Future<String?> shareTwitter(
    String captionText, {
    List<String>? hashtags,
    String? imagePath,
    String? url,
    String? trailingText,
  }) async {
    //Caption
    var _captionText = captionText;

    //Hashtags
    if (hashtags != null && hashtags.isNotEmpty) {
      final tags = hashtags.map((t) => '#$t ').join(' ');
      _captionText = _captionText + "\n" + tags.toString();
    }

    //Url
    String _url;
    var _imagePath = imagePath;
    var data = platform;
    if (url != null) {
      if (Platform.isAndroid) {
        _url = Uri.parse(url).toString().replaceAll('#', "%23");
      } else {
        _url = Uri.parse(url).toString();
      }
      _captionText = _captionText + "\n" + _url;
    }

    if (trailingText != null) {
      _captionText = _captionText + "\n" + trailingText;
    }

    Map<String, dynamic> args = <String, dynamic>{
      "captionText": _captionText + " ",
      "image": _imagePath
    };
    final String? version = await data.invokeMethod('shareTwitter', args);
    return version;
  }

  AppinioSocialShare appinioSocialShare = AppinioSocialShare();

  Future<void> shareToWhatsApp(String message, String filePath) async {
    print(filePath);
    String response =
        await appinioSocialShare.shareToWhatsapp(message, filePath: filePath);
    print(response);
  }
  // static Future<bool> reSaveImage(String? imagePath, String filename) async {
  //   if (imagePath == null) {
  //     return false;
  //   }
  //   final tempDir = await getTemporaryDirectory();

  //   File file = File(imagePath);
  //   Uint8List bytes = file.readAsBytesSync();
  //   var stickerData = bytes.buffer.asUint8List();
  //   String stickerAssetName = filename;
  //   final Uint8List stickerAssetAsList = stickerData;
  //   final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
  //   print("path hello:- ${stickerAssetPath}");
  //   file = await File(stickerAssetPath).create();
  //   file.writeAsBytesSync(stickerAssetAsList);
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomNumber,
        tooltip: 'Generate',
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text("Here"),
                ),
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            // Image.asset("assets/badge_to_share.png"),
            ElevatedButton(
                onPressed: () async {
                  await screenshotController
                      .capture(
                          delay: const Duration(milliseconds: 10),
                          pixelRatio: MediaQuery.of(context).devicePixelRatio)
                      .then((bytes) async {
                    final tempDir = await getTemporaryDirectory();

                    // final fileN = File("${tempDir.path}/appName.png");
                    final file = File('storage/emulated/0/Download/test.jpeg');
                    // bool test = await File(file.path).exists();
                    // if (test) {
                    //   file.delete(recursive: false);
                    // }

                    await file.writeAsBytes(bytes!, flush: true);

                    shareToWhatsApp("Message Text!!", file.absolute.path);
                    // await shareTelegram("hello world", imagePath: file.path);
                    // await shareWhatsapp(
                    //     "This is Social Share twitter example with link",
                    //     // hashtags: ["SocialSharePlugin", "world", "foo", "bar"],
                    //     // url: "https://google.com/hello",
                    //     // trailingText: "cool!!",
                    //     imagePath: file.path);

                    // await Share.shareXFiles(
                    //   [XFile(screenshotFilePath)],
                    //   // text: "Text. My invite link:",
                    //   sharePositionOrigin: () {
                    //     RenderBox? box =
                    //         context.findRenderObject() as RenderBox?;
                    //     return box!.localToGlobal(Offset.zero) & box.size;
                    //   }(),
                    // );
                  }).catchError((onError) {
                    print(onError);
                  });

                  // final tempDir = await getTemporaryDirectory();
                  // ByteData byteData =
                  //     await rootBundle.load('assets/badge_to_share.png');
                  // final file = File('${tempDir.path}/image.png');
                  // var data = byteData.buffer.asUint8List();
                  // print(byteData.buffer.asUint8List());
                  // await file.writeAsBytes(byteData.buffer.asUint8List(),
                  //     flush: true);
                  // print("success");

                  // bool isThere =
                  //     await File("storage/emulated/0/Download/test.jpg")
                  //         .exists();
                  // print(isThere);
                  // PermissionStatus status = await Permission.storage.status;

                  // if (!status.isGranted) {
                  //   await Permission.storage.request();
                  // }

                  // handleClick(
                  //   "here we are now",
                  //   // "storage/emulated/0/Download/test.jpg",
                  //   file.path,
                  // );
                  // shareFile();
                },
                child: Text("Click me")),
          ],
        ),
      ),
    );
  }
}

// Future<void> shareFile() async {
//   try {
//     await WhatsappShare.shareFile(
//       phone: '911234567890',
//       filePath: ["storage/emulated/0/Download/test.jpg"],
//     );
//     print("success");
//   } on Exception catch (e) {
//     print(e);
//   }
// }
