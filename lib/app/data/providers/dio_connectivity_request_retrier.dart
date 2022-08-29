import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConnectivityRequestRetry {
  final Dio? dio;
  final Connectivity? connectivity;
  final String? methode;

  DioConnectivityRequestRetry(
      {@required this.dio,
      @required this.connectivity,
      @required this.methode});

  Future<Response> scheduleRequestRetry(RequestOptions? requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription = connectivity!.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription!.cancel();
          responseCompleter.complete(
            dio!.request(requestOptions!.path,
                cancelToken: requestOptions.cancelToken,
                data: requestOptions.data,
                onReceiveProgress: requestOptions.onReceiveProgress,
                onSendProgress: requestOptions.onSendProgress,
                queryParameters: requestOptions.queryParameters,
                options:
                    Options(headers: requestOptions.headers, method: methode)),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
