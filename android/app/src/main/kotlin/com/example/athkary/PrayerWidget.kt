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
import kotlin.math.max

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
                PrayerRow(R.id.prayerRow1, R.id.prayerName1, R.id.prayerTime1, "الفجر"),
                PrayerRow(R.id.prayerRow2, R.id.prayerName2, R.id.prayerTime2, "الشروق"),
                PrayerRow(R.id.prayerRow3, R.id.prayerName3, R.id.prayerTime3, "الظهر"),
                PrayerRow(R.id.prayerRow4, R.id.prayerName4, R.id.prayerTime4, "العصر"),
                PrayerRow(R.id.prayerRow5, R.id.prayerName5, R.id.prayerTime5, "المغرب"),
                PrayerRow(R.id.prayerRow6, R.id.prayerName6, R.id.prayerTime6, "العشاء"),
            )

            val nextPrayer = findNextPrayerName(prayers, prefs)
            val goldColor = ContextCompat.getColor(context, R.color.widget_gold)
            val textColor = ContextCompat.getColor(context, R.color.widget_text)

            rows.forEach { row ->
                val prayerTime = readPrayerTimeFromPrefs(prefs, row.prayerName)
                views.setTextViewText(row.nameId, row.prayerName)
                views.setTextViewText(row.timeId, prayerTime)

                val isNext = row.prayerName == nextPrayer
                val rowColor = if (isNext) goldColor else textColor
                views.setTextColor(row.nameId, rowColor)
                views.setTextColor(row.timeId, rowColor)
                views.setInt(
                    row.rowId,
                    "setBackgroundResource",
                    if (isNext) R.drawable.prayer_row_next_background else R.drawable.prayer_row_background,
                )
            }

            val nextPrayerText = nextPrayer?.let { "القادم: $it" } ?: ""
            views.setTextViewText(R.id.widgetNextPrayer, nextPrayerText)

            val remaining = nextPrayer?.let {
                val raw = readPrayerTimeFromPrefs(prefs, it)
                formatRemainingTime(raw)
            } ?: ""
            views.setTextViewText(
                R.id.widgetRemainingTime,
                if (remaining.isEmpty()) "" else "المتبقي: $remaining",
            )

            val locationLabel = prefs.getString("prayer_widget_location", null)
                ?: prefs.getString("flutter.prayer_widget_location", "الموقع الافتراضي")
                ?: "الموقع الافتراضي"
            views.setTextViewText(R.id.widgetLocation, locationLabel)
            views.setTextViewText(R.id.widgetDate, formatDate())

            return views
        }

        private data class PrayerRow(
            val rowId: Int,
            val nameId: Int,
            val timeId: Int,
            val prayerName: String,
        )

        private fun findNextPrayerName(
            prayers: List<String>,
            prefs: android.content.SharedPreferences,
        ): String? {
            val now = Calendar.getInstance()
            val nowMinutes = now.get(Calendar.HOUR_OF_DAY) * 60 + now.get(Calendar.MINUTE)

            prayers.forEach { prayerName ->
                val raw = readPrayerTimeFromPrefs(prefs, prayerName)
                if (raw == "--:--") return@forEach
                val minutes = parseMinutesFromPrayerTime(raw) ?: return@forEach
                if (minutes > nowMinutes) return prayerName
            }
            return prayers.firstOrNull()
        }

        private fun readPrayerTimeFromPrefs(
            prefs: android.content.SharedPreferences,
            prayerName: String,
        ): String {
            return prefs.getString(prayerName, null)
                ?: prefs.getString("flutter.$prayerName", "--:--")
                ?: "--:--"
        }

        private fun formatRemainingTime(rawTime: String): String {
            val minutesTarget = parseMinutesFromPrayerTime(rawTime) ?: return "--:--"
            val now = Calendar.getInstance()
            val nowMinutes = now.get(Calendar.HOUR_OF_DAY) * 60 + now.get(Calendar.MINUTE)

            var diff = minutesTarget - nowMinutes
            if (diff < 0) diff += 24 * 60

            val hours = max(0, diff / 60)
            val minutes = max(0, diff % 60)
            return String.format(Locale.US, "%02d:%02d", hours, minutes)
        }

        private fun parseMinutesFromPrayerTime(rawTime: String): Int? {
            val normalized = normalizeTime(rawTime)
            val formatter = SimpleDateFormat("h:mm a", Locale.US)
            val parsedDate = runCatching { formatter.parse(normalized) }.getOrNull() ?: return null
            val cal = Calendar.getInstance().apply { time = parsedDate }
            return cal.get(Calendar.HOUR_OF_DAY) * 60 + cal.get(Calendar.MINUTE)
        }

        private fun normalizeTime(time: String): String {
            return time
                .replace('ص', 'A')
                .replace('م', 'P')
                .replace("A", "AM")
                .replace("P", "PM")
                .replace("AMM", "AM")
                .replace("PMM", "PM")
                .replace("am", "AM")
                .replace("pm", "PM")
                .replace(" ", "")
                .replace("AM", " AM")
                .replace("PM", " PM")
                .trim()
        }

        private fun formatDate(): String {
            val locale = Locale("ar")
            val formatter = SimpleDateFormat("EEEE، d MMMM", locale)
            return formatter.format(Date())
        }
    }
}
