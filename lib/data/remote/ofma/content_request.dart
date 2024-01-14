import 'package:http/http.dart' as http;
import 'package:ofma_app/models/concert_response.dart';

class ContentRequest {
  final String _baseUrl = '10.0.2.2:3000';
  final String _path = '/api/exclusive-content';

  Future<ConcertResponse?> getContent(
      {required String category, required bool highlighted}) async {
    final url = Uri.http(_baseUrl, _path, {
      'category': category,
      'highlighted': highlighted.toString(),
      'shown': 'true',
      'published': 'true'
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ConcertResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
