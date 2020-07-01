import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class Utility {
  static Image imageFromBase64String(String base64String) {
    if (base64String == null) {
      return null;
    }
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List imageFromBase64String2(String base64String) {
    if (base64String == null) {
      return null;
    }

    Uint8List bytes = base64Decode(base64String);
    return bytes;
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
