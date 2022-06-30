package com.example.scenekit_plugin

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import android.app.Activity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import androidx.annotation.Nullable
import io.flutter.plugin.common.PluginRegistry.Registrar

class ScenekitPlugin: FlutterPlugin, ActivityAware {
  @Nullable
  private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

  private var methodCallHandler: MethodCallHandlerImpl? = null

  companion object {
    const val TAG = "scenekit"

    private const val CHANNEL_NAME = "scenekit"
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      registrar
        .platformViewRegistry()
        .registerViewFactory(CHANNEL_NAME, FlutterScenekitFactory(registrar.activity()!!, registrar.messenger()))
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
  }

  override fun onDetachedFromEngine(p0: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = null
  }

  override fun onDetachedFromActivity() {
    //TODO remove othen channel
    methodCallHandler?.stopListening()
    methodCallHandler = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    flutterPluginBinding?.platformViewRegistry?.registerViewFactory(CHANNEL_NAME, FlutterScenekitFactory(binding.activity, flutterPluginBinding?.binaryMessenger!!))
    methodCallHandler = MethodCallHandlerImpl(
      binding.activity, flutterPluginBinding?.binaryMessenger!!)

  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }
}


class FlutterScenekitFactory(val activity: Activity, val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(p0: Context?, p1: Int, p2: Any?): PlatformView {
    val creationParams = p2 as Map<String?, Any?>?
    return FlutterSceneView(activity, p0,messenger, p1, creationParams)
  }
}

