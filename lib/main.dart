import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ofma_app/services/notifications.dart';

import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:ofma_app/providers/edit_profile_form_provider.dart';
import 'package:ofma_app/providers/login_form_provider.dart';
import 'package:ofma_app/providers/recover_password_form_provider.dart';
import 'package:ofma_app/providers/register_form_provider.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_config.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  await Future.wait([
    Stripe.instance.applySettings(),
    Preferences.init(),
    initNotifications()
  ]);
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
    final channel = IOWebSocketChannel.connect(
        'ws://10.0.2.2:80/stream?token=${dotenv.env['PUSH_SERVER_KEY'] ?? ''}');
    channel.stream.listen((message) {
      final jsonMessage = jsonDecode(message);
      if (jsonMessage['title'] == (Preferences.user?.id ?? '')) {
        final body = jsonMessage['message'];
        showNotification('¡Estatus de orden actualizado!', body);
      }
    });
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
