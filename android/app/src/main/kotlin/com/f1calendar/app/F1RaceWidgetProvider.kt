package com.f1calendar.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.SystemClock
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class F1RaceWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val title = widgetData.getString("widget_race_title", "下一场大奖赛") ?: "下一场大奖赛"
        val location = widgetData.getString("widget_race_location", "打开 App 获取最新赛历")
            ?: "打开 App 获取最新赛历"
        val target = widgetData.getLong("widget_race_target", 0L)
        val views = RemoteViews(context.packageName, R.layout.f1_race_widget)
        views.setTextViewText(R.id.widget_race_title, title)
        views.setTextViewText(R.id.widget_race_location, location)
        if (target > System.currentTimeMillis()) {
            val base = SystemClock.elapsedRealtime() + (target - System.currentTimeMillis())
            views.setChronometer(R.id.widget_race_countdown, base, "%s", true)
            views.setChronometerCountDown(R.id.widget_race_countdown, true)
        } else {
            views.setTextViewText(R.id.widget_race_countdown, "已结束")
        }
        views.setOnClickPendingIntent(R.id.widget_race_root, openAppIntent(context))
        for (id in appWidgetIds) appWidgetManager.updateAppWidget(id, views)
    }

    private fun openAppIntent(context: Context): PendingIntent {
        val intent = Intent(context, MainActivity::class.java)
        return PendingIntent.getActivity(
            context,
            1002,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }
}
