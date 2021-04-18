import 'dart:convert';
import 'dart:typed_data';

Uint8List processDataImage(imageString) {
  final stripped = imageString?.replaceFirst(
      RegExp(r'data:image/[^;]+;base64,'), '') as String;
  return base64.decode(stripped);
}
