import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sturmer/features/leagues/models/league_table_model.dart';

void main() async {
  try {
    var leagueTable =
        await fetchLeagueTable(113); // Använd ett giltigt leagueId här
    print(leagueTable);
  } catch (e) {
    print('Error: $e');
  }
}

const String apiKey = 'c782c7db4989516cbc9f3319891c2068';
const String apiHost = 'v1.handball.api-sports.io';

// Din fetchLeagueTable funktion här
Future<List<LeagueTableModel>> fetchLeagueTable(int leagueId) async {
  var url =
      Uri.parse('https://$apiHost/standings?league=$leagueId&season=2023');

  var headers = {'x-rapidapi-key': apiKey, 'x-rapidapi-host': apiHost};

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    print(response.body);
    var data = jsonDecode(response.body);
    return List<LeagueTableModel>.from(data['response']
        .map((matchData) => LeagueTableModel.fromJson(matchData)));
  } else {
    throw Exception(
        'Failed to load tabels. Status code: ${response.statusCode}');
  }
}
