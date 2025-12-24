// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> showAddParahDialog(
  BuildContext context,
  ParahController controller,
) async {
  final eng = TextEditingController();
  final arab = TextEditingController();
  final parahNo = TextEditingController();
  final parahId = TextEditingController();
  final pageCount = TextEditingController();
  final ayatCount = TextEditingController();

  String typeArea = "Makki"; // default selection

  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text("Add Parah"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: parahId,
                decoration: const InputDecoration(labelText: "Parah ID"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: eng,
                decoration: const InputDecoration(labelText: "English Name"),
              ),
              TextField(
                controller: arab,
                decoration: const InputDecoration(labelText: "Arabic Name"),
              ),
              const SizedBox(height: 12),

              /// RADIO SELECTION MAKKI / MADNI
              Row(
                children: [
                  // const Text("Type: "),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: const Text("Makki"),
                      leading: Radio<String>(
                        value: "Makki",
                        groupValue: typeArea,
                        onChanged: (value) {
                          if (value != null) {
                            typeArea = value;
                            (ctx as Element).markNeedsBuild();
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                                            contentPadding: EdgeInsets.all(0),

                      title: const Text("Madni"),
                      leading: Radio<String>(
                        value: "Madni",
                        groupValue: typeArea,
                        onChanged: (value) {
                          if (value != null) {
                            typeArea = value;
                            (ctx as Element).markNeedsBuild();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              TextField(
                controller: parahNo,
                decoration: const InputDecoration(labelText: "Parah No"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pageCount,
                decoration: const InputDecoration(labelText: "Page Count"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: ayatCount,
                decoration: const InputDecoration(labelText: "Ayat Count"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              // Test Firestore connection first
              try {
                await FirebaseFirestore.instance.collection("pdf_parah").get();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error connecting to Firestore: $e")),
                );
                return;
              }

              // Call controller to add parah
              var res = await controller.addParah(
                parahId: int.tryParse(parahId.text) ?? 0,
                engName: eng.text,
                arabicName: arab.text,
                typeArea: typeArea,
                parahNo: int.tryParse(parahNo.text) ?? 0,
                pageCount: int.tryParse(pageCount.text) ?? 0,
                ayatCount: int.tryParse(ayatCount.text) ?? 0,
                pdfParah: "",
              );

              if (res["status"] == true) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Parah added successfully")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(res["message"] ?? "Failed to add Parah"),
                  ),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
