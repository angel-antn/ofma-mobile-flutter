import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/components/fields/login_text_form_field.dart';
import 'package:ofma_app/components/titles/login_title.dart';
import 'package:ofma_app/components/fields/password_text_form_field.dart';
import 'package:ofma_app/providers/register_form_provider.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/data/remote/ofma/user_request.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/check_email.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        context.pushReplacementNamed(AppRouterConstants.loginScreen);
      },
      child: Scaffold(
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
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const _BackButton(),
                    ),
                    const SizedBox(height: 30),
                    const _RegisterCard(),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final buttonDecoration = BoxDecoration(
        color: AppColors.translucentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(20)));

    const textStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

    return TouchableOpacity(
      onTap: () => context.pushReplacementNamed(AppRouterConstants.loginScreen),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: buttonDecoration,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(width: 5),
            Text(
              'Volver',
              style: textStyle,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}

class _RegisterCard extends StatelessWidget {
  const _RegisterCard();

  @override
  Widget build(BuildContext context) {
    final cardDecoration = BoxDecoration(
        color: AppColors.translucentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(25)));

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(30),
        decoration: cardDecoration,
        child: const _RegisterForm());
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);

    validateName(String value) {
      if (value != '') {
        return null;
      }
      return 'El nombre es obligatorio';
    }

    validateLastname(String value) {
      if (value != '') {
        return null;
      }
      return 'El apellido es obligatorio';
    }

    validateEmail(String value) {
      if (checkEmail(value: value)) {
        return null;
      }
      return 'correo electrónico no valido';
    }

    validatePassword(String value) {
      if (value.length >= 6) {
        return null;
      }
      return 'min. 6 carcateres';
    }

    validateRepeatedPassword(String value, String password) {
      if (value.length >= 6) {
        if (value == password) {
          return null;
        }
        return 'Las contraseñas no coinciden';
      }
      return 'min. 6 carcateres';
    }

    submitForm({
      required String name,
      required String lastname,
      required String email,
      required String password,
      required Function clearProvider,
    }) async {
      if (isLoading == true) return;

      setState(() {
        isLoading = true;
      });

      final request = UserRequest();
      final response = await request.register(
        email: email,
        password: password,
        name: name,
        lastname: lastname,
      );

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
      key: registerFormProvider.registerFormKey,
      child: Column(
        children: [
          const LoginTitle(text: 'Registrarse'),
          const SizedBox(height: 30),
          LoginTextFormField(
            icon: CommunityMaterialIcons.account,
            hintText: 'Nombre',
            onChanged: (value) => registerFormProvider.name = value,
            validator: (value) => validateName(value),
          ),
          const SizedBox(height: 20),
          LoginTextFormField(
            icon: CommunityMaterialIcons.account_outline,
            hintText: 'Apellido',
            onChanged: (value) => registerFormProvider.lastname = value,
            validator: (value) => validateLastname(value),
          ),
          const SizedBox(height: 20),
          LoginTextFormField(
            icon: CommunityMaterialIcons.at,
            hintText: 'Correo electrónico',
            onChanged: (value) => registerFormProvider.email = value,
            validator: (value) => validateEmail(value),
          ),
          const SizedBox(height: 20),
          PasswordTextFormField(
            hintText: 'Contraseña',
            icon: CommunityMaterialIcons.lock_open_outline,
            onChanged: (value) => registerFormProvider.password = value,
            validator: (value) => validatePassword(value),
          ),
          const SizedBox(height: 20),
          PasswordTextFormField(
            hintText: 'Confirmar contraseña',
            icon: CommunityMaterialIcons.lock_outline,
            onChanged: (value) => registerFormProvider.repeatedPassword = value,
            validator: (value) => validateRepeatedPassword(
              value,
              registerFormProvider.password,
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            width: double.infinity,
            text: 'Registrarse',
            onTap: () {
              if (!registerFormProvider.isValidForm()) return;
              submitForm(
                name: registerFormProvider.name,
                lastname: registerFormProvider.lastname,
                email: registerFormProvider.email,
                password: registerFormProvider.password,
                clearProvider: registerFormProvider.clear,
              );
            },
          ),
        ],
      ),
    );
  }
}
