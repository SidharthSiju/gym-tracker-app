import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/widgets/exercise_modal_form.dart';
import 'package:gym_app/widgets/exercises_card.dart';
import 'package:gym_app/widgets/main_drawer.dart';

class ExercisesScreen extends ConsumerWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      drawer: MainDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: ExercisesCard()),
                SizedBox(height: 40),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(
                              context,
                            ).viewInsets.bottom, // keyboard safe
                            left: 16,
                            right: 16,
                            top: 16,
                          ),
                          child: const Center(child: ExerciseModalForm()),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 15,
            top: 25,
            child: FloatingActionButton(
              elevation: 0,
              mini: true,
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
