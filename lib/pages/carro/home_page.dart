import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
    _tabController.addListener(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Clássicos",
            ),
            Tab(
              text: "Esportivos",
            ),
            Tab(
              text: "Luxo",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
