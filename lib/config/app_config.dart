/// 私域定制版配置
///
/// 服务器地址内置在此，登录页不再显示、也不需要填写服务器地址。
class AppConfig {
  /// 内置服务器地址（编译时可通过 --dart-define=SELENE_SERVER_URL=... 覆盖）
  static const String serverUrl = String.fromEnvironment(
    'SELENE_SERVER_URL',
    defaultValue: 'https://mtv.7052.cn:444',
  );

  /// 锁定服务器地址：true 时登录页隐藏服务器地址输入框
  static const bool lockServerUrl = true;
}
