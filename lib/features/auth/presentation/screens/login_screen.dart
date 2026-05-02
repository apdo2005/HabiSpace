import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habispace/features/auth/presentation/logic/auth_bloc.dart';
import 'package:habispace/features/auth/presentation/logic/auth_state.dart';
import 'package:habispace/features/auth/presentation/screens/terms_and_conditions_screen.dart';
import 'package:habispace/routes.dart';
import 'package:habispace/shared/custom_svg.dart';
import 'package:habispace/shared/custom_textformfield.dart';
import 'package:habispace/shared/snakbar.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import 'package:habispace/utils/app_validation.dart';

import 'in_our_privacy_policy_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _getErrorMessage(String apiMessage) {
    final msg = apiMessage.toLowerCase();

    if (msg.contains('invalid credentials') || msg.contains('unauthorized')) {
      return 'Incorrect email or password. Please try again.';
    }
    if (msg.contains('email')) {
      return 'Please check your email address.';
    }
    if (msg.contains('password')) {
      return 'Incorrect password. Please try again.';
    }
    if (msg.contains('not found') || msg.contains('no account')) {
      return 'No account found with this email.';
    }
    if (msg.contains('server') || msg.contains('500')) {
      return 'Server error. Please try again later.';
    }

    return apiMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightMedium,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .center,

                children: [
                  SizedBox(height: AppSizes.h80),
                  CustomSvgImage(
                    path: "assets/images/logo2.svg",
                    height: AppSizes.h50,
                    width: AppSizes.w170,
                  ),
                  SizedBox(height: AppSizes.h24),
                  Text(
                    "Sign In Account",
                    style: GoogleFonts.poppins(
                      fontSize: AppSizes.h20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondBlack,
                    ),
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomTextformfeild(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    controller: _emailController,
                    validator: AppValidators.email,
                    formFieldKey: const Key("email"),
                    labelText: "Email",
                    labelcolor: AppColors.secondBlack,
                    borderRadius: AppSizes.r10,
                  ),
                  SizedBox(height: AppSizes.h16),
                  CustomTextformfeild(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Password ",
                    controller: _passwordController,
                    validator: AppValidators.password,
                    formFieldKey: const Key("password"),
                    labelText: "password",
                    isPassword: true,
                    labelcolor: AppColors.secondBlack,
                    borderRadius: AppSizes.r10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgotPassword);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.h12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.h24),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        CustomSnackBar().successBar(
                          context,
                          "Welcome back, ${state.user.username}!",
                        );
                        Navigator.pushReplacementNamed(context, AppRoutes.home);

                      } else if (state is AuthError) {
                      final message = _getErrorMessage(state.message);
                      CustomSnackBar().errorBar(context, message);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignInWithEmailEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size(double.infinity, AppSizes.h40),
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.r8),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: AppSizes.sp12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.light,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.h24),
                  Row(
                    mainAxisAlignment: .spaceBetween,

                    children: [
                      Container(height: 2, width: 120, color: AppColors.borderColor),
                      Text(
                        "or login with",
                        style: GoogleFonts.inter(
                          fontSize: AppSizes.sp12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondBlack,
                        ),
                      ),
                      Container(height: 2, width: 120, color: AppColors.borderColor),
                    ],
                  ),
                  SizedBox(height: AppSizes.h18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<AuthBloc>().add(const SignInWithGoogleEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color(0xffEBEBEB),
                          minimumSize: Size(double.infinity, AppSizes.h50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.r16),
                          ),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: AppColors.blue,

                          size: AppSizes.r20,
                        ),
                        label: Text(
                          "Continue with  Google",
                          style: GoogleFonts.poppins(
                            fontSize: AppSizes.sp16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff334155),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: AppSizes.h24),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.poppins(
                            fontSize: AppSizes.sp12,
                            color: AppColors.secondBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),

                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: AppSizes.sp12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.h24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By signing in, you agree to our",
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.sp12,
                          color: AppColors.secondBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      GestureDetector(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TermsAndConditionsScreen(),
                              ),
                            ),
                        child: Text(
                          "Terms and Conditions.",
                          style: GoogleFonts.poppins(
                            fontSize: AppSizes.sp12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Learn how we use your data",
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.sp12,
                          color: AppColors.secondBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PrivacyPolicyScreen(),
                              ),
                            ),
                        child: Text(
                          "in our Privacy Policy.",
                          style: GoogleFonts.poppins(
                            fontSize: AppSizes.sp12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
