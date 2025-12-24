class ParahModel {
  final String id;
  final int parahId;
  final String engName;
  final String arabicName;
  final String typeArea;
  final int parahNo;
  final int pageCount;
  final int ayatCount;
  final String pdfParah;

  ParahModel({
    required this.id,
    required this.parahId,
    required this.engName,
    required this.arabicName,
    required this.typeArea,
    required this.parahNo,
    required this.pageCount,
    required this.ayatCount,
    required this.pdfParah,
  });

  Map<String, dynamic> toMap() {
    return {
      "parahId": parahId,
      "engName": engName,
      "arabicName": arabicName,
      "typeArea": typeArea,
      "parahNo": parahNo,
      "pageCount": pageCount,
      "ayatCount": ayatCount,
      "pdfParah": pdfParah,
    };
  }

  factory ParahModel.fromMap(String id, Map<String, dynamic> map) {
    return ParahModel(
      id: id,
      parahId: map["parahId"] ?? 0,
      engName: map["engName"] ?? "",
      arabicName: map["arabicName"] ?? "",
      typeArea: map["typeArea"] ?? "",
      parahNo: map["parahNo"] ?? 0,
      pageCount: map["pageCount"] ?? 0,
      ayatCount: map["ayatCount"] ?? 0,
      pdfParah: map["pdfParah"] ?? "",
    );
  }
}
