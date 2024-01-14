import 'package:http/http.dart' as http;
import 'package:ofma_app/models/concert_response.dart';

class ConcertRequest {
  final String _baseUrl = '10.0.2.2:3000';
  final String _path = '/api/concert';

  Future<ConcertResponse?> getConcerts() async {
    final url = Uri.http(_baseUrl, _path, {'all': 'false'});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ConcertResponse.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Concert?> getConcertById(String id) async {
    final url = Uri.http(_baseUrl, '$_path/$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Concert.fromJson(response.body);
    } else {
      return null;
    }
  }
}
