package com.example.athkary

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "athkary/prayer_widget",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "refreshPrayerWidget" -> {
                    PrayerWidget.updateAllWidgets(this)
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        }
    }
}