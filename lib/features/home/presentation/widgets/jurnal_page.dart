import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/core/widgets/custom_app_bar.dart';
import 'package:sipena_orangtua/core/widgets/custom_segmented_tab.dart';

class JurnalPage extends StatefulWidget {
  const JurnalPage({super.key});

  @override
  State<JurnalPage> createState() => _JurnalPageState();
}

class _JurnalPageState extends State<JurnalPage> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _nilaiData = [
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'nilai': 90, 'naik': true},
    {'mapel': 'Procedure Text', 'guru': 'Bu Vivi Sp.d', 'nilai': 78, 'naik': false},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'nilai': 90, 'naik': true},
    {'mapel': 'Procedure Text', 'guru': 'Bu Vivi Sp.d', 'nilai': 78, 'naik': false},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'nilai': 90, 'naik': true},
    {'mapel': 'Procedure Text', 'guru': 'Bu Vivi Sp.d', 'nilai': 78, 'naik': false},
  ];

  final List<Map<String, dynamic>> _tugasData = [
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'status': 'Dikumpulkan', 'collected': true},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'status': 'Belum Dikumpulkan', 'collected': false},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'status': 'Dikumpulkan', 'collected': true},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'status': 'Belum Dikumpulkan', 'collected': false},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'status': 'Dikumpulkan', 'collected': true},
    {'mapel': 'Geometri', 'guru': 'Bu Vivi Sp.d', 'status': 'Belum Dikumpulkan', 'collected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: const CustomAppBar(title: 'Jurnal Siswa'),
      body: Column(
        children: [
          CustomSegmentedTab(
            tabs: const ['Rekap Nilai', 'Rekap Tugas'],
            selectedIndex: _selectedTab,
            onTabChanged: (i) => setState(() => _selectedTab = i),
          ),
          _buildSemesterDropdown(),
          _buildTableHeader(),
          Expanded(
            child: _selectedTab == 0
                ? _buildRekapNilaiList()
                : _buildRekapTugasList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.dividerColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Semester Genap 2025/2026',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  _selectedTab == 0 ? 'Perubahan' : 'Status',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            if (_selectedTab == 0)
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

  Widget _buildRekapNilaiList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _nilaiData.length,
      itemBuilder: (context, i) {
        final item = _nilaiData[i];
        return _buildNilaiItem(item);
      },
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
                    color: AppTheme.accentOrange,
                  ),
                ),
                Text(
                  item['guru'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Icon(
                item['naik'] ? Icons.arrow_upward : Icons.arrow_downward,
                color: item['naik'] ? AppTheme.successGreen : AppTheme.dangerRed,
                size: 20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '${item['nilai']}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRekapTugasList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _tugasData.length,
      itemBuilder: (context, i) {
        final item = _tugasData[i];
        return _buildTugasItem(item);
      },
    );
  }

  Widget _buildTugasItem(Map<String, dynamic> item) {
    final bool collected = item['collected'];
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
            child: const Icon(Icons.assignment_outlined, color: AppTheme.primaryBlue, size: 18),
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
                  item['guru'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: collected
                      ? AppTheme.successGreen.withOpacity(0.12)
                      : AppTheme.dangerRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['status'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: collected ? AppTheme.successGreen : AppTheme.dangerRed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
