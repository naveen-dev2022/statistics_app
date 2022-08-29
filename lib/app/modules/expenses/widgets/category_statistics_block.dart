import 'package:flutter/material.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';
import 'package:smartpointer/app/modules/expenses/models/category_statistics_model.dart';
import 'package:smartpointer/values/utils/reusable_components.dart';

class CategoryStatisticsblock extends StatelessWidget {
  CategoryStatisticsblock({Key? key, this.data, this.controller, this.image})
      : super(key: key);

  ResponseData? data;
  ExpensesController? controller;
  String? image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: CircleAvatar(
          backgroundImage: AssetImage(image!),
          backgroundColor: Colors.transparent,
          radius: 16,
        ),
      ),
      title: AppWidgets.buildText(
          text: data!.categoryName!.toUpperCase(),
          color: Colors.grey.shade500,
          fontSize: 13),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: AppWidgets.buildText(
          text: '\$${data!.amountSpent} spent',
          fontFamily: 'montserrat_regular',
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 13,
      ),
      onTap: () {
        controller!.isShowBackButton.value = true;
        controller!.appBarTitle.value = data!.categoryName!;
        controller!.chooseCategory.value = 'SUBCATEGORY';
        controller!.fetchSubCategoryStatisticsData(
            '2021-06-09', '2021-06-10', data!.categoryId);
      },
    );
  }
}
