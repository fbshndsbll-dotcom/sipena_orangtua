import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/core/widgets/custom_app_bar.dart';
import '../notifikasi/notifikasi_page.dart';

// Indeks sub-page di Progres Anak
const int kSubTugas = 0;
const int kSubAbsensi = 1;
const int kSubRekapNilai = 2;

class DashboardPage extends StatelessWidget {
  /// Callback untuk pindah ke halaman Progres Anak dengan sub-page tertentu
  final void Function(int subIndex) onNavigateToProgress;

  const DashboardPage({super.key, required this.onNavigateToProgress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: CustomAppBar(
        title: '',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: AppTheme.primaryBlue,
                        child: Icon(Icons.person, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Trisno Wibowo',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotifikasiPage()),
                  ),
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.notifications_outlined, color: AppTheme.textPrimary, size: 22),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.dangerRed,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStudentCard(),
                  const SizedBox(height: 14),
                  _buildMenuGrid(context),
                  const SizedBox(height: 14),
                  _buildNotificationSection(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header biru dengan info orang tua ─────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryBlue, AppTheme.primaryBlueLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF3B82F6),
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang,',
                  style: GoogleFonts.poppins(
                      color: Colors.white70, fontSize: 13),
                ),
                Text(
                  'Orang Tua/Wali',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  'Pantau perkembangan belajar anak\nAnda dengan mudah',
                  style: GoogleFonts.poppins(
                      color: Colors.white60, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'SMK NEGERI 1 BOYOLALI',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Ringkasan data siswa ───────────────────────────────────────────────────
  Widget _buildStudentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_outline,
                    color: AppTheme.primaryBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'Ringkasan Data Siswa',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppTheme.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppTheme.dividerColor),
          const SizedBox(height: 12),
          _buildInfoRow('Nama', 'Asep Kopling'),
          _buildInfoRow('Kelas', 'XI RPL 1'),
          _buildInfoRow('Wali Kelas', 'Umi Kulsum'),
          _buildStatusRow(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: AppTheme.textSecondary)),
          ),
          Text(': ',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppTheme.textSecondary)),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text('Status',
                style: GoogleFonts.poppins(
                    fontSize: 13, color: AppTheme.textSecondary)),
          ),
          Text(': ',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppTheme.textSecondary)),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Aktif',
              style: GoogleFonts.poppins(
                  color: AppTheme.successGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ── Menu navigasi (Tugas, Absensi, Rekap Nilai) ────────────────────────────
  Widget _buildMenuGrid(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.assignment_outlined,
            iconColor: AppTheme.accentOrange,
            iconBg: AppTheme.accentOrange.withOpacity(0.12),
            label: 'Tanggungan Tugas',
            trailingWidget: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.accentOrange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '5 tugas',
                style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accentOrange),
              ),
            ),
            onTap: () => onNavigateToProgress(kSubTugas),
            isLast: false,
          ),
          _buildMenuItem(
            context,
            icon: Icons.calendar_month_outlined,
            iconColor: AppTheme.primaryBlueLight,
            iconBg: AppTheme.primaryBlue.withOpacity(0.1),
            label: 'Absensi',
            trailingWidget: null,
            onTap: () => onNavigateToProgress(kSubAbsensi),
            isLast: false,
          ),
          _buildMenuItem(
            context,
            icon: Icons.bar_chart_rounded,
            iconColor: AppTheme.successGreen,
            iconBg: AppTheme.successGreen.withOpacity(0.12),
            label: 'Rekap Nilai',
            trailingWidget: Text(
              '87,5',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.successGreen),
            ),
            onTap: () => onNavigateToProgress(kSubRekapNilai),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required Widget? trailingWidget,
    required VoidCallback onTap,
    required bool isLast,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.vertical(
            top: isLast ? Radius.zero : Radius.zero,
            bottom: isLast ? const Radius.circular(16) : Radius.zero,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary),
                  ),
                ),
                if (trailingWidget != null) ...[
                  trailingWidget,
                  const SizedBox(width: 8),
                ],
                const Icon(Icons.chevron_right,
                    color: AppTheme.textLight, size: 20),
              ],
            ),
          ),
        ),
        if (!isLast)
          const Divider(
              height: 1, indent: 56, endIndent: 0, color: AppTheme.dividerColor),
      ],
    );
  }

  // ── Notifikasi terbaru ─────────────────────────────────────────────────────
  Widget _buildNotificationSection() {
    final notifs = [
      {'title': 'Tugas baru: Laporan Fisika', 'time': '1 jam yang lalu'},
      {'title': 'Ahmad Rizky — Alpha Sejarah', 'time': '3 jam yang lalu'},
      {'title': 'Ahmad Rizky — Izin Matematika', 'time': '2 hari yang lalu'},
    ];

    return Builder(
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_active, color: AppTheme.accentOrange, size: 18),
                    const SizedBox(width: 8),
                    Text('Notifikasi Terbaru',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.textPrimary)),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotifikasiPage()),
                  ),
                  child: Text(
                    'Lihat semua >',
                    style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...notifs.map((n) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotifikasiPage()),
              ),
              child: _buildNotifItem(n['title']!, n['time']!),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifItem(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppTheme.accentOrange.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_outlined,
                color: AppTheme.accentOrange, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary)),
                Text(time,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppTheme.textLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
