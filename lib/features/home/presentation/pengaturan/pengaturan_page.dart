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
  int _selectedLang = 0;

  final _oldPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  bool _isLoading = false;
  String? _oldPasswordError;
  String? _confirmError;
  String? _successMessage;

  @override
  void dispose() {
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async {
    setState(() {
      _oldPasswordError = null;
      _confirmError = null;
      _successMessage = null;
    });

    if (_oldPasswordCtrl.text.isEmpty) {
      setState(() => _oldPasswordError = 'Password lama harus diisi');
      return;
    }
    if (_oldPasswordCtrl.text != 'password123') {
      setState(() => _oldPasswordError = 'Password lama tidak sesuai');
      return;
    }
    if (_newPasswordCtrl.text.isEmpty) {
      setState(() => _confirmError = 'Password baru harus diisi');
      return;
    }
    if (_confirmPasswordCtrl.text != _newPasswordCtrl.text) {
      setState(() => _confirmError = 'Konfirmasi tidak cocok');
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isLoading = false;
      _successMessage = 'Password berhasil diubah';
      _oldPasswordCtrl.clear();
      _newPasswordCtrl.clear();
      _confirmPasswordCtrl.clear();
    });

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _successMessage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: const CustomAppBar(title: 'Pengaturan'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── C.1 Pilih Bahasa ───────────────────────────────────────
                Text('Pilih Bahasa',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.textPrimary)),
                const SizedBox(height: 12),
                _buildLanguageCard(index: 0, imagePath: 'assets/images/flag_id.png', title: 'Bahasa Indonesia', subtitle: 'Bahasa utama aplikasi'),
                const SizedBox(height: 10),
                _buildLanguageCard(index: 1, imagePath: 'assets/images/flag_jw.png', title: 'Bahasa Jawa', subtitle: ''),
                const SizedBox(height: 12),
                _buildInfoBox('Bahasa dapat diubah kapan saja melalui menu preferensi'),
                const SizedBox(height: 24),

                // ─── C.2 Ubah Password ──────────────────────────────────────
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.lock_outline, color: AppTheme.primaryBlue, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text('Ubah Password', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.textPrimary)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Jika lupa password, hubungi admin sekolah untuk mendapatkan reset password.',
                          style: GoogleFonts.poppins(fontSize: 10, color: AppTheme.textSecondary)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildForgotRow(),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPasswordField(label: 'Password Lama', controller: _oldPasswordCtrl, obscure: _obscureOld, onToggle: () => setState(() => _obscureOld = !_obscureOld), errorText: _oldPasswordError),
                      const SizedBox(height: 16),
                      _buildPasswordField(label: 'Password Baru', hint: 'Minimal 6 Karakter', controller: _newPasswordCtrl, obscure: _obscureNew, onToggle: () => setState(() => _obscureNew = !_obscureNew)),
                      const SizedBox(height: 16),
                      _buildPasswordField(label: 'Konfirmasi Password Baru', hint: 'Ulangi password baru', controller: _confirmPasswordCtrl, obscure: _obscureConfirm, onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm), errorText: _confirmError),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            disabledBackgroundColor: AppTheme.primaryBlue.withOpacity(0.5),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : Text('Simpan', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          if (_successMessage != null)
            Positioned(
              top: 16, left: 16, right: 16,
              child: Material(
                color: Colors.transparent,
                child: AnimatedOpacity(
                  opacity: _successMessage != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.successGreen),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 22),
                        const SizedBox(width: 10),
                        Text(_successMessage!, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.warningYellow.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.warningYellow.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppTheme.warningYellow, size: 16),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.warningYellow))),
        ],
      ),
    );
  }

  Widget _buildForgotRow() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          const Icon(Icons.phone_outlined, color: AppTheme.accentOrange, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text('Lupa password? Hubungi admin sekolah untuk reset password.',
                style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.accentOrange, decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    String? hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint ?? '••••••••••',
            hintStyle: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textLight),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppTheme.textLight, size: 20),
              onPressed: onToggle,
            ),
            errorText: errorText,
            errorStyle: GoogleFonts.poppins(fontSize: 11, color: AppTheme.dangerRed),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.dividerColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.dangerRed)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.dangerRed, width: 1.5)),
            filled: true,
            fillColor: AppTheme.backgroundGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageCard({required int index, required String imagePath, required String title, required String subtitle}) {
    final bool isSelected = _selectedLang == index;
    return GestureDetector(
      onTap: () {
        if (_selectedLang == index) return;
        setState(() => _selectedLang = index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text('Bahasa berhasil diubah', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white)),
            ]),
            backgroundColor: AppTheme.successGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 2),
            margin: const EdgeInsets.all(16),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppTheme.primaryBlue : AppTheme.dividerColor, width: isSelected ? 2 : 1),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20, height: 20,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSelected ? AppTheme.primaryBlue : AppTheme.textLight, width: 2)),
              child: isSelected ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryBlue))) : null,
            ),
            const SizedBox(width: 12),
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppTheme.backgroundGrey, borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.flag, color: AppTheme.textLight, size: 24)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: isSelected ? AppTheme.primaryBlue : AppTheme.textPrimary)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
