import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartpointer/app/data/providers/dio_connectivity_request_retrier.dart';
import 'package:smartpointer/app/data/providers/interceptors.dart';
import 'package:smartpointer/app/modules/expenses/models/category_statistics_model.dart';
import 'package:smartpointer/app/modules/expenses/models/chart_model.dart';
import 'package:smartpointer/app/modules/expenses/models/subcategory_statistics_model.dart';
import 'package:smartpointer/values/utils/keys.dart';

class ExpensesController extends GetxController {
  ///Category Statistics:
  var isLoadingCategoryStatisticsData = false.obs;
  var categoryStatisticsData = CategoryStatisticsModel().obs;
  RxBool isInternetAvailable = true.obs;
  List<Color> categoryColor = [
    Color.fromRGBO(227, 152, 159, 1.0),
    Color.fromRGBO(97, 156, 225, 1.0),
    Color.fromRGBO(179, 211, 127, 1.0),
    Color.fromRGBO(243, 213, 158, 1.0),
    Color.fromRGBO(225, 145, 75, 1.0)
  ];

  List<String> categoryImage = [
    'assets/images/home-2.png',
    'assets/images/airplane.png',
    'assets/images/home-2.png',
    'assets/images/airplane.png',
  ];

  void plotDataIntoCharts() {
    ///clear chart data

    clearPreviewData();

    for (int i = 0;
        i < categoryStatisticsData.value.responseData!.length;
        i++) {
      pieChartData!.add(
        ChartData(
            categoryStatisticsData.value.responseData![i].categoryName!,
            categoryStatisticsData.value.responseData![i].amountSpent!,
            categoryColor[i]),
      );
      barChartData!.add(
        ChartData(
            categoryStatisticsData.value.responseData![i].categoryName!,
            categoryStatisticsData.value.responseData![i].amountSpent!,
            categoryColor[i]),
      );
      donutChartData!.add(
        ChartData(
            categoryStatisticsData.value.responseData![i].categoryName!,
            categoryStatisticsData.value.responseData![i].amountSpent!,
            categoryColor[i]),
      );
    }

    calculatePercentage();
  }

  void calculatePercentage() {
    categoryTotalAmount = categoryStatisticsData.value.responseData!
        .fold<dynamic>(0, (total, current) => total + current.amountSpent!);
  }

  ///Sub Category Statistics:
  var subCategoryStatisticsData = SubCategoryStatisticsModel().obs;
  var isLoadingSubCategoryStatisticsData = false.obs;
  RxBool isSubCategoryInternetAvailable = true.obs;

  void plotSubCategoryDataIntoCharts() {
    clearPreviewData();

    for (int i = 0;
        i < subCategoryStatisticsData.value.responseData!.length;
        i++) {
      pieChartData!.add(
        ChartData(
            subCategoryStatisticsData.value.responseData![i].subCategoryName!,
            subCategoryStatisticsData.value.responseData![i].amountSpent!,
            categoryColor[i]),
      );
      barChartData!.add(
        ChartData(
            subCategoryStatisticsData.value.responseData![i].subCategoryName!,
            subCategoryStatisticsData.value.responseData![i].amountSpent!,
            categoryColor[i]),
      );
      donutChartData!.add(
        ChartData(
            subCategoryStatisticsData.value.responseData![i].subCategoryName!,
            subCategoryStatisticsData.value.responseData![i].amountSpent!,
            categoryColor[i]),
      );
    }

    calculateSubCategoryPercentage();
  }

  void calculateSubCategoryPercentage() {
    categoryTotalAmount = subCategoryStatisticsData.value.responseData!
        .fold<dynamic>(0, (total, current) => total + current.amountSpent!);
  }

  /// chart data instance
  List<ChartData>? pieChartData = <ChartData>[].obs;
  List<ChartData>? barChartData = <ChartData>[].obs;
  List<ChartData>? donutChartData = <ChartData>[].obs;
  int categoryTotalAmount = 0;
  RxString chooseCategory = 'CATEGORY'.obs;
  RxString appBarTitle = 'Expenses'.obs;
  RxBool isShowBackButton = false.obs;

  @override
  void onInit() {
    fetchCategoryStatisticsData('2021-06-09', '2021-06-10');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void clearPreviewData() {
    pieChartData = [];
    barChartData = [];
    donutChartData = [];
  }

  Future<void> fetchCategoryStatisticsData(
    String? fromDate,
    String? toDate,
  ) async {
    Dio? dio = Dio();

    dio.interceptors.add(
      CategoryStatisticsInterceptor(
        fromDate: fromDate,
        toDate: toDate,
        requestRetry: DioConnectivityRequestRetry(
          dio: dio,
          methode: 'POST',
          connectivity: Connectivity(),
        ),
      ),
    );

    isLoadingCategoryStatisticsData(true);

    await dio.post(
      '${Keys.BASEURL_KEY}api/v1.0/master/CategoryStatistics',
    );
  }

  Future<void> fetchSubCategoryStatisticsData(
      String? fromDate, String? toDate, int? categoryId) async {
    Dio? dio = Dio();

    dio.interceptors.add(
      SubCategoryStatisticsInterceptor(
        fromDate: fromDate,
        toDate: toDate,
        categoryId: categoryId,
        requestRetry: DioConnectivityRequestRetry(
          dio: dio,
          methode: 'POST',
          connectivity: Connectivity(),
        ),
      ),
    );

    isLoadingSubCategoryStatisticsData(true);

    await dio.post(
      '${Keys.BASEURL_KEY}api/v1.0/master/SubCategoryStatistics',
    );
  }
}
