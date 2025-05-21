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
                Flexible(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          loginOrRegister = !loginOrRegister;
                        });
                      },
                      child: Text(
                        loginOrRegister ? 'Авторизация' : 'Регистрация',
                        style: AppTypography.font18RegularZillaSlab.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
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
    return BlocBuilder<AuthPageBloc, AuthPageState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 46, top: 50, right: 46),
            child: Column(
              children: [
                Text(
                  'Авторизация',
                  style: AppTypography.font48RegularZillaSlab.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  controller: loginController,
                  hintText: 'Почта',
                  icon: SvgIcons.iconUser,
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  hideText: true,
                  controller: passwordController,
                  hintText: 'Пароль',
                  icon: SvgIcons.iconLockLocked,
                ),
                const SizedBox(height: 35),
                AppButtonWidget(
                  name: 'Войти',
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
        if (state is SuccessRegisterState) {
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
          context.read<AuthPageBloc>().add(
                LoginEvent(
                  username: emailController.text,
                  password: passwordController.text,
                ),
              );
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
            padding: const EdgeInsets.only(left: 46, top: 50, right: 46),
            child: Column(
              children: [
                Text(
                  'Регистрация',
                  style: AppTypography.font48RegularZillaSlab.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  controller: userNameController,
                  hintText: 'Имя пользователя',
                  icon: SvgIcons.iconUser,
                ),
                const SizedBox(height: 35),
                AuthTextField(
                  hideText: true,
                  controller: passwordController,
                  hintText: 'Пароль',
                  icon: SvgIcons.iconLockLocked,
                ),
                const SizedBox(height: 45),
                AuthTextField(
                  controller: emailController,
                  hintText: 'Почта',
                  icon: SvgIcons.iconLockLocked,
                ),
                const SizedBox(height: 35),
                AppButtonWidget(
                  name: 'Регистрация',
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
