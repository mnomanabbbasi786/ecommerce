import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:ecommerce/provider/CartProvider.dart';
import 'package:ecommerce/provider/WishListProvider.dart';
import 'package:ecommerce/screens/darkmodebutton.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '/routes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '/screens/splash/splash_screen.dart';
import '/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: SupabaseCredentials.APIurl, anonKey: SupabaseCredentials.APIKey);

  String? userId = await AuthenticationsRepostry.getUserIdFromPrefs();
  String initialRoute =
      (userId == null) ? SplashScreen.routeName : HomeScreen.routeName;
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://9e32abe50c0bcffd9a4446b20883f857@o4505724548022272.ingest.sentry.io/4505724557918208';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (context) => ThemeProvider()),
        provider.ChangeNotifierProvider(
            create: (context) => WishListProvider()),
        provider.ChangeNotifierProvider(create: (context) => CartProvider())
      ],
      child: MyApp(initialRoute: initialRoute),
    )),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final themeProvider = provider.Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HSE-ecommerce',
      theme: theme(),
      darkTheme: darkTheme(),
      themeMode: themeProvider.themeMode,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
