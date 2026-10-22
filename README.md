# TvP

> 服务器地址内置、开箱即用的私域影视客户端。基于 [MoonTechLab/Selene](https://github.com/MoonTechLab/Selene) 改造，全平台（Android / Windows / macOS / iOS）由 GitHub Actions 自动构建。

![Flutter](https://img.shields.io/badge/Flutter-3.44.0-02569B?logo=flutter)
![Version](https://img.shields.io/badge/version-1.6.9-blue)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20Windows%20%7C%20macOS%20%7C%20iOS-lightgrey)
[![Download](https://img.shields.io/github/v/release/xinyule/selene-tvp?label=release&color=2ea44f)](https://github.com/xinyule/selene-tvp/releases/latest)

---

## 这是什么

TvP 是 [Selene](https://github.com/MoonTechLab/Selene)（MoonTV 系影视客户端）的**私域定制版**，功能与原版完全一致，只改了分发相关的部分：

| 改造项 | 说明 |
| --- | --- |
| **服务器地址内置** | 登录页不再有「服务器地址」输入框，地址写在代码常量里，打开只需填**用户名 + 密码** |
| **可与原版共存** | 包名 / Bundle ID 全部改为 `com.tvp.app`（原版 `org.moontechlab.selene`），能和官方客户端同时安装 |
| **更新指向本仓库** | 应用内「检查更新」调用 `xinyule/selene-tvp/releases/latest`，点击版本号跳转本仓库主页 |
| **应用名与图标** | 显示名统一为 **TvP**，换成影院银幕风格图标 |

---

## 下载

👉 **<https://github.com/xinyule/selene-tvp/releases/latest>**

| 文件 | 平台 | 适用 |
| --- | --- | --- |
| `TvP-1.6.9.apk` | Android | arm64 + armeabi-v7a 通用包，一个包装所有手机 |
| `TvP-Windows-x64.zip` | Windows | 64 位，解压后运行 `tvp.exe` |
| `TvP-macOS-arm64.zip` | macOS | Apple 芯片（M1 / M2 / M3 / M4） |
| `TvP-macOS-x64.zip` | macOS | Intel 芯片 |
| `TvP-iOS-unsigned.ipa` | iOS | **未签名**，需自行签名后安装 |

> GitHub 访问不畅时，在下载链接前拼镜像前缀即可：
> `https://gh-proxy.com/https://github.com/...` 或 `https://ghproxy.net/https://github.com/...`

### 安装提示

- **Android**：直接安装。若提示「未知来源」，允许一次即可。
- **Windows**：解压**整个文件夹**后运行 `tvp.exe`（不要只拷 exe 出来）。首次打开被 SmartScreen 拦截时，点「更多信息 → 仍要运行」。
- **macOS**：解压得到 `TvP.app`，拖入「应用程序」。应用未公证，首次启动需**右键 → 打开**。
- **iOS**：本 IPA 未签名，无法直接装到普通 iPhone。三种办法：
  1. 有 Apple 开发者账号：用 Xcode / Transporter 重签名后分发（TestFlight 或 Ad Hoc）；
  2. 无付费账号：用爱思助手、AltStore、Sideloadly 等工具配合个人 Apple ID 自签（免费账号有效期 7 天）；
  3. 在仓库 Secrets 里配置签名证书，让 CI 自动产出已签名的 IPA。

---

## 已知限制

- **Windows ARM64 无法提供**：Flutter 官方目前没有 Windows ARM64 桌面引擎（CMake 配置阶段即失败）。x64 包在 ARM 版 Windows（骁龙本）上可通过模拟层正常运行。
- **iOS 包未签名**：原因见上方安装提示。
- **更新检查依赖 `api.github.com`**：该域名在国内网络偶尔不通，失败时会静默跳过，只影响「不弹更新提示」，不影响播放。

---

## 自行构建

每次推送到 `main` 分支，GitHub Actions 会自动编译全部平台，产物在对应 workflow 的 Artifacts 里。

| Workflow | 产出 |
| --- | --- |
| `.github/workflows/build.yml` | Android APK（arm64 + armeabi-v7a） |
| `.github/workflows/build-desktop.yml` | Windows x64、macOS arm64 / x64、iOS（未签名 IPA） |

**改成你自己的服务器地址**：编辑 `lib/config/app_config.dart`，把常量 `defaultValue` 改成你的地址（结尾不要带斜杠），推送后约 15 分钟出新包。

```dart
// lib/config/app_config.dart
class AppConfig {
  static const String serverUrl = String.fromEnvironment(
    'SELENE_SERVER_URL',
    defaultValue: 'https://你的服务器地址',
  );

  /// 锁定服务器地址：true 时登录页隐藏服务器地址输入框
  static const bool lockServerUrl = true;
}
```

也可以在构建时用 `--dart-define=SELENE_SERVER_URL=https://...` 覆盖，无需改代码。

> 提示：本仓库是公开的，写在代码里的服务器地址会被公开看到。若在意，可把仓库改回 Private（那样下载链接需要登录 GitHub 才能访问）。

本地构建需要 Flutter 3.44.0（stable）：

```bash
flutter pub get
flutter build apk --release
flutter build windows --release
flutter build macos --release
flutter build ios --release --no-codesign
```

---

## 版权与声明

- 本项目基于 [MoonTechLab/Selene](https://github.com/MoonTechLab/Selene) 源码改造，遵循上游项目的许可条款；本仓库仅用于私域分发与自动构建，不对上游功能做二次分发声明上的变更。
- 本项目仅为客户端壳，不提供、不存储任何影视资源；播放内容由你自建的服务端决定，请遵守所在地法律法规。
- 使用本项目造成的任何问题由使用者自行承担。
