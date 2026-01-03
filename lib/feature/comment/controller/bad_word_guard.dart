import 'dart:convert';
import 'package:pick_champ/feature/comment/controller/word_data.dart';

class BadWordGuard {
  BadWordGuard() {
    _badWords = _decodeBadWords();
  }

  late final List<String> _badWords;

  List<String> _decodeBadWords() {
    final decoded = utf8.decode(base64.decode(wordData));
    return decoded.split('\n');
  }

  bool isContain(String input) {
    for (final badWord in _badWords) {
      if (_containsExactWord(input, badWord)) {
        return true;
      }
    }
    return false;
  }

  String filterBadWords(String input) {
    var result = input;

    for (final badWord in _badWords) {
      result = result.replaceAllMapped(
        RegExp(
          r'\b' + RegExp.escape(badWord) + r'\b',
          caseSensitive: false,
        ),
        (match) => '*' * match.group(0)!.length,
      );
    }

    return result;
  }

  bool _containsExactWord(String input, String word) {
    final cleanedInput = input.replaceAll(RegExp(r'[^\w\s]'), '');
    final words = cleanedInput.toLowerCase().split(' ');
    return words.contains(word.toLowerCase());
  }
}
