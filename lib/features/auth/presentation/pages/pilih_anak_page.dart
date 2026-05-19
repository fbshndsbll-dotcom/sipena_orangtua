import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/features/home/presentation/pages/home_page.dart';

// Model sederhana data anak
class _AnakModel {
  final String nama;
  final String kelas;
  final String? avatarAsset;

  const _AnakModel({
    required this.nama,
    required this.kelas,
    this.avatarAsset,
  });
}

class PilihAnakPage extends StatefulWidget {
  const PilihAnakPage({super.key});

  @override
  State<PilihAnakPage> createState() => _PilihAnakPageState();
}

class _PilihAnakPageState extends State<PilihAnakPage>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;

  // Data dummy anak — nantinya diganti dari API
  final List<_AnakModel> _daftarAnak = const [
    _AnakModel(
      nama: 'Gavin Khalisio H.',
      kelas: 'XI RPL 1',
      avatarAsset: 'assets/images/avatar_student.png',
    ),
    _AnakModel(
      nama: 'Gavin Khalisio H.',
      kelas: 'XI RPL 1',
      avatarAsset: 'assets/images/avatar_student.png',
    ),
  ];

  late AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _handlePilih() {
    if (_selectedIndex == null) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomePage(),
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── AppBar custom ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logosipena.png',
                      height: 32,
                      errorBuilder: (_, __, ___) => Text(
                        'Sipena',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // User info pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Trisno Wibowo',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.notifications_outlined,
                        color: Colors.white, size: 22),
                  ],
                ),
              ),

              // ── Header teks ───────────────────────────────────────
              const SizedBox(height: 32),
              FadeTransition(
                opacity: _animCtrl,
                child: Column(
                  children: [
                    Text(
                      'PILIH ANAK',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pilih anak untuk melihat perkembangan belajar',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // ── Daftar anak ───────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  itemCount: _daftarAnak.length,
                  itemBuilder: (context, i) {
                    final anak = _daftarAnak[i];
                    final isSelected = _selectedIndex == i;
                    return AnimatedBuilder(
                      animation: _animCtrl,
                      builder: (_, child) {
                        final delay = i * 0.15;
                        final t = ((_animCtrl.value - delay) /
                                (1.0 - delay))
                            .clamp(0.0, 1.0);
                        return Opacity(
                          opacity: t,
                          child: Transform.translate(
                            offset: Offset(0, 30 * (1 - t)),
                            child: child,
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedIndex = i);
                          // Langsung navigasi ke dashboard setelah tap
                          Future.delayed(
                              const Duration(milliseconds: 300),
                              _handlePilih);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.15),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.accentOrange
                                        : Colors.white.withOpacity(0.3),
                                    width: isSelected ? 3 : 1.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppTheme.accentOrange
                                                .withOpacity(0.4),
                                            blurRadius: 16,
                                            spreadRadius: 2,
                                          )
                                        ]
                                      : [],
                                ),
                                child: ClipOval(
                                  child: anak.avatarAsset != null
                                      ? Image.asset(
                                          anak.avatarAsset!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                            Icons.person,
                                            color: Colors.white54,
                                            size: 44,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          color: Colors.white54,
                                          size: 44,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.accentOrange
                                        : Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      anak.nama,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      anak.kelas,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
