import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/core/widgets/app_button_widget.dart';
import 'package:test_web_project/feature/auth_page/widgets/auth_text_field.dart';

import '../../../core/resourses/svg_icons.dart';
import '../../app/routing/route_path.dart';

class AuthPage extends StatelessWidget {
  static String name = RoutePath.authPage;

  const AuthPage({super.key});

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
          height: 500,
          width: 412,
          child: Center(
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
                    hintText: 'Email',
                    icon: SvgIcons.iconUser,
                  ),
                  const SizedBox(height: 35),
                  AuthTextField(
                    hintText: 'Password',
                    icon: SvgIcons.iconLockLocked,
                  ),
                  const SizedBox(height: 18),
                  AppButtonWidget(
                    name: 'Login',
                    onTap: () {
                      context.go(RoutePath.allCoursesPage);
                    },
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
