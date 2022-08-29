import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';
import 'package:smartpointer/app/modules/expenses/views/chart_view.dart';
import 'package:smartpointer/app/modules/expenses/widgets/category_statistics_block.dart';
import 'package:smartpointer/values/utils/reusable_components.dart';

class ExpensesView extends GetView<ExpensesController> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 246, 249, 1.0),
        appBar: AppWidgets.appbar(context, '', () {
          controller.isShowBackButton.value = false;
          controller.appBarTitle.value = 'Expenses';
          controller.chooseCategory.value = 'CATEGORY';
          controller.plotDataIntoCharts();
        }),
        body: Obx(() => controller.isInternetAvailable.value
            ? ListView(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  controller.isLoadingCategoryStatisticsData.value
                      ? GridViewSkeletonLoader(
                          itemCount: 1,
                          itemsPerRow: 1,
                          childAspectRatio: 1.5,
                        )
                      : controller.categoryStatisticsData.value.error == null
                          ? currentOrientation == Orientation.portrait
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: height / 2.7,
                                  width: width,
                                  child: const ChartView())
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: height / 1.5,
                                  width: width,
                                  child: const ChartView())
                          : ErrorMessage(
                              errorMessage:
                                  controller.categoryStatisticsData.value.error,
                              onPressed: () {
                                controller.fetchCategoryStatisticsData(
                                    '2021-06-09', '2021-06-10');
                              },
                            ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          width: width,
                          child: AppWidgets.buildText(
                            text: 'Top Spending Categories',
                            fontFamily: 'montserrat_bold',
                            fontSize: 22,
                          ),
                        ),
                        const Divider(
                          height: 1.0,
                        ),
                        controller.isLoadingCategoryStatisticsData.value
                            ? ListViewSkeletonLoader(
                                itemCount: 3,
                              )
                            : controller.categoryStatisticsData.value.error ==
                                    null
                                ? ListView.separated(
                                    itemCount: controller.categoryStatisticsData
                                        .value.responseData!.length,
                                    addAutomaticKeepAlives: true,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CategoryStatisticsblock(
                                          data: controller
                                              .categoryStatisticsData
                                              .value
                                              .responseData![index],
                                          image:
                                              controller.categoryImage[index],
                                          controller: controller);
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 1.0,
                                    ),
                                  )
                                : ErrorMessage(
                                    errorMessage: controller
                                        .categoryStatisticsData.value.error,
                                    onPressed: () {
                                      controller.fetchCategoryStatisticsData(
                                          '2021-06-09', '2021-06-10');
                                    },
                                  ),
                        const Divider(
                          height: 1.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          width: width,
                          child: AppWidgets.buildText(
                              text: 'View all categories',
                              color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              )
            : const InternetConnectionError()));
  }
}
