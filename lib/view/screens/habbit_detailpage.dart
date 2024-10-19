import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../modal/helper/dataHelper.dart';

class HabbitDetailpage extends StatefulWidget {
  const HabbitDetailpage({super.key});

  @override
  State<HabbitDetailpage> createState() => _HabbitDetailpageState();
}

class _HabbitDetailpageState extends State<HabbitDetailpage> {
  TextEditingController habitController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  List<Map<String, dynamic>> habits = [];

  @override
  void initState() {
    super.initState();
    loadHabits();
  }

  Future<void> loadHabits() async {
    await DbHelper.dbHelper.initDB();
    final fetchedHabits = await DbHelper.dbHelper.fetchHabits();
    setState(() {
      habits = fetchedHabits.map((habit) {
        return {
          'id': habit['id'],
          'title': habit['title'],
          'time': habit['time'],
          'completed': habit['completed'] == 1,
          'color': Colors.grey,
        };
      }).toList();
    });
  }

  void addHabit() async {
    String habitName = habitController.text;
    String habitTime = timeController.text;

    if (habitName.isNotEmpty && habitTime.isNotEmpty) {
      await DbHelper.dbHelper.addDb(habitName, habitTime);
      habitController.clear();
      timeController.clear();
      loadHabits();
    }
  }

  void toggleHabitCompletion(int index) async {
    setState(() {
      habits[index]['completed'] = !habits[index]['completed'];
    });
    await DbHelper.dbHelper.updateHabit(habits[index]['id']);
  }

  void deleteHabit(int id) async {
    await DbHelper.dbHelper.removeDB(id);
    loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Create a Custom Habit',
          style: GoogleFonts.getFont(
            'Mulish',
            textStyle:
                const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add new habit for today!',
              style: GoogleFonts.getFont(
                'Mulish',
                textStyle: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: habitController,
              decoration: const InputDecoration(
                labelText: "Habit Name",
                border: OutlineInputBorder(),
                hintText: "Enter your habit",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                labelText: "Start Time",
                border: OutlineInputBorder(),
                hintText: "e.g. Start at 9:30 AM",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addHabit,
              child: Text(
                "Add Habit",
                style: GoogleFonts.getFont("Mulish",
                    textStyle: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: habit['color'].withOpacity(0.1),
                        child: Icon(Icons.task_alt, color: habit['color']),
                      ),
                      title: Text(
                        habit['title'],
                        style: GoogleFonts.getFont("Mulish",
                            textStyle: const TextStyle(fontSize: 16)),
                      ),
                      subtitle: Text(
                        habit['time'],
                        style: GoogleFonts.getFont("Mulish",
                            textStyle: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ),
                      trailing: habit['completed']
                          ? const Icon(Icons.check_circle,
                              color: Colors.blueAccent)
                          : const Icon(Icons.radio_button_unchecked,
                              color: Colors.grey),
                      onTap: () => toggleHabitCompletion(index),
                      onLongPress: () => deleteHabit(habit['id']),
                    ),
                  ),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (habits.isNotEmpty) {
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please add a habit first."),
                        ));
                      }
                    },
                    child: Text(
                      'Continue',
                      style: GoogleFonts.getFont("Mulish",
                          textStyle: TextStyle(fontSize: 14)),
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
