import 'package:flutter/material.dart';
import 'package:smartpointer/app/modules/expenses/widgets/bar_chart.dart';
import 'package:smartpointer/app/modules/expenses/widgets/donut_chart.dart';
import 'package:smartpointer/app/modules/expenses/widgets/pie_chart.dart';

class ChartView extends StatefulWidget {
  const ChartView({Key? key}) : super(key: key);

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  static List<Widget>? _children;
  int _currentIndex = 0;

  @override
  void initState() {
    _children = [PieChart(), BarChart(), DonutChart()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 246, 249, 1.0),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 0,
          backgroundColor: const Color.fromRGBO(245, 246, 249, 1.0),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            color: Colors.red,
            fontFamily: 'montserrat_medium',
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'montserrat_medium',
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              label: 'Piechart',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage('assets/images/pie-chart.png'),
                  size: 17,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Barchart',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage('assets/images/bar-chart.png'),
                  size: 17,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Donutchart',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage('assets/images/donut-chart.png'),
                  size: 17,
                ),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      body: _children!.elementAt(_currentIndex),
    );
  }
}
