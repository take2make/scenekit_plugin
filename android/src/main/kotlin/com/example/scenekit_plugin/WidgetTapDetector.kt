package com.example.scenekit_plugin

import android.content.Context
import android.view.GestureDetector
import android.view.MotionEvent
import com.google.ar.sceneform.HitTestResult

class WidgetTapDetector(
    context: Context,
    listener: OnTapListener
) {
    private var lastEventNode: WidgetNode? = null
    fun handleTouchEvent(hitTestResult: HitTestResult, motionEvent: MotionEvent) {
        val node = hitTestResult.node
        if (node is WidgetNode) {
            lastEventNode = node
            gestureDetector.onTouchEvent(motionEvent)
        }
    }

    private val gestureDetector = GestureDetector(context, object :
        GestureDetector.SimpleOnGestureListener() {
        override fun onSingleTapConfirmed(e: MotionEvent): Boolean {
            val widgetNode = lastEventNode
            if (widgetNode != null) {
                listener.onTap(widgetNode)
            }
            return true
        }
    })

    fun interface OnTapListener {
        fun onTap(node: WidgetNode)
    }
}