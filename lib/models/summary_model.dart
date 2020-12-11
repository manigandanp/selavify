import 'dart:convert';

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));

String summaryToJson(Summary data) => json.encode(data.toJson());

class Summary {
  Summary({
    this.income,
    this.expanse,
    this.investment,
    this.withdrawl,
    this.balance,
  });

  SummaryObj income;
  SummaryObj expanse;
  SummaryObj investment;
  double withdrawl;
  SummaryObj balance;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        income: SummaryObj.fromJson(json["income"]),
        expanse: SummaryObj.fromJson(json["expanse"]),
        investment: SummaryObj.fromJson(json["investment"]),
        withdrawl: json["withdrawl"],
        balance: SummaryObj.fromJson(json["balance"]),
      );

  Map<String, dynamic> toJson() => {
        "income": income.toJson(),
        "expanse": expanse.toJson(),
        "investment": investment.toJson(),
        "withdrawl": withdrawl,
        "balance": balance.toJson(),
      };
}

class SummaryObj {
  SummaryObj({
    this.total,
    this.cash,
    this.account,
  });

  double total;
  double cash;
  double account;

  factory SummaryObj.fromJson(Map<String, dynamic> json) => SummaryObj(
        total: json["total"],
        cash: json["cash"],
        account: json["account"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "cash": cash,
        "account": account,
      };
}
