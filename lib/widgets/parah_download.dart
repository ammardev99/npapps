import 'package:flutter/material.dart';
import 'package:npapp/widgets/show_badge.dart';

// ignore: must_be_immutable
class DownloadParahTile extends StatelessWidget {
  int parahCount;
  DownloadParahTile({super.key, required this.parahCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              ShowBadge(count: parahCount, color: Colors.grey, size: 32),
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.download_rounded, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
