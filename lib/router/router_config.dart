import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ofma_app/components/transitions/custom_fade_transition.dart';
import 'package:ofma_app/components/transitions/swipe_to_right_transition.dart';
import 'package:ofma_app/enums/cotent_category.dart';
import 'package:ofma_app/router/codec/multi_codec.dart';
import 'package:ofma_app/router/router_const.dart';

//transitions
import 'package:ofma_app/components/transitions/swipe_to_left_transition.dart';
import 'package:ofma_app/screens/concert/concert_screen.dart';
import 'package:ofma_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:ofma_app/screens/exclusive_content/exclusive_content_screen.dart';

//screens
import 'package:ofma_app/screens/login/login_screen.dart';
import 'package:ofma_app/screens/main/main_screen.dart';
import 'package:ofma_app/screens/orders/orders_screen.dart';
import 'package:ofma_app/screens/qr_scanner/qr_scanner_screen.dart';
import 'package:ofma_app/screens/recover_password/recover_password_screen.dart';
import 'package:ofma_app/screens/register/register_screen.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/screens/suscription/suscription_screen.dart';

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
      GoRoute(
        path: '/recover',
        name: AppRouterConstants.recoverPasswordScreen,
        pageBuilder: (context, state) {
          return CustomFadeTransition(child: const RecoverPasswordScreen());
        },
      ),
      GoRoute(
        path: '/edit',
        name: AppRouterConstants.editProfileScreen,
        pageBuilder: (context, state) {
          return SwipeToRightTransition(child: const EditProfileScreen());
        },
      ),
      GoRoute(
        path: '/concert/:id',
        name: AppRouterConstants.concertScreen,
        pageBuilder: (context, state) {
          return CustomFadeTransition(
              child: ConcertScreen(
            id: state.pathParameters['id']!,
          ));
        },
      ),
      GoRoute(
        path: '/content',
        name: AppRouterConstants.exclusiveContentScreen,
        pageBuilder: (context, state) {
          final category = state.extra as ContentCategory;
          return CustomFadeTransition(
              child: ExclusiveContentScreen(
            category: category,
          ));
        },
      ),
      GoRoute(
        path: '/suscription',
        name: AppRouterConstants.suscriptionScreen,
        pageBuilder: (context, state) {
          return SwipeToRightTransition(child: const SuscriptionScreen());
        },
      ),
      GoRoute(
        path: '/scanner',
        name: AppRouterConstants.qRScannerScreen,
        pageBuilder: (context, state) {
          return SwipeToRightTransition(child: const QRScannerScreen());
        },
      ),
      GoRoute(
        path: '/orders',
        name: AppRouterConstants.ordersScreen,
        pageBuilder: (context, state) {
          return SwipeToRightTransition(child: const OrdersScreen());
        },
      ),
    ],
    extraCodec: MultiCodec(),
    redirect: (context, state) {
      final token = Preferences.token;

      // Si el usuario está autenticado y está intentando acceder a la pantalla de inicio de sesión o de registro,
      // redirige al usuario a la pantalla principal.
      if (token != null &&
          !JwtDecoder.isExpired(token) &&
          (state.fullPath == '/login' ||
              state.fullPath == '/register' ||
              state.fullPath == '/recover')) {
        return '/main';
      }

      // Si el usuario no está autenticado y está intentando acceder a cualquier otra pantalla que no sea la de inicio de sesión o de registro,
      // redirige al usuario a la pantalla de inicio de sesión.
      if ((token == null || JwtDecoder.isExpired(token)) &&
          state.fullPath != '/login' &&
          state.fullPath != '/register' &&
          state.fullPath != '/recover') {
        return '/login';
      }

      // Si ninguna de las condiciones anteriores se cumple, no redirige.
      return null;
    },
  );
}
