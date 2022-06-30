package com.example.scenekit_plugin

import android.annotation.SuppressLint
import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.graphics.Color
import android.os.Build
import android.os.Build.VERSION_CODES
import android.os.Handler
import android.util.Log
import android.view.MotionEvent
import android.view.View
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.google.ar.core.*
import com.google.ar.sceneform.*
import com.google.ar.sceneform.math.Vector3
import com.google.ar.sceneform.rendering.Material
import com.google.ar.sceneform.rendering.MaterialFactory
import com.google.ar.sceneform.rendering.Renderable
import com.google.ar.sceneform.rendering.ShapeFactory
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


@SuppressLint("SetTextI18n")
@RequiresApi(VERSION_CODES.O)
internal class FlutterSceneView(val activity: Activity, context: Context?, messenger: BinaryMessenger, id: Int, creationParams: Map<String?, Any?>?) : PlatformView,MethodChannel.MethodCallHandler {
    private val sceneView: SceneView
    //private val textView: TextView
    private val methodChannel: MethodChannel = MethodChannel(messenger, "scenekit_$id")

    override fun getView(): View {
        return sceneView
    }

    override fun dispose() {}

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "checkConfiguration" -> {
                result.success("1")
            }
            else -> {
                result.notImplemented()
            }
        }
    }


    private fun addOnTapHandler(parentNode: Node, context: Context?) {
        parentNode.setOnTapListener { hitTestResult: HitTestResult, motionEvent: MotionEvent? ->
            Log.d("TAG", "addOnTapHandler: " + hitTestResult.point)
            val color =
                com.google.ar.sceneform.rendering.Color(Color.parseColor("#FF7390"))
            MaterialFactory.makeOpaqueWithColor(context, color)
                .thenAccept { material: Material? ->
                    val sphere: Renderable =
                        ShapeFactory.makeSphere(0.05f, Vector3.zero(), material)
                    val node = Node()
                    node.setParent(hitTestResult.node)
                    node.localPosition = hitTestResult.point
                    node.renderable = sphere
                }
        }
    }

    init {
        methodChannel.setMethodCallHandler(this)

        sceneView = SceneView(context)
        sceneView.layoutParams.width = 200
        sceneView.setBackgroundColor(R.color.orange.toInt())
        val scene = sceneView.getScene()
        val parentNode = Node()
        scene.addChild(parentNode)
        addOnTapHandler(parentNode, context)

        /*textView = TextView(context)
        textView.textSize = 72f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "Rendered on a native Android view (id: $id)"
        */
    }
}