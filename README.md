# F1 赛历（f1_calendar）

基于 Flutter 3.x + Dart 3 + Material 3 的 F1 赛历客户端，Android 优先。两个标签页：**赛历** 与 **积分榜**，积分榜支持车手 / 车队切换与车队详情页。数据来自 Jolpica-F1（免费、无需 key），不依赖任何自建服务器；全部响应与图片落本地缓存，弱网与断网仍可打开。

积分榜页面右上角的组件按钮可以选择一位车手，并添加两种 Android 主屏小组件：单一车手积分、下一场比赛倒计时。倒计时由 Android 原生 Chronometer 驱动，App 刷新真实赛历数据后同步到桌面。

## 运行

```bash
flutter pub get
flutter run            # 连接真机 / 模拟器
flutter build apk      # 需要本机 Android SDK 与 JDK 17
```

代码生成（模型与 retrofit 接口的 `*.freezed.dart` / `*.g.dart` 已随仓库提交，改模型后再执行）：

```bash
dart run build_runner build
```

## 技术选型

| 用途 | 选择 |
| --- | --- |
| 状态管理 | flutter_riverpod（AsyncNotifier + AsyncValue 三态） |
| 路由 | go_router（StatefulShellRoute 保留各 Tab 栈，淡入转场） |
| 网络 | dio + retrofit（接口自动生成） |
| 模型 | freezed + json_serializable |
| 本地缓存 | Hive（响应正文 + ETag/Last-Modified + 抓取时间） |
| 图片 | cached_network_image（磁盘缓存 + 占位 + 淡入） |
| 时间 | intl（zh_CN 日期格式化） |

## 架构

```
lib/
  main.dart                     启动：初始化 intl / Hive，注入 CacheStore
  app/
    router.dart                 go_router 路由表 + 底部 NavigationBar 外壳
    theme.dart                  Material3 主题 + 设计 token（AppPalette）
    providers.dart              Dio / 缓存 / 赛季 等基础设施 provider
  core/
    network/dio_client.dart     超时、JSON、缓存拦截器装配
    network/http_cache_interceptor.dart  条件请求（If-None-Match / If-Modified-Since）、304 复用缓存
    storage/hive_box.dart       CacheStore + CachedPayload（TTL 判断）
    error/failure.dart          DioException → 领域 Failure
    utils/date_x.dart           下一场比赛、倒计时拆解、按月分组、日期格式化
  features/
    calendar/  data（race_api / race_response / race_cache / repository_impl）
               domain（race 模型、仓库接口、GetNextRace 用例）
               presentation（页面、下一场卡片、赛历行、providers）
    standings/ data（standings_api / response / cache / repository_impl）
               domain（standing 模型、仓库接口）
               presentation（积分页、车手 / 车队海报卡、车队详情、providers）
    widgets/   widget_settings_page / widget_sync_service（Android 主屏小组件同步）
  shared/
    models/team_asset.dart      车队 → 车图 / 队色 / 车手头像 静态映射
    models/locale_labels.dart   国家与城市中文、赛道短名、分站渐变
    widgets/                    卡片图、头像、队色条、滚动数字、状态页、分组标题
```

## 缓存与离线策略

- 赛历缓存 **24 小时**，积分榜缓存 **5 分钟**；TTL 写在 Repository 层，UI 不感知。
- 打开页面先渲染缓存，过期时后台静默刷新（stale-while-revalidate），弱网秒开。
- 请求带 `If-None-Match` / `If-Modified-Since`；服务端返回 304 时直接复用缓存正文，只更新时间戳。
- 网络失败但存在缓存时返回旧数据，不把页面变成错误页；无缓存才展示错误态与重试。
- 图片走 cached_network_image 磁盘缓存；远端 URL 用 Cloudinary `w_` 参数取 600/1200 宽度，解码再加 `memCacheWidth`，省流量也省内存。
- 赛季跟随本机年份自动推导，跨年无需发版；分站数量完全按接口返回处理，不硬编码 24 站。

## 视觉规范

- 底色 `#F3F3F3`、卡片纯白、圆角 12px、阴影 `0 1 3 rgba(0,0,0,.06)`；
- 强调色只用 `#0067C0`（深色模式提亮为 `#4C9BE8`）；
- 字号只有 32 / 20 / 15 / 12 四级，大数字使用 tabular figures 保证对齐；
- 分割线 1px `#E5E5E5`，不用卡片堆阴影；深色模式底色 `#1F1F1F`、卡片 `#2B2B2B`；
- 每屏最多一个重色块（赛历页的「下一场」渐变卡片）。

## 测试

```bash
flutter analyze   # 无问题
flutter test      # 用例覆盖时间计算、分组、站点数容错、素材映射、接口解析与卡片渲染
```

## 素材说明

车图与车手头像来自 formula1.com 官方媒体地址（2026 赛季路径）。所有 URL 集中在 `lib/shared/models/team_asset.dart`，换赛季或换素材只需改这一处；新增车队若未收录会走灰色兜底，不会崩溃。
