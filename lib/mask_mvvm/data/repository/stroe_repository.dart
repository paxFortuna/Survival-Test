import 'package:mask_mvvm/mask_mvvm/data/model/mask_store.dart';

abstract interface class StoreRepository {
  Future<List<MaskStore>> getStores();
}