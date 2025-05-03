import 'dart:ui';

import 'package:booksy_app/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('hexToColor devuelve el color correcto', (){
    
    var stringColor = "#2196F3";
    var colorExpected = const Color(0x662196F3);
    var colorActual = hexToColor(stringColor);

    expect(colorActual, colorExpected); // assertion = aseveración
  });
}