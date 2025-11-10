import 'package:flutter/material.dart';
import 'package:gym_app/widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      drawer: MainDrawer(),
      body: Stack(
        children: [
          Center(
            child: Text(
              'Nothing to display',
              style: TextStyle(color: Colors.white),
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
