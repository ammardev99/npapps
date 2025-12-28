import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/controllers/parah_local_controller.dart';
import 'package:npapp/widgets/add_parah.dart';
import 'package:npapp/widgets/common/my_snack_bar.dart';
import 'package:npapp/widgets/parah/no_parah.dart';
import 'package:npapp/widgets/parah/parah_tile.dart';

class ParahControlPanel extends StatefulWidget {
  const ParahControlPanel({super.key});

  @override
  State<ParahControlPanel> createState() => _ParahControlPanelState();
}

class _ParahControlPanelState extends State<ParahControlPanel> {
  final ParahController parahController = ParahController();
  final ParahLocalController localController = ParahLocalController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Parah Control Panel"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add Parah"),
                onPressed: () async {
                  await showAddParahDialog(context, parahController);
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.delete_forever),
                label: const Text("Clear All Parahs"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirm Clear"),
                      content: const Text(
                        "Are you sure you want to clear all downloaded Parahs?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await localController.init();
                    await localController.clearAllParahs();

                    CustomSnackBar.roundedSnackBar(
                      // ignore: use_build_context_synchronously
                      context,
                      "All downloaded Parahs cleared",
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              NoParahTile(parahCount: 1),

              ShowParahTile(
                engName: "Parah",
                arabicName: 'پارہ',
                typeArea: "Makki",
                parahNo: 2,
                pageCount: 23,
                ayatCount: 23,
                localSave: () {
                  CustomSnackBar.roundedSnackBar(
                    context,
                    "Save locally action triggered",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
