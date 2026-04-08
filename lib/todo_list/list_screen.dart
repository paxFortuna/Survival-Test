// import 'package:flutter/material.dart';

// import '../main.dart';
// import 'create_screen.dart';
// import 'main.dart';
// import 'todo_item.dart';

// class ListScreen extends StatefulWidget {
//   const ListScreen({super.key});

//   @override
//   State<ListScreen> createState() => _ListScreenState();
// }

// class _ListScreenState extends State<ListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Todo 리스트')),
//       body: ListView(
//         // todos : main 화면에 설정된 HiveDb Box(todolist.db)
//         children: todos.values
//             .map(
//               (e) => TodoItem(
//                 todo: e,
//                 onTap: (tod) async {
//                   tod.isDone = !tod.isDone;
//                   await tod.save();
//                   setState(() {});
//                 },
//                 onDelete: (tod) async {
//                   await tod.delete();
//                   setState(() {});
//                 },
//               ),
//             )
//             .toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CreateScreen()),
//           );
//           setState(() {});
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
