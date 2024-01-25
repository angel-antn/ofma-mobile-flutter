import 'dart:convert';

class OrdersResponse {
  int? totalCount;
  int? page;
  int? pageSize;
  List<Order>? result;

  OrdersResponse({
    this.totalCount,
    this.page,
    this.pageSize,
    this.result,
  });

  factory OrdersResponse.fromJson(String str) =>
      OrdersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdersResponse.fromMap(Map<String, dynamic> json) => OrdersResponse(
        totalCount: json["totalCount"],
        page: json["page"],
        pageSize: json["pageSize"],
        result: json["result"] == null
            ? []
            : List<Order>.from(json["result"]!.map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "page": page,
        "pageSize": pageSize,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class Order {
  String? id;
  double? amount;
  DateTime? createdAt;
  DateTime? paidAt;
  String? type;
  String? status;
  String? reference;
  User? user;
  ExchangeRate? exchangeRate;
  TransferBankAccount? transferBankAccount;
  MobilePayBankAccount? mobilePayBankAccount;
  ZelleBankAccount? zelleBankAccount;

  Order({
    this.id,
    this.amount,
    this.createdAt,
    this.paidAt,
    this.type,
    this.status,
    this.reference,
    this.user,
    this.exchangeRate,
    this.transferBankAccount,
    this.mobilePayBankAccount,
    this.zelleBankAccount,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        amount: json["amount"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        paidAt: json["paidAt"] == null ? null : DateTime.parse(json["paidAt"]),
        type: json["type"],
        status: json["status"],
        reference: json["reference"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        exchangeRate: json["exchangeRate"] == null
            ? null
            : ExchangeRate.fromMap(json["exchangeRate"]),
        transferBankAccount: json["transferBankAccount"] == null
            ? null
            : TransferBankAccount.fromMap(json["transferBankAccount"]),
        mobilePayBankAccount: json["mobilePayBankAccount"] == null
            ? null
            : MobilePayBankAccount.fromMap(json["mobilePayBankAccount"]),
        zelleBankAccount: json["zelleBankAccount"] == null
            ? null
            : ZelleBankAccount.fromMap(json["zelleBankAccount"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "paidAt":
            "${paidAt!.year.toString().padLeft(4, '0')}-${paidAt!.month.toString().padLeft(2, '0')}-${paidAt!.day.toString().padLeft(2, '0')}",
        "type": type,
        "status": status,
        "reference": reference,
        "user": user?.toMap(),
        "exchangeRate": exchangeRate?.toMap(),
        "transferBankAccount": transferBankAccount?.toMap(),
        "mobilePayBankAccount": mobilePayBankAccount?.toMap(),
        "zelleBankAccount": zelleBankAccount?.toMap(),
      };
}

class ExchangeRate {
  String? id;
  double? rate;
  DateTime? createdAt;

  ExchangeRate({
    this.id,
    this.rate,
    this.createdAt,
  });

  factory ExchangeRate.fromJson(String str) =>
      ExchangeRate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeRate.fromMap(Map<String, dynamic> json) => ExchangeRate(
        id: json["id"],
        rate: json["rate"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rate": rate,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class MobilePayBankAccount {
  String? id;
  String? accountHolderPhone;
  String? accountHolderDocument;
  String? accountAlias;
  bool? isShown;

  MobilePayBankAccount({
    this.id,
    this.accountHolderPhone,
    this.accountHolderDocument,
    this.accountAlias,
    this.isShown,
  });

  factory MobilePayBankAccount.fromJson(String str) =>
      MobilePayBankAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MobilePayBankAccount.fromMap(Map<String, dynamic> json) =>
      MobilePayBankAccount(
        id: json["id"],
        accountHolderPhone: json["accountHolderPhone"],
        accountHolderDocument: json["accountHolderDocument"],
        accountAlias: json["accountAlias"],
        isShown: json["isShown"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accountHolderPhone": accountHolderPhone,
        "accountHolderDocument": accountHolderDocument,
        "accountAlias": accountAlias,
        "isShown": isShown,
      };
}

class TransferBankAccount {
  String? id;
  String? accountNumber;
  String? accountHolderName;
  String? accountHolderEmail;
  String? accountHolderDocument;
  String? accountAlias;
  bool? isShown;

  TransferBankAccount({
    this.id,
    this.accountNumber,
    this.accountHolderName,
    this.accountHolderEmail,
    this.accountHolderDocument,
    this.accountAlias,
    this.isShown,
  });

  factory TransferBankAccount.fromJson(String str) =>
      TransferBankAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransferBankAccount.fromMap(Map<String, dynamic> json) =>
      TransferBankAccount(
        id: json["id"],
        accountNumber: json["accountNumber"],
        accountHolderName: json["accountHolderName"],
        accountHolderEmail: json["accountHolderEmail"],
        accountHolderDocument: json["accountHolderDocument"],
        accountAlias: json["accountAlias"],
        isShown: json["isShown"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accountNumber": accountNumber,
        "accountHolderName": accountHolderName,
        "accountHolderEmail": accountHolderEmail,
        "accountHolderDocument": accountHolderDocument,
        "accountAlias": accountAlias,
        "isShown": isShown,
      };
}

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  bool? isCollaborator;

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.isCollaborator,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        isCollaborator: json["isCollaborator"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "isCollaborator": isCollaborator,
      };
}

class ZelleBankAccount {
  String? id;
  String? accountHolderEmail;
  String? accountHolderName;
  String? accountAlias;
  bool? isShown;

  ZelleBankAccount({
    this.id,
    this.accountHolderEmail,
    this.accountHolderName,
    this.accountAlias,
    this.isShown,
  });

  factory ZelleBankAccount.fromJson(String str) =>
      ZelleBankAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZelleBankAccount.fromMap(Map<String, dynamic> json) =>
      ZelleBankAccount(
        id: json["id"],
        accountHolderEmail: json["accountHolderEmail"],
        accountHolderName: json["accountHolderName"],
        accountAlias: json["accountAlias"],
        isShown: json["isShown"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accountHolderEmail": accountHolderEmail,
        "accountHolderName": accountHolderName,
        "accountAlias": accountAlias,
        "isShown": isShown,
      };
}
