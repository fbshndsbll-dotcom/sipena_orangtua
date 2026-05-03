import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/core/widgets/custom_app_bar.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  int _selectedLang = 0; // 0 = Indonesia, 1 = Jawa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: const CustomAppBar(title: 'Pengaturan'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Bahasa',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildLanguageCard(
              index: 0,
              flag: '🇮🇩',
              title: 'Bahasa Indonesia',
              subtitle: 'Bahasa utama aplikasi',
            ),
            const SizedBox(height: 10),
            _buildLanguageCard(
              index: 1,
              flag: '🏝️',
              title: 'Bahasa Jawa',
              subtitle: 'Opsi bahasa aplikasi',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.warningYellow.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.warningYellow.withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppTheme.warningYellow, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bahasa dapat diubah kapan saja yang melalui menu preferensi',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.warningYellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required int index,
    required String flag,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedLang == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedLang = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.backgroundGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(flag, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppTheme.primaryBlue : AppTheme.textLight,
                  width: 2,
                ),
                color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 13)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
