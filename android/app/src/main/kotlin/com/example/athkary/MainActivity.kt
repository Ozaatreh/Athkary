package com.example.athkary

import android.content.Context
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
                    val timesRaw = call.argument<Map<*, *>>("times")
                    val locationLabel = call.argument<String>("location")

                    val times = timesRaw?.mapNotNull { (key, value) ->
                        val k = key?.toString() ?: return@mapNotNull null
                        val v = value?.toString() ?: "--:--"
                        k to v
                    }?.toMap()

                    if (times != null || locationLabel != null) {
                        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                        val editor = prefs.edit()

                        times?.forEach { (key, value) ->
                            editor.putString("flutter.$key", value)
                            editor.putString(key, value)
                        }

                        if (!locationLabel.isNullOrBlank()) {
                            editor.putString("flutter.prayer_widget_location", locationLabel)
                            editor.putString("prayer_widget_location", locationLabel)
                        }

                        editor.apply()
                    }

                    PrayerWidget.updateAllWidgets(this)
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        }
    }
}
