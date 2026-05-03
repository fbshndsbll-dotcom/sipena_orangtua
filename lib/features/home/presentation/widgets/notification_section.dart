import 'package:flutter/material.dart';

class NotificationSection extends StatelessWidget {
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Notifikasi Terbaru",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Lihat semua",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),

          SizedBox(height: 10),

          item("Tugas Bahasa Indonesia"),
          item("Tugas Bahasa Indonesia"),
          item("Tugas Bahasa Indonesia"),
        ],
      ),
    );
  }

  Widget item(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.notifications, color: Colors.orange),
      title: Text(title),
      subtitle: Text("2 jam yang lalu",
          style: TextStyle(fontSize: 12)),
    );
  }
}