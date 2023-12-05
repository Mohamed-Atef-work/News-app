import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/core/dataBase/local/constants.dart';
import 'package:news/screens/Home/controller/controller.dart';
import 'package:news/screens/Home/controller/states.dart';
import 'package:news/screens/Home/widgets/bottomNavItem.dart';

import '../HomeScreens/drawer/view.dart';

class HomeLayOutScreen extends StatelessWidget {
  const HomeLayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeController>(
          create: (context) => HomeController()
            ..getArticles(
              category: "general",
              country: country,
            ),
        ),
      ],
      child: BlocConsumer<HomeController, HomeStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              title: DefaultText(
                text: HomeController.get(context).getTitle(
                  index: HomeController.get(context).currentIndex,
                  context: context,
                ),
                fontSize: 25,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      //AppCubit.get(context).changeAppMode();
                    },
                    icon: const Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: HomeController.get(context)
                .screens[HomeController.get(context).currentIndex],
            bottomNavigationBar: BottomNav(),
          );
        },
      ),
    );
  }
}
