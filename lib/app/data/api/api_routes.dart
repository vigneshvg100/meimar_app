class ApiRoutes {
  // static const ITENERARY_BASE_URL = String.fromEnvironment('ITENERARY_BASE_URL');
  static const ITENERARY_BASE_URL = "http://localhost:5000";
  static const GENERATE_ITENERARY = "/generateItenerary";

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
