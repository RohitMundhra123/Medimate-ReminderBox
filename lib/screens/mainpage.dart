// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medbox/screens/about.dart';
import 'package:medbox/screens/homescreen.dart';
import 'package:medbox/screens/profile.dart';
import 'package:medbox/screens/schedulescreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> _screens;

  int index = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const ScheduleScreen(),
      const ProfilePage(),
      const AboutPage(),
    ];
  }

  AppBar appBar() {
    return AppBar(
      title: const Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/logos/logo.png"),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "MediMate ReminderBox",
            style: TextStyle(
                letterSpacing: 1.1,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).size.width <= 500) ? appBar() : null,
      body: Row(children: [
        if (MediaQuery.of(context).size.width >= 500)
          NavigationRail(
            extended: MediaQuery.of(context).size.width >= 800 ? true : false,
            elevation: 5,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/logos/logo.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MediaQuery.of(context).size.width >= 800
                      ? const Text(
                          "MediMate ReminderBox",
                          style: TextStyle(
                              letterSpacing: 1.1,
                              color: Colors.greenAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        )
                      : const Column(
                          children: [
                            Text(
                              "MediMate",
                              style: TextStyle(
                                  letterSpacing: 1.1,
                                  color: Colors.greenAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "ReminderBox",
                              style: TextStyle(
                                  letterSpacing: 1.1,
                                  color: Colors.greenAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                ],
              ),
            ),
            indicatorShape: const RoundedRectangleBorder(),
            //  minExtendedWidth: 200,
            indicatorColor: Colors.transparent,
            backgroundColor: const Color(0x800C1320),
            selectedLabelTextStyle: const TextStyle(
                color: Color(0xFF24CCCC),
                fontSize: 16,
                fontWeight: FontWeight.w700),
            unselectedLabelTextStyle: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w500),
            destinations: [
              _buildIconRailButton(0, "Home"),
              _buildIconRailButton(1, "Schedule"),
              _buildIconRailButton(2, "Profile"),
              _buildIconRailButton(3, "About"),
            ],
            selectedIndex: index,
            onDestinationSelected: (value) {
              setState(() {
                index = value;
              });
            },
          ),
        Expanded(child: _screens[index])
      ]),
      bottomNavigationBar: MediaQuery.of(context).size.width < 500
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF0C1320),
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              unselectedFontSize: 14,
              elevation: 0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.white,
              selectedItemColor: const Color(0xFF24CCCC),
              selectedLabelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              items: [
                _buildIconButton(0, "Home"),
                _buildIconButton(1, "Schedule"),
                _buildIconButton(2, "Profile"),
                _buildIconButton(3, "About"),
              ],
              currentIndex: index,
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
            )
          : null,
    );
  }

  _buildIconButton(int x, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset("assets/icons/${label.toLowerCase()}.svg",
          height: 24,
          width: 24,
          color: x == index ? const Color(0xFF24CCCC) : Colors.white),
      label: label,
    );
  }

  _buildIconRailButton(int x, String label) {
    return NavigationRailDestination(
      icon: SvgPicture.asset("assets/icons/${label.toLowerCase()}.svg",
          height: 24,
          width: 24,
          color: x == index ? const Color(0xFF24CCCC) : Colors.white),
      padding: EdgeInsets.zero,
      label: Text(label),
    );
  }
}
