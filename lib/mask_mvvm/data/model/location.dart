// view(화면)에 보여질 데이터를 담는 객체
// Domain Driven Design
// Domain: 유사한 업무의 집합, 특정상황(주문.결재.로그인)이나 특정객체(유저. 손님)가 중심이 될 수 있음.
// 모델 클래스 : 도메인을 클래스로 작성한 것 : factory패턴과 singleton패턴
// 싱글턴패턴: 1개의 인스턴스만 생성되는 것을 보증하기 위한 패턴. 캐시나 공유데이터, 처리의 효율화 등에 사용.
// 데이터 클래스 4종(copyWith, toString, equals, hashCode), 직렬화2종(fromJson, toJson)

class Location {
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Location && runtimeType == other.runtimeType &&
              latitude == other.latitude && longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;


}