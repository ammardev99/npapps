import 'package:flutter/material.dart';
import 'package:npapp/widgets/show_badge.dart';

class ShowParahTile extends StatelessWidget {
  final String engName;
  final String arabicName;
  final String typeArea;
  final int parahNo;
  final int pageCount;
  final int ayatCount;
  final String urlPdf;
  final Color color;

  final VoidCallback? onDelete; // optional
  final VoidCallback? onTap; // optional
  final VoidCallback? localSave; // optional

  const ShowParahTile({
    super.key,
    required this.engName,
    required this.arabicName,
    required this.typeArea,
    required this.parahNo,
    required this.pageCount,
    required this.ayatCount,
    this.urlPdf = "",
    this.color = Colors.green,
    this.onDelete,
    this.onTap,
    this.localSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ShowBadge(count: parahNo),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      engName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(typeArea, style: const TextStyle(color: Colors.grey)),
                        const Text(" • ", style: TextStyle(color: Colors.grey)),
                        Text("$pageCount Pages", style: const TextStyle(color: Colors.grey)),
                        // const Text(" • ", style: TextStyle(color: Colors.grey)),
                        // Text("$ayatCount Ayat", style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                arabicName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (localSave != null)
                IconButton(
                  onPressed: localSave,
                  icon: const Icon(Icons.file_download_outlined, color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
