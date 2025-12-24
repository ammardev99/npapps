import 'package:flutter/material.dart';
import 'package:npapp/controllers/parah_controller.dart';
import 'package:npapp/widgets/add_parah.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  final ParahController parahController = ParahController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Control Panel"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("Add Parah"),
          onPressed: () async {
            await showAddParahDialog(context, parahController);
          },
        ),
      ),
    );
  }
}
