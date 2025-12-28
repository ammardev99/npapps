import 'package:flutter/material.dart';
import 'package:npapp/widgets/common/my_snack_bar.dart';
import 'package:npapp/widgets/show_badge.dart';

// ignore: must_be_immutable
class NoParahTile extends StatelessWidget {
  int parahCount;

  NoParahTile({super.key, required this.parahCount});

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
          CustomSnackBar.roundedSnackBar(context, "Parah not available",);
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

          child: Row(
            children: [
              ShowBadge(count: parahCount, color: Colors.grey, scale: 0.8),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Parah $parahCount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              //  (trailing)
              IconButton(onPressed: (){
                          CustomSnackBar.roundedSnackBar(context, "PDF url not fount",);
              }, icon: Icon(Icons.error_outline_rounded, color: Colors.grey),)
              
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
            "Are you sure you want to delete Parah?\nThis action cannot be undone.",
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
                // if (onDelete != null) onDelete!();
              },
            ),
          ],
        );
      },
    );
  }
}
