package com.example.athkary

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import java.text.SimpleDateFormat
import java.util.*
import com.example.athkary.R

class PrayerWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.prayer_widget)

            // Sample hardcoded prayer times — replace with dynamic data later
            val prayerTimes = mapOf(
                "الفجر" to "04:15 ص",
                "الشروق" to "05:45 ص",
                "الظهر" to "12:10 م",
                "العصر" to "03:30 م",
                "المغرب" to "06:20 م",
                "العشاء" to "07:40 م"
            )

            val currentHour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY)

            views.removeAllViews(R.id.prayerTimesContainer)

            for ((prayerName, time) in prayerTimes) {
                val itemView = RemoteViews(context.packageName, R.layout.widget_item)
                 itemView.setTextViewText(R.id.prayerName, prayerName)
                 itemView.setTextViewText(R.id.prayerTime, time)


                // Basic highlight for current prayer if needed (mock logic)
                if (time.startsWith(String.format("%02d", currentHour))) {
                    itemView.setInt(android.R.id.text1, "setTextColor", 0xFF1E88E5.toInt())
                    itemView.setInt(android.R.id.text2, "setTextColor", 0xFF1E88E5.toInt())
                }

                views.addView(R.id.prayerTimesContainer, itemView)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
