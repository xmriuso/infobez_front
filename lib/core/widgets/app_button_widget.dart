import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/typography.dart';

class AppButtonWidget extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  final Color? color;
  final Color? disabledColor;

  const AppButtonWidget({
    super.key,
    required this.name,
    this.onTap,
    this.color,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 45,
        minHeight: 45,
        maxWidth: 320,
        minWidth: 200,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color ?? AppColors.white,
          disabledBackgroundColor: disabledColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FittedBox(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppTypography.font18RegularZillaSlab.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
