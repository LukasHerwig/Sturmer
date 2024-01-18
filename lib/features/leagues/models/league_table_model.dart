// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LeagueTableModel {
  final String teamName;
  final int position;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  LeagueTableModel({
    required this.teamName,
    required this.position,
    required this.playedGames,
    required this.won,
    required this.draw,
    required this.lost,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
  });

  LeagueTableModel copyWith({
    String? teamName,
    int? position,
    int? playedGames,
    int? won,
    int? draw,
    int? lost,
    int? points,
    int? goalsFor,
    int? goalsAgainst,
    int? goalDifference,
  }) {
    return LeagueTableModel(
      teamName: teamName ?? this.teamName,
      position: position ?? this.position,
      playedGames: playedGames ?? this.playedGames,
      won: won ?? this.won,
      draw: draw ?? this.draw,
      lost: lost ?? this.lost,
      points: points ?? this.points,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      goalDifference: goalDifference ?? this.goalDifference,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teamName': teamName,
      'position': position,
      'playedGames': playedGames,
      'won': won,
      'draw': draw,
      'lost': lost,
      'points': points,
      'goalsFor': goalsFor,
      'goalsAgainst': goalsAgainst,
      'goalDifference': goalDifference,
    };
  }

  factory LeagueTableModel.fromMap(Map<String, dynamic> map) {
    return LeagueTableModel(
      teamName: map['team']['name'] as String,
      position: map['position'] as int,
      playedGames: map['games']['played'] as int,
      won: map['games']['win']['total'] as int,
      draw: map['games']['draw']['total'] as int,
      lost: map['games']['lose']['total'] as int,
      points: map['points'] as int,
      goalsFor: map['goals']['for'] as int,
      goalsAgainst: map['goals']['against'] as int,
      goalDifference:
          (map['goals']['for'] as int) - (map['goals']['against'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory LeagueTableModel.fromJson(String source) =>
      LeagueTableModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LeagueTableModel(teamName: $teamName, position: $position, playedGames: $playedGames, won: $won, draw: $draw, lost: $lost, points: $points, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, goalDifference: $goalDifference)';
  }

  @override
  bool operator ==(covariant LeagueTableModel other) {
    if (identical(this, other)) return true;

    return other.teamName == teamName &&
        other.position == position &&
        other.playedGames == playedGames &&
        other.won == won &&
        other.draw == draw &&
        other.lost == lost &&
        other.points == points &&
        other.goalsFor == goalsFor &&
        other.goalsAgainst == goalsAgainst &&
        other.goalDifference == goalDifference;
  }

  @override
  int get hashCode {
    return teamName.hashCode ^
        position.hashCode ^
        playedGames.hashCode ^
        won.hashCode ^
        draw.hashCode ^
        lost.hashCode ^
        points.hashCode ^
        goalsFor.hashCode ^
        goalsAgainst.hashCode ^
        goalDifference.hashCode;
  }
}
