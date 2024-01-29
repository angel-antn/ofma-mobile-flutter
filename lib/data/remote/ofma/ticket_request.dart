import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/models/ticket_response.dart';
import 'package:ofma_app/models/use_ticket_response.dart';

class TicketRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/ticket';

  Future<TicketResponse?> getTicketsByUser() async {
    final url = Uri.http(_baseUrl, '$_path/user/${Preferences.user?.id ?? ''}');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${Preferences.token}',
    });

    if (response.statusCode == 200) {
      return TicketResponse.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UseTicketResponse?> useTicket(String id) async {
    final url = Uri.http(_baseUrl, '$_path/use-ticket');

    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${Preferences.token}',
    }, body: {
      "id": id
    });

    //TODO: only for presentations
    await Future.delayed(const Duration(milliseconds: 2000));

    if (response.statusCode == 201) {
      return UseTicketResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
