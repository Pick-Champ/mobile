import 'package:pick_champ/feature/profile/model/user.dart';

extension UserJsonExtension on User {
  Map<String, dynamic> toJsonWithoutId() {
    final json = toJson()..remove('_id');
    return json;
  }
}
