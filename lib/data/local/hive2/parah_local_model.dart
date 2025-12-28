import 'package:hive/hive.dart';

part 'parah_local_model.g.dart';

@HiveType(typeId: 1)
class ParahLocalModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title; // English Name

  @HiveField(2)
  String arabicName;

  @HiveField(3)
  String typeArea;

  @HiveField(4)
  int parahNo;

  @HiveField(5)
  int pageCount;

  @HiveField(6)
  int ayatCount;

  @HiveField(7)
  String filePath;

  @HiveField(8)
  DateTime downloadDate;

  ParahLocalModel({
    required this.id,
    required this.title,
    required this.arabicName,
    required this.typeArea,
    required this.parahNo,
    required this.pageCount,
    required this.ayatCount,
    required this.filePath,
    required this.downloadDate,
  });

  @override
  String toString() {
    return 'ParahLocalModel(id: $id, title: $title, arabic: $arabicName, parahNo: $parahNo, pageCount: $pageCount, ayatCount: $ayatCount, path: $filePath)';
  }
}
