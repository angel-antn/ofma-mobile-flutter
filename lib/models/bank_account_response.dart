import 'dart:convert';

class BankAccountResponse {
  TransferBankAccounts? transferBankAccounts;
  MobilePayBankAccounts? mobilePayBankAccounts;
  ZelleBankAccounts? zelleBankAccounts;

  BankAccountResponse({
    this.transferBankAccounts,
    this.mobilePayBankAccounts,
    this.zelleBankAccounts,
  });

  factory BankAccountResponse.fromJson(String str) =>
      BankAccountResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankAccountResponse.fromMap(Map<String, dynamic> json) =>
      BankAccountResponse(
        transferBankAccounts: json["transferBankAccounts"] == null
            ? null
            : TransferBankAccounts.fromMap(json["transferBankAccounts"]),
        mobilePayBankAccounts: json["mobilePayBankAccounts"] == null
            ? null
            : MobilePayBankAccounts.fromMap(json["mobilePayBankAccounts"]),
        zelleBankAccounts: json["zelleBankAccounts"] == null
            ? null
            : ZelleBankAccounts.fromMap(json["zelleBankAccounts"]),
      );

  Map<String, dynamic> toMap() => {
        "transferBankAccounts": transferBankAccounts?.toMap(),
        "mobilePayBankAccounts": mobilePayBankAccounts?.toMap(),
        "zelleBankAccounts": zelleBankAccounts?.toMap(),
      };
}

class MobilePayBankAccounts {
  int? totalCount;
  List<MobilePayBankAccountsResult>? result;

  MobilePayBankAccounts({
    this.totalCount,
    this.result,
  });

  factory MobilePayBankAccounts.fromJson(String str) =>
      MobilePayBankAccounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MobilePayBankAccounts.fromMap(Map<String, dynamic> json) =>
      MobilePayBankAccounts(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<MobilePayBankAccountsResult>.from(json["result"]!
                .map((x) => MobilePayBankAccountsResult.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class MobilePayBankAccountsResult {
  String? id;
  String? accountHolderPhone;
  String? accountHolderDocument;
  String? accountAlias;
  bool? isShown;
  Bank? bank;

  MobilePayBankAccountsResult({
    this.id,
    this.accountHolderPhone,
    this.accountHolderDocument,
    this.accountAlias,
    this.isShown,
    this.bank,
  });

  factory MobilePayBankAccountsResult.fromJson(String str) =>
      MobilePayBankAccountsResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MobilePayBankAccountsResult.fromMap(Map<String, dynamic> json) =>
      MobilePayBankAccountsResult(
        id: json["id"],
        accountHolderPhone: json["accountHolderPhone"],
        accountHolderDocument: json["accountHolderDocument"],
        accountAlias: json["accountAlias"],
        isShown: json["isShown"],
        bank: json["bank"] == null ? null : Bank.fromMap(json["bank"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accountHolderPhone": accountHolderPhone,
        "accountHolderDocument": accountHolderDocument,
        "accountAlias": accountAlias,
        "isShown": isShown,
        "bank": bank?.toMap(),
      };
}

class Bank {
  String? id;
  String? name;
  String? code;

  Bank({
    this.id,
    this.name,
    this.code,
  });

  factory Bank.fromJson(String str) => Bank.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bank.fromMap(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
      };
}

class TransferBankAccounts {
  int? totalCount;
  List<TransferBankAccountsResult>? result;

  TransferBankAccounts({
    this.totalCount,
    this.result,
  });

  factory TransferBankAccounts.fromJson(String str) =>
      TransferBankAccounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransferBankAccounts.fromMap(Map<String, dynamic> json) =>
      TransferBankAccounts(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<TransferBankAccountsResult>.from(json["result"]!
                .map((x) => TransferBankAccountsResult.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class TransferBankAccountsResult {
  String? id;
  String? accountNumber;
  String? accountHolderName;
  String? accountHolderEmail;
  String? accountHolderDocument;
  String? accountAlias;
  bool? isShown;
  Bank? bank;

  TransferBankAccountsResult({
    this.id,
    this.accountNumber,
    this.accountHolderName,
    this.accountHolderEmail,
    this.accountHolderDocument,
    this.accountAlias,
    this.isShown,
    this.bank,
  });

  factory TransferBankAccountsResult.fromJson(String str) =>
      TransferBankAccountsResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransferBankAccountsResult.fromMap(Map<String, dynamic> json) =>
      TransferBankAccountsResult(
        id: json["id"],
        accountNumber: json["accountNumber"],
        accountHolderName: json["accountHolderName"],
        accountHolderEmail: json["accountHolderEmail"],
        accountHolderDocument: json["accountHolderDocument"],
        accountAlias: json["accountAlias"],
        isShown: json["isShown"],
        bank: json["bank"] == null ? null : Bank.fromMap(json["bank"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accountNumber": accountNumber,
        "accountHolderName": accountHolderName,
        "accountHolderEmail": accountHolderEmail,
        "accountHolderDocument": accountHolderDocument,
        "accountAlias": accountAlias,
        "isShown": isShown,
        "bank": bank?.toMap(),
      };
}

class ZelleBankAccounts {
  int? totalCount;
  List<ZelleBankAccountsResult>? result;

  ZelleBankAccounts({
    this.totalCount,
    this.result,
  });

  factory ZelleBankAccounts.fromJson(String str) =>
      ZelleBankAccounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZelleBankAccounts.fromMap(Map<String, dynamic> json) =>
      ZelleBankAccounts(
        totalCount: json["totalCount"],
        result: json["result"] == null
            ? []
            : List<ZelleBankAccountsResult>.from(
                json["result"]!.map((x) => ZelleBankAccountsResult.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class ZelleBankAccountsResult {
  String? id;
  String? accountHolderEmail;
  String? accountHolderName;
  String? accountAlias;
  bool? isShown;

  ZelleBankAccountsResult({
    this.id,
    this.accountHolderEmail,
    this.accountHolderName,
    this.accountAlias,
    this.isShown,
  });

  factory ZelleBankAccountsResult.fromJson(String str) =>
      ZelleBankAccountsResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZelleBankAccountsResult.fromMap(Map<String, dynamic> json) =>
      ZelleBankAccountsResult(
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
