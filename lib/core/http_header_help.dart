class HttpHeaderHelp {
  HttpHeaderHelp._();

  static Map<String, String> headers() {
    return {
      'Connection': 'Keep-Alive',
      'Keep-Alive': 'timeout=5, max=1000',
    };
  }
}
