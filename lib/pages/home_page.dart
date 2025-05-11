import 'package:apartme/pages/login_page.dart';
import 'package:apartme/pages/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../providers/user_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerViewComponent(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<UserProvider>(context, listen: false)
                  .logout();
              context.go(HomePage.routeName);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Click the button to view the apartment",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    context.go(WebViewPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text(
                    "View Apartment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Consumer<CategoryProvider>(
      //   builder: (context, provider, child) => provider.categories!.isEmpty
      //       ? const Center(
      //     child: Text(" No Categories Found ... "),
      //   )
      //       : GridView.builder(
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //       ),
      //       itemCount: provider.categories!.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return CategoryListItem(
      //             category: provider.categories![index],
      //             onPress: (value) {
      //               context.go(ProductsPage.routeName,
      //                   extra: provider.categories![index]);
      //             });
      //       }),
      // ),
    );
  }
}
