import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/models/stripe_response.dart';

class StripeRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/stripe';

  Future<StripeResponse?> getPaymentIntentAndCustomer(
      {required double amount}) async {
    final url = Uri.http(_baseUrl, '$_path/getPaymentIntentAndCustomer');

    final response = await http.post(url, body: {
      'email': Preferences.user?.email ?? '',
      'name': Preferences.user?.name ?? '',
      'lastname': Preferences.user?.lastname ?? '',
      'amount': amount.toString()
    }, headers: {
      'Authorization': 'Bearer ${Preferences.token}',
    });

    if (response.statusCode == 201) {
      return StripeResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
