package com.github.nitf.umimamoru

import android.content.IntentFilter;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import android.content.Intent;

class MainActivity(): FlutterActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    val methodChannel = MethodChannel(flutterView, "com.github.nitf")
    val receiver = MyReceiver(methodChannel)
    val mTime = IntentFilter(Intent.ACTION_TIME_TICK)
    registerReceiver(receiver, mTime)
  }
}
