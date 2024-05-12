import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageWrapper extends StatefulWidget {
  const PageWrapper({
    super.key,
    required this.navShell,
  });

  final StatefulNavigationShell navShell;

  @override
  State<StatefulWidget> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  int pageIndex = 0;

  void _goToBranch(int i) {
    widget.navShell.goBranch(
      i,
      initialLocation: i == widget.navShell.currentIndex
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });

    _goToBranch(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SizedBox (   //We tell the page to take as much space as possible
        width: double.infinity,
        height: double.infinity,
        child: widget.navShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 63, 148, 223),
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color.fromARGB(255, 0, 38, 255),
      currentIndex: pageIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Like List'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'WinkelGids'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Qr Scan'),
        ],
      ),
    );
  }
}
