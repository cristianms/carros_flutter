import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carros/carros_page.dart';
import 'package:carros/pages/favoritos/favoritos_page.dart';
import 'package:flutter/material.dart';
import 'package:carros/utils/prefs.dart';

import 'carros_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    this._initTabs();
  }

  _initTabs() async {
    _tabController.index = await Prefs.getInt("tabIdx");
    print("Tab default ${_tabController.index}");

    _tabController.addListener(() {
      print("Tab clicada ${_tabController.index}");
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Carros"),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: "Clássicos",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Esportivos",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Luxo",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Favoritos",
                  icon: Icon(Icons.favorite),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              CarrosPage(TipoCarro.classicos),
              CarrosPage(TipoCarro.esportivos),
              CarrosPage(TipoCarro.luxo),
              FavoritosPage(),
            ],
          ),
          drawer: DrawerList(),
        ));
  }
}
