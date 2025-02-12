class Env {
  static const String webApiKey =
      String.fromEnvironment('WEB_API_KEY', defaultValue: '');
  static const String webAppId =
      String.fromEnvironment('WEB_APP_ID', defaultValue: '');
  static const String webMessagingSenderId =
      String.fromEnvironment('WEB_MESSAGING_SENDER_ID', defaultValue: '');
  static const String webProjectId =
      String.fromEnvironment('WEB_PROJECT_ID', defaultValue: '');
  static const String webAuthDomain =
      String.fromEnvironment('WEB_AUTH_DOMAIN', defaultValue: '');
  static const String webStorageBucket =
      String.fromEnvironment('WEB_STORAGE_BUCKET', defaultValue: '');
  static const String webMeasurementId =
      String.fromEnvironment('WEB_MEASUREMENT_ID', defaultValue: '');

  static const String androidApiKey =
      String.fromEnvironment('ANDROID_API_KEY', defaultValue: '');
  static const String androidAppId =
      String.fromEnvironment('ANDROID_APP_ID', defaultValue: '');
  static const String androidMessagingSenderId =
      String.fromEnvironment('ANDROID_MESSAGING_SENDER_ID', defaultValue: '');
  static const String androidProjectId =
      String.fromEnvironment('ANDROID_PROJECT_ID', defaultValue: '');
  static const String androidStorageBucket =
      String.fromEnvironment('ANDROID_STORAGE_BUCKET', defaultValue: '');

  static const String iosApiKey =
      String.fromEnvironment('IOS_API_KEY', defaultValue: '');
  static const String iosAppId =
      String.fromEnvironment('IOS_APP_ID', defaultValue: '');
  static const String iosMessagingSenderId =
      String.fromEnvironment('IOS_MESSAGING_SENDER_ID', defaultValue: '');
  static const String iosProjectId =
      String.fromEnvironment('IOS_PROJECT_ID', defaultValue: '');
  static const String iosStorageBucket =
      String.fromEnvironment('IOS_STORAGE_BUCKET', defaultValue: '');
  static const String iosBundleId =
      String.fromEnvironment('IOS_BUNDLE_ID', defaultValue: '');

  static const String macosApiKey =
      String.fromEnvironment('MACOS_API_KEY', defaultValue: '');
  static const String macosAppId =
      String.fromEnvironment('MACOS_APP_ID', defaultValue: '');
  static const String macosMessagingSenderId =
      String.fromEnvironment('MACOS_MESSAGING_SENDER_ID', defaultValue: '');
  static const String macosProjectId =
      String.fromEnvironment('MACOS_PROJECT_ID', defaultValue: '');
  static const String macosStorageBucket =
      String.fromEnvironment('MACOS_STORAGE_BUCKET', defaultValue: '');
  static const String macosBundleId =
      String.fromEnvironment('MACOS_BUNDLE_ID', defaultValue: '');

  static const String windowsApiKey =
      String.fromEnvironment('WINDOWS_API_KEY', defaultValue: '');
  static const String windowsAppId =
      String.fromEnvironment('WINDOWS_APP_ID', defaultValue: '');
  static const String windowsMessagingSenderId =
      String.fromEnvironment('WINDOWS_MESSAGING_SENDER_ID', defaultValue: '');
  static const String windowsProjectId =
      String.fromEnvironment('WINDOWS_PROJECT_ID', defaultValue: '');
  static const String windowsAuthDomain =
      String.fromEnvironment('WINDOWS_AUTH_DOMAIN', defaultValue: '');
  static const String windowsStorageBucket =
      String.fromEnvironment('WINDOWS_STORAGE_BUCKET', defaultValue: '');
  static const String windowsMeasurementId =
      String.fromEnvironment('WINDOWS_MEASUREMENT_ID', defaultValue: '');
}
