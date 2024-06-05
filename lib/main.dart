import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/core/dataBase/local/cache_helper.dart';
import 'package:news/l10n/app_localizations.dart';
import 'core/cubit/states.dart';
import 'core/dataBase/local/constants.dart';
import 'core/styles/themes.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  //Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();

  uId = CacheHelper.getData(key: "uId");
  print("The user id is ------------------->${uId}");
  language = CacheHelper.getData(key: "lang");
  print("The user language is ------------------->${language}");

  /*country = CacheHelper.getData(
    key: "country",
  );
  print("The user id is ------------------->${country}");*/

  runApp(
    uId != null
        ? BlocProvider<AppController>(
            create: (_) => AppController()
              ..getUser()
              ..listenToTheChangesOnMarkedArticles(),
            child: const MyApp(),
          )
        : BlocProvider<AppController>(
            create: (_) => AppController(),
            child: const MyApp(),
          ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppController, AppStates>(
      listener: (_, __) {},
      builder: (context, states) {
        return MaterialApp(
          theme: lightTheme,
          home: AppController.get(context).startScreen(),
          locale: language == null ? null : Locale(language!),
          supportedLocales: AppLocalizations.supportedLocales,
          title: AppLocalizations.of(context)?.appName ?? "news",
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          localeResolutionCallback: AppController.get(context).localeCallBack,
          //debugShowCheckedModeBanner: false,
          //darkTheme: darkTheme,
        );
      },
    );
  }
}

/*class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}*/
