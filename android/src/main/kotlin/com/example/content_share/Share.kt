package com.example.content_share

import android.content.Context
import android.content.Intent
import android.text.TextUtils
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class Share(private val context: Context) {


    fun share(call: MethodCall, result: MethodChannel.Result) {
        try {
            val title: String = call.argument("title")!!
            val text: String? = call.argument("text")
            val chooserTitle : String? = call.argument("chooserTitle")
            if (title.isEmpty()) {
                Log.println(Log.ERROR, "", "FlutterShare Error: Title null or empty")
                result.error("FlutterShare: Title cannot be null or empty", null, null)
                return
            }
            val extraTextList = ArrayList<String?>()
            if (text != null && text.isNotEmpty()) {
                extraTextList.add(text)
            }
            val intent = Intent()
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.action = Intent.ACTION_SEND
            intent.type = "text/plain"
            intent.putExtra(Intent.EXTRA_SUBJECT,title)
            intent.putExtra(Intent.EXTRA_TEXT, text)
            val chooserIntent = Intent.createChooser(intent, chooserTitle)
            chooserIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            chooserIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(chooserIntent)
            result.success(true)
        } catch (ex: Exception) {
            Log.println(Log.ERROR, "", "FlutterShare: Error")
            ex.message?.let { result.error(it, null, null) }
        }
    }

}