package com.example.scenekit_plugin

import androidx.lifecycle.Lifecycle

interface LifecycleProvider {
    fun getLifecycle(): Lifecycle
}