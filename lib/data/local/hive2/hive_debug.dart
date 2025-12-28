import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Print Hive box item count
void printHiveBoxSize(Box box) {
  debugPrint("Box '${box.name}' contains ${box.length} items");
}

/// Optional: calculate Hive folder size
Future<void> printHiveStorageSize() async {
  final dir = await getApplicationDocumentsDirectory();
  int size = await _calculateDirectorySize(dir);
  debugPrint("Hive Storage Size: ${size / 1024} KB");
}

Future<int> _calculateDirectorySize(Directory dir) async {
  int total = 0;
  await for (var entity in dir.list(recursive: true, followLinks: false)) {
    if (entity is File) {
      total += await entity.length();
    }
  }
  return total;
}
