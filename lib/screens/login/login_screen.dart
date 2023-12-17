import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/buttons/secondary_button.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/components/fields/login_text_form_field.dart';
import 'package:ofma_app/components/titles/login_title.dart';
import 'package:ofma_app/components/fields/password_text_form_field.dart';
import 'package:ofma_app/providers/login_form_provider.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/data/remote/ofma/user_request.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/check_email.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/backgrounds/login_background.webp',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Center(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  SvgPicture.asset(
                    'assets/logo/ofma_logo.svg',
                    width: 230,
                  ),
                  const SizedBox(height: 40),
                  const _LoginCard(),
                  const SizedBox(height: 25),
                ],
              )),
        )
      ],
    ));
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard();

  @override
  Widget build(BuildContext context) {
    final cardDecoration = BoxDecoration(
        color: AppColors.translucentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(25)));

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(30),
        decoration: cardDecoration,
        child: const _LoginForm());
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    validateEmail(String value) {
      if (checkEmail(value: value)) {
        return null;
      }
      return 'correo electronico no valido';
    }

    validatePassword(String value) {
      if (value.length >= 6) {
        return null;
      }
      return 'min. 6 carcateres';
    }

    submitForm({
      required String email,
      required String password,
      required Function clearProvider,
    }) async {
      if (isLoading == true) return;

      setState(() {
        isLoading = true;
      });

      final request = UserRequest();
      final response = await request.login(email: email, password: password);

      if (response == null) {
        Fluttertoast.showToast(
            msg: 'No se pudo iniciar sesión', backgroundColor: Colors.grey);
        setState(() {
          isLoading = false;
        });
        return;
      }

      Preferences.token = response.token;
      Preferences.user = response.user;
      userDataProvider.user = response.user;

      clearProvider();

      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.pushReplacementNamed(AppRouterConstants.mainScreen);
      });
    }

    return Form(
      key: loginFormProvider.loginFormKey,
      child: Column(
        children: [
          const LoginTitle(text: 'Iniciar sesión'),
          const SizedBox(height: 30),
          LoginTextFormField(
            icon: CommunityMaterialIcons.at,
            hintText: 'Correo electronico',
            onChanged: (value) => loginFormProvider.email = value,
            validator: (value) => validateEmail(value),
          ),
          const SizedBox(height: 20),
          PasswordTextFormField(
            hintText: 'Contraseña',
            validator: (value) => validatePassword(value),
            icon: CommunityMaterialIcons.lock_open_outline,
            onChanged: (value) => loginFormProvider.password = value,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            width: double.infinity,
            text: 'Iniciar sesión',
            isLoading: isLoading,
            onTap: () {
              if (!loginFormProvider.isValidForm()) return;
              submitForm(
                email: loginFormProvider.email,
                password: loginFormProvider.password,
                clearProvider: loginFormProvider.clear,
              );
            },
          ),
          const SizedBox(height: 15),
          SecondaryButton(
            width: double.infinity,
            text: 'Registrarse',
            onTap: () => context.pushReplacementNamed(
              AppRouterConstants.registerScreen,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TouchableOpacity(
            onTap: () => context.pushReplacementNamed(
              AppRouterConstants.recoverPasswordScreen,
            ),
            child: const Text(
              '¿Olvidó su contraseña?',
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
