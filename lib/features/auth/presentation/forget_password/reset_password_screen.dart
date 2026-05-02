import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habispace/features/auth/presentation/logic/auth_bloc.dart';

import 'package:habispace/features/auth/presentation/logic/auth_state.dart';
import 'package:habispace/routes.dart';

import 'package:habispace/shared/custom_textformfield.dart'
;import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String otp;
  final String email;

  ResetPasswordScreen({
    super.key,
    required this.otp,
    required this.email,
  });

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Password reset successfully!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
                  (route) => false,
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: AppSizes.h24),
                  Text(
                    "Create a new password for\n$email",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  SizedBox(height: AppSizes.h24),



                  CustomTextformfeild(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "New Password",
                    controller: _passwordController,
                    isPassword: true,
                    formFieldKey: const Key("new_password"),
                    labelText: "New Password",
                    labelcolor: AppColors.secondBlack,
                    borderRadius: AppSizes.r10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.h16),
                  CustomTextformfeild(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Confirm Password",
                    controller: _confirmController,
                    isPassword: true,
                    formFieldKey: const Key("confirm_password"),
                    labelText: "Confirm Password",
                    labelcolor: AppColors.secondBlack,
                    borderRadius: AppSizes.r10,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizes.h24),
                  ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          ResetPasswordEvent(
                            email: email,
                            otp: otp,
                            password: _passwordController.text,
                            passwordConfirmation: _confirmController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, AppSizes.h50),
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r8),
                      ),
                    ),
                    child: state is AuthLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      "Reset Password",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}