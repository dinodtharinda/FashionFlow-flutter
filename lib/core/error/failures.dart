import 'package:flutter/foundation.dart';

class Failure{
  final String message;
  Failure([this.message ="a unexpected error occured"]){
    if (kDebugMode) {
      print(message);
    }
  }
}