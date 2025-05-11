enum RegexType { eMail, onlyNumber, phoneNumber, password, username }

extension RegexTypeExtension on RegexType {
  RegExp get regex {
    switch (this) {
      case RegexType.eMail:
        return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$');
      case RegexType.onlyNumber:
        return RegExp(r'^[0-9]+$');
      case RegexType.phoneNumber:
        return RegExp(r'^\+[1-9][0-9]{3,14}$');
      case RegexType.password:
        return RegExp(r'^.{6,20}$');
      case RegexType.username:
        return RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    }
  }
}
