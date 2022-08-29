class AccountsDataModel {
  bool? status;
  String? message;
  List<ResponseData>? responseData;
  String? error;

  AccountsDataModel({this.status, this.message, this.responseData});

  AccountsDataModel.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  String? name;
  String? dOB;
  String? phone;
  String? email;
  String? cardType;
  String? cardFeatures;
  int? isDeleted;

  ResponseData(
      {this.customerId,
      this.name,
      this.dOB,
      this.phone,
      this.email,
      this.cardType,
      this.cardFeatures,
      this.isDeleted});

  ResponseData.fromJson(Map<String, dynamic> json) {
    customerId = json['CustomerId'];
    name = json['Name'];
    dOB = json['DOB'];
    phone = json['Phone'];
    email = json['Email'];
    cardType = json['CardType'];
    cardFeatures = json['CardFeatures'];
    isDeleted = json['IsDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerId'] = this.customerId;
    data['Name'] = this.name;
    data['DOB'] = this.dOB;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['CardType'] = this.cardType;
    data['CardFeatures'] = this.cardFeatures;
    data['IsDeleted'] = this.isDeleted;
    return data;
  }
}
