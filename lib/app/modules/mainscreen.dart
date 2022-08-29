import 'package:flutter/material.dart';
import 'package:smartpointer/app/modules/expenses/views/expenses_view.dart';

import 'accounts/views/accounts_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget>? _children;
  int _currentIndex = 1;

  @override
  void initState() {
    _children = [
      Scaffold(
          body: Container(
        child: const Center(
          child: Text('HOME'),
        ),
      )),
      ExpensesView(),
      Scaffold(
          body: Container(
        child: const Center(
          child: Text('PORFOLIO'),
        ),
      )),
      AccountsView(),
      Scaffold(
          body: Container(
        child: const Center(
          child: Text('MORE'),
        ),
      )),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 10,
        backgroundColor: Colors.white,
        selectedItemColor: Color.fromRGBO(93, 122, 196, 1.0),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          color: Color.fromRGBO(93, 122, 196, 1.0),
          fontFamily: 'montserrat_regular',
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'montserrat_regular',
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageIcon(
              AssetImage('assets/images/home-3.png'),
              size: 18,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Expenses',
            icon: ImageIcon(
              AssetImage('assets/images/expense.png'),
              size: 18,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Portfolio',
            icon: ImageIcon(
              AssetImage('assets/images/portfolio.png'),
              size: 18,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Accounts',
            icon: ImageIcon(
              AssetImage('assets/images/user.png'),
              size: 18,
            ),
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(
              Icons.more_horiz,
              size: 18,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _children!.elementAt(_currentIndex),
    );
  }
}
