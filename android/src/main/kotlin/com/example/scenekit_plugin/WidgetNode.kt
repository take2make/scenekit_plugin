package com.example.scenekit_plugin

import android.content.Context
import android.content.res.ColorStateList
import android.graphics.BitmapFactory
import android.util.Base64
import android.util.Log
import android.widget.ImageView
import com.google.ar.sceneform.FrameTime
import com.google.ar.sceneform.Node
import com.google.ar.sceneform.math.Quaternion
import com.google.ar.sceneform.math.Vector3
import com.google.ar.sceneform.rendering.Renderable
import com.google.ar.sceneform.rendering.ViewRenderable


class WidgetNode(
    context: Context,
    val key: String,
    private val color: Int,
    private val imageData: String?,
) : Node() {
    init {
        name = key
        ViewRenderable.builder()
            .setView(context, R.layout.item_widget)
            .build()
            .thenAccept { viewRenderable ->
                (viewRenderable.view as? ImageView)?.apply {
                    backgroundTintList = ColorStateList.valueOf(color)
                    imageData?.let {
                        val byteArray = Base64.decode(it, Base64.DEFAULT)
                        setImageBitmap(BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size))
                    }
                }
                viewRenderable.isShadowCaster = false
                viewRenderable.renderPriority = Renderable.RENDER_PRIORITY_FIRST
                renderable = viewRenderable
            }
    }

    override fun onUpdate(frame: FrameTime?) {
        super.onUpdate(frame)
        setLookDirection(scene?.camera?.localPosition, Vector3.up())
    }
}