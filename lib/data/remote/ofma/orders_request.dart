import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/models/orders_response.dart';

class OrderRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/order';

  Future<OrdersResponse?> getOrdersByUser({required int page}) async {
    final user = Preferences.user;
    final url = Uri.http(_baseUrl, '$_path/user/${user?.id ?? ''}',
        {'page': page.toString(), 'pageSize': '4'});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return OrdersResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
