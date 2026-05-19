import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';

class _NotifItem {
  final String kategori;
  final String judul;
  final String deskripsi;
  final String waktu;
  bool isRead;
  final Color color;
  final IconData icon;

  _NotifItem({
    required this.kategori,
    required this.judul,
    required this.deskripsi,
    required this.waktu,
    required this.isRead,
    required this.color,
    required this.icon,
  });
}

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  final List<_NotifItem> _notifs = [
    _NotifItem(
      kategori: 'Tugas Baru',
      judul: 'Tugas baru: Laporan Fisika',
      deskripsi: 'Guru Fisika memberikan tugas baru "Laporan Praktikum Gelombang". Batas pengumpulan: 21 Mei 2026.',
      waktu: '1 jam yang lalu',
      isRead: false,
      color: AppTheme.accentOrange,
      icon: Icons.assignment_add,
    ),
    _NotifItem(
      kategori: 'Absensi',
      judul: 'Ahmad Rizky — Alpha Sejarah',
      deskripsi: 'Ahmad Rizky tidak hadir tanpa keterangan pada pelajaran Sejarah hari ini (Senin, 18 Mei 2026).',
      waktu: '3 jam yang lalu',
      isRead: false,
      color: AppTheme.dangerRed,
      icon: Icons.person_off_outlined,
    ),
    _NotifItem(
      kategori: 'Absensi',
      judul: 'Ahmad Rizky — Izin Matematika',
      deskripsi: 'Ahmad Rizky mengajukan izin tidak hadir pada pelajaran Matematika (Jumat, 16 Mei 2026).',
      waktu: '2 hari yang lalu',
      isRead: true,
      color: AppTheme.warningYellow,
      icon: Icons.event_busy_outlined,
    ),
    _NotifItem(
      kategori: 'Nilai',
      judul: 'Nilai Bahasa Indonesia naik',
      deskripsi: 'Nilai tugas "Resensi Buku" Ahmad Rizky naik: 72 → 85. Pertahankan semangat belajarnya!',
      waktu: '3 hari yang lalu',
      isRead: true,
      color: AppTheme.successGreen,
      icon: Icons.trending_up_rounded,
    ),
    _NotifItem(
      kategori: 'Nilai',
      judul: 'Nilai Fisika turun',
      deskripsi: 'Nilai ulangan harian Fisika Ahmad Rizky turun: 80 → 65. Perlu perhatian ekstra.',
      waktu: '5 hari yang lalu',
      isRead: true,
      color: AppTheme.dangerRed,
      icon: Icons.trending_down_rounded,
    ),
  ];

  int get _unreadCount => _notifs.where((n) => !n.isRead).length;

  void _markAsRead(_NotifItem item) {
    if (item.isRead) return;
    setState(() => item.isRead = true);
  }

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifs) n.isRead = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.done_all, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Text('Semua notifikasi ditandai dibaca',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white)),
          ],
        ),
        backgroundColor: AppTheme.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: _buildAppBar(context),
      body: _notifs.isEmpty ? _buildEmpty() : _buildList(),
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
            const Icon(Icons.chevron_left, color: AppTheme.textPrimary, size: 22),
            Text('Notifikasi',
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
          ],
        ),
      ),
      leadingWidth: 140,
      actions: [
        if (_unreadCount > 0)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: _markAllAsRead,
                child: Text('Tandai semua dibaca',
                    style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildList() {
    final unread = _notifs.where((n) => !n.isRead).toList();
    final read = _notifs.where((n) => n.isRead).toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (unread.isNotEmpty) ...[
          _groupHeader('Belum Dibaca', unread.length),
          const SizedBox(height: 8),
          ...unread.map((n) => _buildCard(n)),
          const SizedBox(height: 16),
        ],
        if (read.isNotEmpty) ...[
          _groupHeader('Sudah Dibaca', null),
          const SizedBox(height: 8),
          ...read.map((n) => _buildCard(n)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _groupHeader(String label, int? count) {
    return Row(
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: AppTheme.dangerRed.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Text('$count', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.dangerRed)),
          ),
        ],
      ],
    );
  }

  Widget _buildCard(_NotifItem n) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: n.isRead ? AppTheme.cardWhite : n.color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14),
        border: n.isRead ? null : Border.all(color: n.color.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: n.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                child: Icon(n.icon, color: n.color, size: 22),
              ),
              if (!n.isRead)
                Positioned(
                  top: 0, right: 0,
                  child: Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(color: AppTheme.dangerRed, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: n.color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(n.kategori, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: n.color)),
                    ),
                    const Spacer(),
                    Text(n.waktu, style: GoogleFonts.poppins(fontSize: 10, color: AppTheme.textLight)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(n.judul, style: GoogleFonts.poppins(fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary)),
                const SizedBox(height: 4),
                Text(n.deskripsi, style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textSecondary, height: 1.4)),
                if (!n.isRead) ...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _markAsRead(n),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.done, size: 13, color: AppTheme.primaryBlue),
                            const SizedBox(width: 4),
                            Text('Tandai dibaca', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.primaryBlue)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64, color: AppTheme.textLight.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text('Tidak ada notifikasi', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 6),
          Text('Semua notifikasi akan muncul di sini.', style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textLight)),
        ],
      ),
    );
  }
}
