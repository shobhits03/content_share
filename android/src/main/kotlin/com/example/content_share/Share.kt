package com.example.content_share

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.core.content.FileProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File


class Share(private val context: Context) {


    fun share(call: MethodCall, result: MethodChannel.Result) {
        try {
            val title: String = call.argument("title")!!
            val text: String? = call.argument("text")
            val chooserTitle : String? = call.argument("chooserTitle")
            if (title.isEmpty()) {
                Log.println(Log.ERROR, "", "ContentShare Error: Title null or empty")
                result.error("ContentShare: Title cannot be null or empty", null, null)
                return
            }
            val extraTextList = ArrayList<String?>()
            if (text != null && text.isNotEmpty()) {
                extraTextList.add(text)
            }
            val intent = Intent()
            initiateIntent(intent)
            intent.type = "text/plain"
            intent.putExtra(Intent.EXTRA_SUBJECT,title)
            intent.putExtra(Intent.EXTRA_TEXT, text)
            val chooserIntent = Intent.createChooser(intent, chooserTitle)
            chooserIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            chooserIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(chooserIntent)
            result.success(true)
        } catch (ex: Exception) {
            Log.println(Log.ERROR, "", "ContentShare: Error")
            ex.message?.let { result.error(it, null, null) }
        }
    }

    private fun initiateIntent(intent: Intent) {
        intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        intent.action = Intent.ACTION_SEND
    }

    fun shareFile(call: MethodCall, result: MethodChannel.Result) {
        try {
            val title: String = call.argument("title")!!
            val text: String? = call.argument("text")
            val filePath: String? = call.argument("filePath")
            val fileType: String = call.argument("fileType")!!
            val chooserTitle: String = call.argument("chooserTitle")!!
            if (filePath == null || filePath.isEmpty()) {
                Log.println(
                    Log.ERROR,
                    "",
                    "ContentShare: ShareLocalFile Error: filePath null or empty"
                )
                result.error("ContentShare: FilePath cannot be null or empty", null, null)
                return
            }
            val file = File(filePath)
            val fileUri: Uri = FileProvider.getUriForFile(
                context,
                context.applicationContext.packageName + ".provider",
                file
            )
            val intent = Intent()
            initiateIntent(intent)
            intent.type = fileType
            intent.putExtra(Intent.EXTRA_SUBJECT, title)
            text?.let {
                intent.putExtra(Intent.EXTRA_TEXT, it)
            }
            intent.putExtra(Intent.EXTRA_STREAM, fileUri)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            val chooserIntent = Intent.createChooser(intent, chooserTitle)
            chooserIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            chooserIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(chooserIntent)
            result.success(true)
        } catch (ex: Exception) {
            ex.message?.let { result.error(it, null, null) }
            Log.println(Log.ERROR, "", "ContentShare: Error")
        }
    }

}