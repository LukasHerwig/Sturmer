import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sturmer/theme/pallete.dart'; // Importera intl för datumformatering

class GamesScreen extends ConsumerStatefulWidget {
  const GamesScreen({super.key});

  @override
  ConsumerState<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends ConsumerState<GamesScreen> {
  // var today = DateTime.now();
  // var dates =
  //     List.generate(15, (index) => today.add(Duration(days: index - 7)));
  // final ScrollController scrollController =
  //     ScrollController(initialScrollOffset: (dates.length ~/ 2) * 70.0);

  final ScrollController scrollController = ScrollController();
  final today = DateTime.now();
  late final List<DateTime> dates;

  @override
  void initState() {
    super.initState();
    dates = List.generate(15, (index) => today.add(Duration(days: index - 7)));
    // Sätt en callback för att skrolla efter att bygget är klart
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToToday());
  }

  void scrollToToday() {
    // Beräknar index för dagens datum
    final todayIndex = dates.indexWhere((date) =>
        date.day == today.day &&
        date.month == today.month &&
        date.year == today.year);

    // Beräknar den initiala skrolloffseten
    final initialScrollOffset =
        todayIndex * 70.0 - (MediaQuery.of(context).size.width / 2 - 35.0);
    scrollController.jumpTo(initialScrollOffset);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: currentTheme.backgroundColor,
            height: 80, // Höjden på den horisontella listan
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final isSelected = date.day == today.day &&
                    date.month == today.month &&
                    date.year == today.year;
                return GestureDetector(
                  onTap: () {
                    // Uppdatera tillståndet för att visa den valda dagens matcher
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8), // Utrymme mellan elementen
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50, // Storlek på cirkeln
                          height: 50, // Storlek på cirkeln
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.red[500] : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.E()
                                    .format(date)
                                    .substring(0, 3), // Veckodagen
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                '${date.day}', // Datumet
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            // Resten av skärmen för att visa matcher eller andra data
            child: Container(),
          ),
        ],
      ),
    );
  }
}
