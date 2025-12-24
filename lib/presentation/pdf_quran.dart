// // ignore_for_file: use_build_context_synchronously

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:npapp/controllers/parah_controller.dart';
// import 'package:npapp/presentation/auth/auth.dart';
// import 'package:npapp/services/auth_services.dart';
// import 'package:npapp/widgets/add_parah.dart';
// import 'package:npapp/widgets/parah_tile.dart';

// class PdfQuran extends StatelessWidget {
//   PdfQuran({super.key});
//   final ParahController controller = ParahController();
//   final AuthServices authService = AuthServices();

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(user?.email ?? "No User"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               var res = await authService.logoutUser();
//               if (res["status"] == true) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => AuthScreen()),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(res["message"] ?? "Logout failed")),
//                 );
//               }
//             },
//             icon: const Icon(Icons.logout_rounded),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.grey.shade300,
//       body: StreamBuilder(
//         stream: controller.listenParah(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 "Error connecting: ${snapshot.error}",
//                 style: TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text(
//                 "No Parah Found",
//                 style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
//               ),
//             );
//           }

//           final list = snapshot.data!;

//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: list.length,
//             itemBuilder: (context, index) {
//               final p = list[index];

//               return ShowParahTile(
//                 engName: p.engName,
//                 arabicName: p.arabicName,
//                 typeArea: p.typeArea,
//                 parahNo: p.parahNo,
//                 pageCount: p.pageCount,
//                 ayatCount: p.ayatCount,
//                 onTap: () {
//                   debugPrint("Open Parah ${p.parahNo}");
//                 },
//                 onDelete: () {
//                   controller.deleteParah(p.id);
//                 },
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showAddParahDialog(context, controller);
//         },
//         child: const Icon(Icons.add),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     final bulkController = BulkParahController();
//       //     await bulkController.addBulkParah(context);
//       //   },
//       //   child: const Icon(Icons.upload),
//       // ),
//     );
//   }
// }


