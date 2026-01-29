import 'dart:io';

import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/controllers/parah_local_controller.dart';
import 'package:npapp/data/models/parah_model.dart';
import 'package:npapp/data/local/hive2/parah_local_model.dart';
import 'package:npapp/widgets/parah/parah_tile.dart';
import 'package:npapp/widgets/parah/no_parah.dart';
import 'package:npapp/presentation/hq/parah_pdf_screen.dart';

class CombinedParahListScreen extends StatefulWidget {
  const CombinedParahListScreen({super.key});

  @override
  State<CombinedParahListScreen> createState() =>
      _CombinedParahListScreenState();
}

class _CombinedParahListScreenState extends State<CombinedParahListScreen> {
  final ParahController firebaseController = ParahController();
  final ParahLocalController localController = ParahLocalController();

  List<ParahLocalModel> localParahs = [];
  List<ParahModel> firebaseParahs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await localController.init();
    localParahs = localController.getAllParahs();

    firebaseController.listenParah().listen((list) {
      setState(() {
        firebaseParahs = list;
        loading = false;
      });
    });
  }

ParahLocalModel? _localByParahNo(int parahNo) {
  try {
    return localParahs.firstWhere((p) => p.parahNo == parahNo);
  } catch (e) {
    return null;
  }
}

ParahModel? _firebaseByParahNo(int parahNo) {
  try {
    return firebaseParahs.firstWhere((p) => p.parahNo == parahNo);
  } catch (e) {
    return null;
  }
}

  Future<String> downloadParahPdf(ParahModel parah) async {
    // Replace with real download logic; here we simulate a path
    String localPath = "/path/to/local/${parah.parahNo}.pdf";
    debugPrint("Downloading Parah ${parah.parahNo} to $localPath");
    return localPath;
  }

  Future<void> _refreshParahs() async {
    await localController.init();
    setState(() {
      localParahs = localController.getAllParahs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All 30 Parahs")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshParahs,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: 30,
                itemBuilder: (context, index) {
                  int parahNo = index + 1;

                  final local = _localByParahNo(parahNo);
                  final firebase = _firebaseByParahNo(parahNo);

                  // Local saved → show normally
                  if (local != null) {
                    return ShowParahTile(
                      engName: local.title,
                      arabicName: local.arabicName,
                      typeArea: local.typeArea,
                      parahNo: parahNo,
                      pageCount: local.pageCount,
                      ayatCount: local.ayatCount,
                      onTap: () {
                        if (File(local.filePath).existsSync()) {
                          debugPrint("Opening local PDF for Parah $parahNo");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ParahPdfScreen(
                                parahNo: local.parahNo,
                                pdfUrl: local.filePath,
                                isLocal: true,
                              ),
                            ),
                          );
                        } else if (firebase != null &&
                            firebase.pdfParah.isNotEmpty) {
                          debugPrint("Opening Firebase PDF for Parah $parahNo");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ParahPdfScreen(
                                parahNo: firebase.parahNo,
                                pdfUrl: firebase.pdfParah,
                                isLocal: false,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("PDF not available")),
                          );
                        }
                      },
                      onDelete: () async {
                        await localController.deleteParah(local.id);
                        setState(() {
                          localParahs.remove(local);
                        });
                      },
                    );
                  }

                  // Not in local, but in Firebase → show download button
                  if (firebase != null) {
                    return ShowParahTile(
                      engName: firebase.engName,
                      arabicName: firebase.arabicName,
                      typeArea: firebase.typeArea,
                      parahNo: parahNo,
                      pageCount: firebase.pageCount,
                      ayatCount: firebase.ayatCount,
                      onTap: () {},
                      localSave: () async {
                        String localPath =
                            await downloadParahPdf(firebase);
                        await localController.saveParahPdfFromFirebase(
                            firebase, localPath);
                        setState(() {
                          localParahs = localController.getAllParahs();
                        });
                      },
                    );
                  }

                  // Not in Firebase and not local → NoParahTile
                  return NoParahTile(
                    parahCount: parahNo,
                    showFirebaseInfo: firebase != null,
                  );
                },
              ),
            ),
    );
  }
}
