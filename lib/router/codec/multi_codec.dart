import 'dart:convert';

import 'package:ofma_app/enums/cotent_category.dart';

class MultiCodec extends Codec<dynamic, String> {
  @override
  Converter<String, dynamic> get decoder => _MultiDecoder();

  @override
  Converter<dynamic, String> get encoder => _MultiEncoder();
}

class _MultiDecoder extends Converter<String, dynamic> {
  @override
  dynamic convert(String input) {
    // Aquí puedes agregar la lógica para deserializar tus datos
    // Por ejemplo, podrías verificar si la entrada es un valor de ContentCategory
    switch (input) {
      case 'entrevista':
        return ContentCategory.interview;
      case 'concierto':
        return ContentCategory.concert;
      default:
        // Si la entrada no coincide con ningún valor de ContentCategory, puedes devolver la entrada tal cual
        return input;
    }
  }
}

class _MultiEncoder extends Converter<dynamic, String> {
  @override
  String convert(dynamic input) {
    // Aquí puedes agregar la lógica para serializar tus datos
    // Por ejemplo, si la entrada es una instancia de ContentCategory, puedes devolver su representación en cadena
    if (input is ContentCategory) {
      return input.value;
    } else {
      // Si la entrada no es una instancia de ContentCategory, puedes devolver la entrada tal cual
      return input.toString();
    }
  }
}
