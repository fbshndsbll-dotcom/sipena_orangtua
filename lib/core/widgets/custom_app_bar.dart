import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showMenuIcon = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.cardWhite,
      elevation: 0,
      leading: showMenuIcon
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: AppTheme.primaryBlue),
                onPressed: () {},
              ),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo "Si" in blue, "pena" with "p" in orange
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Si',
                  style: GoogleFonts.poppins(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: 'p',
                  style: GoogleFonts.poppins(
                    color: AppTheme.accentOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: 'ena',
                  style: GoogleFonts.poppins(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
