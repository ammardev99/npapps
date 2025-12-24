import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PdfPickerController {
  File? pdfFile;

  Future<File?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      pdfFile = File(result.files.single.path!);
      return pdfFile;
    }
    return null;
  }

  void clear() {
    pdfFile = null;
  }
}
