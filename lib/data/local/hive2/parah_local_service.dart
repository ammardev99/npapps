import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'parah_local_model.dart';

class ParahLocalService {
  static const String parahBoxName = 'downloaded_parahs';
  late Box<ParahLocalModel> _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(ParahLocalModelAdapter().typeId)) {
      Hive.registerAdapter(ParahLocalModelAdapter());
    }
    _box = await Hive.openBox<ParahLocalModel>(parahBoxName);
    debugPrint("Hive Parah Box Initialized with ${_box.length} items");
  }

  Future<void> saveParah(ParahLocalModel parah) async {
    await _box.put(parah.id, parah);
    debugPrint("Saved Parah: ${parah.title} at ${parah.filePath}");
  }

// In ParahLocalService
Future<void> clearAllParahs() async {
  await _box.clear(); // Only clears downloaded_parahs
  debugPrint("Hive box cleared: downloaded_parahs");
}

  List<ParahLocalModel> getAllParahs() {
    final list = _box.values.toList();
    debugPrint("Fetched ${list.length} items from Hive");
    for (var p in list) {
      debugPrint(
          "Local Parah -> id: ${p.id} | title: ${p.title} | arabic: ${p.arabicName} | path: ${p.filePath}");
    }
    return list;
  }

  Future<void> deleteParah(String id) async {
    await _box.delete(id);
    debugPrint("Deleted Parah ID: $id | Remaining: ${_box.length}");
  }
}
