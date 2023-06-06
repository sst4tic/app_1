class Constants {
  static const String API_URL_DOMAIN = 'https://beta.cloud.yiwumart.org/api/v1/core?';
  static const String BASE_URL_DOMAIN = 'https://beta.cloud.yiwumart.org/';
  static String USER_TOKEN = '';
  static String header = 'Authorization';
  static String bearer = '';
  static headers() => {header: bearer, 'user-agent': 'YiwuMart: test'};
}