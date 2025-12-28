import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<int> calculateDirectorySize(Directory dir) async {
  int totalSize = 0;

  if (await dir.exists()) {
    await for (FileSystemEntity entity in dir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        totalSize += await entity.length();
      }
    }
  }

  return totalSize; // bytes
}

// Get the Hive directory path
Future<Directory> getHiveDirectory() async {
  final appDir = await getApplicationDocumentsDirectory();
  return Directory('${appDir.path}/hive');
}

// Get the size of the Hive
Future<int> getHiveStorageSize() async {
  final hiveDir = await getHiveDirectory();
  return await calculateDirectorySize(hiveDir);
}

// Format bytes to a human-readable string
String formatBytes(int bytes) {
  const kb = 1024;
  const mb = kb * 1024;

  if (bytes >= mb) {
    return '${(bytes / mb).toStringAsFixed(2)} MB';
  } else if (bytes >= kb) {
    return '${(bytes / kb).toStringAsFixed(2)} KB';
  } else {
    return '$bytes B';
  }
}

// Show usage in a Flutter widget
class HiveStorageInfo extends StatefulWidget {
  const HiveStorageInfo({super.key});

  @override
  State<HiveStorageInfo> createState() => _HiveStorageInfoState();
}

class _HiveStorageInfoState extends State<HiveStorageInfo> {
  String hiveSize = 'Loading...';

  @override
  void initState() {
    super.initState();
    loadHiveSize();
  }

  Future<void> loadHiveSize() async {
    final size = await getHiveStorageSize();
    setState(() {
      hiveSize = formatBytes(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Hive Storage Used'),
      subtitle: Text(hiveSize),
      trailing: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: loadHiveSize,
      ),
    );
  }
}
