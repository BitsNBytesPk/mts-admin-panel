import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../languages/translation_keys.dart' as lang_key;
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets/custom_material_button.dart';
import '../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../utils/custom_widgets/loader_view.dart';
import '../../../utils/images_paths.dart';
import '../../../utils/validators.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginViewModel _viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return LoaderView(
      child: Scaffold(
        backgroundColor: primaryWhite,
        body: Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            lang_key.welcomeBack.tr,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          lang_key.welcomeBackDesc.tr,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: primaryGrey
                          ),
                        ),
                        SizedBox(height: 20,),
                        _CredentialFields(),
                        // _RememberMeAndForgotPassword(),
                        CustomMaterialButton(
                            onPressed: () => _viewModel.login(),
                          text: lang_key.signIn.tr,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                ImagesPaths.loginImage,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// TextFormFields for providing login credentials
class _CredentialFields extends StatelessWidget {
  _CredentialFields();

  final LoginViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _viewModel.formKey,
      child: Column(
        spacing: 10,
        children: [
          CustomTextFormField(
            title: lang_key.email.tr,
            controller: _viewModel.emailController,
            validator: (value) => Validators.validateEmail(value),
            suffixIcon: Icon(Icons.email_outlined, color: primaryGrey,),
          ),
          Obx(() => CustomTextFormField(
            obscureText: _viewModel.obscurePassword.value,
            title: lang_key.password.tr,
            controller: _viewModel.passwordController,
            validator: (value) => Validators.validateEmptyField(value),
            suffixIcon: Icon(_viewModel.obscurePassword.isTrue ? CupertinoIcons.eye_slash : CupertinoIcons.eye, color: primaryGrey,),
            suffixOnPressed: () => _viewModel.obscurePassword.value = !_viewModel.obscurePassword.value,
          ),
          ),
        ],
      ),
    );
  }
}