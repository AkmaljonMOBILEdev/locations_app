import 'package:flutter/material.dart';
import 'package:locations_app/ui/tab_box/list_screen/list_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/tab_box_provider.dart';
import 'map_screen/map_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(MapScreen());
    screens.add(ListScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<TabBoxProvider>().index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.deepPurple,
        onTap: (index) {
          context.read<TabBoxProvider>().changeIndex(index);
        },
        currentIndex: context.watch<TabBoxProvider>().index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map_sharp), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Saved"),
        ],
      ),
    );
  }
}
