import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/core/widgets/custom_app_bar.dart';
import 'package:sipena_orangtua/core/widgets/custom_segmented_tab.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _nilaiData = [
    {'mapel': 'Sejarah', 'subtitle': 'Rata Rata Nilai', 'nilai': 90},
    {'mapel': 'Matematika', 'subtitle': 'Rata Rata Nilai', 'nilai': 67},
    {'mapel': 'Bahasa Indonesia', 'subtitle': 'Rata Rata Nilai', 'nilai': 85},
    {'mapel': 'Bahasa Indonesia', 'subtitle': 'Rata Rata Nilai', 'nilai': 80},
    {'mapel': 'Agama', 'subtitle': 'Rata Rata Nilai', 'nilai': 80},
    {'mapel': 'PPKN', 'subtitle': 'Rata Rata Nilai', 'nilai': 89},
  ];

  final List<Map<String, dynamic>> _absensiDetail = [
    {'tanggal': '27 April 2026', 'status': 'Hadir', 'color': 0xFF22C55E},
    {'tanggal': '28 April 2026', 'status': 'Izin', 'color': 0xFFF59E0B},
    {'tanggal': '29 April 2026', 'status': 'Hadir', 'color': 0xFF22C55E},
    {'tanggal': '29 April 2026', 'status': 'Hadir', 'color': 0xFF22C55E},
    {'tanggal': '30 April 2026', 'status': 'Alpha', 'color': 0xFFEF4444},
  ];

  final List<Map<String, dynamic>> _tugasTerlewat = [
    {
      'judul': 'Laporan Praktikum Inheritance',
      'kategori': 'Kejuruan',
      'deadline': 'Deadline: 1 Mei 2026',
    },
    {
      'judul': 'Laporan Praktikum Inheritance',
      'kategori': 'Kejuruan',
      'deadline': 'Deadline: 1 Mei 2026',
    },
    {
      'judul': 'Laporan Praktikum Inheritance',
      'kategori': 'Kejuruan',
      'deadline': 'Deadline: 1 Mei 2026',
    },
    {
      'judul': 'Laporan Praktikum Inheritance',
      'kategori': 'Kejuruan',
      'deadline': 'Deadline: 1 Mei 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: const CustomAppBar(title: 'Progress Anak'),
      body: Column(
        children: [
          CustomSegmentedTab(
            tabs: const ['Rekap Tugas', 'Absensi', 'Tugas Terlewat'],
            selectedIndex: _selectedTab,
            onTabChanged: (i) => setState(() => _selectedTab = i),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildRekapTugasTab(),
                _buildAbsensiTab(),
                _buildTugasTerlewatTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================== TAB 1: REKAP TUGAS/NILAI =====================
  Widget _buildRekapTugasTab() {
    return Column(
      children: [
        _buildNilaiTableHeader(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _nilaiData.length,
            itemBuilder: (_, i) => _buildNilaiItem(_nilaiData[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildNilaiTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Mata Pelajaran',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Perubahan',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Nilai',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNilaiItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.backgroundGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.menu_book, color: AppTheme.primaryBlue, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['mapel'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  item['subtitle'],
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: const SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${item['nilai']}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, size: 18, color: AppTheme.textLight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================== TAB 2: ABSENSI =====================
  Widget _buildAbsensiTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rekapan Absen Bulan Ini',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          // Month dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'April',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 18),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              _buildAbsensiStatCard('Hadir', '20', const Color(0xFF1565C0)),
              const SizedBox(width: 12),
              _buildAbsensiStatCard('Izin', '5', AppTheme.warningYellow),
              const SizedBox(width: 12),
              _buildAbsensiStatCard('Alpha', '1', AppTheme.dangerRed),
            ],
          ),
          const SizedBox(height: 20),
          // Pie chart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: 20,
                          color: const Color(0xFF1565C0),
                          radius: 50,
                          title: '',
                        ),
                        PieChartSectionData(
                          value: 5,
                          color: AppTheme.warningYellow,
                          radius: 50,
                          title: '',
                        ),
                        PieChartSectionData(
                          value: 1,
                          color: AppTheme.dangerRed,
                          radius: 50,
                          title: '',
                        ),
                      ],
                      centerSpaceRadius: 36,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(const Color(0xFF1565C0), 'Hadir', '20 (87%)'),
                    const SizedBox(height: 8),
                    _buildLegendItem(AppTheme.warningYellow, 'Izin', '2 (9%)'),
                    const SizedBox(height: 8),
                    _buildLegendItem(AppTheme.dangerRed, 'Alpha', '1 (4%)'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Detail Kehadiran
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Kehadiran',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                ..._absensiDetail.map((e) => _buildAbsensiDetailItem(e)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, String count) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label  $count',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildAbsensiDetailItem(Map<String, dynamic> item) {
    final color = Color(item['color']);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item['tanggal'],
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          Row(
            children: [
              Text(
                item['status'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===================== TAB 3: TUGAS TERLEWAT =====================
  Widget _buildTugasTerlewatTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._tugasTerlewat.map((e) => _buildTugasTerlewatItem(e)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.infoBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.infoBlue.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.infoBlue, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Segera Selesaikan Tugas yang terlewat agar nilai tidak terpengaruh.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppTheme.infoBlue,
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

  Widget _buildTugasTerlewatItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.warningYellow.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.warning_amber_rounded, color: AppTheme.warningYellow, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['judul'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  item['kategori'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  item['deadline'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.dangerRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Terlewat',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.dangerRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
