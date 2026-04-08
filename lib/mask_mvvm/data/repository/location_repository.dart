// Repository패턴은 소프트웨어 개발에서 데이터 저장소에 접근하는 개개체를 추상화하고,
// 데이터소스(DB, File 등)와의 통신을 담당하는 객체를 캡슐화하는 디지아니 패턴이다.
// 추상클래스 인터페이스로 메소드 이름만 설정하고, RepositoryImpl에서 기능을 구현.
// 비즈니스 로직과 데이터를 분리하는 것은 여러 이점이 있다.
// 유지 관리성 향상, 재사용성 향상, 테스트 용이성 향상, 확장성 향상, 데이터 액세스 추상화
// 확장을 고려한 Repository 패턴 - 데이터 추상화를 위한 인터페이스를 정의
//
// abstract interface class UserRepository{
// Future<User> findUserId(String id);
// Future<void> deleterUser(String id)}
//   // 인터페이스 구현체 작성
// class TodoRepositoryImpl implements TodoRepository {

//   final TodoDataSource _todoDataSource;

//    // 네트우크로부터 받은 데이터를 캐시
//   List<Todo> _todos =[];
//   TodoRepositoryImpl({super.key, required this._todoDataSource);
//   @override
//   Future<Todo> findTodoById(int id) => _todoDataSource.getTodo(id);
//   Future<List<Todo>> getAllTodos({bool refresh=false}) async {
//      if(refresh || _todos.isEmpty) {
//        _todos = await _todoDataSource.getTodos();
//      }
//      return _todos;
//    }
// 여러 종류의 Impl 클래스가 작성될 수 있다.

import 'package:mask_mvvm/mask_mvvm/data/model/location.dart';

abstract interface class LocationRepository{
  Future<Location> getLocation();

  double distanceBetween(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      );

}

