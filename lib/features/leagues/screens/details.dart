import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sturmer/core/api_service.dart';
import 'package:sturmer/core/navigation/drawer.dart';
import 'package:sturmer/features/leagues/models/league_table_model.dart';

var apiService = ApiService();

class LeagueDetailsScreen extends ConsumerWidget {
  final String? leagueName;
  final int? leagueId;

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  const LeagueDetailsScreen(
      {required this.leagueId, required this.leagueName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Stürmer',
                style: TextStyle(
                    fontFamily: 'Germania One',
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(width: 10),
              Icon(Icons.sports_handball_outlined),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                displayDrawer(context);
              },
            );
          }),
        ],
      ),
      endDrawer: const ListDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                leagueName!,
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<LeagueTableModel>>(
              future: apiService.fetchLeagues(leagueId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 20),
                    child: DataTable(
                      columnSpacing: 10,
                      columns: const [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('Team')),
                        DataColumn(label: Text('P')),
                        DataColumn(label: Text('W')),
                        DataColumn(label: Text('D')),
                        DataColumn(label: Text('L')),
                        DataColumn(label: Text('G')),
                        DataColumn(label: Text('Pts')),
                      ],
                      rows: snapshot.data!
                          .map(
                            (team) => DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.08);
                                }
                                if (snapshot.data!.indexOf(team) % 2 == 0) {
                                  return Colors.grey.withOpacity(0.3);
                                }
                                return null; // Use default value for other states and odd rows
                              }),
                              cells: [
                                DataCell(Text(team.position.toString())),
                                DataCell(Text(team.teamName)),
                                DataCell(Text(team.playedGames.toString())),
                                DataCell(Text(team.won.toString())),
                                DataCell(Text(team.draw.toString())),
                                DataCell(Text(team.lost.toString())),
                                DataCell(Text(
                                    '${team.goalsFor}:${team.goalsAgainst}')),
                                DataCell(Text(team.points.toString())),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
