// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sturmer/core/api_service.dart';
import 'package:sturmer/core/navigation/drawer.dart';
import 'package:sturmer/features/home/games/models/games.dart';
import 'package:sturmer/features/home/widgets/date_scroll_list_widget.dart';
import 'package:sturmer/theme/pallete.dart';

var apiService = ApiService();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Map<String, List<Games>> matchesCache = {};

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  final ScrollController scrollController = ScrollController();
  final today = DateTime.now();
  late final List<DateTime> dates;
  late List<Games> matches = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dates = List.generate(15, (index) => today.add(Duration(days: index - 7)));
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToToday());
  }

  void scrollToToday() {
    final todayIndex = dates.indexWhere((date) =>
        date.day == today.day &&
        date.month == today.month &&
        date.year == today.year);
    final initialScrollOffset =
        todayIndex * 70.0 - (MediaQuery.of(context).size.width / 2 - 35.0);
    scrollController.jumpTo(initialScrollOffset);
  }

  Future<void> onDateSelected(DateTime date) async {
    setState(() {
      selectedDate = date;
    });

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    if (matchesCache.containsKey(formattedDate)) {
      setState(() {
        matches = matchesCache[formattedDate]!;
      });
      return;
    }

    List<Games> allMatches = [];
    var apiService = ApiService();
    for (var leagueName in apiService.leagueNameToId.keys) {
      try {
        var fetchedMatches = await apiService.fetchMatches(
            date, apiService.leagueNameToId[leagueName]!);
        allMatches.addAll(fetchedMatches);
      } catch (e) {
        debugPrint('Error fetching matches for $leagueName: $e');
      }
    }

    matchesCache[formattedDate] = allMatches;
    setState(() {
      matches = allMatches;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

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
      body: Column(
        children: [
          DateScrollListWidget(
            currentTheme: currentTheme, // Skicka aktuellt tema
            scrollController: scrollController, // Skicka scrollController
            dates: dates, // Skicka alla datum
            selectedDate: selectedDate, // Skicka det valda datumet
            onDateSelected: onDateSelected, // Skicka funktionen
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: _buildLeaguesList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaguesList() {
    final currentTheme = ref.watch(themeNotifierProvider);

    final List<String> leagues = [
      'Handbollsligan Herr',
      'Handbollsligan Dam',
      'Allsvenskan Herr',
      'Allsvenskan Dam',
      // Lägg till fler ligor om nödvändigt
    ];

    return ListView.builder(
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        var leagueMatches = getMatchesForLeague(leagues[index], selectedDate);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Theme(
              data: currentTheme.copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                backgroundColor: currentTheme.backgroundColor,
                title: Row(
                  children: [
                    Text(leagues[index]),
                    const Spacer(),
                    Text(
                      '${leagueMatches.length}',
                      style: TextStyle(
                        color: currentTheme.textTheme.bodyLarge!.color,
                      ),
                    ),
                  ],
                ),
                children: leagueMatches
                    .map((match) => ListTile(
                          title:
                              Text('${match.home.name} vs ${match.away.name}'),
                          subtitle: Text('Time: ${match.time}'),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Games> getMatchesForLeague(String leagueName, DateTime date) {
    int leagueId = apiService.leagueNameToId[leagueName] ?? -1;
    return matches
        .where((game) =>
            game.league.id == leagueId &&
            DateFormat('yyyy-MM-dd').format(game.date) ==
                DateFormat('yyyy-MM-dd').format(date))
        .toList();
  }
}
