import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mask_mvvm/mask_mvvm/data/model/mask_store.dart';
import 'package:mask_mvvm/mask_mvvm/data/repository/stroe_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<List<MaskStore>> getStores() async {
    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json'));

    final List jsonList = jsonDecode(response.body)['stores'];

    return jsonList
        .where((e) => e['remain_stat'] != null)
        .map((e) => MaskStore(
        name: e['name'] as String,
        address: e['addr'] as String,
        distance: 0,
        remainStatus: e['remain_stat'] as String,
        latitude: e['lat'] as double,
        longitude: e['lng'] as double))
        .toList();
  }
}