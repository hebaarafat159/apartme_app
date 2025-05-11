import 'package:apartme/firebase_options.dart';
import 'package:apartme/pages/home_page.dart';
import 'package:apartme/pages/login_page.dart';
import 'package:apartme/pages/web_view_page.dart';
import 'package:apartme/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowMaterialGrid: false,
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Apartme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _route,
    );
  }
}

final _route = GoRouter(
  initialLocation: HomePage.routeName,
  redirect: (context, state) {
    if (Provider.of<UserProvider>(context, listen: false).user == null) {
      return LoginPage.routeName;
    }
    return null;
  },
  routes: [
    GoRoute(
      name: HomePage.routeName,
      path: HomePage.routeName,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          name: WebViewPage.routeName,
          path: WebViewPage.routeName,
          builder: (context, state) => WebViewPage(),
          //     WebViewPage(
          //   category: state.extra as CategoryModel,
          // ),
        ),
        // GoRoute(
        //   name: ProductsPage.routeName,
        //   path: ProductsPage.routeName,
        //   builder: (context, state) => ProductsPage(
        //     category: state.extra as CategoryModel,
        //   ),
        // ),
        // GoRoute(
        //     name: ProductDetailsPage.routeName,
        //     path: ProductDetailsPage.routeName,
        //     builder: (context, state) => ProductDetailsPage(
        //       id: state.extra as String,
        //     )),
        // GoRoute(
        //   name: CartPage.routeName,
        //   path: CartPage.routeName,
        //   builder: (context, state) => CartPage(),
        // ),
      ],
    ),
    GoRoute(
      name: LoginPage.routeName,
      path: LoginPage.routeName,
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
