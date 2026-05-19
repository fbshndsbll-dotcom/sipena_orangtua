import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data dummy
  final List<Map<String, dynamic>> _dataAlpa = [
    {'tanggal': '12 April 2026', 'mapel': 'Matematika', 'keterangan': 'Alfa'},
    {'tanggal': '18 April 2026', 'mapel': 'Bahasa Indonesia', 'keterangan': 'Alfa'},
    {'tanggal': '25 April 2026', 'mapel': 'Sejarah', 'keterangan': 'Alfa'},
  ];

  final List<Map<String, dynamic>> _dataRekap = [
    {'mapel': 'Matematika', 'hadir': 18, 'alfa': 1, 'izin': 0, 'sakit': 1},
    {'mapel': 'Bahasa Indonesia', 'hadir': 19, 'alfa': 1, 'izin': 0, 'sakit': 0},
    {'mapel': 'Sejarah', 'hadir': 17, 'alfa': 1, 'izin': 1, 'sakit': 1},
    {'mapel': 'Fisika', 'hadir': 20, 'alfa': 0, 'izin': 0, 'sakit': 0},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // ── Tab bar ────────────────────────────────────────────────
          Container(
            color: AppTheme.cardWhite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _buildTab(0, 'INI ALPA'),
                const SizedBox(width: 12),
                _buildTab(1, 'REKAP ABSEN'),
              ],
            ),
          ),

          // ── Tab content ────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAlpaView(),
                _buildRekapView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.cardWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            const SizedBox(width: 8),
            const Icon(Icons.chevron_left,
                color: AppTheme.textPrimary, size: 22),
            Text(
              'Absensi',
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary),
            ),
          ],
        ),
      ),
      leadingWidth: 140,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Image.asset(
            'assets/images/logosipena.png',
            height: 36,
            errorBuilder: (_, __, ___) => Text(
              'Sipena',
              style: GoogleFonts.poppins(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _tabController.animateTo(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.dangerRed : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isSelected ? Colors.white : AppTheme.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Tab 1: Ini Alpa ──────────────────────────────────────────────────────
  Widget _buildAlpaView() {
    if (_dataAlpa.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline,
                color: AppTheme.successGreen, size: 60),
            const SizedBox(height: 12),
            Text(
              'Tidak ada data alpa',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.textPrimary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dataAlpa.length,
      itemBuilder: (context, i) {
        final item = _dataAlpa[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.cardWhite,
            borderRadius: BorderRadius.circular(14),
            border:
                Border.all(color: AppTheme.dangerRed.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.dangerRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_busy,
                    color: AppTheme.dangerRed, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['mapel'],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppTheme.textPrimary),
                    ),
                    Text(
                      item['tanggal'],
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.dangerRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['keterangan'],
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.dangerRed),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Tab 2: Rekap Absen ───────────────────────────────────────────────────
  Widget _buildRekapView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dataRekap.length,
      itemBuilder: (context, i) {
        final item = _dataRekap[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardWhite,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['mapel'],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildAbsenBadge('Hadir', '${item['hadir']}',
                      AppTheme.successGreen),
                  const SizedBox(width: 8),
                  _buildAbsenBadge(
                      'Alfa', '${item['alfa']}', AppTheme.dangerRed),
                  const SizedBox(width: 8),
                  _buildAbsenBadge(
                      'Izin', '${item['izin']}', AppTheme.warningYellow),
                  const SizedBox(width: 8),
                  _buildAbsenBadge(
                      'Sakit', '${item['sakit']}', AppTheme.infoBlue),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAbsenBadge(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                  fontSize: 10, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
