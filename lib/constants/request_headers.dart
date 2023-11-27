// ignore_for_file: constant_identifier_names

class RequestHeaders {
  static const JWT_HEADER = 'x-auth-token';
  static const CONTENT_TYPE_HEADER = 'Content-Type';
  static const JSON_TYPE = 'application/json; charset=UTF-8';

  static Map<String, String> getUnAuthenticatedHeaders() {
    return <String, String>{
      CONTENT_TYPE_HEADER: JSON_TYPE,
    };
  }
}
