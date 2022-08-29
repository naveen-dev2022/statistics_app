import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smartpointer/app/data/providers/dio_connectivity_request_retrier.dart';
import 'package:smartpointer/app/data/providers/exceptions.dart';
import 'package:smartpointer/app/modules/accounts/controllers/accounts_controller.dart';
import 'package:smartpointer/app/modules/accounts/models/accounts_model.dart';
import 'package:smartpointer/app/modules/expenses/controllers/expenses_controller.dart';
import 'package:smartpointer/app/modules/expenses/models/category_statistics_model.dart';
import 'package:smartpointer/app/modules/expenses/models/subcategory_statistics_model.dart';
import 'package:smartpointer/values/utils/helpers.dart';

///Interceptor block requests ,response,error
///@@@@@Retry On Connection Change

///Category Statistics:
class CategoryStatisticsInterceptor extends Interceptor {
  final DioConnectivityRequestRetry? requestRetry;
  String? fromDate;
  String? toDate;

  CategoryStatisticsInterceptor(
      {@required this.requestRetry, this.fromDate, this.toDate});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('requesting#####${fromDate}-------${toDate}');
    //  options.path = '${Keys.BASEURL_KEY}api/v1.0/master/CategoryStatistics';
    options.data = {"FromDate": fromDate, "ToDate": toDate};
    // options.queryParameters = {"FromDate": fromDate, "ToDate": toDate};
    return super.onRequest(options, handler); //add this line
  }

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    print(response.statusCode);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> map =
            Map<String, dynamic>.from(response.data!);
        Get.find<ExpensesController>().categoryStatisticsData.value =
            CategoryStatisticsModel.fromJson(map);
        print('responseData######${response.data}');
        Get.find<ExpensesController>().plotDataIntoCharts();
        Get.find<ExpensesController>().isLoadingCategoryStatisticsData(false);
      }
    } catch (error) {
      if (error is! Exception) {
        if (error.toString().contains("is not a subtype of")) {
          Get.find<ExpensesController>().categoryStatisticsData.value.error =
              'Type Error';
          Get.find<ExpensesController>().isLoadingCategoryStatisticsData(false);
        }
      }
    }
    // do something before response
    return super.onResponse(response, handler); //add this line
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      if (err.type == DioErrorType.other &&
          err.error != null &&
          err.error is SocketException) {
        Get.find<ExpensesController>().isInternetAvailable(false);
        requestRetry!.scheduleRequestRetry(err.requestOptions).then((value) {
          print('!!!ConnectivityResult##########');
          Get.find<ExpensesController>().isInternetAvailable(true);
        });
      } else {
        String errorMessage = Exceptions.DioExceptions(err);
        Get.find<ExpensesController>().categoryStatisticsData.value.error =
            errorMessage;
        Get.find<ExpensesController>().isLoadingCategoryStatisticsData(false);
        Get.find<ExpensesController>().isInternetAvailable(true);
      }
    } on FormatException catch (_) {
      Get.find<ExpensesController>().categoryStatisticsData.value.error =
          'Format exception';
      Get.find<ExpensesController>().isLoadingCategoryStatisticsData(false);
      Get.find<ExpensesController>().isInternetAvailable(true);
    }

    return super.onError(err, handler);
  }
}

///Sub Category Statistics:
class SubCategoryStatisticsInterceptor extends Interceptor {
  final DioConnectivityRequestRetry? requestRetry;
  String? fromDate;
  String? toDate;
  int? categoryId;

  SubCategoryStatisticsInterceptor(
      {@required this.requestRetry,
      this.fromDate,
      this.toDate,
      this.categoryId});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('requesting#####${fromDate}-------$toDate------${categoryId}');
    //  options.path = '${Keys.BASEURL_KEY}api/v1.0/master/CategoryStatistics';
    options.data = {
      "FromDate": fromDate,
      "ToDate": toDate,
      "CategoryId": categoryId
    };
    // options.queryParameters = {"FromDate": fromDate, "ToDate": toDate};
    return super.onRequest(options, handler); //add this line
  }

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    print(response.statusCode);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> map =
            Map<String, dynamic>.from(response.data!);
        Get.find<ExpensesController>().subCategoryStatisticsData.value =
            SubCategoryStatisticsModel.fromJson(map);
        print('responseData######${response.data}');
        Get.find<ExpensesController>().plotSubCategoryDataIntoCharts();
        Get.find<ExpensesController>()
            .isLoadingSubCategoryStatisticsData(false);
      }
    } catch (error) {
      if (error is! Exception) {
        if (error.toString().contains("is not a subtype of")) {
          Get.find<ExpensesController>().subCategoryStatisticsData.value.error =
              'Type Error';
          Get.find<ExpensesController>()
              .isLoadingSubCategoryStatisticsData(false);
        }
      }
    }
    // do something before response
    return super.onResponse(response, handler); //add this line
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      if (err.type == DioErrorType.other &&
          err.error != null &&
          err.error is SocketException) {
        AppMethods.GetxSnackBar('No Internet Connection');
        Get.find<ExpensesController>().isSubCategoryInternetAvailable(false);
        requestRetry!.scheduleRequestRetry(err.requestOptions).then((value) {
          print('!!!ConnectivityResult##########');
          Get.find<ExpensesController>().isSubCategoryInternetAvailable(true);
        });
      } else {
        String errorMessage = Exceptions.DioExceptions(err);
        Get.find<ExpensesController>().subCategoryStatisticsData.value.error =
            errorMessage;
        Get.find<ExpensesController>()
            .isLoadingSubCategoryStatisticsData(false);
        Get.find<ExpensesController>().isSubCategoryInternetAvailable(true);
      }
    } on FormatException catch (_) {
      Get.find<ExpensesController>().subCategoryStatisticsData.value.error =
          'Format exception';
      Get.find<ExpensesController>().isLoadingSubCategoryStatisticsData(false);
      Get.find<ExpensesController>().isSubCategoryInternetAvailable(true);
    }

    return super.onError(err, handler);
  }
}

///Accounts data:
class AccountsInterceptor extends Interceptor {
  final DioConnectivityRequestRetry? requestRetry;

  AccountsInterceptor({
    @required this.requestRetry,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.queryParameters = {"FromDate": fromDate, "ToDate": toDate};
    return super.onRequest(options, handler); //add this line
  }

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    print(response.statusCode);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> map =
            Map<String, dynamic>.from(response.data!);
        Get.find<AccountsController>().accountsData.value =
            AccountsDataModel.fromJson(map);
        print('responseData######${response.data}');
        Get.find<AccountsController>().isLoadingAccountsData(false);
      }
    } catch (error) {
      if (error is! Exception) {
        if (error.toString().contains("is not a subtype of")) {
          Get.find<AccountsController>().accountsData.value.error =
              'Type Error';
          Get.find<AccountsController>().isLoadingAccountsData(false);
        }
      }
    }
    // do something before response
    return super.onResponse(response, handler); //add this line
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      if (err.type == DioErrorType.other &&
          err.error != null &&
          err.error is SocketException) {
        Get.find<AccountsController>().isInternetAvailable(false);
        requestRetry!.scheduleRequestRetry(err.requestOptions).then((value) {
          print('!!!ConnectivityResult##########');
          Get.find<AccountsController>().isInternetAvailable(true);
        });
      } else {
        String errorMessage = Exceptions.DioExceptions(err);
        Get.find<AccountsController>().accountsData.value.error = errorMessage;
        Get.find<AccountsController>().isLoadingAccountsData(false);
        Get.find<AccountsController>().isInternetAvailable(true);
      }
    } on FormatException catch (_) {
      Get.find<AccountsController>().accountsData.value.error =
          'Format exception';
      Get.find<AccountsController>().isLoadingAccountsData(false);
      Get.find<AccountsController>().isInternetAvailable(true);
    }

    return super.onError(err, handler);
  }
}
