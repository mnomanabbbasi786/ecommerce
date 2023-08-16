import 'package:flutter/material.dart';

class DarkModeButton extends StatelessWidget {
  final Function() onPressed;
  final Color lightColor;
  final Color darkColor;

  const DarkModeButton({
    Key? key,
    required this.onPressed,
    required this.lightColor,
    required this.darkColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.lightbulb,
        color: Theme.of(context).brightness == Brightness.light
            ? lightColor
            : darkColor,
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  toggleTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;
}
