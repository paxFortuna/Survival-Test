import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mask_mvvm/mask_mvvm/data/repository/location_repository_impl.dart';
import 'package:mask_mvvm/mask_mvvm/data/repository/store_repository_impl.dart';
import 'package:mask_mvvm/mask_mvvm/ui/main_screen.dart';
import 'package:mask_mvvm/mask_mvvm/ui/main_view_model.dart';
import 'package:provider/provider.dart';

import 'todo_list/todo.dart';

late final Box<Todo> todos;
// void main() {
void main() async{
  await Hive.initFlutter();
  try {
    await dotenv.load(fileName: ".env_1"); // Load environment variables
  } catch (e) {
    debugPrint("Error loading .env_1 file: $e");
  }
  //
  await dotenv.load(fileName: ".env"); // 환경 변수 로드
  runApp(MyApp());
  //
  Hive.registerAdapter(TodoAdapter());
  // Box<Todo> todos = await Hive.openBox<Todo>('todolist.db');
  todos = await Hive.openBox<Todo>('todolist.db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // provider
        home: ChangeNotifierProvider<MainViewModel>(
          create: (BuildContext context) {
            return MainViewModel(
              storeRepository: StoreRepositoryImpl(),
              locationRepository: LocationRepositoryImpl(),
            );
          },
          child: const MainScreen(),
        ),
      //
      // ListenableBuilder를 사용하는 경우 생성자 설정해야 함.
      // home: MainScreen(
      //   viewModel: MainViewModel(
      //     storeRepository: MockStoreRepository(),
      //     locationRepository: MockLocationRepository(),
      //   ),
      // ),
    );
  }
}
