import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateScrollListWidget extends StatelessWidget {
  const DateScrollListWidget({
    super.key,
    required this.currentTheme,
    required this.scrollController,
    required this.dates,
    required this.selectedDate, // Lägg till denna rad
    required this.onDateSelected, // Lägg till denna rad
  });

  final ThemeData currentTheme;
  final ScrollController scrollController;
  final List<DateTime> dates;
  final DateTime selectedDate;
  final Future<void> Function(DateTime date)
      onDateSelected; // Lägg till denna rad

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentTheme.backgroundColor,
      height: 80,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected =
              date.day == selectedDate.day && // Använd selectedDate här
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date), // Uppdatera tillståndet här
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red[500] : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.E().format(date).substring(0, 3),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
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
    );
  }
}
