// ViewModel - 상태관리
// 모든 UI상태는 ViewModel이 가진다.
// ViewModel은 View에 데이터바인딩을 제공해야 하며, ChangeNotifier를 활용하면 쉽게 가능하다.
// ChangeNotifier는 notifyListeners() 호울을 하여 관찰자에 통지한다.
// 이러한 것을 상태관리라고 한다. 데이터가 변경되면 화면이 자동으로 다시 그려진다.
// 상태에 따라 자동으로 UI가 그려지니 휴멍에러가 적어진다.
//
// Repository 객체를 생성하여, 레포지토리의 메소드를 이용하여 기능을 구현한다.
// 1. 화면에서 일어날 이벤트(액션)을 모두 메서드로 정의
// 2. todos, isLoading 같은 상태(변수)가 변경되면 notifyListener()를 호출하여 UI 갱신 알림
// ListenableBuilder
// Listenable 인텨페이스를 구현하는 ChangetNotifier, ValueNotifier 등을 관찰하여
// 변경상항이 있을 때 위젯을 재생성
// ChangeNotifier구현한 ViewModel을 관찰하는 용도로 좋다.

import 'package:flutter/cupertino.dart';
import 'package:mask_mvvm/mask_mvvm/data/model/mask_store.dart';
import 'package:mask_mvvm/mask_mvvm/data/repository/location_repository.dart';
import 'package:mask_mvvm/mask_mvvm/data/repository/stroe_repository.dart';

class MainViewModel with ChangeNotifier {
  final StoreRepository _storeRepository;
  final LocationRepository _locationRepository;

  MainViewModel({
    required StoreRepository storeRepository,
    required LocationRepository locationRepository,
  }) : _storeRepository = storeRepository,
       _locationRepository = locationRepository {
    fetchStores();
  }

  List<MaskStore> _stores = [];

  // List는 getter를 해도 조작되기에 아래와 같이 추가.
  List<MaskStore> get stores => List.unmodifiable(_stores);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void fetchStores() async {
    _isLoading = true;
    notifyListeners();

    final stores = await _storeRepository.getStores();
    final location = await _locationRepository.getLocation();

    for (var store in stores) {
      store.distance = _locationRepository.distanceBetween(
        store.latitude,
        store.longitude,
        location.latitude,
        location.longitude,
      );
    }

    stores.sort((a,b) => a.distance.compareTo(b.distance));

    _stores = stores;

    _isLoading = !_isLoading;
    notifyListeners();
  }
}
