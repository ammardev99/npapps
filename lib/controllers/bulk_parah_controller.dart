import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BulkParahController {
  final CollectionReference parahRef = FirebaseFirestore.instance.collection(
    "pdf_parah",
  );

  bool isLoading = false;

  /// Call this method to bulk add 30 Parah
  Future<void> addBulkParah(BuildContext context) async {
    if (isLoading) return; // prevent duplicate calls
    isLoading = true;

    final scaffold = ScaffoldMessenger.of(context);

    // Show loading SnackBar
    scaffold.showSnackBar(const SnackBar(content: Text("Adding 30 Parah…")));

    // Sample 30 Parah list
    final List<Map<String, dynamic>> parahList = List.generate(30, (index) {
      int parahNo = index + 1;
      return {
        "parahId": parahNo,
        "engName": "Parah $parahNo",
        "arabicName": "Value $parahNo", // replace later
        "typeArea": "Makki", // default
        "parahNo": parahNo,
        "pageCount": 0,
        "ayatCount": 0,
        "pdfParah": "",
      };
    });

    int successCount = 0;

    for (var p in parahList) {
      try {
        await parahRef.add(p);
        debugPrint("Added Parah: ${p['engName']}");
        successCount++;
      } catch (e) {
        debugPrint("Error adding ${p['engName']}: $e");
      }
    }

    isLoading = false;

    scaffold.showSnackBar(
      SnackBar(
        content: Text("Bulk add complete! Added $successCount of 30 Parah."),
      ),
    );
  }
}

// FloatingActionButton(
//   onPressed: () async {
//     final bulkController = BulkParahController();
//     await bulkController.addBulkParah(context);
//   },
//   child: const Icon(Icons.upload),
// )

final List<Map<String, dynamic>> parahList = [
  {
    "parahId": 1,
    "engName": "Parah 1",
    "arabicName": "Value 1",
    "typeArea": "Makki",
    "parahNo": 1,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 2,
    "engName": "Parah 2",
    "arabicName": "Value 2",
    "typeArea": "Makki",
    "parahNo": 2,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 3,
    "engName": "Parah 3",
    "arabicName": "Value 3",
    "typeArea": "Makki",
    "parahNo": 3,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 4,
    "engName": "Parah 4",
    "arabicName": "Value 4",
    "typeArea": "Makki",
    "parahNo": 4,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 5,
    "engName": "Parah 5",
    "arabicName": "Value 5",
    "typeArea": "Makki",
    "parahNo": 5,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 6,
    "engName": "Parah 6",
    "arabicName": "Value 6",
    "typeArea": "Makki",
    "parahNo": 6,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 7,
    "engName": "Parah 7",
    "arabicName": "Value 7",
    "typeArea": "Makki",
    "parahNo": 7,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 8,
    "engName": "Parah 8",
    "arabicName": "Value 8",
    "typeArea": "Makki",
    "parahNo": 8,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 9,
    "engName": "Parah 9",
    "arabicName": "Value 9",
    "typeArea": "Makki",
    "parahNo": 9,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 10,
    "engName": "Parah 10",
    "arabicName": "Value 10",
    "typeArea": "Makki",
    "parahNo": 10,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 11,
    "engName": "Parah 11",
    "arabicName": "Value 11",
    "typeArea": "Makki",
    "parahNo": 11,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 12,
    "engName": "Parah 12",
    "arabicName": "Value 12",
    "typeArea": "Makki",
    "parahNo": 12,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 13,
    "engName": "Parah 13",
    "arabicName": "Value 13",
    "typeArea": "Makki",
    "parahNo": 13,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 14,
    "engName": "Parah 14",
    "arabicName": "Value 14",
    "typeArea": "Makki",
    "parahNo": 14,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 15,
    "engName": "Parah 15",
    "arabicName": "Value 15",
    "typeArea": "Makki",
    "parahNo": 15,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 16,
    "engName": "Parah 16",
    "arabicName": "Value 16",
    "typeArea": "Makki",
    "parahNo": 16,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 17,
    "engName": "Parah 17",
    "arabicName": "Value 17",
    "typeArea": "Makki",
    "parahNo": 17,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 18,
    "engName": "Parah 18",
    "arabicName": "Value 18",
    "typeArea": "Makki",
    "parahNo": 18,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 19,
    "engName": "Parah 19",
    "arabicName": "Value 19",
    "typeArea": "Makki",
    "parahNo": 19,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 20,
    "engName": "Parah 20",
    "arabicName": "Value 20",
    "typeArea": "Makki",
    "parahNo": 20,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 21,
    "engName": "Parah 21",
    "arabicName": "Value 21",
    "typeArea": "Makki",
    "parahNo": 21,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 22,
    "engName": "Parah 22",
    "arabicName": "Value 22",
    "typeArea": "Makki",
    "parahNo": 22,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 23,
    "engName": "Parah 23",
    "arabicName": "Value 23",
    "typeArea": "Makki",
    "parahNo": 23,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 24,
    "engName": "Parah 24",
    "arabicName": "Value 24",
    "typeArea": "Makki",
    "parahNo": 24,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 25,
    "engName": "Parah 25",
    "arabicName": "Value 25",
    "typeArea": "Makki",
    "parahNo": 25,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 26,
    "engName": "Parah 26",
    "arabicName": "Value 26",
    "typeArea": "Makki",
    "parahNo": 26,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 27,
    "engName": "Parah 27",
    "arabicName": "Value 27",
    "typeArea": "Makki",
    "parahNo": 27,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 28,
    "engName": "Parah 28",
    "arabicName": "Value 28",
    "typeArea": "Makki",
    "parahNo": 28,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 29,
    "engName": "Parah 29",
    "arabicName": "Value 29",
    "typeArea": "Makki",
    "parahNo": 29,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
  {
    "parahId": 30,
    "engName": "Parah 30",
    "arabicName": "Value 30",
    "typeArea": "Makki",
    "parahNo": 30,
    "pageCount": 0,
    "ayatCount": 0,
    "pdfParah": "",
  },
];
