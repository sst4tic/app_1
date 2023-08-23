class Constants {
  static const String API_URL_DOMAIN = 'https://cloud.yiwumart.org/api/v1/core?';
  static const String BASE_URL_DOMAIN = 'https://cloud.yiwumart.org/';
  static String USER_TOKEN = '';
  static String header = 'Authorization';
  static String bearer = '';
  static String useragent = '';
  static String platform = '';
  static headers() => {header: bearer, 'user-agent': 'YiwuMart: $platform'};
  static String startAt = '';
  static String endAt = '';
  static bool movingPermission = false;
}