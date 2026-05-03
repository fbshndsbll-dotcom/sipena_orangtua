import 'package:flutter/material.dart';

class DashboardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFF0D47A1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dashboard Anak",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("Lihat semua",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),

          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              item("89.7", "Rata Rata Nilai"),
              item("89%", "Kehadiran"),
              item("0/20", "Tugas Selesai"),
            ],
          ),
        ],
      ),
    );
  }

  Widget item(String value, String title) {
    return Container(
      width: 90,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange)),
          SizedBox(height: 4),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}