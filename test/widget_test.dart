// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:chat_application/models/user_model.dart';

void main() {
  test('UserModel serializes and handles missing optional data', () {
    final user = UserModel.fromJson({'uid': 'user-1', 'name': 'Test User'});

    expect(user.uid, 'user-1');
    expect(user.name, 'Test User');
    expect(user.email, isEmpty);
    expect(user.image, isEmpty);
    expect(user.toJson(), {
      'image': '',
      'name': 'Test User',
      'email': '',
      'uid': 'user-1',
    });
  });
}
