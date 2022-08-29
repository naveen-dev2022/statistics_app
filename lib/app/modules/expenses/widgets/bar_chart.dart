import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';
import 'package:smartpointer/app/modules/expenses/models/chart_model.dart';
import 'package:smartpointer/values/utils/reusable_components.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  BarChart({Key? key}) : super(key: key);

  late TooltipBehavior _tooltip;
  var expensesController = Get.find<ExpensesController>();

  Widget ChooseCategory(Orientation currentOrientation) {
    switch (expensesController.chooseCategory.value) {
      case "CATEGORY":
        {
          return expensesController.isLoadingCategoryStatisticsData.value
              ? GridViewSkeletonLoader(
                  itemCount: 1,
                  itemsPerRow: 1,
                  childAspectRatio: 1.5,
                )
              : expensesController.categoryStatisticsData.value.error == null
                  ? chartUIBlock(currentOrientation)
                  : ErrorMessage(
                      errorMessage:
                          expensesController.categoryStatisticsData.value.error,
                      onPressed: () {},
                    );
        }

      case "SUBCATEGORY":
        {
          return expensesController.isLoadingSubCategoryStatisticsData.value
              ? GridViewSkeletonLoader(
                  itemCount: 1,
                  itemsPerRow: 1,
                  childAspectRatio: 1.6,
                )
              : expensesController.subCategoryStatisticsData.value.error == null
                  ? chartUIBlock(currentOrientation)
                  : ErrorMessage(
                      errorMessage: expensesController
                          .subCategoryStatisticsData.value.error,
                      onPressed: () {},
                    );
        }

      default:
        {
          return SizedBox();
        }
    }
  }

  ///chart UI block
  Widget chartUIBlock(Orientation currentOrientation) {
    return Row(
      children: [
        SizedBox(
          width: 60.w,
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: expensesController.categoryTotalAmount / 1000,
                  interval: 1),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<ChartData, String>>[
                BarSeries<ChartData, String>(
                  dataSource: expensesController.barChartData!,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y / 1000,
                  pointColorMapper: (ChartData data, _) => data.colors,
                )
              ]),
        ),
        currentOrientation == Orientation.portrait
            ? Expanded(child: Container())
            : SizedBox(
                width: 30,
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < expensesController.barChartData!.length; i++)
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: expensesController.categoryColor[i],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      AppWidgets.buildText(
                          fontSize: 9,
                          fontWeight: FontWeight.w200,
                          color: Color.fromRGBO(93, 122, 196, 1.0),
                          text:
                              '${((expensesController.barChartData![i].y / expensesController.categoryTotalAmount) * 100).truncate()}% ${expensesController.barChartData![i].x}'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
          ],
        ),
        SizedBox(
          width: 12,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _tooltip = TooltipBehavior(enable: true);
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    return Obx(() => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: ChooseCategory(currentOrientation)));
  }
}
