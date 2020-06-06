import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mainEntitySample = MainEntity(title: 'test', id: '0', image_url: 'http');

  test('Should return MainEntity When Created', () {
    expect(mainEntitySample.id, '0');
    expect(mainEntitySample.title, 'test');
    expect(mainEntitySample.image_url, 'http');
  });

  test('Should return Json When Calling toJson', (){
    final mainEntityJson = mainEntitySample.toJson();

    expect(mainEntityJson['id'], '0');
    expect(mainEntityJson['title'], 'test');
    expect(mainEntityJson['image_url'], 'http');

  });
}
