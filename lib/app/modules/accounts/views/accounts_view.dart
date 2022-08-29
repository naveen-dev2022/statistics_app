import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartpointer/app/modules/accounts/controllers/accounts_controller.dart';
import 'package:smartpointer/app/modules/accounts/widgets/account_details_block.dart';
import 'package:smartpointer/values/utils/reusable_components.dart';

class AccountsView extends GetView<AccountsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppWidgets.appbar1(context, 'Accounts', () {}),
        body: Obx(() => controller.isInternetAvailable.value
            ? ListView(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  controller.isLoadingAccountsData.value
                      ? GridViewSkeletonLoader(
                          itemCount: 3,
                          itemsPerRow: 1,
                          childAspectRatio: 1.5,
                        )
                      : controller.accountsData.value.error == null
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller
                                  .accountsData.value.responseData!.length,
                              addAutomaticKeepAlives: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return AccountDetailsBlock(
                                    data: controller.accountsData.value
                                        .responseData![index],
                                    BGColor: controller.chooseCardBgColor(
                                        controller.accountsData.value
                                            .responseData![index].cardType),
                                    cardType: controller.findCardType(controller
                                        .accountsData
                                        .value
                                        .responseData![index]
                                        .cardType),
                                    controller: controller);
                              },
                            )
                          : ErrorMessage(
                              errorMessage: controller.accountsData.value.error,
                              onPressed: () {
                                controller.fetchAccountsData();
                              },
                            ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              )
            : const InternetConnectionError()));
  }
}
