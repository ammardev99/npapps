// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/controllers/pdf_picker_controller.dart';

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

  final pdfPicker = PdfPickerController();

  String typeArea = "Makki";
  bool isUploading = false;
  double progress = 0;

  return showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
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

                  Row(
                    children: ["Makki", "Madni"].map((e) {
                      return Expanded(
                        child: RadioListTile(
                          value: e,
                          groupValue: typeArea,
                          title: Text(e),
                          onChanged: (v) =>
                              setState(() => typeArea = v!),
                        ),
                      );
                    }).toList(),
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

                  const SizedBox(height: 10),

                  /// PDF SELECT
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: Text(
                      pdfPicker.pdfFile == null
                          ? "Select PDF"
                          : "PDF Selected",
                    ),
                    onPressed: () async {
                      await pdfPicker.pickPdf();
                      setState(() {});
                    },
                  ),

                  if (isUploading) ...[
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: progress),
                    Text("${(progress * 100).toStringAsFixed(0)}%"),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isUploading
                    ? null
                    : () => Navigator.pop(ctx),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: isUploading
                    ? null
                    : () async {
                        if (pdfPicker.pdfFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select a PDF")),
                          );
                          return;
                        }

                        setState(() => isUploading = true);

                        final res =
                            await controller.addParahWithPdf(
                          parahId:
                              int.tryParse(parahId.text) ?? 0,
                          engName: eng.text,
                          arabicName: arab.text,
                          typeArea: typeArea,
                          parahNo:
                              int.tryParse(parahNo.text) ?? 0,
                          pageCount:
                              int.tryParse(pageCount.text) ?? 0,
                          ayatCount:
                              int.tryParse(ayatCount.text) ?? 0,
                          pdfFile: pdfPicker.pdfFile!,
                          onProgress: (p) {
                            setState(() => progress = p);
                          },
                        );

                        setState(() => isUploading = false);

                        if (res["status"] == true) {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Parah added successfully")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(res["message"])),
                          );
                        }
                      },
                child: Text(
                  isUploading ? "Uploading..." : "Add",
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
