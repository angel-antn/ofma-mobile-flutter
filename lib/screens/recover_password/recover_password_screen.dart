import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/components/fields/login_text_form_field.dart';
import 'package:ofma_app/components/fields/password_text_form_field.dart';
import 'package:ofma_app/components/titles/login_title.dart';
import 'package:ofma_app/data/remote/ofma/user_request.dart';
import 'package:ofma_app/providers/recover_password_form_provider.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/check_email.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    onPopInvoked() {
      if (pageController.page! > 0 && pageController.page! != 2) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Easing.standard,
        );
      } else {
        context.pushReplacementNamed(AppRouterConstants.loginScreen);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => onPopInvoked(),
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
                      child: _BackButton(
                        pageController: pageController,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _RecoverCard(
                      pageController: pageController,
                    ),
                    const SizedBox(height: 25),
                  ],
                )),
          )
        ],
      )),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    popPage() {
      if (pageController.page! > 0 && pageController.page != 2) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Easing.standard,
        );
      } else {
        context.pushReplacementNamed(AppRouterConstants.loginScreen);
      }
    }

    final buttonDecoration = BoxDecoration(
        color: AppColors.translucentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(20)));

    const textStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

    return TouchableOpacity(
      onTap: () => popPage(),
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

class _RecoverCard extends StatelessWidget {
  const _RecoverCard({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cardDecoration = BoxDecoration(
        color: AppColors.translucentWhite,
        borderRadius: const BorderRadius.all(Radius.circular(25)));

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(30),
        decoration: cardDecoration,
        child: _RecoverForm(
          pageController: pageController,
        ));
  }
}

class _RecoverForm extends StatefulWidget {
  const _RecoverForm({required this.pageController});

  final PageController pageController;

  @override
  State<_RecoverForm> createState() => _RecoverFormState();
}

class _RecoverFormState extends State<_RecoverForm> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final recoverPasswordFormProvider =
        Provider.of<RecoverPasswordFormProvider>(context);
    return SizedBox(
        height: 600,
        child: Stack(
          children: [
            PageView(
              controller: widget.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) => setState(() {
                index = value;
              }),
              scrollDirection: Axis.horizontal,
              children: [
                _RecoverFormPageOne(
                  pageController: widget.pageController,
                  recoverPasswordFormProvider: recoverPasswordFormProvider,
                ),
                _RecoverFormPageTwo(
                  pageController: widget.pageController,
                  recoverPasswordFormProvider: recoverPasswordFormProvider,
                ),
                _RecoverFormPageThree(pageController: widget.pageController)
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  child: _Paginator(actualIndex: index),
                ))
          ],
        ));
  }
}

class _RecoverFormPageOne extends StatefulWidget {
  const _RecoverFormPageOne({
    required this.pageController,
    required this.recoverPasswordFormProvider,
  });

  final PageController pageController;
  final RecoverPasswordFormProvider recoverPasswordFormProvider;

  @override
  State<_RecoverFormPageOne> createState() => _RecoverFormPageOneState();
}

class _RecoverFormPageOneState extends State<_RecoverFormPageOne> {
  bool isLoading = false;
  nextPage() async {
    setState(() {
      isLoading = true;
    });

    final request = UserRequest();
    final response = await request.resetPasswordRequest(
      email: widget.recoverPasswordFormProvider.email,
    );

    setState(() {
      isLoading = false;
    });

    if (response != null) {
      Fluttertoast.showToast(msg: response, backgroundColor: Colors.grey);
      return;
    } else {
      widget.pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Easing.standard,
      );
    }
  }

  validateEmail(String value) {
    if (checkEmail(value: value)) {
      return null;
    }
    return 'correo electrónico no válido';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: widget.recoverPasswordFormProvider.recoverPasswordFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const LoginTitle(text: '¿Olvidó su contraseña?'),
                  const SizedBox(height: 15),
                  const Text(
                    'No te preocupes, a todos nos ha pasado',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  LoginTextFormField(
                    icon: CommunityMaterialIcons.at,
                    hintText: 'Correo electrónico',
                    onChanged: (value) =>
                        widget.recoverPasswordFormProvider.email = value,
                    validator: (value) => validateEmail(value),
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    hintText: 'Nueva contraseña',
                    validator: (value) => validatePassword(value),
                    icon: CommunityMaterialIcons.lock_open_outline,
                    onChanged: (value) =>
                        widget.recoverPasswordFormProvider.password = value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    hintText: 'Confirma la nueva contraseña',
                    validator: (value) => validateRepeatedPassword(
                      value,
                      widget.recoverPasswordFormProvider.password,
                    ),
                    icon: CommunityMaterialIcons.lock_open_outline,
                    onChanged: (value) => widget
                        .recoverPasswordFormProvider.repeatedPassword = value,
                  ),
                ],
              ),
            ),
          ),
          PrimaryButton(
            isLoading: isLoading,
            width: double.infinity,
            onTap: () {
              if (!widget.recoverPasswordFormProvider.isValidForm()) return;
              nextPage();
            },
            text: 'Siguiente',
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

class _RecoverFormPageTwo extends StatefulWidget {
  const _RecoverFormPageTwo({
    required this.pageController,
    required this.recoverPasswordFormProvider,
  });

  final PageController pageController;
  final RecoverPasswordFormProvider recoverPasswordFormProvider;

  @override
  State<_RecoverFormPageTwo> createState() => _RecoverFormPageTwoState();
}

class _RecoverFormPageTwoState extends State<_RecoverFormPageTwo> {
  bool isLoading = false;
  String pinCode = '';

  @override
  Widget build(BuildContext context) {
    nextPage() async {
      if (pinCode.length == 6) {
        setState(() {
          isLoading = true;
        });

        final request = UserRequest();
        final response = await request.validateResetPasswordRequest(
          email: widget.recoverPasswordFormProvider.email,
          password: widget.recoverPasswordFormProvider.password,
          otp: pinCode,
        );

        setState(() {
          isLoading = false;
        });

        if (response != null) {
          Fluttertoast.showToast(msg: response, backgroundColor: Colors.grey);
          return;
        } else {
          widget.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Easing.standard,
          );
        }
      }
    }

    onChanged(String value) {
      setState(() {
        pinCode = value;
      });
    }

    final pinTheme = PinTheme(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      shape: PinCodeFieldShape.box,
      inactiveColor: AppColors.translucentWhite,
      disabledColor: AppColors.translucentWhite,
      selectedColor: AppColors.lessTranslucentWhite,
      activeColor: AppColors.translucentWhite,
      activeFillColor: AppColors.translucentWhite,
      inactiveFillColor: AppColors.red,
      selectedFillColor: AppColors.lessTranslucentWhite,
      errorBorderColor: AppColors.red,
      inactiveBorderWidth: 3,
    );

    final PinCodeTextField pinCodeTextField = PinCodeTextField(
      autoFocus: true,
      appContext: context,
      length: 6,
      enableActiveFill: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: pinTheme,
      textStyle: const TextStyle(color: Colors.white),
      autoDismissKeyboard: true,
      keyboardType: TextInputType.number,
      onChanged: (value) => onChanged(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      errorTextSpace: 30,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            children: [
              const LoginTitle(text: 'Código de recuperación'),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '¡Ya casi terminamos de establecer tu nueva contraseña!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Te enviamos a tu correo electrónico una clave de confirmación de cambio de contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: pinCodeTextField,
              ),
              const Text(
                'La clave de 6 dígitos enviada a su correo electrónico es de un solo uso. Ingrese la clave para establecer su nueva constraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        PrimaryButton(
          width: double.infinity,
          onTap: () => nextPage(),
          text: 'Siguiente',
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _RecoverFormPageThree extends StatelessWidget {
  const _RecoverFormPageThree({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/logo/ofma_logo.svg',
                    width: 180,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    '¡Su clave ha sido actualizada con éxito!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const _ConfirmResetPasswordImage(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Podrá iniciar sesión con su nueva contraseña a partir de ahora',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        PrimaryButton(
          width: double.infinity,
          onTap: () =>
              context.pushReplacementNamed(AppRouterConstants.loginScreen),
          text: 'Iniciar sesión',
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ConfirmResetPasswordImage extends StatelessWidget {
  const _ConfirmResetPasswordImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.translucentWhite,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CommunityMaterialIcons.lock_check_outline,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Row(
              children: [
                Icon(
                  CommunityMaterialIcons.multiplication,
                  color: Colors.white,
                ),
                Icon(
                  CommunityMaterialIcons.multiplication,
                  color: Colors.white,
                ),
                Icon(
                  CommunityMaterialIcons.multiplication,
                  color: Colors.white,
                ),
                Icon(
                  CommunityMaterialIcons.multiplication,
                  color: Colors.white,
                ),
                Icon(
                  CommunityMaterialIcons.multiplication,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Paginator extends StatelessWidget {
  const _Paginator({required this.actualIndex});

  final int actualIndex;

  BoxDecoration getBoxDecoration(int index) {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: (index == actualIndex)
            ? AppColors.secondaryColor
            : AppColors.lessTranslucentWhite);
  }

  double getWidth(int index) {
    return !(index == actualIndex) ? 10 : 35;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: getWidth(0),
            height: 10,
            decoration: getBoxDecoration(0),
          ),
          const SizedBox(
            width: 10,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: getWidth(1),
            height: 10,
            decoration: getBoxDecoration(1),
          ),
          const SizedBox(
            width: 10,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: getWidth(2),
            height: 10,
            decoration: getBoxDecoration(2),
          )
        ],
      ),
    );
  }
}
