package com.f1calendar.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class F1DriverWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val name = widgetData.getString("widget_driver_name", "车手积分") ?: "车手积分"
        val team = widgetData.getString("widget_driver_team", "F1") ?: "F1"
        val points = widgetData.getString("widget_driver_points", "--") ?: "--"
        val color = widgetData.getString("widget_driver_color", "#0067C0") ?: "#0067C0"
        val accent = runCatching { Color.parseColor(color) }.getOrDefault(Color.rgb(0, 103, 192))

        for (id in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.f1_driver_widget)
            views.setTextViewText(R.id.widget_driver_name, name)
            views.setTextViewText(R.id.widget_driver_team, team)
            views.setTextViewText(R.id.widget_driver_points, points)
            views.setInt(R.id.widget_driver_accent, "setBackgroundColor", accent)
            views.setOnClickPendingIntent(R.id.widget_root, openAppIntent(context))
            appWidgetManager.updateAppWidget(id, views)
        }
    }

    private fun openAppIntent(context: Context): PendingIntent {
        val intent = Intent(context, MainActivity::class.java)
        return PendingIntent.getActivity(
            context,
            1001,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }
}
