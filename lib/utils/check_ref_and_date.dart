import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ofma_app/utils/is_numeric_string.dart';

bool checkRefAndDate({required String ref, required String date}) {
  if (date == '') {
    Fluttertoast.showToast(
        msg: 'Debe ingresar la fecha de compra', backgroundColor: Colors.grey);
    return false;
  } else if (ref == '') {
    Fluttertoast.showToast(
        msg: 'Debe ingresar un número de referencia',
        backgroundColor: Colors.grey);
    return false;
  } else if (ref.length < 4) {
    Fluttertoast.showToast(
        msg: 'El numero de referencia debe tener al menos 4 digitos',
        backgroundColor: Colors.grey);
    return false;
  } else if (!isNumericString(ref)) {
    Fluttertoast.showToast(
        msg: 'El numero de referencia no es válido',
        backgroundColor: Colors.grey);
    return false;
  }
  return true;
}
