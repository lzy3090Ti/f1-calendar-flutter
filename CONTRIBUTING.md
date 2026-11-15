# 参与贡献

感谢你关注 F1 Calendar。提交代码前，请先阅读 [LICENSE.md](LICENSE.md)：本项目允许非商业使用、修改和分发，但不允许未经授权的商业使用。

## 开始之前

- 对较大改动，先创建 Issue 说明问题、方案和预期行为。
- 一个 Pull Request 只处理一个明确主题，避免混入无关格式化或重构。
- 不提交 API Key、个人签名、设备路径、构建产物或包含隐私数据的缓存。
- 提交即表示你有权贡献该内容，并同意按本仓库同一许可证提供。

## 本地开发

环境要求：Flutter 3.47.9、Dart 3.13.7；构建 Android 时还需 JDK 17 和 Android SDK。

```bash
flutter pub get
flutter run
```

修改 Freezed 模型或 Retrofit 接口后，重新生成代码：

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 提交前检查

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

请同时验证与改动相关的真实交互，尤其是：

- 赛历、比赛结果、车队积分和车队详情是否仍能正常打开；
- 有缓存、无缓存、弱网和断网状态下的界面是否合理；
- 浅色与深色模式是否都可读；
- 是否引入不必要的网络请求、敏感权限或大型二进制文件。

## 分支与提交

从最新 `main` 创建分支，使用清晰、单一的提交说明，例如：

```text
fix: reuse cached standings after a 304 response
docs: clarify Android signing requirements
feat: add driver standings
```

## Pull Request

请在描述中说明：

1. 改动解决了什么问题；
2. 实现方式及重要取舍；
3. 执行过哪些测试；
4. UI 改动附前后截图；
5. 是否涉及数据结构、缓存、权限或许可证变化。
