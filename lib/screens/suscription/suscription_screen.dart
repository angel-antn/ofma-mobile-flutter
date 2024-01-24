import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:provider/provider.dart';

class SuscriptionScreen extends StatelessWidget {
  const SuscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Suscripción')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Stack(
                children: [
                  _SuscriptionHeader(),
                  _SucriptionBody(),
                  _SuscriptionPrice(),
                  _SuscriptionTitle(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (userDataProvider.user?.isPremium == false)
                PrimaryButton(
                    width: double.maxFinite, onTap: () {}, text: 'Siguiente'),
              if (userDataProvider.user?.isPremium == true)
                const Text('¡Usted ya ha adquirido la suscripcion premium!'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuscriptionTitle extends StatelessWidget {
  const _SuscriptionTitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              'Premium',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1),
            ),
            Text(
              'Pago mensual',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class _SucriptionBody extends StatelessWidget {
  const _SucriptionBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 190),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: AppColors.secondaryColor, width: 2)),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Con la suscripción mensual podrás:'),
            Divider(
              thickness: 0.3,
            ),
            _SuscriptionTile(
              text: 'Apoyar a la OFMA para seguir creciendo',
            ),
            _SuscriptionTile(
              text: 'Disfrutar de nuestro contenido 24/7',
            ),
            _SuscriptionTile(
              text: 'Ver entrevistas exclusivas ',
            ),
            _SuscriptionTile(
              text: 'Ver grabaciones de nuestros conciertos',
            )
          ],
        ),
      ),
    );
  }
}

class _SuscriptionTile extends StatelessWidget {
  const _SuscriptionTile({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(15),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(children: [
        Icon(
          FeatherIcons.check,
          color: AppColors.green,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text)
      ]),
    );
  }
}

class _SuscriptionHeader extends StatelessWidget {
  const _SuscriptionHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 175,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Image.asset(
          'assets/backgrounds/suscription_banner.webp',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class _SuscriptionPrice extends StatelessWidget {
  const _SuscriptionPrice();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 110),
        child: Container(
          width: 115,
          height: 115,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(5, 5), blurRadius: 7.5)
            ],
          ),
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12)),
            child: Text(
              '\$1.99',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
