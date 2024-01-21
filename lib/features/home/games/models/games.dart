class Games {
  final int id;
  final DateTime date;
  final String time;
  final League league;
  final Team home;
  final Team away;
  final Score scores;

  Games({
    required this.id,
    required this.date,
    required this.time,
    required this.league,
    required this.home,
    required this.away,
    required this.scores,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      id: json['id'] as int,
      date: DateTime.parse(json['date']),
      time: json['time'] as String,
      league: League.fromJson(json['league']),
      home: Team.fromJson(json['teams']['home']),
      away: Team.fromJson(json['teams']['away']),
      scores: Score.fromJson(json['scores']),
    );
  }
}

class League {
  final int id;
  final String name;

  League({
    required this.id,
    required this.name,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
    );
  }
}

class Score {
  final int? home;
  final int? away;

  Score({
    this.home,
    this.away,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      home: json['home'],
      away: json['away'],
    );
  }
}
