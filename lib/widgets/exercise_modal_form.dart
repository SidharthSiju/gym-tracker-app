import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/data/exercises_selection.dart';
import 'package:gym_app/models/exercise.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExerciseModalForm extends ConsumerStatefulWidget {
  const ExerciseModalForm({super.key});

  @override
  ConsumerState<ExerciseModalForm> createState() => _ExerciseModalFormState();
}

class _ExerciseModalFormState extends ConsumerState<ExerciseModalForm> {
  Exercise? _selectedExercise;
  var _selectedSets = 0;
  var _selectedReps = 0;
  var _selectedWeight = 0.0;
  var _selectedDuration = 0.0;
  final _formKey = GlobalKey<FormState>();

  void _saveExercise() async {
    if (_selectedExercise == null) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    Navigator.of(context).pop();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('workouts')
        .doc(_selectedExercise!.id)
        .set({
          'name': _selectedExercise!.name,
          'date_created': _selectedExercise!.date,
          'reps': _selectedReps,
          'sets': _selectedSets,
          'weight': _selectedWeight,
          'duration': _selectedDuration,
          'groups': _selectedExercise!.groups.name,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: DropdownMenu(
                enableFilter: true,
                requestFocusOnTap: true,
                width: 300,
                menuHeight: 200,
                onSelected: (value) {
                  _selectedExercise = value;
                },
                label: Text('Search for an exercise...'),
                dropdownMenuEntries: [
                  for (final entry in exercisesSelection)
                    DropdownMenuEntry(value: entry, label: entry.name),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      initialValue: '0',
                      decoration: InputDecoration(labelText: 'Sets'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _selectedSets = int.parse(newValue!);
                        _selectedExercise!.setSets(_selectedSets);
                      },
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      initialValue: '0',
                      decoration: InputDecoration(labelText: 'Reps'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _selectedReps = int.parse(newValue!);
                        _selectedExercise!.setReps(_selectedReps);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '*If applicable',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      initialValue: '0',
                      decoration: InputDecoration(labelText: 'Weight(kg)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _selectedWeight = double.parse(newValue!);
                        _selectedExercise!.setWeight(_selectedWeight);
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      initialValue: '0',
                      decoration: InputDecoration(labelText: 'Duration(sec)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _selectedDuration = double.parse(newValue!);
                        _selectedExercise!.setDuration(_selectedDuration);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: _saveExercise, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
