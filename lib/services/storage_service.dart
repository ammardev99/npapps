import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadParahPdf(File file, int parahNo) {
    return _storage
        .ref('parah_pdfs/parah_$parahNo.pdf')
        .putFile(file);
  }
}
