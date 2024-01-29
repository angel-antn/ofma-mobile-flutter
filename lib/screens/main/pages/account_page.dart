import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/tiles/custom_tile.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/to_title_case.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cuenta'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/backgrounds/account_background.webp',
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const _AccountBody()
        ],
      ),
    );
  }
}

class _AccountBody extends StatelessWidget {
  const _AccountBody();

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 145),
      child: Column(
        children: [
          Text(
            'Hola ${toTitleCase(userDataProvider.user?.name ?? "")} ${toTitleCase(userDataProvider.user?.lastname ?? "")}',
            style: textStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          const _AccountCard(),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard();

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black54, offset: Offset(0, -5), blurRadius: 15)
      ],
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    );

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        width: double.infinity,
        decoration: boxDecoration,
        child: const _AccountCardBody(),
      ),
    );
  }
}

class _AccountCardBody extends StatelessWidget {
  const _AccountCardBody();

  @override
  Widget build(BuildContext context) {
    logout() {
      Preferences.clear();
      context.pushReplacementNamed(AppRouterConstants.loginScreen);
    }

    return Column(
      children: [
        CustomTile(
          color: AppColors.pink,
          icon: FeatherIcons.shoppingBag,
          onTap: () => context.pushNamed(AppRouterConstants.ordersScreen),
          text: 'Ver órdenes',
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTile(
          color: AppColors.lightBlue,
          icon: FeatherIcons.gift,
          onTap: () => context.pushNamed(AppRouterConstants.suscriptionScreen),
          text: 'Suscripción',
        ),
        const SizedBox(
          height: 16,
        ),
        if (Preferences.user?.isCollaborator == true)
          Column(
            children: [
              CustomTile(
                color: AppColors.purple,
                icon: FeatherIcons.userCheck,
                onTap: () =>
                    context.pushNamed(AppRouterConstants.qRScannerScreen),
                text: 'Revisar QRs',
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        const Divider(),
        const SizedBox(
          height: 16,
        ),
        CustomTile(
          color: AppColors.green,
          icon: FeatherIcons.user,
          onTap: () => context.pushNamed(AppRouterConstants.editProfileScreen),
          text: 'Editar perfil',
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTile(
          color: AppColors.yellow,
          icon: FeatherIcons.helpCircle,
          onTap: () {
            launchUrl(Uri.parse('http://${dotenv.env['FAQ_HOST'] ?? ''}'),
                mode: LaunchMode.externalApplication);
          },
          text: 'Ayuda',
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTile(
          color: AppColors.red,
          icon: FeatherIcons.xCircle,
          onTap: () => logout(),
          text: 'Cerrar sesión',
        ),
      ],
    );
  }
}
