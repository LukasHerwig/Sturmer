import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sturmer/core/api_service.dart';
import 'package:sturmer/features/leagues/models/league_table_model.dart';
import 'package:sturmer/features/leagues/screens/leagues.dart';
import 'package:sturmer/theme/pallete.dart';

var apiService = ApiService();

class LeagueDetailsScreen extends ConsumerWidget {
  final String? leagueName;
  final int? leagueId;

  const LeagueDetailsScreen(
      {required this.leagueId, required this.leagueName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height;
    final double itemWidth = size.width;

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
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarExtension(
              currentTheme: currentTheme,
              width: itemWidth,
              title: '$leagueName',
              height: 50,
              fontSize: 22,
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<LeagueTableModel>>(
              future: apiService.fetchLeagues(leagueId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: const Row(
                            children: [
                              Expanded(
                                  flex: 0,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 5, top: 5, left: 5, right: 8),
                                    child: Text('#'),
                                  )), // Justera 'flex' efter behov
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Team',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'M',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  )),
                              // Expanded(
                              //     flex: 2,
                              //     child: Center(
                              //       child: Text(
                              //         'W/D/L',
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     )),
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      'G',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'P',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              // Fortsätt med de andra kolumnerna...
                            ],
                          ),
                        ),
                        ...snapshot.data!.map((team) {
                          return Column(
                            children: [
                              const Divider(height: 1, color: Colors.grey),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0,
                                            bottom: 5,
                                            top: 5,
                                            left: 5),
                                        child: Text(team.position.toString()),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        team.teamName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      team.playedGames.toString(),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: Center(
                                  //     child: Text(
                                  //         '${team.won}/${team.draw}/${team.lost}'),
                                  //   ),
                                  // ),
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                            '${team.goalsFor}:${team.goalsAgainst}'),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(team.points.toString())),
                                  // Fortsätt med de andra kolumnerna...
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
                  // return Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 5.0, right: 5.0, bottom: 20),
                  //   child: DataTable(
                  //     columnSpacing: 12,
                  //     dataRowMinHeight: 30,
                  //     dataRowMaxHeight: 40,
                  //     headingRowHeight: 40,
                  //     columns: const [
                  //       DataColumn(label: Text('')),
                  //       DataColumn(label: Text('Team')),
                  //       DataColumn(label: Text('P')),
                  //       DataColumn(label: Text('W')),
                  //       DataColumn(label: Text('D')),
                  //       DataColumn(label: Text('L')),
                  //       DataColumn(label: Text('G')),
                  //       DataColumn(label: Text('Pts')),
                  //     ],
//                       rows: snapshot.data!
//                           .map(
//                             (team) => DataRow(
//                               color: MaterialStateProperty.resolveWith<Color?>(
//                                   (Set<MaterialState> states) {
//                                 if (states.contains(MaterialState.selected)) {
//                                   return Theme.of(context)
//                                       .colorScheme
//                                       .primary
//                                       .withOpacity(0.08);
//                                 }
//                                 if (snapshot.data!.indexOf(team) % 2 == 0) {
//                                   return Colors.grey.withOpacity(0.3);
//                                 }
//                                 return null; // Use default value for other states and odd rows
//                               }),
//                               cells: [
//                                 DataCell(Text(team.position.toString())),
//                                 DataCell(Text(team.teamName)),
//                                 DataCell(Text(team.playedGames.toString())),
//                                 DataCell(Text(team.won.toString())),
//                                 DataCell(Text(team.draw.toString())),
//                                 DataCell(Text(team.lost.toString())),
//                                 DataCell(Text(
//                                     '${team.goalsFor}:${team.goalsAgainst}')),
//                                 DataCell(Text(team.points.toString())),
//                               ],
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   );
//                 } else {
//                   return Text('No data available');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
