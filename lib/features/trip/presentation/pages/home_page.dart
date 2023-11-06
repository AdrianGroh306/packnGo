import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/presentation/pages/addtrip_page.dart';
import 'package:travel_app/features/trip/presentation/pages/mytrip_page.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';

class HomePage extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripListNotifierProvider.notifier).loadTrips();

    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });

    return Scaffold(
      appBar: AppBar(elevation: 0,toolbarHeight: 100,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("Hi Tobi :D"),
        Text("Travelling Today ?")],
      ),),
      body: PageView(
        controller: _pageController,
        children: [
          MyTripPage(),
          AddTripPage(),
          Text("3"),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) {
          return BottomNavigationBar(
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                  label: "My Trips", icon: Icon(Icons.list)),
              BottomNavigationBarItem(
                  label: "Add Trips", icon: Icon(Icons.add)),
              BottomNavigationBarItem(
                  label: "Maps", icon: Icon(Icons.map))
            ],
          );
        },
      ),
    );
  }
}
