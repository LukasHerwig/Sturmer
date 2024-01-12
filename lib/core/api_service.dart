import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sturmer/features/home/games/models/games.dart';

class ApiService {
  static const String apiKey = 'c782c7db4989516cbc9f3319891c2068';
  static const String apiHost = 'v1.handball.api-sports.io';

  Future<List<Games>> fetchMatches(DateTime date, int leagueId) async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(date);
    var url = Uri.parse(
        'https://$apiHost/games?league=$leagueId&season=2023&date=$formattedDate');

    var headers = {'x-rapidapi-key': apiKey, 'x-rapidapi-host': apiHost};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<Games>.from(
          data['response'].map((matchData) => Games.fromJson(matchData)));
    } else {
      throw Exception(
          'Failed to load matches. Status code: ${response.statusCode}');
    }
  }

  final Map<String, int> leagueNameToId = {
    'Handbollsligan Herr': 113,
    'Handbollsligan Dam': 114,
    'Allsvenskan Herr': 111,
    'Allsvenskan Dam': 112,
  };
}
