import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/buttons/secondary_button.dart';
import 'package:ofma_app/components/fields/custom_text_form_field.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/data/remote/ofma/user_request.dart';
import 'package:ofma_app/providers/edit_profile_form_provider.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cuenta'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/backgrounds/edit_account_background.webp',
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const _EditProfileBody()
          ],
        ),
      ),
    );
  }
}

class _EditProfileBody extends StatelessWidget {
  const _EditProfileBody();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    );

    return const Padding(
      padding: EdgeInsets.only(top: 300),
      child: Column(
        children: [
          Text(
            'Editar perfil',
            style: textStyle,
          ),
          SizedBox(
            height: 15,
          ),
          _EditProfileCard(),
        ],
      ),
    );
  }
}

class _EditProfileCard extends StatelessWidget {
  const _EditProfileCard();

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: MediaQuery.of(context).size.height - 400,
      width: double.infinity,
      decoration: boxDecoration,
      child: const _EditProfileCardBody(),
    );
  }
}

class _EditProfileCardBody extends StatefulWidget {
  const _EditProfileCardBody();

  @override
  State<_EditProfileCardBody> createState() => _EditProfileCardBodyState();
}

class _EditProfileCardBodyState extends State<_EditProfileCardBody> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    final editProfileFormProvider =
        Provider.of<EditProfileFormProvider>(context);

    validateName(String value) {
      if (value.isEmpty) {
        return 'Debe ingresar el apellido';
      }
      return null;
    }

    validateLastname(String value) {
      if (value.isEmpty) {
        return 'Debe ingresar el apellido';
      }
      return null;
    }

    submitForm({
      required String name,
      required String lastname,
      required Function clearProvider,
    }) async {
      if (isLoading == true) return;

      setState(() {
        isLoading = true;
      });

      final request = UserRequest();
      final response = await request.edit(name: name, lastname: lastname);

      if (response == null) {
        Fluttertoast.showToast(
            msg: 'Ha ocurrido un error inesperado',
            backgroundColor: Colors.grey);
        setState(() {
          isLoading = false;
        });
        return;
      }

      bool wasPremium = Preferences.user?.isPremium ?? false;
      response.isPremium = wasPremium;

      Preferences.user = response;

      userDataProvider.updateUser(response);

      clearProvider();

      Fluttertoast.showToast(
          msg: 'Sus datos fueron actualizados con éxito',
          backgroundColor: Colors.grey);
      setState(() {
        isLoading = false;
      });
    }

    goBack() {
      editProfileFormProvider.clear();
      context.pop();
    }

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: editProfileFormProvider.editProfileFormKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            initialValue: editProfileFormProvider.name,
            hintText: 'Nombre',
            icon: CommunityMaterialIcons.account,
            onChanged: (value) => editProfileFormProvider.name = value,
            validator: (value) => validateName(value),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            initialValue: editProfileFormProvider.lastname,
            hintText: 'Apellido',
            icon: CommunityMaterialIcons.account_outline,
            onChanged: (value) => editProfileFormProvider.lastname = value,
            validator: (value) => validateLastname(value),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
              width: double.infinity,
              onTap: () => submitForm(
                  name: editProfileFormProvider.name,
                  lastname: editProfileFormProvider.lastname,
                  clearProvider: editProfileFormProvider.clear),
              text: 'Guardar'),
          const SizedBox(
            height: 10,
          ),
          SecondaryButton(
              width: double.infinity, onTap: () => goBack(), text: 'Volver')
        ],
      ),
    );
  }
}
