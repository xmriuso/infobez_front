import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/core/widgets/app_button_widget.dart';
import 'package:test_web_project/feature/auth_page/widgets/auth_text_field.dart';

import '../../../core/resourses/svg_icons.dart';
import '../../app/routing/route_path.dart';
import '../bloc/auth_page_bloc.dart';

class AuthPage extends StatefulWidget {
  static String name = RoutePath.authPage;

  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loginOrRegister = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthPageBloc>().add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.loginGradient1,
                  AppColors.loginGradient2,
                  AppColors.loginGradient3,
                  AppColors.loginGradient4,
                  AppColors.loginGradient5,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            height: loginOrRegister ? 600 : 500,
            width: 412,
            child: Column(
              children: [
                !loginOrRegister ? AuthWidget() : RegisterWidget(),
                const SizedBox(height: 36),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loginOrRegister = !loginOrRegister;
                    });
                  },
                  child: Text(
                    'Register',
                    style: AppTypography.font18RegularZillaSlab.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthPageBloc, AuthPageState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.go(RoutePath.allCoursesPage);
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 50),
            child: Column(
              children: [
                Text(
                  'Login',
                  style: AppTypography.font48RegularZillaSlab.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  controller: loginController,
                  hintText: 'Email',
                  icon: SvgIcons.iconUser,
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: SvgIcons.iconLockLocked,
                ),
                const SizedBox(height: 18),
                AppButtonWidget(
                  name: 'Login',
                  onTap: () {
                    if (loginController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      context.read<AuthPageBloc>().add(
                            LoginEvent(
                              username: loginController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthPageBloc, AuthPageState>(
      listenWhen: (lastContext, context) {
        return lastContext is AuthLoadingState;
      },
      listener: (context, state) {
        if (state is AuthSuccessState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Text(
                    'Успешная регистрация',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              });
        }
        if (state is AuthErrorState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Text(
                    'Ошибка регистрации',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              });
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 50),
            child: Column(
              children: [
                Text(
                  'Login',
                  style: AppTypography.font48RegularZillaSlab.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  controller: userNameController,
                  hintText: 'Username',
                  icon: SvgIcons.iconUser,
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: SvgIcons.iconLockLocked,
                ),
                const SizedBox(height: 45),
                AuthTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: SvgIcons.iconLockLocked,
                ),
                const SizedBox(height: 18),
                AppButtonWidget(
                  name: 'Register',
                  onTap: () {
                    if (userNameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      context.read<AuthPageBloc>().add(
                            RegisterEvent(
                              name: userNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
