import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/resourses/images.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

import '../../../core/theme/typography.dart';

class CustomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell child;
  final int? index;

  const CustomNavigationBar({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blue,
                  AppColors.pink,
                  AppColors.yellow,
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                Image.asset(
                  AssetsImages.topBarIcon,
                  height: 55,
                  width: 90,
                ),
                const Spacer(),
                TopBarItem(
                  title: 'Все курсы',
                  isSelected: index == 0,
                  onTap: () {
                    child.goBranch(0);
                  },
                ),
                const SizedBox(width: 30),
                TopBarItem(
                  title: 'Мои курсы',
                  isSelected: index == 1,
                  onTap: () {
                    child.goBranch(1);
                  },
                ),
                const Spacer(),
                Icon(
                  Icons.access_time_filled,
                  size: 30,
                  color: AppColors.white,
                ),
                Icon(
                  Icons.access_time_filled,
                  size: 30,
                  color: AppColors.white,
                ),
                Icon(
                  Icons.access_time_filled,
                  size: 30,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TopBarItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isSelected
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.white,
                  ),
                )
              : null,
        ),
        child: Text(
          title,
          style: AppTypography.font20RegularZillaSlab.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            color: isSelected ? AppColors.white : AppColors.white,
          ),
        ),
      ),
    );
  }
}
