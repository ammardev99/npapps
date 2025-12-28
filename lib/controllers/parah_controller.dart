// ignore_for_file: avoid_print

import 'dart:io';
import 'package:npapp/data/models/parah_model.dart';
import 'package:npapp/services/pdf_quran_pak_services.dart';
import 'package:npapp/services/storage_service.dart';

class ParahController {
  final PdfQuranPakServices service = PdfQuranPakServices();
  final StorageService storageService = StorageService();

  // ADD PARAH WITH PDF
  Future<Map<String, dynamic>> addParahWithPdf({
    required int parahId,
    required String engName,
    required String arabicName,
    required String typeArea,
    required int parahNo,
    required int pageCount,
    required int ayatCount,
    required File pdfFile,
    required Function(double progress) onProgress,
  }) async {
    try {
      final uploadTask = storageService.uploadParahPdf(pdfFile, parahNo);

      uploadTask.snapshotEvents.listen((event) {
        final progress =
            event.bytesTransferred / event.totalBytes;
        onProgress(progress);
      });

      final snapshot = await uploadTask;
      final pdfUrl = await snapshot.ref.getDownloadURL();

      ParahModel model = ParahModel(
        id: "",
        parahId: parahId,
        engName: engName,
        arabicName: arabicName,
        typeArea: typeArea,
        parahNo: parahNo,
        pageCount: pageCount,
        ayatCount: ayatCount,
        pdfParah: pdfUrl,
      );

      return await service.addParah(model);
    } catch (e) {
      print("ERROR (ParahController.addParahWithPdf): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  // DELETE PARAH
  Future<Map<String, dynamic>> deleteParah(String id) async {
    return await service.deleteParah(id);
  }

  // LISTENER STREAM
  Stream<List<ParahModel>> listenParah() {
    return service.getAllParah();
  }
}
