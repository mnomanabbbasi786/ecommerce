import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;

  ErrorBoundary({required this.child});

  @override
  _ErrorBoundaryState createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      Sentry.captureException(details.exception, stackTrace: details.stack);
      // You can also show some feedback to the user here
      // like a Dialog or a SnackBar.
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    FlutterError.onError = FlutterError.dumpErrorToConsole;
    super.dispose();
  }
}
