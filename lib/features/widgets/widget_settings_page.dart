import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';

import '../../app/theme.dart';
import '../calendar/presentation/calendar_providers.dart';
import '../standings/domain/driver_standing.dart';
import '../standings/presentation/standings_providers.dart';
import 'widget_sync_service.dart';

/// 小组件设置：选择车手后，可直接请求系统把两种小组件放到桌面。
class WidgetSettingsPage extends ConsumerStatefulWidget {
  const WidgetSettingsPage({super.key});

  @override
  ConsumerState<WidgetSettingsPage> createState() => _WidgetSettingsPageState();
}

class _WidgetSettingsPageState extends ConsumerState<WidgetSettingsPage> {
  String? _selectedDriver;

  @override
  Widget build(BuildContext context) {
    final asyncRows = ref.watch(driverStandingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('主屏小组件')),
      body: asyncRows.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('车手积分暂不可用')),
        data: (rows) => _buildContent(context, rows),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<DriverStanding> rows) {
    if (rows.isEmpty) return const Center(child: Text('暂无车手积分数据'));
    final selected = _selectedDriver ?? rows.first.driver.driverId;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: <Widget>[
        Text('车手积分小组件', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          '先选择一位车手，桌面小组件会显示他的实时积分。',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: selected,
          decoration: const InputDecoration(
            labelText: '选择车手',
            border: OutlineInputBorder(),
          ),
          items: <DropdownMenuItem<String>>[
            for (final row in rows)
              DropdownMenuItem<String>(
                value: row.driver.driverId,
                child: Text('${row.driver.fullName} · ${row.points} PTS'),
              ),
          ],
          onChanged: (value) => setState(() => _selectedDriver = value),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => _saveDriver(selected),
          icon: const Icon(Icons.save_outlined),
          label: const Text('保存车手选择'),
        ),
        const SizedBox(height: 30),
        Text('添加到桌面', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          'Android 桌面长按空白处，选择 F1 赛历小组件；也可以使用下面按钮直接请求添加。',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 14),
        _WidgetActionCard(
          icon: Icons.person_outline,
          title: '车手积分',
          subtitle: '显示所选车手的当前积分',
          onTap: () async {
            await _saveDriver(selected, showMessage: false);
            await HomeWidget.requestPinWidget(
              qualifiedAndroidName: WidgetSyncService.driverProvider,
            );
          },
        ),
        _WidgetActionCard(
          icon: Icons.timer_outlined,
          title: '比赛倒计时',
          subtitle: '显示下一场大奖赛的倒计时',
          onTap: () async {
            final races = ref.read(racesProvider).asData?.value;
            if (races != null) await WidgetSyncService.syncRace(races);
            await HomeWidget.requestPinWidget(
              qualifiedAndroidName: WidgetSyncService.raceProvider,
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          '小组件数据会在 App 刷新赛历或积分后同步；比赛倒计时在桌面上会持续走秒。',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Future<void> _saveDriver(String driverId, {bool showMessage = true}) async {
    await WidgetSyncService.saveSelectedDriver(driverId);
    final rows = ref.read(driverStandingsProvider).asData?.value;
    if (rows != null) await WidgetSyncService.syncDrivers(rows);
    if (showMessage && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已保存，车手积分小组件会显示该车手')));
    }
  }
}

class _WidgetActionCard extends StatelessWidget {
  const _WidgetActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: context.palette.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Icon(icon, color: context.palette.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.add_circle_outline),
            ],
          ),
        ),
      ),
    ),
  );
}
