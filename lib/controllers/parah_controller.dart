// ignore_for_file: avoid_print

import 'package:npapp/models/parah_model.dart';
import 'package:npapp/services/pdf_quran_pak_services.dart';

class ParahController {
  final PdfQuranPakServices service = PdfQuranPakServices();

  // ADD PARAH
  Future<Map<String, dynamic>> addParah({
    required int parahId,
    required String engName,
    required String arabicName,
    required String typeArea,
    required int parahNo,
    required int pageCount,
    required int ayatCount,
    required String pdfParah,
  }) async {
    try {
      ParahModel model = ParahModel(
        id: "",
        parahId: parahId,
        engName: engName,
        arabicName: arabicName,
        typeArea: typeArea,
        parahNo: parahNo,
        pageCount: pageCount,
        ayatCount: ayatCount,
        pdfParah: pdfParah,
      );

      return await service.addParah(model);
    } catch (e) {
      print("ERROR (ParahController.add): $e");
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
