import 'package:flutter/material.dart';
import 'package:helloflutter/components/card_good_morning.dart';
import 'package:helloflutter/components/card_dashboard_info.dart';
import 'package:helloflutter/components/card_menu.dart';
import 'package:helloflutter/components/list_resto.dart';
import 'package:helloflutter/gen/fonts.gen.dart';
import 'package:helloflutter/screen/favorite_screen.dart';
import 'package:helloflutter/screen/search_screen.dart';
import 'package:helloflutter/screen/setting_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String user;
  static const routeName = "/dashboard";

  const DashboardScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Image.asset(
                        "images/background_app.png",
                        fit: BoxFit.fill,
                        width: screenSize.width,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CardGoodMorning(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                " $user".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontFamily: FontFamily.poppins,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CardDashboardInfo(),
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                      child: Text(
                        "Resto",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff59981A)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        "Eauteuy Recomendations",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 49, 94, 2)),
                      ),
                    ),
                    ListResto(screenSize),
                  ]),
            ),
            const Positioned(
              top: 2,
              right: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CardMenu(
                    colorMenu: Colors.grey,
                    iconMenu: Icons.settings,
                    screenName: SettingScreen.routeName,
                  ),
                  CardMenu(
                    colorMenu: Colors.red,
                    iconMenu: Icons.favorite,
                    screenName: FavoriteScreen.routeName,
                  ),
                  CardMenu(
                    colorMenu: Colors.brown,
                    iconMenu: Icons.search,
                    screenName: SearchScreen.routeName,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
