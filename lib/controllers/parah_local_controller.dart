import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:npapp/data/local/hive2/parah_local_model.dart';
import 'package:npapp/data/local/hive2/parah_local_service.dart';
import 'package:npapp/data/models/parah_model.dart';
import 'package:path_provider/path_provider.dart';

class ParahLocalController {
  final ParahLocalService localService = ParahLocalService();

  /// Initialize Hive
  Future<void> init() async {
    await localService.init();
    debugPrint(
      "Hive Parah Box Initialized with ${getAllParahs().length} items",
    );
  }

  /// Download PDF from Firebase URL and return local file path
Future<String> downloadParahPdf(ParahModel parah) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final localPath = '${dir.path}/parah_${parah.parahNo}.pdf';

    debugPrint("DOWNLOAD START -> ${parah.pdfParah}");
    debugPrint("LOCAL PATH -> $localPath");

    final dio = Dio();
    await dio.download(
      parah.pdfParah,
      localPath,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: true,
      ),
    );

    debugPrint("DOWNLOAD END -> Saved at $localPath");
    return localPath;
  } catch (e) {
    debugPrint("DOWNLOAD ERROR -> $e");
    rethrow;
  }
}


  /// Clear ONLY downloaded_parahs box
  Future<void> clearAllParahs() async {
    debugPrint("CLEAR START -> downloaded_parahs");
    await localService.clearAllParahs();
    debugPrint("CLEAR END -> downloaded_parahs is now empty");
  }

  /// Save Firebase Parah to local Hive
  Future<void> saveParahPdfFromFirebase(
    ParahModel firebaseParah,
    String localPath,
  ) async {
    final parah = ParahLocalModel(
      id: firebaseParah.id,
      title: firebaseParah.engName,
      arabicName: firebaseParah.arabicName,
      typeArea: firebaseParah.typeArea,
      parahNo: firebaseParah.parahNo,
      pageCount: firebaseParah.pageCount,
      ayatCount: firebaseParah.ayatCount,
      filePath: localPath,
      downloadDate: DateTime.now(),
    );

    debugPrint(
      "SAVE START -> id: ${firebaseParah.id} | title: ${firebaseParah.engName}",
    );

    await localService.saveParah(parah);

    debugPrint("SAVE END -> Parah saved locally");
  }

  /// Fetch all local Parahs
  List<ParahLocalModel> getAllParahs() {
    final list = localService.getAllParahs();
    debugPrint("FETCH -> ${list.length} local Parahs");
    return list;
  }

  /// Delete single Parah
  Future<void> deleteParah(String id) async {
    debugPrint("DELETE START -> id: $id");
    await localService.deleteParah(id);
    debugPrint(
      "DELETE END -> remaining ${getAllParahs().length} items",
    );
  }
}
