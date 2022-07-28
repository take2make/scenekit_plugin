package com.example.scenekit_plugin

import android.content.Context
import android.net.Uri
import android.os.Handler
import android.util.Log
import com.google.ar.sceneform.FrameTime
import com.google.ar.sceneform.Node
import com.google.ar.sceneform.assets.RenderableSource
import com.google.ar.sceneform.collision.Box
import com.google.ar.sceneform.collision.Sphere
import com.google.ar.sceneform.math.Quaternion
import com.google.ar.sceneform.math.Vector3
import com.google.ar.sceneform.rendering.ModelRenderable
import com.google.ar.sceneform.ux.*
import kotlin.math.cos
import kotlin.math.sin

class EarthNode(
    private val context: Context,
    transformationSystem: TransformationSystem,
    private val scale: Float,
) : BaseTransformableNode(transformationSystem) {

    companion object {
        const val RADIUS = 0.9f

        fun getX(radius: Float, lat: Double, long: Double): Float {
            return (radius * cos(Math.toRadians(lat)) * sin(Math.toRadians(long))).toFloat()
        }

        fun getY(radius: Float, lat: Double, long: Double): Float {
            return radius * sin(Math.toRadians(lat)).toFloat()
        }

        fun getZ(radius: Float, lat: Double, long: Double): Float {
            return (radius * cos(Math.toRadians(lat)) * cos(Math.toRadians(long))).toFloat()
        }

        var renderableCache: ModelRenderable? = null
    }

    init {
        name = "earth"
        addTransformationController(
            RotationController(this, transformationSystem.dragRecognizer, 1 / scale)
        )
        addTransformationController(
            ScaleController(this, transformationSystem.pinchRecognizer).apply {
                minScale = 0.5f
                maxScale = 3f
            }
        )
        loadModel()
    }

    private fun loadModel() {
        if (renderableCache != null) {
            renderable = renderableCache
            return
        }

//        1.5227485f
//        1.7491373716f
        val modelPath = "new/untitled.gltf"
        ModelRenderable.builder()
            .setSource(
                context, RenderableSource.builder().setSource(
                    context,
                    Uri.parse(modelPath),
                    RenderableSource.SourceType.GLTF2
                )
                    .setScale(1f)
                    .setRecenterMode(RenderableSource.RecenterMode.CENTER)
                    .build()
            )
            .setRegistryId(modelPath)
            .build()
            .thenAccept { modelRenderable ->
                renderableCache = modelRenderable
                renderable = modelRenderable
                select()
            }
    }
}

class RotationController(
    transformableNode: BaseTransformableNode,
    gestureRecognizer: BaseGestureRecognizer<DragGesture>,
    var radius: Float,
) : BaseTransformationController<DragGesture>(transformableNode, gestureRecognizer) {

    private var rotationRate = 0.08f
    private var lat: Double = 0.0
    private var long: Double = 0.0

    override fun canStartTransformation(gesture: DragGesture?): Boolean {
        return transformableNode.isSelected
    }

    override fun onActivated(node: Node) {
        super.onActivated(node)
        Handler().postDelayed({
            transformCamera(lat, long)
        }, 0)
    }


    override fun onContinueTransformation(gesture: DragGesture) {
        val rotationAmountX = gesture.delta.x * rotationRate / transformableNode.localScale.x
        val rotationAmountY = gesture.delta.y * rotationRate / transformableNode.localScale.x
        val deltaAngleX = rotationAmountX.toDouble()
        val deltaAngleY = rotationAmountY.toDouble()

        lat += deltaAngleY
        long -= deltaAngleX

        transformCamera(lat, long)
    }

    override fun onEndTransformation(gesture: DragGesture) {}

    private fun transformCamera(lat: Double, long: Double) {
        val camera = transformableNode.scene?.camera

        var rot = Quaternion.eulerAngles(Vector3.zero())
        val pos = Vector3(
            EarthNode.getX(radius, lat, long),
            EarthNode.getY(radius, lat, long),
            EarthNode.getZ(radius, lat, long)
        )
        rot = Quaternion.multiply(rot, Quaternion(Vector3.up(), (long).toFloat()))
        rot = Quaternion.multiply(rot, Quaternion(Vector3.right(), (-lat).toFloat()))
        camera?.localRotation = rot
        camera?.localPosition = pos
    }
}