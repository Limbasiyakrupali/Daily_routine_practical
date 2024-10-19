import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../habit_modal.dart';

class HomePage extends StatelessWidget {
  final List<Habit> habits = [
    Habit('Read a book for 15 minutes', Icons.book, Colors.blueAccent),
    Habit('Meditate for 30 minutes', Icons.self_improvement, Colors.green),
    Habit('Drink 5 glasses of water', Icons.local_drink, Colors.purpleAccent),
    Habit('Run up to 1 km', Icons.directions_run, Colors.pinkAccent),
    Habit('Doing homework', Icons.school, Colors.yellow),
    Habit('Morning workout', Icons.fitness_center, Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Habit',
          style:
              GoogleFonts.getFont("Mulish", textStyle: TextStyle(fontSize: 22)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: habit.color.withOpacity(0.1),
                              child: Icon(habit.icon, color: habit.color),
                            ),
                            title: Text(
                              habit.name,
                              style: GoogleFonts.getFont("Mulish",
                                  textStyle: TextStyle(fontSize: 15)),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                "habbit_timer",
                                arguments: {
                                  'habitName': habit.name,
                                  'habitIcon': habit.icon,
                                  'habitColor': habit.color,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed("habbit_detail");
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Create a custom habit",
                      style: GoogleFonts.getFont("Mulish",
                          textStyle: const TextStyle(fontSize: 14)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Continue',
                      style: GoogleFonts.getFont("Mulish",
                          textStyle: const TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
