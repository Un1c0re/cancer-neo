import 'dart:typed_data';
import 'package:mime/mime.dart';

bool isImage(Uint8List data) {
  String? mimeType = lookupMimeType('', headerBytes: data);
  return mimeType != null && mimeType.startsWith('image');
}

bool isPdf(Uint8List data) {
  String? mimeType = lookupMimeType('', headerBytes: data);
  return mimeType != null && mimeType == 'application/pdf';
}
