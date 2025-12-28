import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/controllers/parah_local_controller.dart';
import 'package:npapp/presentation/hq/parah_pdf_screen.dart';
import 'package:npapp/widgets/common/my_snack_bar.dart';
import 'package:npapp/widgets/parah/no_parah.dart';
import 'package:npapp/widgets/parah/parah_tile.dart';

class ParahListScreen extends StatefulWidget {
  const ParahListScreen({super.key});

  @override
  State<ParahListScreen> createState() => _ParahListScreenState();
}

class _ParahListScreenState extends State<ParahListScreen> {
  final ParahController controller = ParahController();
  final ParahLocalController localController = ParahLocalController();

  @override
  void initState() {
    super.initState();
    localController.init(); // initialize Hive
  }

  bool _hasPdf(String? url) => url != null && url.trim().isNotEmpty;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.listenParah(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text("No Parah Found"));

        final list = snapshot.data!;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final p = list[index];
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
                        builder: (_) => ParahPdfScreen(
                          parahNo: p.parahNo,
                          pdfUrl: p.pdfParah,
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    controller.deleteParah(p.id);
                  },
localSave: () async {
  try {
    await localController.init();

    final localPath =
        await localController.downloadParahPdf(p);

    await localController.saveParahPdfFromFirebase(
      p,
      localPath,
    );

    CustomSnackBar.roundedSnackBar(
      // ignore: use_build_context_synchronously
      context,
      "Parah saved for offline use",
    );
    debugPrint("Parah ${p.parahNo} saved locally at $localPath");
  } catch (e) {
    CustomSnackBar.roundedSnackBar(
      // ignore: use_build_context_synchronously
      context,
      "Failed to save Parah",

    );
    debugPrint("Error saving Parah locally: $e");
  }
},

                );
              }
              return NoParahTile(parahCount: p.parahNo);
            },
          ),
        );
      },
    );
  }
}
