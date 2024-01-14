import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ofma_app/providers/edit_profile_form_provider.dart';
import 'package:ofma_app/providers/login_form_provider.dart';
import 'package:ofma_app/providers/recover_password_form_provider.dart';
import 'package:ofma_app/providers/register_form_provider.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_config.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51OOTZ8D5hIkovXn9XJMGyT1Br0i2NAuZfWtoGJAjPbOubLYgHU6KiVEUVZU59pS5ACz7ryrcOrUHmsunpXqRpn3M00SUuCko5O';
  await Stripe.instance.applySettings();
  await Preferences.init();
  runApp(const AppProviderTree());
}

class AppProviderTree extends StatelessWidget {
  const AppProviderTree({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProfileFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecoverPasswordFormProvider(),
        ),
      ],
      child: const OfmaApp(),
    );
  }
}

class OfmaApp extends StatelessWidget {
  const OfmaApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      title: 'Ofma app',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter().router.routeInformationParser,
      routerDelegate: AppRouter().router.routerDelegate,
      routeInformationProvider: AppRouter().router.routeInformationProvider,
    );
  }
}