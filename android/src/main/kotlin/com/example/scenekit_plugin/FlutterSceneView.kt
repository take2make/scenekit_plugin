package com.example.scenekit_plugin

import android.content.Context
import android.graphics.drawable.ColorDrawable
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.google.ar.sceneform.SceneView
import com.google.ar.sceneform.math.Vector3
import com.google.ar.sceneform.ux.FootprintSelectionVisualizer
import com.google.ar.sceneform.ux.TransformationSystem
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


internal class FlutterSceneView(
    private val context: Context,
    messenger: BinaryMessenger,
    id: Int,
    private val lifecycleProvider: LifecycleProvider
) : PlatformView, MethodChannel.MethodCallHandler, DefaultLifecycleObserver {
    private var sceneView: SceneView?
    private val methodChannel: MethodChannel = MethodChannel(messenger, "scenekit_$id")
    private val transformationSystem by lazy { makeTransformationSystem() }
    private var earthNode: EarthNode? = null

    init {
        methodChannel.setMethodCallHandler(this)
        lifecycleProvider.getLifecycle()?.addObserver(this)

        sceneView = SceneView(context)
        val scene = sceneView?.scene?.apply {
            sunlight?.isEnabled = false
            val widgetTapDetector = WidgetTapDetector(context) { node ->
                methodChannel.invokeMethod("widget_tap", node.key)
            }
            addOnPeekTouchListener { hitTestResult, motionEvent ->
                hitTestAll(motionEvent).forEach {
                    widgetTapDetector.handleTouchEvent(it, motionEvent)
                }
                transformationSystem.onTouch(hitTestResult, motionEvent)
            }
        }
    }


    override fun getView(): View? {
        return sceneView
    }

    override fun dispose() {
        destroyNativeView()
        destroySceneView()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "init" -> {
                sceneView?.resume()
                result.success(null)
            }
            "remove_widgets" -> {
                earthNode?.children?.reversed()?.forEach { node ->
                    if (node is WidgetNode) {
                        node.setParent(null)
                    }
                }
                result.success(null)
            }
            "add_earth_to_scene" -> {
                if (earthNode != null) {
                    return
                }
                val backgroundColor = call.argument<Number>("backgroundColor")
                sceneView?.apply {
                    background = if (backgroundColor != null) {
                        ColorDrawable(backgroundColor.toInt())
                    } else {
                        ColorDrawable(0xffffff)
                    }
                    val scale = call.argument<Double>("initialScale")?.toFloat() ?: 1f

                    val earthNode = EarthNode(context, transformationSystem, scale).apply {
                        localPosition = Vector3(
                            call.argument<Double>("x")?.toFloat() ?: 0f,
                            call.argument<Double>("y")?.toFloat() ?: 0f,
                            call.argument<Double>("z")?.toFloat() ?: 0f,
//                        -1f,
                        )
                    }
                    scene.addChild(earthNode)
                    this@FlutterSceneView.earthNode = earthNode
                }
                result.success(null)
            }
            "add_widgets_to_earth" -> {
                val earthNode = this.earthNode ?: return

                val widgets = call.argument<List<Map<String, Any>>>("widgets")
                widgets?.forEach { data ->
                    val key = data["key"] as? String
                    val latitude = data["latitude"] as? Double
                    val longitude = data["longitude"] as? Double
                    if (key != null && latitude != null && longitude != null) {
                        val color = data["color"] as? Long ?: 0x000000
                        val imageData = data["imageData"] as? String

                        val correctedLatitude: Double
                        val correctedLongitude: Double
                        if (latitude >= 0 && longitude >= 0) {
                            if (latitude > longitude) {
                                correctedLatitude = latitude - 10.4f
                                correctedLongitude = longitude
                            } else {
                                correctedLatitude = latitude - 15.5f
                                correctedLongitude = longitude + 2f
                            }
                        } else if (latitude < 0 && longitude < 0) {
                            correctedLatitude = latitude + 10.4f
                            correctedLongitude = longitude
                        } else if (latitude < 0 && longitude >= 0) {
                            correctedLatitude = latitude + 1.9f
                            correctedLongitude = longitude + 2f
                        } else {
                            correctedLatitude = latitude - 16f
                            correctedLongitude = longitude
                        }

                        WidgetNode(context, key, color.toInt(), imageData).apply {
                            val radius = EarthNode.RADIUS + 0.1f
                            localPosition = Vector3(
                                EarthNode.getX(
                                    radius,
                                    correctedLatitude,
                                    correctedLongitude
                                ),
                                EarthNode.getY(
                                    radius,
                                    correctedLatitude,
                                    correctedLongitude
                                ),
                                EarthNode.getZ(
                                    radius,
                                    correctedLatitude,
                                    correctedLongitude
                                ),
                            )
                            setParent(earthNode)
                        }
                    }
                }
                result.success(null)
            }
            "checkConfiguration" -> result.success("1")
            else -> result.notImplemented()
        }
    }

    private fun makeTransformationSystem(): TransformationSystem {
        val selectionVisualizer = FootprintSelectionVisualizer()
        return TransformationSystem(context.resources.displayMetrics, selectionVisualizer)
    }

    override fun onResume(owner: LifecycleOwner) {
        sceneView?.resume()
    }

    override fun onPause(owner: LifecycleOwner) {
        sceneView?.pause()
    }

    override fun onDestroy(owner: LifecycleOwner) {
        owner.lifecycle.removeObserver(this)
        destroyNativeView()
        destroySceneView()
        EarthNode.renderableCache = null
    }

    private fun destroyNativeView() {
        methodChannel.setMethodCallHandler(null)
        lifecycleProvider.getLifecycle()?.removeObserver(this)
    }

    private fun destroySceneView() {
        earthNode = null
        sceneView?.pause()
        sceneView?.destroy()
        sceneView = null
    }
}