import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kedai_ayam_nina/core/assets.dart';
import 'package:kedai_ayam_nina/core/constant/enum.dart';
import 'package:kedai_ayam_nina/core/widgets/snackbarr/custom_snackbar.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/component/signup_form.dart';
import 'package:kedai_ayam_nina/router/router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        Image.asset(Assets.logoC1),
        Text(
          "Kedai Ayam Nina",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar(
                  message: "Registrasi Berhasil",
                  state: SnackBarState.success,
                ),
              );
              context.go(MyRoute.adminCatalog.path);
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar(
                  message: state.message,
                  state: SnackBarState.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SignUpForm(
              name: _nameController,
              email: _emailController,
              password: _passwordController,
              confirmPassword: _confirmPasswordController,
              isLoading: state is AuthInProgress,
              formKey: GlobalKey<FormState>(),
              onSignUp: () {
                context.read<AuthBloc>().add(
                  AuthRegister(
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text,
                    confirmPassword: _confirmPasswordController.text,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
