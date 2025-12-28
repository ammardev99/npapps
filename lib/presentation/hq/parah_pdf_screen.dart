import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ParahPdfScreen extends StatelessWidget {
  final int parahNo;
  final String pdfUrl;
  final bool isLocal;

  const ParahPdfScreen({
    super.key,
    required this.parahNo,
    required this.pdfUrl,
    this.isLocal = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Parah $parahNo")),
        body: isLocal
            ? File(pdfUrl).existsSync()
                ? SfPdfViewer.file(
                    File(pdfUrl),
                    onDocumentLoadFailed: (details) =>
                        debugPrint("PDF LOAD ERROR: ${details.error}"),
                    onDocumentLoaded: (details) =>
                        debugPrint("PDF loaded successfully"),
                  )
                : _errorWidget("Local PDF not found at path:\n$pdfUrl")
            : SfPdfViewer.network(
                pdfUrl,
                onDocumentLoadFailed: (details) =>
                    debugPrint("PDF LOAD ERROR: ${details.error}"),
                onDocumentLoaded: (details) =>
                    debugPrint("PDF loaded successfully"),
              ),
      ),
    );
  }

  Widget _errorWidget(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, size: 60, color: Colors.green),
          const SizedBox(height: 12),
          Text(msg, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
