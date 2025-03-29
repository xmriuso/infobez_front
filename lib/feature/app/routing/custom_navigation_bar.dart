import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/resourses/images.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
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
                  AppColors.loginGradient3,
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
                NavIconButton(),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class NavIconButton extends StatefulWidget {
  @override
  _NavIconButtonState createState() => _NavIconButtonState();
}

class _NavIconButtonState extends State<NavIconButton> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _toggleMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    final buttonOffset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _toggleMenu(),
        child: Stack(
          children: [
            Positioned(
              left: buttonOffset.dx - 150,
              top: buttonOffset.dy + buttonSize.height + 5,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuButton(
                        icon: Icons.person_outline,
                        label: 'Профиль',
                        onPressed: () => _navigateToProfile(context),
                      ),
                      _buildMenuButton(
                        icon: Icons.delete,
                        label: 'Корз ина',
                        onPressed: () => null,
                      ),
                      _buildMenuButton(
                        icon: Icons.exit_to_app,
                        label: 'Выйти',
                        onPressed: () => _logout(context),
                        isDestructive: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isDestructive = false,
  }) {
    return TextButton(
      onPressed: () {
        _toggleMenu();
        onPressed();
      },
      style: TextButton.styleFrom(
        foregroundColor: isDestructive ? Colors.red : Colors.black87,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 20, color: isDestructive ? Colors.red : Colors.black54),
          SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    // Навигация к профилю
    context.go(RoutePath.profilePage);
  }

  void _logout(BuildContext context) {
    // Логика выхода
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Подтверждение'),
        content: Text('Вы действительно хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go(RoutePath.authPage);
            },
            child: Text('Выйти', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: _buttonKey,
      icon: Icon(Icons.menu, size: 30, color: Colors.white),
      onPressed: _toggleMenu,
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
