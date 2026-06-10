class ApiEndpoints {
  // Base URLs
  static const String baseUrl = 'https://api.syncmate.com';
  static const String apiV1 = '/api/v1';

  // Auth Routes
  static const String _auth = '$apiV1/auth';
  static const String requestSignupOtp = '$_auth/signup/request-otp';
  static const String completeSignup = '$_auth/signup/complete';
  static const String signin = '$_auth/signin';
  static const String logout = '$_auth/logout';
  static const String profile = '$_auth/profile';
  static const String editProfile = '$_auth/editProfile';
  static const String changePassword = '$_auth/changePassword';
  static const String forgotPassword = '$_auth/forgotPassword';
  static const String resetPassword = '$_auth/resetPassword';

  // Connection Routes
  static const String _connection = '$apiV1/connection';
  static const String sendConnectionRequest = '$_connection/sendRequest';
  static const String getConnections = _connection;
  static const String getPendingRequests = '$_connection/requests';
  static const String getSentRequests = '$_connection/sent';

  // Dynamic/Parameterized Connection Routes
  static String acceptConnectionRequest(String requestId) => '$_connection/accept/$requestId';
  static String rejectConnectionRequest(String requestId) => '$_connection/reject/$requestId';
  static String cancelConnectionRequest(String requestId) => '$_connection/cancel/$requestId';
  static String removeConnection(String connectionId) => '$_connection/remove/$connectionId';

  // Health
  static const String health = '/health';
}
