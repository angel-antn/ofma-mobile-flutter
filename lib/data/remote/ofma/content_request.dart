import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/models/content_response.dart';

class ContentRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/exclusive-content';

  Future<ContentResponse?> getContent(
      {required String category,
      required bool highlighted,
      String? name}) async {
    final url = Uri.http(_baseUrl, _path, {
      'category': category,
      'highlighted': highlighted.toString(),
      'shown': 'true',
      'published': 'true',
      'name': name
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ContentResponse.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Content?> getContentById(String id) async {
    final url = Uri.http(_baseUrl, '$_path/$id');

    final response = await http.get(url);

    //TODO: for presentation only
    await Future.delayed(Duration(milliseconds: 1000));

    if (response.statusCode == 200) {
      return Content.fromJson(response.body);
    } else {
      return null;
    }
  }
}
