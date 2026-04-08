import 'package:flutter/material.dart';
import 'package:mask_mvvm/mask_mvvm/ui/component/store_item.dart';
import 'package:mask_mvvm/mask_mvvm/ui/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  // provider 대신 ListenableBuilder 사용할때 생성자를 만들어서 사용. provider 없이 사용.
  // final MainViewModel viewModel;
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // provider viewModel 사용하는 경우
    final viewModel = context.watch<MainViewModel>();
    return Scaffold(
      // ListenableBuilder 사용할 경우, Text 위젯을 ListenableBuilder로 감싸줘야 함.
      // provider를 사용하면 그대로 작동함.
      appBar: AppBar(title: Text('마스크 재고 있는 곳: ${viewModel.stores.length}곳')),
      // provider 사용하는 경우
      body: ListView(
              children: viewModel.stores
                  .map((store) => StoreItem(store: store))
                  .toList(),
            ),
      // ListenableBuilder로 생성자 불러와서 상태관리하는 방법.
      // body: ListenableBuilder(
      //   listenable: viewModel,
      //   builder: (BuildContext context, Widget? child) {
      //     return ListView(
      //       children: viewModel.stores
      //           .map((store) => StoreItem(store: store))
      //           .toList(),
      //     );
      //   },
      // ),
    );
  }
}
