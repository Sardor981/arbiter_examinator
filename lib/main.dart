import 'package:arbiter_examinator/common/app/services/injcetion_container.dart';
import 'package:arbiter_examinator/presentation/screens/home_screen.dart';
import 'package:arbiter_examinator/presentation/screens/login_screen.dart';
import 'package:arbiter_examinator/provider/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initInjection();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('uz'), Locale('en'), Locale("ru")],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('uz'),
        startLocale: Locale("uz"),
        saveLocale: true,
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<AuthProvider>(),
        )
      ],
      child: ScreenUtilInit(
        designSize: MediaQuery.of(context).size.width >= 600
            ? const Size(1280, 800)
            : const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true, //size
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
