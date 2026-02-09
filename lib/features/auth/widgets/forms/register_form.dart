import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/utils/string_utils.dart';
import 'package:transit_tracer/core/validators/auth_validate.dart';
import 'package:transit_tracer/features/auth/bloc/auth_bloc.dart';
import 'package:transit_tracer/features/auth/cubit/password_strength_meter_cubit.dart';
import 'package:transit_tracer/features/user/models/user_role/user_role.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/features/auth/widgets/form_field/form_field.dart';
import 'package:transit_tracer/features/auth/widgets/user_role_selector/user_role_selector.dart';
import 'package:transit_tracer/generated/l10n.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    this.externalEmailError,
    this.externalPasswordError,
  });
  final GlobalKey<FormState> formKey;
  final String? externalEmailError;
  final String? externalPasswordError;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  Timer? _debounce;
  UserRole _role = UserRole.client;
  bool _obscurePassword = true;
  bool _obscureCoinfirm = true;
  final String _dialCode = '+380';

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCoinfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PasswordStrengthMeterCubit>().passwordFieldEmpty();
  }

  void _onPasswordChanged(String password) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<PasswordStrengthMeterCubit>().checkPassword(password);
      if (password.isEmpty) {
        context.read<PasswordStrengthMeterCubit>().passwordFieldEmpty();
      }
    });
  }

  String get fullPhone {
    final local = phoneController.text.replaceAll(RegExp(r'\D'), '');
    return '$_dialCode$local';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            S.of(context).registrationTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 12),
        UserRoleSelector(
          theme: theme,
          selected: _role,
          onChange: (role) {
            setState(() {
              _role = role;
            });
          },
        ),
        const SizedBox(height: 12),
        AuthFormField(
          theme: theme,
          controller: nameController,
          onChange: null,
          suffixIcon: null,
          obscureText: false,
          type: TextInputType.name,
          hint: S.of(context).nameForm,
          validator: (value) => validateName(
            value,
            emptyField: S.of(context).validationFormEmpty,
            invalidValue: S.of(context).validationInvalidName,
          ),
        ),
        const SizedBox(height: 12),
        AuthFormField(
          theme: theme,
          controller: surnameController,
          onChange: null,
          suffixIcon: null,
          obscureText: false,
          type: TextInputType.name,
          hint: S.of(context).surnameForm,
          validator: (value) => validateName(
            value,
            emptyField: S.of(context).validationFormEmpty,
            invalidValue: S.of(context).validationInvalidSurname,
          ),
        ),
        const SizedBox(height: 12),
        AuthFormField(
          externalError: widget.externalEmailError,
          theme: theme,
          controller: emailController,
          onChange: null,
          suffixIcon: null,
          obscureText: false,
          type: TextInputType.emailAddress,
          hint: S.of(context).emailForm,
          validator: (value) => validateEmail(
            value,
            emptyField: S.of(context).validationFormEmpty,
            invalidEmail: S.of(context).validationInvalidEmail,
          ),
        ),
        const SizedBox(height: 12),
        AuthFormField(
          hint: S.of(context).phoneForm,
          validator: (value) => validatePhone(
            value,
            emptyField: S.of(context).validationFormEmpty,
            invalidPhone: S.of(context).validationInvalidPhone,
          ),
          maxLength: 9,
          prefix: _dialCode,
          type: TextInputType.phone,
          obscureText: false,
          suffixIcon: null,
          onChange: null,
          controller: phoneController,
          theme: theme,
        ),

        const SizedBox(height: 12),
        AuthFormField(
          externalError: widget.externalPasswordError,
          theme: theme,
          controller: passwordController,
          onChange: _onPasswordChanged,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          obscureText: _obscurePassword,
          type: TextInputType.visiblePassword,
          hint: S.of(context).passwordCreateForm,
          validator: (value) => validatePassword(
            value,
            emptyField: S.of(context).validationFormEmpty,
            inavildLenth: S.of(context).validationInvalidPasswordLenth,
            invalidUppercase: S.of(context).validationInvalidPasswordUppercase,
            invalidDigit: S.of(context).validationInvalidPasswordDigit,
            invalidCpecChar: S.of(context).validationInvalidPasswordSpecChar,
          ),
        ),
        const SizedBox(height: 12),
        AuthFormField(
          theme: theme,
          controller: passwordCoinfirmController,
          onChange: _onPasswordChanged,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureCoinfirm ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureCoinfirm = !_obscureCoinfirm;
              });
            },
          ),
          obscureText: _obscureCoinfirm,
          type: TextInputType.visiblePassword,
          hint: S.of(context).passwordConfirmForm,
          validator: (value) => validateCoinfirmPassword(
            value,
            passwordController.text,
            emptyField: S.of(context).validationFormEmpty,
            passwordsDidntMatch: S
                .of(context)
                .validationInvalidConfirmPasswordDidntMatch,
          ),
        ),
        BlocBuilder<PasswordStrengthMeterCubit, PasswordStrengthMeterState>(
          builder: (context, state) {
            late Color color;
            late double level;
            if (state is PasswordFieldEmpty) {
              color = state.color;
              level = state.level;
            } else if (state is PasswordStrengthMeterChecked) {
              color = state.color;
              level = state.level;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    color: color,
                    value: level,
                    backgroundColor: const Color(0xFF4A4A4C),
                  ),
                ],
              ),
            );
          },
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(StartLogin());
          },
          child: Text(S.of(context).haveAccTextButton),
        ),
        BaseButton(
          onPressed: () {
            if (widget.formKey.currentState?.validate() ?? true) {
              context.read<AuthBloc>().add(
                RegisterUser(
                  name: capitalize(nameController.text.trim()),
                  surname: capitalize(surnameController.text.trim()),
                  email: emailController.text.trim(),
                  phone: fullPhone,
                  password: passwordController.text.trim(),
                  userRole: _role,
                ),
              );
            }
          },
          text: S.of(context).registerButton,
        ),
      ],
    );
  }
}
