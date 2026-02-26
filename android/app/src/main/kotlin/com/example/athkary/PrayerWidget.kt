package com.example.athkary

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import androidx.core.content.ContextCompat
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale

class PrayerWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = buildViews(context)
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_REFRESH_WIDGET) {
            updateAllWidgets(context)
        }
    }

    companion object {
        const val ACTION_REFRESH_WIDGET = "com.example.athkary.ACTION_REFRESH_PRAYER_WIDGET"

        fun updateAllWidgets(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val componentName = ComponentName(context, PrayerWidget::class.java)
            val ids = manager.getAppWidgetIds(componentName)
            if (ids.isNotEmpty()) {
                ids.forEach { id ->
                    manager.updateAppWidget(id, buildViews(context))
                }
            }
        }

        private fun buildViews(context: Context): RemoteViews {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val views = RemoteViews(context.packageName, R.layout.prayer_widget)

            val prayers = listOf(
                "الفجر",
                "الشروق",
                "الظهر",
                "العصر",
                "المغرب",
                "العشاء",
            )

            val rows = listOf(
                Triple(R.id.prayerName1, R.id.prayerTime1, "الفجر"),
                Triple(R.id.prayerName2, R.id.prayerTime2, "الشروق"),
                Triple(R.id.prayerName3, R.id.prayerTime3, "الظهر"),
                Triple(R.id.prayerName4, R.id.prayerTime4, "العصر"),
                Triple(R.id.prayerName5, R.id.prayerTime5, "المغرب"),
                Triple(R.id.prayerName6, R.id.prayerTime6, "العشاء"),
            )

            val nextPrayer = findNextPrayerName(prayers, prefs)
            val goldColor = ContextCompat.getColor(context, R.color.widget_gold)
            val textColor = ContextCompat.getColor(context, R.color.widget_text)

            rows.forEach { (nameId, timeId, prayerName) ->
                val prayerTime = prefs.getString("flutter.$prayerName", "--:--") ?: "--:--"
                val displayName = if (prayerName == nextPrayer) "$prayerName • القادم" else prayerName
                views.setTextViewText(nameId, displayName)
                views.setTextViewText(timeId, prayerTime)
                val rowColor = if (prayerName == nextPrayer) goldColor else textColor
                views.setTextColor(nameId, rowColor)
                views.setTextColor(timeId, rowColor)
            }

            val locationLabel = prefs.getString("flutter.prayer_widget_location", "الموقع الافتراضي") ?: "الموقع الافتراضي"
            views.setTextViewText(R.id.widgetLocation, locationLabel)
            views.setTextViewText(R.id.widgetDate, formatDate())

            return views
        }

        private fun findNextPrayerName(
            prayers: List<String>,
            prefs: android.content.SharedPreferences,
        ): String? {
            val formatter = SimpleDateFormat("h:mm a", Locale.US)
            val now = Calendar.getInstance()
            val nowMinutes = now.get(Calendar.HOUR_OF_DAY) * 60 + now.get(Calendar.MINUTE)

            prayers.forEach { prayerName ->
                val raw = prefs.getString("flutter.$prayerName", null) ?: return@forEach
                val normalized = normalizeTime(raw)
                val parsedDate = runCatching { formatter.parse(normalized) }.getOrNull() ?: return@forEach
                val cal = Calendar.getInstance().apply { time = parsedDate }
                val minutes = cal.get(Calendar.HOUR_OF_DAY) * 60 + cal.get(Calendar.MINUTE)
                if (minutes > nowMinutes) return prayerName
            }
            return prayers.firstOrNull()
        }

        private fun normalizeTime(time: String): String {
            return time
                .replace("ص", "AM")
                .replace("م", "PM")
                .replace("AM", "AM")
                .replace("PM", "PM")
                .trim()
        }

        private fun formatDate(): String {
            val locale = Locale("ar")
            val formatter = SimpleDateFormat("EEEE، d MMMM", locale)
            return formatter.format(Date())
        }
    }
}