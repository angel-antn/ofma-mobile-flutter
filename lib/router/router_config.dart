import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ofma_app/components/transitions/custom_fade_transition.dart';
import 'package:ofma_app/router/router_const.dart';

//transitions
import 'package:ofma_app/components/transitions/swipe_to_left_transition.dart';

//screens
import 'package:ofma_app/screens/login/login_screen.dart';
import 'package:ofma_app/screens/main/main_screen.dart';
import 'package:ofma_app/screens/register/register_screen.dart';
import 'package:ofma_app/data/local/preferences.dart';

class AppRouter {
  static final AppRouter _singleton = AppRouter._internal();

  factory AppRouter() {
    return _singleton;
  }

  AppRouter._internal();

  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/main',
        name: AppRouterConstants.mainScreen,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: const MainScreen());
        },
      ),
      GoRoute(
        path: '/login',
        name: AppRouterConstants.loginScreen,
        pageBuilder: (context, state) {
          return SwipeToLeftTransition(child: const LoginScreen());
        },
      ),
      GoRoute(
        path: '/register',
        name: AppRouterConstants.registerScreen,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: const RegisterScreen());
        },
      ),
    ],
    redirect: (context, state) {
      final token = Preferences.token;

      // Si el usuario está autenticado y está intentando acceder a la pantalla de inicio de sesión o de registro,
      // redirige al usuario a la pantalla principal.
      if (token != null &&
          !JwtDecoder.isExpired(token) &&
          (state.fullPath == '/login' || state.fullPath == '/register')) {
        return '/main';
      }

      // Si el usuario no está autenticado y está intentando acceder a cualquier otra pantalla que no sea la de inicio de sesión o de registro,
      // redirige al usuario a la pantalla de inicio de sesión.
      if ((token == null || JwtDecoder.isExpired(token)) &&
          state.fullPath != '/login' &&
          state.fullPath != '/register') {
        return '/login';
      }

      // Si ninguna de las condiciones anteriores se cumple, no redirige.
      return null;
    },
  );
}
