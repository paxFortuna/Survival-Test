// mvvm pattern
// 앱에서는 레포지토리를 단순화하고, UI관련된 비즈니스 로직을 별도 클래스로 관리하고,
// 이 클래스는 레포지토리를 활용한다. 이것을 ViewModel이라고 부르자.
// View -> ViewModel(UI비즈니스 로직) ->Repository(Data비즈니스 로직) -> DataSource
// 데이터소스에는 데어터베이스와 crud를 구현한 메소드가 있다.
// 레포지토리에는 추상클래스 인터페이스 레포지토리(빈 메소드)와
// 인터페이스를의 빈메소드를 오브라이드하여 구현한 레포지토리임플로 구성된다.
// 레포지토리임플에서는 인터페이스의 메소드를 오브라이드하여, 데이터소스 인스턴스의 메소드를 불러온다.
// mvvm 패턴에서 Model은 데이터소스(db, file과 crud) + 레포지토리 + 레포지토리임플로 구성
// 상태관리하는 ViewModel(=f(state))은 View(UI)와 함께 ui 또는 screen 디렉토리에서 관리된다.
// Model은 data Layer로 domain 디렉토리에 (모델클래스, datasource),
// repository 디렉토리에 (repository, repositorImpl)로 구성

import 'package:geolocator/geolocator.dart';
import 'package:mask_mvvm/mask_mvvm/data/model/location.dart';
import 'package:mask_mvvm/mask_mvvm/data/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  double distanceBetween(
      double startLat, double startLng, double endLat, double endLng) =>
      Geolocator.distanceBetween(startLat, startLng, endLat, endLng);

  @override
  Future<Location> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        return const Location(latitude: 0, longitude: 0);
      } else if (permission == LocationPermission.deniedForever) {
        return const Location(latitude: 0, longitude: 0);
      }

      // 승인
      final position = await Geolocator.getCurrentPosition();
      return Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    }

    return const Location(latitude: 0, longitude: 0);
  }
}