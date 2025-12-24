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

  final VoidCallback? onDelete; // NEW
  final VoidCallback? onTap; // Optional

  const ShowParahTile({
    super.key,
    required this.engName,
    required this.arabicName,
    required this.typeArea,
    required this.parahNo,
    required this.pageCount,
    required this.ayatCount,
    this.urlPdf = "'",
    this.onDelete,
    this.onTap,
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
        onLongPress: () {
          if (onDelete != null) {
            _showDeleteDialog(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ShowBadge(count: parahNo),
              const SizedBox(width: 12),

              // Names and metadata
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      engName+urlPdf,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(typeArea),
                        const Text(" • "),
                        Text("$pageCount Pages"),
                      ],
                    ),
                  ],
                ),
              ),

              // Arabic Name
              Text(
                arabicName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),

              // OPTIONAL DELETE ICON
              // if (onDelete != null)
              //   IconButton(
              //     icon: const Icon(Icons.delete, color: Colors.red),
              //     onPressed: () => _showDeleteDialog(context),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Parah?"),
          content: Text(
            "Are you sure you want to delete Parah $parahNo?\nThis action cannot be undone.",
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(context);
                if (onDelete != null) onDelete!();
              },
            ),
          ],
        );
      },
    );
  }
}
