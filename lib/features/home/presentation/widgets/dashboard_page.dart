import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipena_orangtua/config/app_theme.dart';
import 'package:sipena_orangtua/core/widgets/custom_app_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: const CustomAppBar(title: 'Dashboard'),
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
                  _buildDashboardAnakSection(),
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
                    color: Colors.white70,
                    fontSize: 13,
                  ),
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
                    color: Colors.white60,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            offset: const Offset(0, 2),
          ),
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
                child: const Icon(Icons.person_outline, color: AppTheme.primaryBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'Ringkasan Data Siswa',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
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
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Text(
            ': ',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
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
            child: Text(
              'Status',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Text(
            ': ',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Aktif',
              style: GoogleFonts.poppins(
                color: AppTheme.successGreen,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardAnakSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dashboard Anak',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Lihat semua >',
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildStatItem(Icons.bar_chart, '89.7', 'Rata Rata Nilai'),
              const SizedBox(width: 10),
              _buildStatItem(Icons.people_outline, '89%', 'Kehadiran'),
              const SizedBox(width: 10),
              _buildStatItem(Icons.assignment_outlined, '0/20', 'Tugas Selesai'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white70, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: AppTheme.accentOrange,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 9.5,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection() {
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
            offset: const Offset(0, 2),
          ),
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
                  Text(
                    'Notifikasi Terbaru',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Lihat semua',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildNotifItem('Tugas Bahasa Indonesia', '2 jam yang lalu'),
          _buildNotifItem('Tugas Bahasa Indonesia', '2 jam yang lalu'),
          _buildNotifItem('Tugas Bahasa Indonesia', '2 jam yang lalu'),
        ],
      ),
    );
  }

  Widget _buildNotifItem(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppTheme.accentOrange.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_outlined, color: AppTheme.accentOrange, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}