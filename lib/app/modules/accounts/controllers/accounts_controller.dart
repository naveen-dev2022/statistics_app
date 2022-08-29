import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartpointer/app/data/providers/dio_connectivity_request_retrier.dart';
import 'package:smartpointer/app/data/providers/interceptors.dart';
import 'package:smartpointer/app/modules/accounts/models/accounts_model.dart';
import 'package:smartpointer/values/utils/keys.dart';

class AccountsController extends GetxController {
  ///Category Statistics:
  var isLoadingAccountsData = false.obs;
  var accountsData = AccountsDataModel().obs;
  RxBool isInternetAvailable = true.obs;

  List<Color> accountsBgColor = [
    Color(0xffffffff),
    Color(0xffffffff),
    Color(0xffffffff),
  ];

  Color findCardType(String? cardType) {
    switch (cardType!.toUpperCase()) {
      case "GOLD":
        {
          return Color(0xffFFD700);
        }

      case "SILVER":
        {
          return Color(0xffC0C0C0);
        }

      case "PALTTINUM":
        {
          return Color(0xffE5E4E2);
        }

      default:
        {
          return Colors.transparent;
        }
    }
  }

  Color chooseCardBgColor(String? cardType) {
    switch (cardType!.toUpperCase()) {
      case "GOLD":
        {
          return Color(0xfffcf6d5);
        }

      case "SILVER":
        {
          return Color(0xffeaeaea);
        }

      case "PALTTINUM":
        {
          return Color(
            0xfff5f4f4,
          );
        }

      default:
        {
          return Colors.transparent;
        }
    }
  }

  @override
  void onInit() {
    fetchAccountsData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> fetchAccountsData() async {
    Dio? dio = Dio();

    dio.interceptors.add(
      AccountsInterceptor(
        requestRetry: DioConnectivityRequestRetry(
          dio: dio,
          methode: 'GET',
          connectivity: Connectivity(),
        ),
      ),
    );

    isLoadingAccountsData(true);

    await dio.get(
      '${Keys.BASEURL_KEY}api/v1.0/master/CustomerList',
    );
  }
}
