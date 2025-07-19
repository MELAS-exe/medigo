import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medigo/presentation/features/home/screens/home.dart';
import 'package:medigo/presentation/features/map/screens/map_screen.dart';
import 'package:medigo/presentation/features/health/screens/health_screen.dart';
import 'package:medigo/presentation/features/solidarity/screens/solidarity_screen.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    MapScreen(),
    HealthScreen(),
    SolidarityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(index: _currentIndex, children: _pages),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 240,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            _currentIndex == 0
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Image.asset("assets/home.png")),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            _currentIndex == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Image.asset("assets/carte.png")),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            _currentIndex == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Image.asset("assets/medecin.png")),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 3;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            _currentIndex == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Image.asset("assets/donation.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
