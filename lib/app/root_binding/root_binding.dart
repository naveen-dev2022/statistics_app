import 'package:get/get.dart';
import 'package:smartpointer/app/modules/accounts/controllers/accounts_controller.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpensesController>(() => ExpensesController(), fenix: true);
    Get.lazyPut<AccountsController>(() => AccountsController(), fenix: true);
    //  Get.put<TopChannelController>(TopChannelController());
  }
}
