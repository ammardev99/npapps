import 'package:flutter/material.dart';
import 'package:npapp/widgets/common/my_snack_bar.dart';
import 'package:npapp/widgets/show_badge.dart';

class NoParahTile extends StatelessWidget {
  final int parahCount;
  final bool showFirebaseInfo; // optional, default false

  const NoParahTile({
    super.key,
    required this.parahCount,
    this.showFirebaseInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onLongPress: () {
          _showDeleteDialog(context);
        },
        onTap: () {
          CustomSnackBar.roundedSnackBar(
            context,
            "Parah not available",
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              ShowBadge(count: parahCount, color: Colors.grey, scale: 0.8),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Parah $parahCount",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (showFirebaseInfo)
                IconButton(
                  onPressed: () {
                    CustomSnackBar.roundedSnackBar(
                        context, "PDF not found on Firebase");
                  },
                  icon: const Icon(Icons.cloud_off_rounded, color: Colors.grey),
                )
              else
                IconButton(
                  onPressed: () {
                    CustomSnackBar.roundedSnackBar(
                        context, "PDF url not found");
                  },
                  icon: const Icon(Icons.error_outline_rounded, color: Colors.grey),
                ),
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
          content: const Text(
              "Are you sure you want to delete Parah?\nThis action cannot be undone."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(context);
                // Implement delete callback if needed
              },
            ),
          ],
        );
      },
    );
  }
}
