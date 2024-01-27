import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/models/content_response.dart';

class ContentRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/exclusive-content';

  Future<ContentResponse?> getContent(
      {required String category, required bool highlighted}) async {
    final url = Uri.http(_baseUrl, _path, {
      'category': category,
      'highlighted': highlighted.toString(),
      'shown': 'true',
      'published': 'true'
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ContentResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
