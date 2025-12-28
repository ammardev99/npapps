// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:npapp/data/models/parah_model.dart';

class PdfQuranPakServices {
  final CollectionReference parahRef = FirebaseFirestore.instance.collection(
    "pdf_parah",
  );

  Future<Map<String, dynamic>> addParah(ParahModel model) async {
    try {
      DocumentReference doc = await parahRef.add(model.toMap());

      print("STATUS: Parah added successfully");
      return {"status": true, "id": doc.id};
    } catch (e) {
      print("ERROR (addParah): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteParah(String id) async {
    try {
      await parahRef.doc(id).delete();
      print("STATUS: Parah deleted successfully");
      return {"status": true};
    } catch (e) {
      print("ERROR (deleteParah): $e");
      return {"status": false, "message": e.toString()};
    }
  }

  Stream<List<ParahModel>> getAllParah() {
    return parahRef
        .orderBy("parahNo") // Order by Parah number ascending
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) => ParahModel.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();
        });
  }
}
