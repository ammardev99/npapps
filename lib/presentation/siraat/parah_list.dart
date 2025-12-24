// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/services/auth_services.dart';
import 'package:npapp/widgets/parah_tile.dart';

class ParahListScreen extends StatelessWidget {
  ParahListScreen({super.key});

  final ParahController controller = ParahController();
  final AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parah List")),
      backgroundColor: Colors.grey.shade300,
      body: StreamBuilder(
        stream: controller.listenParah(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error connecting: ${snapshot.error}",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Parah Found",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
            );
          }

          final list = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final p = list[index];

              return ShowParahTile(
                engName: p.engName,
                arabicName: p.arabicName,
                typeArea: p.typeArea,
                parahNo: p.parahNo,
                pageCount: p.pageCount,
                ayatCount: p.ayatCount,
                onTap: () {
                  debugPrint("Open Parah ${p.parahNo}");
                },
                onDelete: () {
                  controller.deleteParah(p.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
