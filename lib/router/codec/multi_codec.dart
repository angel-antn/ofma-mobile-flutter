import 'dart:convert';

import 'package:ofma_app/enums/cotent_category.dart';
import 'package:ofma_app/models/payment_params.dart';

class MultiCodec extends Codec<dynamic, String> {
  @override
  Converter<String, dynamic> get decoder => _MultiDecoder();

  @override
  Converter<dynamic, String> get encoder => _MultiEncoder();
}

class _MultiDecoder extends Converter<String, dynamic> {
  @override
  dynamic convert(String input) {
    // Intenta deserializar como PaymentParams
    try {
      Map<String, dynamic> data = jsonDecode(input);
      return PaymentParams(
        type: data['type'],
        amount: data['amount'],
        concertId: data['concertId'],
      );
    } catch (e) {
      // Si falla, intenta deserializar como ContentCategory
      switch (input) {
        case 'entrevista':
          return ContentCategory.interview;
        case 'concierto':
          return ContentCategory.concert;
        default:
          return input;
      }
    }
  }
}

class _MultiEncoder extends Converter<dynamic, String> {
  @override
  String convert(dynamic input) {
    // Intenta serializar como PaymentParams
    if (input is PaymentParams) {
      return jsonEncode({
        'type': input.type,
        'amount': input.amount,
        'concertId': input.concertId,
      });
    } else if (input is ContentCategory) {
      // Si no es PaymentParams, intenta serializar como ContentCategory
      return input.value;
    } else {
      return input.toString();
    }
  }
}
