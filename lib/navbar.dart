import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:extended_navbar_scaffold/extended_navbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'gmap.dart';

class ExtendedNavBar extends StatefulWidget {
  ExtendedNavBar({Key key}) : super(key: key);

  _ExtendedNavBarState createState() => _ExtendedNavBarState();
}

class _ExtendedNavBarState extends State<ExtendedNavBar> {
  @override
  Widget build(BuildContext context) {
    return ExtendedNavigationBarScaffold(
      body: GMap(),
      elevation: 0,
      navBarColor: Colors.white,
      navBarIconColor: Colors.black,
      moreButtons: [
        MoreButtonModel(
          icon: MaterialCommunityIcons.wallet,
          label: 'Wallet',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: MaterialCommunityIcons.parking,
          label: 'My Bookings',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: MaterialCommunityIcons.car_multiple,
          label: 'My Cars',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: FontAwesome.book,
          label: 'Transactions',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: MaterialCommunityIcons.home_map_marker,
          label: 'Offer Parking',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: FontAwesome5Regular.user_circle,
          label: 'Profile',
          onTap: () {},
        ),
        null,
        MoreButtonModel(
          icon: EvaIcons.settings,
          label: 'Settings',
          onTap: () {},
        ),
        null,
      ],
      searchWidget: Container(
        height: 50,
        color: Colors.redAccent,
      ),
      // onTap: (button) {},
      // currentBottomBarCenterPercent: (currentBottomBarParallexPercent) {},
      // currentBottomBarMorePercent: (currentBottomBarMorePercent) {},
      // currentBottomBarSearchPercent: (currentBottomBarSearchPercent) {},
      parallexCardPageTransformer: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: parallaxCardItemsList.length,
            itemBuilder: (context, index) {
              final item = parallaxCardItemsList[index];
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(index);
              return ParallaxCardsWidget(
                item: item,
                pageVisibility: pageVisibility,
              );
            },
          );
        },
      ),
    );
  }

  final parallaxCardItemsList = <ParallaxCardItem>[
    ParallaxCardItem(
        title: 'Some Random Route 1',
        body: 'Place 1',
        background: Container(
          color: Colors.orange,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 2',
        body: 'Place 2',
        background: Container(
          color: Colors.redAccent,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 3',
        body: 'Place 1',
        background: Container(
          color: Colors.blue,
        )),
  ];
}
