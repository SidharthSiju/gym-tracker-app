import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/providers/screen_state_provider.dart';
import 'package:gym_app/screens/exercises.dart';
import 'package:gym_app/screens/home.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _listTileColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final currentScreen = ref.watch(screenStateProvider);

    void chooseScreen(String screenRef, Widget screenWidget) async {
      if (screenRef == currentScreen) {
        Navigator.of(context).pop();
        return;
      }

      ref.read(screenStateProvider.notifier).setScreen(screenRef);
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) {
            return screenWidget;
          },
        ),
      );
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 130),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            child: Row(
              children: [
                Expanded(child: Icon(Icons.sports_gymnastics, size: 50)),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            leading: Icon(Icons.home, color: _listTileColor),
            title: Text('Home', style: TextStyle(color: _listTileColor)),
            onTap: () {
              chooseScreen('home', HomeScreen());
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            leading: Icon(Icons.check, color: _listTileColor),
            title: Text('Exercise', style: TextStyle(color: _listTileColor)),
            onTap: () {
              chooseScreen('exercise', ExercisesScreen());
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            leading: Icon(Icons.chat_bubble, color: _listTileColor),
            title: Text('Chatbot', style: TextStyle(color: _listTileColor)),
            onTap: () {},
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              leading: Icon(Icons.exit_to_app, color: _listTileColor),
              title: Text('Sign Out', style: TextStyle(color: _listTileColor)),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
