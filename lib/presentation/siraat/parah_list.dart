// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/presentation/hq/parah_pdf_screen.dart';
import 'package:npapp/services/auth_services.dart';
import 'package:npapp/widgets/parah_download.dart';
import 'package:npapp/widgets/parah_tile.dart';

class ParahListScreen extends StatefulWidget {
  const ParahListScreen({super.key});

  @override
  State<ParahListScreen> createState() => _ParahListScreenState();
}

class _ParahListScreenState extends State<ParahListScreen> {
  final ParahController controller = ParahController();
  final AuthServices authService = AuthServices();

  bool _hasPdf(String? url) {
    return url != null && url.trim().isNotEmpty;
  }

  Future<void> _onRefresh() async {
    // UX delay so refresh feels natural
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {}); // rebuilds StreamBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.listenParah(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error connecting: ${snapshot.error}",
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No Parah Found", style: TextStyle(fontSize: 18)),
          );
        }
        final list = snapshot.data!;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final p = list[index];
              // ✅ PDF EXISTS
              if (_hasPdf(p.pdfParah)) {
                return ShowParahTile(
                  engName: p.engName,
                  arabicName: p.arabicName,
                  typeArea: p.typeArea,
                  parahNo: p.parahNo,
                  pageCount: p.pageCount,
                  ayatCount: p.ayatCount,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ParahPdfScreen(
                              parahNo: p.parahNo,
                              pdfUrl: p.pdfParah,
                            ),
                      ),
                    );
                  },
                  onDelete: () {
                    controller.deleteParah(p.id);
                  },
                );
              }
              // ❌ PDF NOT FOUND
              return NoPDFParahTile(parahCount: p.parahNo);
            },
          ),
        );
      },
    );
  }
}
