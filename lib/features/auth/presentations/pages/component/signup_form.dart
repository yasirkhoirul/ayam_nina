import 'package:flutter/material.dart';
import 'package:kedai_ayam_nina/core/utils/validators.dart';
import 'package:kedai_ayam_nina/core/widgets/custom_button_gradient.dart';
import 'package:kedai_ayam_nina/core/widgets/custom_textfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isLoading,
    required this.formKey,
    required this.onSignUp,
  });

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final GlobalKey<FormState> formKey;
  final Function() onSignUp;
  final bool isLoading;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLoading ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Form(
          key: widget.formKey,
          child: Column(
            spacing: 16,
            children: [
              if (!widget.isLoading) ...[
                CustomInputField(
                  validator: MyValidators.notNull,
                  controller: widget.name,
                  prefixIcon: Icons.person,
                  label: "Nama Lengkap",
                  hintText: "Masukkan nama lengkap",
                ),
                CustomInputField(
                  validator: MyValidators.notNull,
                  controller: widget.email,
                  prefixIcon: Icons.email,
                  label: "Email",
                  hintText: "Masukkan email",
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomInputField(
                  validator: MyValidators.notNull,
                  controller: widget.password,
                  prefixIcon: Icons.lock,
                  label: "Password",
                  hintText: "Masukkan password (min. 6 karakter)",
                  suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  obscureText: _obscurePassword,
                  onSuffixTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                CustomInputField(
                  validator: MyValidators.notNull,
                  controller: widget.confirmPassword,
                  prefixIcon: Icons.lock,
                  label: "Konfirmasi Password",
                  hintText: "Ulangi password",
                  suffixIcon: _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  obscureText: _obscureConfirmPassword,
                  onSuffixTap: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ] else ...[
                SizedBox(
                  height: 150,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
              CustomGradientButton(
                text: widget.isLoading ? "Loading..." : "Daftar",
                onTap: widget.isLoading
                    ? null
                    : () {
                        if (widget.formKey.currentState!.validate()) {
                          widget.onSignUp.call();
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

