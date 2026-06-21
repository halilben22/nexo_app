import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexo_app/core/theme/app_colors.dart';

import 'package:nexo_app/core/theme/app_text_styles.dart';
import 'package:nexo_app/feature/home/ui/add_new_transaction.dart';
import 'package:nexo_app/feature/home/ui/home_screen.dart';
import 'package:nexo_app/feature/login/bloc/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 168, 84, 193),
            const Color.fromARGB(255, 74, 32, 83),
            const Color.fromARGB(255, 13, 12, 33),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 55, left: 8, right: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    width: 70,
                    height: 70,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.invertedButton,
                    ),
                  ),
                ),

                Text("Master Your Money", style: AppTextStyles.heading1),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Track,analyze and optimize your finance effortlessly.",
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 55),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddTransaction(),
                          ),
                        );
                      }
                      if (state is LoginFailure) {
                        print("Failed : ${state.message}");
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryButton,
                          foregroundColor: AppColors.primary,

                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginWithGoogle());
                        },
                        child: state is LoginLoading
                            ? CircularProgressIndicator(
                                color: AppColors.invertedButton,
                              )
                            : Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
