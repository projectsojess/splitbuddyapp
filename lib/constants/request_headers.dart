class RequestHeaders {
  static Map<String, String> getUnAuthenticatedHeaders() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }
}
