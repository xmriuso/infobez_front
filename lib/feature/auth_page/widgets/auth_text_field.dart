import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_web_project/core/theme/app_colors.dart';

import '../../../core/theme/typography.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final String? icon;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
      ),
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: AppTypography.font18RegularZillaSlab.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: AppTypography.font18RegularZillaSlab.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 18),
            if (icon != null)
              SvgPicture.asset(
                icon!,
                width: 20,
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}
