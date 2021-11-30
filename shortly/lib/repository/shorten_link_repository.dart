import 'package:shortly/models/shorten_link_model.dart';
import 'package:shortly/models/shorten_link_response.dart';
import 'package:shortly/networking/api_base_helper.dart';

/// Repository which uses [ApiBaseHelper] to perform a request to get shortened link [ShortenLinkModel]
class ShortenLinkRepository {
  ShortenLinkRepository(this._apiHelper);

  final ApiBaseHelper _apiHelper;

  Future<ShortenLinkModel> shortenLink(String link) async {
    final response = await _apiHelper.get('shorten', {'url': '$link'});
    return ShortenLinkResponse.fromJson(response).result;
  }
}