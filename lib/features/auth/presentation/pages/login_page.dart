import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/features/auth/presentation/pages/pilih_anak_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  int _selectedRole = 2; // 0=Guru, 1=Siswa, 2=Orang tua
  final _nisnCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _showSuccess = false;
  String? _errorMessage;

  late AnimationController _sheetAnim;
  late Animation<Offset> _sheetSlide;

  @override
  void initState() {
    super.initState();
    _sheetAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _sheetSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _sheetAnim, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _sheetAnim.forward();
    });
  }

  @override
  void dispose() {
    _sheetAnim.dispose();
    _nisnCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // Simulasi validasi
    if (_nisnCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'NISN dan kata sandi tidak boleh kosong';
      });
      return;
    }

    setState(() {
      _isLoading = false;
      _showSuccess = true;
    });

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const PilihAnakPage(),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roles = ['Guru', 'Siswa', 'Orang tua'];
    final roleIcons = [
      Icons.school_outlined,
      Icons.person_outline,
      Icons.people_outline,
    ];

    return Scaffold(
      body: Stack(
        children: [
          // ── Hero background ──────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.48,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/login_hero.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryBlue.withOpacity(0.55),
                        AppTheme.primaryBlue.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom sheet card ────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _sheetSlide,
              child: Container(
                padding: EdgeInsets.only(
                  top: 28,
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 24,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/logosipena.png',
                        height: 36,
                        errorBuilder: (_, __, ___) => Text(
                          'Sipena',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Pilih Role & Masuk',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ── Role selector ──────────────────────────────
                      Row(
                        children: List.generate(roles.length, (i) {
                          final selected = _selectedRole == i;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedRole = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                margin: EdgeInsets.only(
                                    right: i < roles.length - 1 ? 8 : 0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppTheme.accentOrange
                                      : AppTheme.primaryBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Icon(roleIcons[i],
                                        color: Colors.white, size: 20),
                                    const SizedBox(height: 3),
                                    Text(
                                      roles[i],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: selected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 18),

                      // ── Error banner ───────────────────────────────
                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.dangerRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppTheme.dangerRed.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: AppTheme.dangerRed, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppTheme.dangerRed),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // ── NISN ──────────────────────────────────────
                      Text(
                        'NISN Anak:',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _nisnCtrl,
                        hint: 'Masukkan NIK Anda',
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 14),

                      // ── Kata Sandi ────────────────────────────────
                      Row(
                        children: [
                          Text(
                            'Kata Sandi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            ' :',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.accentOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _passCtrl,
                        hint: 'Masukkan Kata Sandi',
                        prefixIcon: Icons.lock_outline,
                        obscure: _obscurePass,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePass
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppTheme.textLight,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _obscurePass = !_obscurePass),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ── Lupa + Ingat ──────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Lupa Kata Sandi?',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: AppTheme.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v!),
                                ),
                              ),
                              Text(
                                'Ingat Saya',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Tombol Masuk ──────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentOrange,
                            disabledBackgroundColor:
                                AppTheme.accentOrange.withOpacity(0.5),
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  'Masuk',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ── Atau ──────────────────────────────────────
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(color: AppTheme.dividerColor)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Atau',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppTheme.textLight),
                            ),
                          ),
                          const Expanded(
                              child: Divider(color: AppTheme.dividerColor)),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // ── Tombol Daftar ─────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: AppTheme.primaryBlue, width: 1.5),
                            padding:
                                const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Footer ────────────────────────────────────
                      Center(
                        child: Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: AppTheme.textLight),
                                children: const [
                                  TextSpan(text: 'Kebijakan Privasi'),
                                  TextSpan(text: ' | '),
                                  TextSpan(text: 'Syarat Penggunaan'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '© 2026 SIPENA Digital Solutions. All Rights Reserved.',
                              style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color: AppTheme.textLight),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Success toast ────────────────────────────────────────────
          if (_showSuccess)
            Positioned(
              top: 52,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle,
                          color: AppTheme.successGreen, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Login Berhasil!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style:
          GoogleFonts.poppins(fontSize: 13, color: AppTheme.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.poppins(fontSize: 13, color: AppTheme.textLight),
        prefixIcon:
            Icon(prefixIcon, color: AppTheme.textLight, size: 20),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
