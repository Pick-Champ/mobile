import 'package:pick_champ/core/const/app_env.dart';

final class CreateImageUrl {
  String fakeProfile() {
    return 'https://images.pexels.com/photos/9363200/pexels-photo-9363200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  }

  String user(String photoName) {
    // print('${AppEnv.baseUrl}/uploads/user/$photoName');
    return '${AppEnv.baseUrl}/uploads/user/$photoName';
  }

  String quiz(String photoName) {
    // print('${AppEnv.baseUrl}/uploads/quiz/$photoName');
    return '${AppEnv.baseUrl}/uploads/quiz/$photoName';
  }

  String selection(String photoName) {
    //  print('${AppEnv.baseUrl}/uploads/selection/$photoName');
    return '${AppEnv.baseUrl}/uploads/selection/$photoName';
  }
}
