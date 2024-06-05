import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/dataBase/local/constants.dart';
import 'package:news/screens/Home/controller/controller.dart';
import 'package:news/screens/Home/controller/states.dart';
import 'package:news/screens/Home/widgets/bottomNavItem.dart';

import '../home_screens/drawer/view.dart';

class HomeLayOutScreen extends StatelessWidget {
  const HomeLayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeController()
        ..getArticles(
          category: "general",
          country: country,
        ),
      child: BlocBuilder<HomeController, HomeStates>(
        builder: (context, state) {
          final controller = HomeController.get(context);
          return Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
              title: DefaultText(
                text: controller.getTitle(
                  index: controller.currentIndex,
                  context: context,
                ),
                fontSize: 25,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: controller.screens[controller.currentIndex],
            bottomNavigationBar: BottomNav(),
          );
        },
      ),
    );
  }
}
