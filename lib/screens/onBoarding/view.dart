import 'package:flutter/material.dart';
import 'package:news/core/components/navigateAndFinish.dart';
import 'package:news/screens/login/view.dart';
import '../../core/components/appText.dart';
import '../../l10n/app_localizations.dart';
import 'controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    navigateAndFinish(
                      context: context,
                      widget: const LoginScreen(),
                    );
                  },
                  child: DefaultText(
                    text: AppLocalizations.of(context)!.skip,
                    fontSize: 20,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    //width: double.infinity,
                    height: 450,
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        controller.currentIndex = index;
                        setState(() {});
                      },
                      //scrollDirection: Axis.horizontal,
                      children: List.generate(
                        controller.images.length,
                        (index) => Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                controller.images[controller.currentIndex],
                                width: double.infinity,
                                height: 250,
                                //width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultText(
                                text: controller.getTitle(
                                  index: index,
                                  context: context,
                                ),
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: CircleAvatar(
                      radius: controller.currentIndex == index ? 10 : 8,
                      backgroundColor: controller.currentIndex == index
                          ? Colors.white
                          : Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
