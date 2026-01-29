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
            ? _loadLocalPdf()
            : _loadFirebasePdf(),
      ),
    );
  }

  Widget _loadLocalPdf() {
    if (File(pdfUrl).existsSync()) {
      debugPrint("Local PDF loaded: $pdfUrl");
      return SfPdfViewer.file(
        File(pdfUrl),
        onDocumentLoadFailed: (details) =>
            debugPrint("Local PDF LOAD ERROR: ${details.error}"),
        onDocumentLoaded: (details) =>
            debugPrint("Local PDF loaded successfully"),
      );
    } else {
      return _errorWidget("Local PDF not found at path:\n$pdfUrl");
    }
  }

  Widget _loadFirebasePdf() {
    debugPrint("Firebase PDF loaded: $pdfUrl");
    return SfPdfViewer.network(
      pdfUrl,
      onDocumentLoadFailed: (details) =>
          debugPrint("Firebase PDF LOAD ERROR: ${details.error}"),
      onDocumentLoaded: (details) =>
          debugPrint("Firebase PDF loaded successfully"),
    );
  }

  Widget _errorWidget(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, size: 60, color: Colors.red),
          const SizedBox(height: 12),
          Text(msg, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
