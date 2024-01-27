import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ofma_app/models/musician.response.dart';

class MusicianRequest {
  final String _baseUrl = dotenv.env['HOST_API'] ?? '';
  final String _path = '/api/musician';

  Future<MusicianResponse?> getMusicians(
      {required bool highlighted, String? name}) async {
    final url = Uri.http(_baseUrl, _path,
        {'highlighted': highlighted.toString(), 'name': name ?? ''});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MusicianResponse.fromJson(response.body);
    } else {
      return null;
    }
  }
}
