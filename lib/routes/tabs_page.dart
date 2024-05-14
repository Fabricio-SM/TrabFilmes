

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/profile_page.dart';

import 'posts_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}); // Remova o "super" aqui

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2, // Este é o número de guias (tabs).
      child: Scaffold(
        body: TabBarView(
          children: const [
            Home(),
            MyProfile(),
          ],
        ),
        bottomNavigationBar: Container(
          height: mediaQuery.height / 12,
          decoration: const BoxDecoration(
            color: Color.fromARGB(150, 86, 223, 223),
          ),
          child: const TabBar(
            unselectedLabelColor: Colors.white,
            tabs: [
              SizedBox(
                height: 60,
                width: 30,
                child: Tab(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 30,
                child: Tab(
                  icon: Icon(
                    Icons.account_box,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
