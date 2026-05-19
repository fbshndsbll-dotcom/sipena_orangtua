import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/core/widgets/custom_app_bar.dart';

class ProgressPage extends StatefulWidget {
  final int initialTab;
  const ProgressPage({super.key, this.initialTab = 0});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void didUpdateWidget(ProgressPage old) {
    super.didUpdateWidget(old);
    if (widget.initialTab != old.initialTab) {
      _tab.animateTo(widget.initialTab);
    }
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 48),
        child: Column(
          children: [
            const CustomAppBar(title: 'Progres Anak'),
            Container(
              color: AppTheme.cardWhite,
              child: TabBar(
                controller: _tab,
                labelColor: AppTheme.primaryBlue,
                unselectedLabelColor: AppTheme.textLight,
                indicatorColor: AppTheme.primaryBlue,
                indicatorWeight: 3,
                labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
                tabs: const [
                  Tab(text: 'Tugas'),
                  Tab(text: 'Absensi'),
                  Tab(text: 'Rekap Nilai'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _TugasTab(),
          _AbsensiTab(),
          _RekapNilaiTab(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// TAB 1 — TUGAS
// ─────────────────────────────────────────────────────────
class _TugasTab extends StatelessWidget {
  final List<Map<String, dynamic>> _tugas = const [
    {'tgl': 25, 'bln': 'Apr', 'mapel': 'Matematika', 'desk': 'Latihan persamaan linear', 'late': false},
    {'tgl': 30, 'bln': 'Apr', 'mapel': 'Bahasa Indonesia', 'desk': 'Resensi buku fiksi', 'late': false},
    {'tgl': 5,  'bln': 'Mei', 'mapel': 'Sejarah', 'desk': 'Esai kemerdekaan', 'late': true},
    {'tgl': 12, 'bln': 'Mei', 'mapel': 'Fisika', 'desk': 'Laporan praktikum gelombang', 'late': false},
    {'tgl': 20, 'bln': 'Mei', 'mapel': 'Kimia', 'desk': 'Rangkuman larutan asam basa', 'late': false},
  ];

  const _TugasTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Counter card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.accentOrange, Color(0xFFFF8C5A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.accentOrange.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tugas yang belum\ndiselesaikan', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text('${_tugas.length}', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48, height: 1)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.assignment_outlined, color: Colors.white, size: 36),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Daftar Tugas', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.textPrimary)),
          ),
          const SizedBox(height: 8),
          ..._tugas.map((t) => _TugasCard(
                tanggal: t['tgl'],
                bulan: t['bln'],
                mapel: t['mapel'],
                deskripsi: t['desk'],
                isLate: t['late'],
              )),
          if (_tugas.any((t) => t['late'] == true))
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3CD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.warningYellow.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppTheme.warningYellow, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Ada tugas melewati batas waktu! Segera kumpulkan.',
                        style: GoogleFonts.poppins(fontSize: 12, color: Color(0xFF856404))),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _TugasCard extends StatelessWidget {
  final int tanggal;
  final String bulan, mapel, deskripsi;
  final bool isLate;

  const _TugasCard({
    required this.tanggal,
    required this.bulan,
    required this.mapel,
    required this.deskripsi,
    required this.isLate,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLate ? AppTheme.dangerRed : AppTheme.accentOrange;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text('$tanggal', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
                Text(bulan, style: GoogleFonts.poppins(fontSize: 10, color: color)),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(mapel, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary)),
                    if (isLate) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppTheme.dangerRed.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text('Terlambat', style: GoogleFonts.poppins(fontSize: 10, color: AppTheme.dangerRed, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ],
                ),
                Text(deskripsi, style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
                const SizedBox(height: 4),
                Text(
                  'Terakhir: $tanggal $bulan 2026',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.textLight, size: 20),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// TAB 2 — ABSENSI
// ─────────────────────────────────────────────────────────
class _AbsensiTab extends StatefulWidget {
  const _AbsensiTab();
  @override
  State<_AbsensiTab> createState() => _AbsensiTabState();
}

class _AbsensiTabState extends State<_AbsensiTab>
    with SingleTickerProviderStateMixin {
  late TabController _sub;
  DateTime _calendarMonth = DateTime(2026, 5);
  DateTime? _selectedDate;

  // Status: 'hadir','alfa','sakit','izin','dispen'
  // Key: DateTime(year, month, day)
  final Map<DateTime, Map<String, dynamic>> _absenData = {
    DateTime(2026, 5, 1): {'status': 'hadir', 'detail': [
      {'mapel': 'Matematika', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'Bahasa Indonesia', 'jam': '08:30-10:00', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 5): {'detail': [
      {'mapel': 'Matematika', 'jam': '07:00-08:30', 'status': 'Alpha'},
      {'mapel': 'Bahasa Indonesia', 'jam': '08:30-10:00', 'status': 'Hadir'},
      {'mapel': 'Sejarah', 'jam': '10:15-11:45', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 6): {'status': 'hadir', 'detail': [
      {'mapel': 'Sejarah', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'Fisika', 'jam': '09:00-10:30', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 7): {'detail': [
      {'mapel': 'Kimia', 'jam': '07:00-08:30', 'status': 'Sakit'},
      {'mapel': 'Bahasa Inggris', 'jam': '09:00-10:30', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 8): {'status': 'hadir', 'detail': [
      {'mapel': 'PKN', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'Agama', 'jam': '09:00-10:00', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 12): {'status': 'alfa', 'detail': [
      {'mapel': 'Matematika', 'jam': '07:00-08:30', 'status': 'Alpha'},
    ]},
    DateTime(2026, 5, 13): {'status': 'hadir', 'detail': [
      {'mapel': 'Bahasa Indonesia', 'jam': '08:30-10:00', 'status': 'Hadir'},
      {'mapel': 'Sejarah', 'jam': '10:15-11:45', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 14): {'status': 'izin', 'detail': [
      {'mapel': 'Fisika', 'jam': '07:00-08:30', 'status': 'Izin'},
      {'mapel': 'Kimia', 'jam': '09:00-10:30', 'status': 'Izin'},
    ]},
    DateTime(2026, 5, 15): {'status': 'hadir', 'detail': [
      {'mapel': 'Bahasa Inggris', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'Matematika', 'jam': '09:00-10:30', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 19): {'status': 'dispen', 'detail': [
      {'mapel': 'PKN', 'jam': '07:00-08:30', 'status': 'Dispen'},
      {'mapel': 'Agama', 'jam': '09:00-10:00', 'status': 'Dispen'},
    ]},
    DateTime(2026, 5, 20): {'status': 'hadir', 'detail': [
      {'mapel': 'Matematika', 'jam': '07:00-08:30', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 21): {'status': 'hadir', 'detail': [
      {'mapel': 'Sejarah', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'Bahasa Indonesia', 'jam': '09:00-10:30', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 22): {'status': 'sakit', 'detail': [
      {'mapel': 'Fisika', 'jam': '07:00-08:30', 'status': 'Sakit'},
    ]},
    DateTime(2026, 5, 26): {'status': 'hadir', 'detail': [
      {'mapel': 'Kimia', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'Bahasa Inggris', 'jam': '09:00-10:30', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 27): {'status': 'hadir', 'detail': [
      {'mapel': 'Matematika', 'jam': '07:00-08:30', 'status': 'Hadir'},
      {'mapel': 'PKN', 'jam': '09:00-10:00', 'status': 'Hadir'},
    ]},
    DateTime(2026, 5, 28): {'status': 'alfa', 'detail': [
      {'mapel': 'Agama', 'jam': '07:00-08:30', 'status': 'Alpha'},
      {'mapel': 'Sejarah', 'jam': '09:00-10:30', 'status': 'Alpha'},
    ]},
    DateTime(2026, 5, 29): {'status': 'hadir', 'detail': [
      {'mapel': 'Bahasa Indonesia', 'jam': '07:00-08:30', 'status': 'Hadir'},
    ]},
  };

  final List<Map<String, dynamic>> _alpa = const [
    {'tgl': '12 April 2026', 'mapel': 'Matematika', 'jam': '07.00 - 08.30'},
    {'tgl': '18 April 2026', 'mapel': 'Bahasa Indonesia', 'jam': '08.30 - 10.00'},
    {'tgl': '25 April 2026', 'mapel': 'Sejarah', 'jam': '10.15 - 11.45'},
  ];

  final Set<int> _expandedIndices = {};

  final List<Map<String, dynamic>> _rekapMapel = [
    {
      'mapel': 'Matematika', 'hadir': 18, 'alfa': 1, 'izin': 0, 'sakit': 1, 'total': 20,
      'history': [
        {'jenis': 'Alpha', 'hari': 'Senin', 'tgl': '12 Mei 2026', 'jam': '07:00 - 08:30', 'ket': 'Tidak hadir tanpa izin'},
        {'jenis': 'Sakit', 'hari': 'Rabu',  'tgl': '14 Mei 2026', 'jam': '10:00 - 11:30', 'ket': 'Surat izin sakit diterima'},
      ],
    },
    {
      'mapel': 'Bahasa Indonesia', 'hadir': 19, 'alfa': 1, 'izin': 0, 'sakit': 0, 'total': 20,
      'history': [
        {'jenis': 'Alpha', 'hari': 'Kamis', 'tgl': '18 April 2026', 'jam': '08:30 - 10:00', 'ket': 'Tidak hadir tanpa izin'},
      ],
    },
    {
      'mapel': 'Sejarah', 'hadir': 17, 'alfa': 1, 'izin': 1, 'sakit': 1, 'total': 20,
      'history': [
        {'jenis': 'Alpha', 'hari': 'Selasa', 'tgl': '22 April 2026', 'jam': '10:15 - 11:45', 'ket': 'Tidak hadir tanpa izin'},
        {'jenis': 'Izin',  'hari': 'Jumat',  'tgl': '2 Mei 2026',    'jam': '07:00 - 08:30', 'ket': 'Keperluan keluarga'},
        {'jenis': 'Sakit', 'hari': 'Senin',  'tgl': '12 Mei 2026',   'jam': '10:15 - 11:45', 'ket': 'Surat izin sakit diterima'},
      ],
    },
    {'mapel': 'Fisika',         'hadir': 20, 'alfa': 0, 'izin': 0, 'sakit': 0, 'total': 20, 'history': []},
    {
      'mapel': 'Kimia',         'hadir': 19, 'alfa': 0, 'izin': 1, 'sakit': 0, 'total': 20,
      'history': [
        {'jenis': 'Izin', 'hari': 'Rabu', 'tgl': '7 Mei 2026', 'jam': '08:30 - 10:00', 'ket': 'Keperluan keluarga'},
      ],
    },
    {
      'mapel': 'Bahasa Inggris', 'hadir': 18, 'alfa': 0, 'izin': 1, 'sakit': 1, 'total': 20,
      'history': [
        {'jenis': 'Izin',  'hari': 'Kamis', 'tgl': '15 Mei 2026', 'jam': '07:00 - 08:30', 'ket': 'Keperluan keluarga'},
        {'jenis': 'Sakit', 'hari': 'Selasa','tgl': '20 Mei 2026', 'jam': '10:00 - 11:30', 'ket': 'Surat izin sakit diterima'},
      ],
    },
    {'mapel': 'PKN',   'hadir': 20, 'alfa': 0, 'izin': 0, 'sakit': 0, 'total': 20, 'history': []},
    {
      'mapel': 'Agama', 'hadir': 19, 'alfa': 0, 'izin': 0, 'sakit': 1, 'total': 20,
      'history': [
        {'jenis': 'Sakit', 'hari': 'Senin', 'tgl': '19 Mei 2026', 'jam': '07:00 - 08:30', 'ket': 'Surat izin sakit diterima'},
      ],
    },
  ];

  int get _totalHadir => _rekapMapel.fold(0, (s, m) => s + (m['hadir'] as int));
  int get _totalAlfa  => _rekapMapel.fold(0, (s, m) => s + (m['alfa']  as int));
  int get _totalIzin  => _rekapMapel.fold(0, (s, m) => s + (m['izin']  as int));
  int get _totalSakit => _rekapMapel.fold(0, (s, m) => s + (m['sakit'] as int));
  int get _totalPertemuan => _rekapMapel.fold(0, (s, m) => s + (m['total'] as int));

  @override
  void initState() {
    super.initState();
    _sub = TabController(length: 3, vsync: this, initialIndex: 2);
    _sub.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _sub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppTheme.cardWhite,
          child: TabBar(
            controller: _sub,
            labelColor: AppTheme.primaryBlue,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.primaryBlue,
            indicatorWeight: 2.5,
            labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
            tabs: const [
              Tab(text: 'Notifikasi Alpha'),
              Tab(text: 'Kalender'),
              Tab(text: 'Rekap Absensi'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _sub,
            children: [
              _buildAlpaList(),
              _buildKalender(),
              _buildRekapAbsensi(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlpaList() {
    if (_alpa.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline, color: AppTheme.successGreen, size: 52),
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada notifikasi alpha ✓',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              'Anak Anda selalu hadir tepat waktu!',
              style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _alpa.length,
      itemBuilder: (_, i) {
        final item = _alpa[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.cardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.dangerRed.withOpacity(0.2)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppTheme.dangerRed.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.event_busy, color: AppTheme.dangerRed, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['mapel'], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary)),
                    Text(item['tgl'], style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
                    Text(item['jam'], style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textLight)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.dangerRed.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text('Alfa', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.dangerRed)),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildKalender() {
    final List<String> dayLabels = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final firstDay = DateTime(_calendarMonth.year, _calendarMonth.month, 1);
    // weekday: 1=Mon ... 7=Sun
    final startOffset = firstDay.weekday - 1;
    final daysInMonth = DateTime(_calendarMonth.year, _calendarMonth.month + 1, 0).day;
    final List<String> monthNames = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

    Color statusColor(String s) {
      switch (s.toLowerCase()) {
        case 'hadir':  return AppTheme.successGreen;
        case 'alpha':  return AppTheme.dangerRed;
        case 'sakit':  return const Color(0xFFFF8C5A);
        case 'izin':   return AppTheme.warningYellow;
        case 'dispen': return AppTheme.infoBlue;
        default:       return AppTheme.successGreen;
      }
    }

    // Hitung status paling berat dari list detail
    String dominantStatus(List detail) {
      const priority = ['alpha', 'sakit', 'izin', 'dispen', 'hadir'];
      String best = 'hadir';
      for (final p in priority) {
        if (detail.any((d) => (d as Map)['status'].toString().toLowerCase() == p)) {
          best = p;
          break;
        }
      }
      return best;
    }

    void showDetail(BuildContext ctx, DateTime date) {
      final key = DateTime(date.year, date.month, date.day);
      final data = _absenData[key];
      if (data == null) return;
      final List detail = data['detail'] as List;
      final String dominant = dominantStatus(detail);
      final Color sc = statusColor(dominant);
      final String dominantLabel = dominant[0].toUpperCase() + dominant.substring(1);
      showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: sc.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.event_note_outlined, color: sc, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${date.day} ${monthNames[date.month]} ${date.year}',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.textPrimary)),
                      Text(dominantLabel,
                          style: GoogleFonts.poppins(fontSize: 12, color: sc, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Detail per Jam Pelajaran',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
              const SizedBox(height: 10),
              ...List.generate(detail.length, (i) {
                final d = detail[i] as Map;
                final String ds = d['status'] as String;
                final Color dc = statusColor(ds);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8, height: 8,
                        margin: const EdgeInsets.only(right: 10, top: 2),
                        decoration: BoxDecoration(color: dc, shape: BoxShape.circle),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d['mapel'] as String,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary)),
                            Text(d['jam'] as String,
                                style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textLight)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: dc.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                        child: Text(ds, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: dc)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      );
    }

    return Builder(
      builder: (ctx) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Kartu kalender ────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
              ),
              child: Column(
                children: [
                  // Navigasi bulan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _calendarMonth = DateTime(_calendarMonth.year, _calendarMonth.month - 1)),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: AppTheme.backgroundGrey, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.chevron_left, color: AppTheme.textPrimary, size: 20),
                        ),
                      ),
                      Text(
                        '${monthNames[_calendarMonth.month]} ${_calendarMonth.year}',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.textPrimary),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _calendarMonth = DateTime(_calendarMonth.year, _calendarMonth.month + 1)),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: AppTheme.backgroundGrey, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.chevron_right, color: AppTheme.textPrimary, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Header hari
                  Row(
                    children: dayLabels.map((d) => Expanded(
                      child: Center(
                        child: Text(d, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600,
                            color: (d == 'Min') ? AppTheme.dangerRed : AppTheme.textSecondary)),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 8),
                  // Grid tanggal
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: startOffset + daysInMonth,
                    itemBuilder: (_, idx) {
                      if (idx < startOffset) return const SizedBox();
                      final day = idx - startOffset + 1;
                      final date = DateTime(_calendarMonth.year, _calendarMonth.month, day);
                      final key = DateTime(date.year, date.month, date.day);
                      final entry = _absenData[key];
                      final List? detail = entry?['detail'] as List?;
                      final String? dominant = detail != null ? dominantStatus(detail) : null;
                      final bool hasAbsence = dominant != null && dominant != 'hadir';
                      final Color dot = dominant != null ? statusColor(dominant) : Colors.transparent;
                      final bool isSelected = _selectedDate != null &&
                          _selectedDate!.year == date.year &&
                          _selectedDate!.month == date.month &&
                          _selectedDate!.day == date.day;
                      final bool isSunday = date.weekday == 7;

                      return GestureDetector(
                        onTap: entry != null ? () {
                          setState(() => _selectedDate = date);
                          showDetail(ctx, date);
                        } : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (hasAbsence ? dot.withOpacity(0.1) : AppTheme.primaryBlue.withOpacity(0.08))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? Border.all(color: hasAbsence ? dot : AppTheme.primaryBlue, width: 1.5)
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$day',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: entry != null ? FontWeight.w600 : FontWeight.w400,
                                  color: isSunday ? AppTheme.dangerRed.withOpacity(0.7) : AppTheme.textPrimary,
                                ),
                              ),
                              if (detail != null) ...[
                                const SizedBox(height: 2),
                                Builder(builder: (_) {
                                  // Kumpulkan status unik, urutkan berdasarkan prioritas
                                  const order = ['alpha', 'sakit', 'izin', 'dispen', 'hadir'];
                                  final unique = order.where((p) => detail.any(
                                    (d) => (d as Map)['status'].toString().toLowerCase() == p,
                                  )).toList();
                                  // Maks 3 dot agar tidak terlalu penuh
                                  final dots = unique.take(3).toList();
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: dots.map((p) => Container(
                                      width: 5, height: 5,
                                      margin: const EdgeInsets.symmetric(horizontal: 1),
                                      decoration: BoxDecoration(color: statusColor(p), shape: BoxShape.circle),
                                    )).toList(),
                                  );
                                }),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // ── Legenda ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.cardWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _legendItem('Hadir', AppTheme.successGreen),
                  _legendItem('Izin', AppTheme.warningYellow),
                  _legendItem('Sakit', const Color(0xFFFF8C5A)),
                  _legendItem('Dispen', AppTheme.infoBlue),
                  _legendItem('Alpha', AppTheme.dangerRed),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // ── Info ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.touch_app_outlined, color: AppTheme.primaryBlue, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Ketuk tanggal untuk melihat detail kehadiran per jam pelajaran.',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.primaryBlue)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget _buildRekapAbsensi() {
    final persen = _totalPertemuan > 0 ? _totalHadir / _totalPertemuan : 0.0;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.bar_chart_rounded, color: AppTheme.primaryBlue, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text('Rekap Kehadiran Keseluruhan',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _statBox('$_totalHadir', 'Total hadir', AppTheme.successGreen, Icons.person_outline),
                    const SizedBox(width: 10),
                    _statBox('$_totalAlfa', 'Total alpha', AppTheme.dangerRed, Icons.person_off_outlined),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _statBox('$_totalIzin', 'Total izin', AppTheme.warningYellow, Icons.assignment_outlined),
                    const SizedBox(width: 10),
                    _statBox('$_totalSakit', 'Total sakit', const Color(0xFFFF8C5A), Icons.medical_services_outlined),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kehadiran keseluruhan', style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textPrimary)),
                    Text('${(persen * 100).toStringAsFixed(0)}%',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.successGreen)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: persen,
                    minHeight: 10,
                    backgroundColor: AppTheme.dividerColor,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.successGreen),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$_totalHadir dari $_totalPertemuan pertemuan',
                        style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textLight)),
                    Text('Min. kehadiran: 75%', style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textLight)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: AppTheme.primaryBlue, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Ketuk mata pelajaran untuk melihat riwayat kehadiran per pertemuan lengkap dengan tanggal dan jam pelajaran.',
                    style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.primaryBlue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.format_list_bulleted, color: AppTheme.primaryBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Text('Per Mata Pelajaran', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(_rekapMapel.length, (idx) {
            final m = _rekapMapel[idx];
            final int hadir = m['hadir'] as int;
            final int total = m['total'] as int;
            final int alfa  = m['alfa']  as int;
            final int izin  = m['izin']  as int;
            final int sakit = m['sakit'] as int;
            final double pct = hadir / total;
            final bool hasAbsence = alfa > 0 || izin > 0 || sakit > 0;
            final bool isExpanded = _expandedIndices.contains(idx);
            final List history = (m['history'] as List?) ?? [];
            return GestureDetector(
              onTap: hasAbsence
                  ? () => setState(() {
                        if (isExpanded) _expandedIndices.remove(idx);
                        else _expandedIndices.add(idx);
                      })
                  : null,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppTheme.cardWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(m['mapel'], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.successGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('${(pct * 100).toStringAsFixed(0)}%',
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.successGreen)),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                isExpanded ? Icons.keyboard_arrow_up : Icons.chevron_right,
                                color: hasAbsence ? AppTheme.primaryBlue : AppTheme.textLight,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: pct,
                              minHeight: 7,
                              backgroundColor: AppTheme.dividerColor,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.successGreen),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              if (sakit > 0) _pill('Sakit ${sakit}x', const Color(0xFFFF8C5A)),
                              if (sakit > 0 && alfa > 0) const SizedBox(width: 6),
                              if (alfa > 0) _pill('Alpha ${alfa}x', AppTheme.dangerRed),
                              if (izin > 0) ...[const SizedBox(width: 6), _pill('Izin ${izin}x', AppTheme.warningYellow)],
                              const Spacer(),
                              Text('$hadir/$total pertemuan', style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textLight)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // ── Detail riwayat ketidakhadiran ─────────────
                    if (isExpanded && history.isNotEmpty) ...[  
                      const Divider(height: 1, color: AppTheme.dividerColor),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Riwayat ketidakhadiran',
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
                            const SizedBox(height: 10),
                            ...List.generate(history.length, (hi) {
                              final h = history[hi] as Map;
                              final bool isAlpha = h['jenis'] == 'Alpha';
                              final bool isSakit = h['jenis'] == 'Sakit';
                              final Color jColor = isAlpha
                                  ? AppTheme.dangerRed
                                  : isSakit
                                      ? const Color(0xFFFF8C5A)
                                      : AppTheme.warningYellow;
                              return Padding(
                                padding: EdgeInsets.only(bottom: hi < history.length - 1 ? 12 : 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: jColor.withOpacity(0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isAlpha ? Icons.close : isSakit ? Icons.medical_services_outlined : Icons.edit_note,
                                        color: jColor,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(h['jenis'] as String,
                                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: jColor)),
                                          Text('${h['hari']}, ${h['tgl']}',
                                              style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
                                          Text(h['ket'] as String,
                                              style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textLight)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 12, color: AppTheme.textLight),
                                        const SizedBox(width: 4),
                                        Text(h['jam'] as String,
                                            style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textSecondary)),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _statBox(String val, String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(val, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20, color: color)),
                Text(label, style: GoogleFonts.poppins(fontSize: 11, color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
    );
  }
}





// ─────────────────────────────────────────────────────────
// TAB 3 — REKAP NILAI
// ─────────────────────────────────────────────────────────
class _RekapNilaiTab extends StatefulWidget {
  const _RekapNilaiTab();

  @override
  State<_RekapNilaiTab> createState() => _RekapNilaiTabState();
}

class _RekapNilaiTabState extends State<_RekapNilaiTab> {
  int? _openIdx; // index mapel yang dibuka detailnya

  final List<Map<String, dynamic>> _mapel = const [
    {'nama': 'Matematika',       'tugas': 7,  'nilai': 81.7},
    {'nama': 'Bahasa Indonesia', 'tugas': 5,  'nilai': 90.7},
    {'nama': 'Sejarah',          'tugas': 3,  'nilai': 73.4},
    {'nama': 'Fisika',           'tugas': 7,  'nilai': 81.7},
    {'nama': 'Kimia',            'tugas': 7,  'nilai': 81.7},
    {'nama': 'Bahasa Inggris',   'tugas': 7,  'nilai': 81.7},
    {'nama': 'PKN',              'tugas': 7,  'nilai': 81.7},
    {'nama': 'Agama',            'tugas': 7,  'nilai': 81.7},
  ];

  final List<Map<String, dynamic>> _detailTugas = const [
    {'nama': 'Tugas 1', 'desk': 'Operasi Hitung Aljabar', 'nilai': 80.0, 'pending': false},
    {'nama': 'Tugas 2', 'desk': 'Operasi Hitung Aljabar', 'nilai': 81.0, 'pending': false},
    {'nama': 'Tugas 3', 'desk': 'Operasi Hitung Aljabar', 'nilai': 81.0, 'pending': false},
    {'nama': 'Tugas 4', 'desk': 'Operasi Hitung Aljabar', 'nilai': 81.0, 'pending': false},
    {'nama': 'Tugas 5', 'desk': 'Operasi Hitung Aljabar', 'nilai': 81.0, 'pending': false},
    {'nama': 'Tugas 6', 'desk': 'Operasi Hitung Aljabar', 'nilai': 81.0, 'pending': false},
    {'nama': 'Tugas 7', 'desk': 'Operasi Hitung Aljabar', 'nilai': 0.0,  'pending': true},
  ];

  double get _rataRata {
    double total = 0;
    for (final m in _mapel) total += (m['nilai'] as double);
    return total / _mapel.length;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kartu rata-rata
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.successGreen.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rekap Nilai', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
                      Text(_rataRata.toStringAsFixed(1), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 42, height: 1.1)),
                      const SizedBox(height: 4),
                      Text('dari semua mata pelajaran', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.bar_chart_rounded, color: Colors.white, size: 36),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(_openIdx == null ? 'Daftar Semua Mata Pelajaran' : 'Daftar Nilai Tugas — ${_mapel[_openIdx!]['nama']}',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.textPrimary)),
          ),
          const SizedBox(height: 8),

          if (_openIdx == null)
            // List mapel
            ..._mapel.asMap().entries.map((e) {
              final m = e.value;
              return GestureDetector(
                onTap: () => setState(() => _openIdx = e.key),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m['nama'], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary)),
                            Text('${m['tugas']} Tugas', style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Text((m['nilai'] as double).toStringAsFixed(1),
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.successGreen)),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: AppTheme.textLight, size: 20),
                    ],
                  ),
                ),
              );
            })
          else ...[
            // Tombol kembali
            GestureDetector(
              onTap: () => setState(() => _openIdx = null),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.chevron_left, color: AppTheme.primaryBlue, size: 18),
                    Text('Kembali ke daftar', style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.primaryBlue)),
                  ],
                ),
              ),
            ),
            // Detail nilai per tugas
            ..._detailTugas.map((t) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppTheme.cardWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['nama'], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textPrimary)),
                          Text(t['desk'], style: GoogleFonts.poppins(fontSize: 12, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    t['pending'] == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppTheme.warningYellow.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                            child: Text('Belum Dinilai', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.warningYellow)),
                          )
                        : Text('${(t['nilai'] as double).toInt()}',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.successGreen)),
                  ],
                ),
              );
            }),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
