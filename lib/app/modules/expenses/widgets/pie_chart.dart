import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';
import 'package:smartpointer/app/modules/expenses/models/chart_model.dart';
import 'package:smartpointer/values/utils/reusable_components.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  PieChart({Key? key}) : super(key: key);

  var expensesController = Get.find<ExpensesController>();

  ///find category
  Widget ChooseCategory(BuildContext context) {
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
                  ? chartUIBlock()
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
                  ? chartUIBlock()
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
  Widget chartUIBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FractionalTranslation(
          translation: Offset(-0.1, 0.0),
          child: SizedBox(
            width: 60.w,
            child: SfCircularChart(
              series: <CircularSeries>[
                // Render pie chart
                PieSeries<ChartData, String>(
                  enableTooltip: true,
                  dataSource: expensesController.pieChartData,
                  pointColorMapper: (ChartData data, _) => data.colors,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < expensesController.pieChartData!.length; i++)
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
                              '${((expensesController.pieChartData![i].y / expensesController.categoryTotalAmount) * 100).truncate()}% ${expensesController.pieChartData![i].x}'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
          ],
        ),
        Expanded(child: Container())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: ChooseCategory(context)));
  }
}
