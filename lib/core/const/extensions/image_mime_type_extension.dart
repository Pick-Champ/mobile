import 'dart:io';

extension ImageMimeTypeExtension on File {
  String get imageMimeType {
    final pathLower = path.toLowerCase();
    if (pathLower.endsWith('.png')) {
      return 'png';
    } else if (pathLower.endsWith('.jpg') || pathLower.endsWith('.jpeg')) {
      return 'jpeg';
    } else {
      throw Exception('Unsupported image file type: $path');
    }
  }
}
