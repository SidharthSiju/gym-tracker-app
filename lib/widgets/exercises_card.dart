import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final authenticatedUser = FirebaseAuth.instance.currentUser!.uid;

class ExercisesCard extends StatelessWidget {
  const ExercisesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onPrimary;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(authenticatedUser)
          .collection('workouts')
          .orderBy('date_created', descending: true)
          .snapshots(),
      builder: (ctx, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
          return Center(child: Text('No messages to display...'));
        }
        if (snapshots.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        final loadedExercises = snapshots.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40, left: 13, right: 13),

          itemCount: loadedExercises.length,
          itemBuilder: (ctx, index) {
            Timestamp? previousTimestamp;
            DateTime? previousDate;
            final timestamp =
                loadedExercises[index].data()['date_created'] as Timestamp;
            final date = timestamp.toDate();
            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
            if (index > 0) {
              previousTimestamp =
                  loadedExercises[index - 1].data()['date_created']
                      as Timestamp;
              previousDate = previousTimestamp.toDate();
            }
            return Column(
              children: [
                if (index == 0)
                  Text(formattedDate, style: TextStyle(color: Colors.white)),
                if (index > 0 && previousDate!.day != date.day)
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        formattedDate,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11),
                            topRight: Radius.circular(11),
                          ),
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                        width: 500,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            loadedExercises[index].data()['name'],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (loadedExercises[index].data()['sets'] != 0)
                            Text(
                              'Sets: ${loadedExercises[index].data()['sets']}',
                              style: TextStyle(color: textColor),
                            ),
                          if (loadedExercises[index].data()['reps'] != 0)
                            Text(
                              'Reps: ${loadedExercises[index].data()['reps']}',
                              style: TextStyle(color: textColor),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (loadedExercises[index].data()['weight'] != 0)
                            Text(
                              'Weight(kg): ${loadedExercises[index].data()['weight']}',
                              style: TextStyle(color: textColor),
                            ),
                          if (loadedExercises[index].data()['duration'] != 0)
                            Text(
                              'Duration(sec): ${loadedExercises[index].data()['duration']}',
                              style: TextStyle(color: textColor),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            ChoiceChip(
                              label: Text(
                                loadedExercises[index].data()['groups'],
                              ),
                              selected: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
