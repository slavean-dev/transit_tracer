import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/validators/auth_validate.dart';
import 'package:transit_tracer/features/auth/bloc/auth_bloc.dart';
import 'package:transit_tracer/core/widgets/base_button.dart';
import 'package:transit_tracer/features/auth/widgets/form_field/form_field.dart';
import 'package:transit_tracer/generated/l10n.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.state,
    this.externalEmailError,
    this.externalPasswordError,
  });
  final GlobalKey<FormState> formKey;
  final AuthState state;
  final String? externalEmailError;
  final String? externalPasswordError;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            S.of(context).loginTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        SizedBox(height: 14),
        AuthFormField(
          externalError: widget.externalEmailError,
          theme: theme,
          controller: loginController,
          onChange: null,
          suffixIcon: null,
          type: TextInputType.emailAddress,
          obscureText: false,
          hint: S.of(context).loginForm,
          validator: (value) => validateRequired(
            value,
            emptyField: S.of(context).validationFormEmpty,
          ),
        ),
        SizedBox(height: 14),
        AuthFormField(
          externalError: widget.externalPasswordError,
          theme: theme,
          controller: passwordController,
          onChange: null,
          suffixIcon: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          ),
          type: TextInputType.visiblePassword,
          obscureText: _obscure,
          hint: S.of(context).passwordForm,
          validator: (value) => validateRequired(
            value,
            emptyField: S.of(context).validationFormEmpty,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(StartRegistration());
          },
          child: Text(S.of(context).dontHaveAccButton),
        ),
        BaseButton(
          text: S.of(context).logButton,
          onPressed: () {
            if (widget.formKey.currentState?.validate() ?? true) {
              context.read<AuthBloc>().add(
                LoginUser(
                  login: loginController.text.trim(),
                  password: passwordController.text.trim(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
