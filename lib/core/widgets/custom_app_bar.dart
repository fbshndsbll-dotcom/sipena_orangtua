import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.cardWhite,
      elevation: 0,
      shadowColor: Colors.black12,
      surfaceTintColor: Colors.transparent,
      // Logo Sipena ditampilkan di title, rata kiri
      titleSpacing: 16,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo icon bulat kecil
          Image.asset(
            'assets/images/logosipena.png',
            width: 90,
            height: 90,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6),
        ],
      ),
      // Judul halaman & actions di sebelah kanan
      actions: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
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
