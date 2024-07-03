import 'dart:async';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  bool _isRunning = false;

  Debouncer({required this.milliseconds});

  void run(Future<void> Function() action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), () async {
      while (_isRunning) {
        await Future<dynamic>.delayed(const Duration(milliseconds: 0));
      }
      _isRunning = true;
      await action();
      _isRunning = false;
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
