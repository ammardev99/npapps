import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ParahPdfScreen extends StatelessWidget {
  final int parahNo;
  final String pdfUrl;

  const ParahPdfScreen({
    super.key,
    required this.parahNo,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Parah $parahNo"),
        ),
        body: pdfUrl.isEmpty
            ? _errorWidget("PDF not available for this Parah")
            : SfPdfViewer.network(
                pdfUrl,
                onDocumentLoadFailed: (details) {
                  debugPrint("PDF LOAD ERROR: ${details.error}");
                },
                onDocumentLoaded: (details) {
                  debugPrint("PDF loaded successfully");
                },
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
          Text(
            msg,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
