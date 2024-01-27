import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/models/exchange_rate_response.dart';

class ExchangeRateRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/exchange-rate';

  Future<ExchangeRateResponse?> getLatestExchangeRate() async {
    final url = Uri.http(_baseUrl, _path);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ExchangeRateResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
