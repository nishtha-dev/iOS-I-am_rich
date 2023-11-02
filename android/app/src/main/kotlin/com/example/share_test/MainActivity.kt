package com.example.share_test

import kotlin.random.Random

import android.content.*
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.net.Uri
import android.os.Build
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.net.URLEncoder
import android.content.ClipData
import android.provider.MediaStore


import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.core.content.FileProvider
import java.io.File

import android.content.ContentValues

import android.content.Context
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.app.Activity

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
      super.configureFlutterEngine(flutterEngine)
     
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel").setMethodCallHandler {
      call, result ->
        if(call.method == "shareWhatsapp") {
            var activeContext: Context? = null
            var activity: Activity? = null
            var context: Context? = null
        // activeContext = if (activity != null) activity!!.applicationContext else context!!

        val content: String? = call.argument("content")
        val image: String? = call.argument("image")
        val whatsappIntent = Intent(Intent.ACTION_SEND)
        // print("image:- $image")
        // print("imguri:- ${image.getAbsolutePath()}")
        // val imgUri = Uri.parse("storage/emulated/0/Download/test.jpg")
        val imgUri = Uri.parse(image)
        // print("imguri:- $imgUri")
        whatsappIntent.putExtra(Intent.EXTRA_STREAM, imgUri)
        whatsappIntent.setType("image/*")
        whatsappIntent.type = "text/plain"
        whatsappIntent.setPackage("com.whatsapp")
        whatsappIntent.putExtra(Intent.EXTRA_TEXT, content)
        // print("whatsappIntent $whatsappIntent" )
        // print("enter try statement")
        try {
            startActivity(whatsappIntent)
            result.success("success")
        } catch (ex: Exception) {
            result.success("error")
        }
            
        }
       else if(call.method == "shareTelegram") {
            var activeContext: Context? = null
            var activity: Activity? = null
            var context: Context? = null
        // activeContext = if (activity != null) activity!!.applicationContext else context!!

        val content: String? = call.argument("content")
        val image: String? = call.argument("image")
        val telegramIntent = Intent(Intent.ACTION_SEND)
        if (image!=null) {
            //check if  image is also provided
            // val imagefile =  File(activeContext!!.cacheDir,image)
            val imagefile =  File(image)
            val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.example.share_test", imagefile)
            intent.type = "image/*"
            intent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
        } else {
            intent.type = "text/plain";
        }
        // val imgUri = FileProvider.get
        // telegramIntent.putExtra(Intent.EXTRA_STREAM, imgUri)
        telegramIntent.setType("image/jpeg")
        // Log.e("telegram uri", imgUri.toString())
        // telegramIntent.type = "image/jpeg"
        telegramIntent.setPackage("org.telegram.messenger")
        telegramIntent.putExtra(Intent.EXTRA_TEXT, content)
        // telegramIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        telegramIntent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
        telegramIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) 
        try {
            // val test = Intent.createChooser(telegramIntent, "xx");
            // startActivity(test)
            startActivity(telegramIntent);
            result.success("success")
        } catch (ex: Exception) {
            result.success("error")
        }
        // try {
        //     val intent = Intent.createChooser(telegramIntent, "Share via Telegram")
        //     context.startActivity(intent)
        //     result.success("success")
        // } catch (ex: Exception) {
        //     result.success("error")
        // }
            
        }
        else if(call.method == "shareTwitter") {
            // var activeContext: Context? = null
            // var activity: Activity? = null
            // var context: Context? = null
        // activeContext = if (activity != null) activity!!.applicationContext else context!!

        val text: String? = call.argument("captionText")
        val image: String? = call.argument("image")
        val imgUri = Uri.parse(image)
        val urlScheme = "http://www.twitter.com/intent/tweet?text=${URLEncoder.encode(text, Charsets.UTF_8.name())}" 
        Log.d("hello", urlScheme)
        val twitterIntent = Intent(Intent.ACTION_VIEW)
        
        // twitterIntent.putExtra(Intent.EXTRA_STREAM, imgUri)
        // twitterIntent.setType("image/*")
        // twitterIntent.type = "text/plain" 
        twitterIntent.data = Uri.parse(urlScheme)
        // twitterIntent.setPackage("com.twitter.android")
        twitterIntent.putExtra(Intent.EXTRA_TEXT, text)
        print("twitterIntent $twitterIntent" )
        print("enter try statement")
        try {
            startActivity(twitterIntent)
            result.success("success")
        } catch (ex: Exception) {
            result.success("error")
        }
            
        }
        else if(call.method == "getRandomNumber") {
          val rand = Random.nextInt(100)
          result.success(rand)
        }
        else {
          result.notImplemented()
        }
    }
    }
}




