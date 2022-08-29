class SubCategoryStatisticsModel {
  bool? status;
  String? message;
  List<ResponseData>? responseData;
  String? error;

  SubCategoryStatisticsModel({this.status, this.message, this.responseData});

  SubCategoryStatisticsModel.fromJson(Map<String, dynamic> json) {
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
  int? subCategoryId;
  String? subCategoryName;

  ResponseData({this.amountSpent, this.subCategoryId, this.subCategoryName});

  ResponseData.fromJson(Map<String, dynamic> json) {
    amountSpent = json['AmountSpent'];
    subCategoryId = json['SubCategoryId'];
    subCategoryName = json['SubCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmountSpent'] = this.amountSpent;
    data['SubCategoryId'] = this.subCategoryId;
    data['SubCategoryName'] = this.subCategoryName;
    return data;
  }
}
