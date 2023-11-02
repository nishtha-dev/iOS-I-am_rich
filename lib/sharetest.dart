// // // import 'dart:async';

// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';

// // // /// Select Whatsapp Type
// // // enum Package { whatsapp, businessWhatsapp }

// // // class WhatsappShare {
// // //   static const MethodChannel _channel = MethodChannel('whatsapp_share');

// // //   /// Checks whether whatsapp is installed in device or not
// // //   ///
// // //   /// [Package] is optional enum parameter which is defualt to [Package.whatsapp]
// // //   /// for business whatsapp set it to [Package.businessWhatsapp], it cannot be null
// // //   ///
// // //   /// return true if installed otherwise false.
// // //   static Future<bool?> isInstalled({Package package = Package.whatsapp}) async {
// // //     String _package;
// // //     _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";
// // //     final bool? success =
// // //         await _channel.invokeMethod('isInstalled', <String, dynamic>{
// // //       "package": _package,
// // //     });
// // //     return success;
// // //   }

// // //   /// Shares a message or/and link url with whatsapp.
// // //   /// - Text: Is the [text] of the message.
// // //   /// - LinkUrl: Is the [linkUrl] to include with the message.
// // //   /// - Phone: is the [phone] contact number to share with.

// // //   static Future<bool?> share({
// // //     required String phone,
// // //     String? text,
// // //     String? linkUrl,
// // //     Package package = Package.whatsapp,
// // //   }) async {
// // //     if (phone.isEmpty) {
// // //       throw FlutterError('Phone cannot be null and with country code');
// // //     }

// // //     String _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

// // //     final bool? success =
// // //         await _channel.invokeMethod('share', <String, dynamic>{
// // //       'title': ' ',
// // //       'text': text,
// // //       'linkUrl': linkUrl,
// // //       'chooserTitle': ' ',
// // //       'phone': phone,
// // //       'package': _package,
// // //     });

// // //     return success;
// // //   }

// // //   /// Shares a local file with whatsapp.
// // //   /// - Text: Is the [text] of the message.
// // //   /// - FilePath: Is the List of paths which can be prefilled.
// // //   /// - Phone: is the [phone] contact number to share with.
// // //   static Future<bool?> shareFile({
// // //     required List<String> filePath,
// // //     required String phone,
// // //     String? text,
// // //     Package package = Package.whatsapp,
// // //   }) async {
// // //     if (filePath.isEmpty) {
// // //       throw FlutterError('FilePath cannot be null');
// // //     } else if (phone.isEmpty) {
// // //       throw FlutterError('Phone cannot be null and with country code');
// // //     }

// // //     String _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

// // //     final bool? success =
// // //         await _channel.invokeMethod('shareFile', <String, dynamic>{
// // //       'title': ' ',
// // //       'text': text,
// // //       'filePath': filePath,
// // //       'chooserTitle': ' ',
// // //       'phone': phone,
// // //       'package': _package,
// // //     });

// // //     return success;
// // //   }
// // // }

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

// class SocialShare {
//   static const MethodChannel _channel = const MethodChannel('share_test');

//   // static Future<String?> shareInstagramStory({
//   //   required String appId,
//   //   required String imagePath,
//   //   String? backgroundTopColor,
//   //   String? backgroundBottomColor,
//   //   String? backgroundResourcePath,
//   //   String? attributionURL,
//   // }) async {
//   //   return shareMetaStory(
//   //     appId: appId,
//   //     platform: "shareInstagramStory",
//   //     imagePath: imagePath,
//   //     backgroundTopColor: backgroundTopColor,
//   //     backgroundBottomColor: backgroundBottomColor,
//   //     attributionURL: attributionURL,
//   //     backgroundResourcePath: backgroundResourcePath,
//   //   );
//   // }

//   // static Future<String?> shareFacebookStory({
//   //   required String appId,
//   //   String? imagePath,
//   //   String? backgroundTopColor,
//   //   String? backgroundBottomColor,
//   //   String? backgroundResourcePath,
//   //   String? attributionURL,
//   // }) async {
//   //   return shareMetaStory(
//   //     appId: appId,
//   //     platform: "shareFacebookStory",
//   //     imagePath: imagePath,
//   //     backgroundTopColor: backgroundTopColor,
//   //     backgroundBottomColor: backgroundBottomColor,
//   //     attributionURL: attributionURL,
//   //     backgroundResourcePath: backgroundResourcePath,
//   //   );
//   // }

//   // static Future<String?> shareMetaStory({
//   //   required String appId,
//   //   required String platform,
//   //   String? imagePath,
//   //   String? backgroundTopColor,
//   //   String? backgroundBottomColor,
//   //   String? attributionURL,
//   //   String? backgroundResourcePath,
//   // }) async {
//   //   var _imagePath = imagePath;
//   //   var _backgroundResourcePath = backgroundResourcePath;

//   //   if (Platform.isAndroid) {
//   //     var stickerFilename = "stickerAsset.png";
//   //     await reSaveImage(imagePath, stickerFilename);
//   //     _imagePath = stickerFilename;
//   //     if (backgroundResourcePath != null) {
//   //       var backgroundImageFilename = backgroundResourcePath.split("/").last;
//   //       await reSaveImage(backgroundResourcePath, backgroundImageFilename);
//   //       _backgroundResourcePath = backgroundImageFilename;
//   //     }
//   //   }

//   //   Map<String, dynamic> args = <String, dynamic>{
//   //     "stickerImage": _imagePath,
//   //     "backgroundTopColor": backgroundTopColor,
//   //     "backgroundBottomColor": backgroundBottomColor,
//   //     "attributionURL": attributionURL,
//   //     "appId": appId
//   //   };

//   //   if (_backgroundResourcePath != null) {
//   //     var extension = _backgroundResourcePath.split(".").last;
//   //     if (["png", "jpg", "jpeg"].contains(extension.toLowerCase())) {
//   //       args["backgroundImage"] = _backgroundResourcePath;
//   //     } else {
//   //       args["backgroundVideo"] = _backgroundResourcePath;
//   //     }
//   //   }

//   //   final String? response = await _channel.invokeMethod(platform, args);
//   //   return response;
//   // }

//   // static Future<String?> shareTwitter(
//   //   String captionText, {
//   //   List<String>? hashtags,
//   //   String? url,
//   //   String? trailingText,
//   // }) async {
//   //   //Caption
//   //   var _captionText = captionText;

//   //   //Hashtags
//   //   if (hashtags != null && hashtags.isNotEmpty) {
//   //     final tags = hashtags.map((t) => '#$t ').join(' ');
//   //     _captionText = _captionText + "\n" + tags.toString();
//   //   }

//   //   //Url
//   //   String _url;
//   //   if (url != null) {
//   //     if (Platform.isAndroid) {
//   //       _url = Uri.parse(url).toString().replaceAll('#', "%23");
//   //     } else {
//   //       _url = Uri.parse(url).toString();
//   //     }
//   //     _captionText = _captionText + "\n" + _url;
//   //   }

//   //   if (trailingText != null) {
//   //     _captionText = _captionText + "\n" + trailingText;
//   //   }

//   //   Map<String, dynamic> args = <String, dynamic>{
//   //     "captionText": _captionText + " ",
//   //   };
//   //   final String? version = await _channel.invokeMethod('shareTwitter', args);
//   //   return version;
//   // }

//   // static Future<String?> shareSms(String message,
//   //     {String? url, String? trailingText}) async {
//   //   Map<String, dynamic>? args;
//   //   if (Platform.isIOS) {
//   //     if (url == null) {
//   //       args = <String, dynamic>{
//   //         "message": message,
//   //       };
//   //     } else {
//   //       args = <String, dynamic>{
//   //         "message": message + " ",
//   //         "urlLink": Uri.parse(url).toString(),
//   //         "trailingText": trailingText
//   //       };
//   //     }
//   //   } else if (Platform.isAndroid) {
//   //     args = <String, dynamic>{
//   //       "message": message + (url ?? '') + (trailingText ?? ''),
//   //     };
//   //   }
//   //   final String? version = await _channel.invokeMethod('shareSms', args);
//   //   return version;
//   // }

//   // static Future<String?> copyToClipboard({String? text, String? image}) async {
//   //   final Map<String, dynamic> args = <String, dynamic>{
//   //     "content": text,
//   //     "image": image,
//   //   };
//   //   final String? response =
//   //       await _channel.invokeMethod('copyToClipboard', args);
//   //   return response;
//   // }

//   static Future<bool?> shareOptions(String contentText,
//       {String? imagePath}) async {
//     Map<String, dynamic> args;

//     var _imagePath = imagePath;
//     if (Platform.isAndroid) {
//       if (imagePath != null) {
//         var stickerFilename = "stickerAsset.png";
//         await reSaveImage(imagePath, stickerFilename);
//         _imagePath = stickerFilename;
//       }
//     }
//     args = <String, dynamic>{"image": _imagePath, "content": contentText};
//     final bool? version = await _channel.invokeMethod('shareOptions', args);
//     return version;
//   }

//   // static Future<String?> shareWhatsapp(String content) async {
//   //   final Map<String, dynamic> args = <String, dynamic>{"content": content};
//   //   final String? version = await _channel.invokeMethod('shareWhatsapp', args);
//   //   return version;
//   // }

//   static Future<String?> shareWhatsapp(String content,
//       {String? imagePath}) async {
//     final Map<String, dynamic> args;
//     var data = _channel;
//     var _imagePath = imagePath;
//     if (Platform.isAndroid) {
//       if (imagePath != null) {
//         var stickerFilename = "stickerAsset.png";
//         await reSaveImage(imagePath, stickerFilename);
//         _imagePath = stickerFilename;
//       }
//     }
//     args = <String, dynamic>{"image": _imagePath, "content": content};
//     final String? version = await data.invokeMethod('shareWhatsapp', args);
//     return version;
//   }

//   static Future<Map?> checkInstalledAppsForShare() async {
//     final Map? apps = await _channel.invokeMethod('checkInstalledApps');
//     return apps;
//   }

//   // static Future<String?> shareTelegram(String content) async {
//   //   final Map<String, dynamic> args = <String, dynamic>{"content": content};
//   //   final String? version = await _channel.invokeMethod('shareTelegram', args);
//   //   return version;
//   // }

// // static Future<String> shareSlack() async {
// //   final String version = await _channel.invokeMethod('shareSlack');
// //   return version;
// // }

//   //Utils
//   static Future<bool> reSaveImage(String? imagePath, String filename) async {
//     if (imagePath == null) {
//       return false;
//     }
//     final tempDir = await getTemporaryDirectory();

//     File file = File(imagePath);
//     Uint8List bytes = file.readAsBytesSync();
//     var stickerData = bytes.buffer.asUint8List();
//     String stickerAssetName = filename;
//     final Uint8List stickerAssetAsList = stickerData;
//     final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
//     file = await File(stickerAssetPath).create();
//     file.writeAsBytesSync(stickerAssetAsList);
//     return true;
//   }
// }
