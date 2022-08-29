class CategoryStatisticsModel {
  bool? status;
  String? message;
  List<ResponseData>? responseData;
  String? error;

  CategoryStatisticsModel({this.status, this.message, this.responseData});

  CategoryStatisticsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['responseData'] != null) {
      responseData = <ResponseData>[];
      json['responseData'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.responseData != null) {
      data['responseData'] = this.responseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  int? amountSpent;
  int? categoryId;
  String? categoryName;

  ResponseData({this.amountSpent, this.categoryId, this.categoryName});

  ResponseData.fromJson(Map<String, dynamic> json) {
    amountSpent = json['AmountSpent'];
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmountSpent'] = this.amountSpent;
    data['CategoryId'] = this.categoryId;
    data['CategoryName'] = this.categoryName;
    return data;
  }
}
