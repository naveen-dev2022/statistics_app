import 'package:get/get.dart';
import 'package:smartpointer/app/modules/expenses/bindings/expenses_binding.dart';
import 'package:smartpointer/app/modules/expenses/views/expenses_view.dart';
import 'package:smartpointer/app/modules/mainscreen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAINSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.EXPENSES,
      page: () => ExpensesView(),
      binding: ExpensesBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: _Paths.MAINSCREEN,
      page: () => MainScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),
  ];
}
