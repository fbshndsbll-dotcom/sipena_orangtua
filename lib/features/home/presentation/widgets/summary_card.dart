import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ringkasan Data Siswa",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          buildRow("Nama", "Asep Kopling"),
          buildRow("Kelas", "XI RPL 1"),
          buildRow("Wali Kelas", "Umi Kulsum"),
          buildStatus(),
        ],
      ),
    );
  }

  Widget buildRow(String t, String v) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t),
          Text(v, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Status"),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("Aktif",
              style: TextStyle(color: Colors.green, fontSize: 12)),
        )
      ],
    );
  }
}