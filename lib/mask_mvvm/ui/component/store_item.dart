import 'package:flutter/material.dart';
import 'package:mask_mvvm/mask_mvvm/data/model/mask_store.dart';

class StoreItem extends StatelessWidget {
  final MaskStore store;
  const StoreItem({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Column(
        children: [
          Text(store.address),
          Text('${store.distance}'),
        ],
      ),
      trailing: _buildRemainStatWidget(),

    );
  }

  _buildRemainStatWidget() {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch(store.remainStatus) {
      case 'plenty':
        remainStat='충분';
        description='100개 이상';
        color=Colors.green;
      case 'some':
        remainStat='보통';
        description='30~100개';
        color=Colors.yellow;
      case 'few':
        remainStat='부족';
        description='2~30개';
        color=Colors.red;
      case 'empty':
        remainStat='소진임박';
        description='1개 이하';
        color=Colors.grey;
    }
    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
