import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/models/bank_account_response.dart';

class BankAccountRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/bank-account';

  Future<BankAccountResponse?> getBankAccounts() async {
    final url = Uri.http(_baseUrl, _path);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return BankAccountResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
