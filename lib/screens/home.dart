import 'package:flutter/material.dart';
import 'package:uni_map/main.dart';
import 'package:uni_map/building_details/ui/building_details.dart';
import 'package:uni_map/screens/search_history.dart';
import 'package:uni_map/screens/tab_screens/map.dart';
import 'package:uni_map/screens/tab_screens/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Row(
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
                height: 33,
                width:33,
                color: Colors.white,
              ),
              SizedBox(width: 5,),
              Text(
                'UniMap',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.history_outlined, 
                color: Colors.white,
                size: 30,
              ),
              tooltip: 'Historial de Búsqueda',
              onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchHistory()),
                    );
                  },
                )
          ],
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: tabBar(context),
        ),
        body: const TabBarView(
          children: [
            UniMap(),
            BuildingDetails(),
            Profile(),
          ],
        ),
      ),
    );
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Theme.of(context).colorScheme.primaryContainer,
      tabs: const <Widget>[
        Tab(
          icon: Icon(Icons.location_on_rounded,
          size: 30,),
          //text: titles[0],
        ),
        Tab(
          icon: Icon(Icons.apartment_outlined,
          size: 30,),
          //text: titles[1],
        ),
        Tab(
          icon: Icon(Icons.person,
          size: 30,),
          //text: titles[2],
        ),
      ],
    );
  }
}
