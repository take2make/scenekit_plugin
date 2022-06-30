package com.example.scenekit_plugin

import android.app.Activity
import android.os.Handler
import android.util.Log
import com.google.ar.core.ArCoreApk
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodCallHandlerImpl(private val activity: Activity, private val messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {
    private var methodChannel: MethodChannel? = null
    private val UTILS_CHANNEL_NAME = "scenekit_plugin"

    init {
        methodChannel = MethodChannel(messenger, UTILS_CHANNEL_NAME)
        methodChannel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.i(ScenekitPlugin.TAG, "Method called: " + call.method)
        when (call.method) {
            "checkConfiguration" -> {
                result.success("1")
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    fun stopListening() {
        methodChannel?.setMethodCallHandler(null)
    }

}