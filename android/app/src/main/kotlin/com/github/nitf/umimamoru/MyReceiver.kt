package com.github.nitf.umimamoru

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MyReceiver(private val methodChannel: MethodChannel): BroadcastReceiver() {

    @SuppressLint("UnsafeProtectedBroadcastReceiver")
    override fun onReceive(context: Context, intent: Intent) {
        methodChannel.invokeMethod("", "")
    }
}