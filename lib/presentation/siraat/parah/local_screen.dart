import 'dart:io';

import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_local_controller.dart';
import 'package:npapp/data/local/hive2/parah_local_model.dart';
import 'package:npapp/presentation/hq/parah_pdf_screen.dart';
import 'package:npapp/widgets/parah/no_parah.dart';
import 'package:npapp/widgets/parah/parah_tile.dart';

class LocalParahListScreen extends StatefulWidget {
  const LocalParahListScreen({super.key});

  @override
  State<LocalParahListScreen> createState() => _LocalParahListScreenState();
}

class _LocalParahListScreenState extends State<LocalParahListScreen> {
  final ParahLocalController localController = ParahLocalController();
  List<ParahLocalModel> localParahs = [];

  @override
  void initState() {
    super.initState();
    _loadLocalParahs();
  }

  Future<void> _loadLocalParahs() async {
    await localController.init();
    final list = localController.getAllParahs();
    if (mounted) {
      setState(() {
        localParahs = list.reversed.toList(); // optional: latest first
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadLocalParahs();
  }

  Future<void> _clearHiveBox() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Clear Local Data"),
        content: const Text(
            "Are you sure you want to delete all local Parah PDFs?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete All"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await localController.clearAllParahs();
      await _loadLocalParahs();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All local Parah data cleared."),
        ),
      );
    }
  }

  bool _fileExists(String path) => File(path).existsSync();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Parah List"),
        actions: [
          IconButton(
            onPressed: _clearHiveBox,
            icon: const Icon(Icons.delete_forever),
            tooltip: "Clear All Local Data",
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: localParahs.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 80),
                  Center(
                    child: Text(
                      "No Local Parah Found",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: localParahs.length,
                itemBuilder: (context, index) {
                  final p = localParahs[index];
                  if (_fileExists(p.filePath)) {
                    return ShowParahTile(
                      engName: p.title,
                      arabicName: p.arabicName,
                      typeArea: "Offline",
                      parahNo: index + 1,
                      pageCount: p.pageCount,
                      ayatCount: p.ayatCount,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ParahPdfScreen(
                              parahNo: index + 1,
                              pdfUrl: p.filePath,
                              isLocal: true,
                            ),
                          ),
                        );
                      },
                      onDelete: () async {
                        await localController.deleteParah(p.id);
                        await _loadLocalParahs();
                      },
                    );
                  }
                  return NoParahTile(parahCount: index + 1);
                },
              ),
      ),
    );
  }
}
