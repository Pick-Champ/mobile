import 'package:pick_champ/feature/profile/model/user.dart';

extension UserJsonExtension on User {
  Map<String, dynamic> updateRequest() {
    return {
      if (displayName != null) 'displayName': displayName,
      if (userName != null) 'userName': userName,
      if (email != null) 'email': email,
    };
  }
}
