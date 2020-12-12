import 'package:selavify/models/models.dart';

extension TransactoinsSummary on List<TransactionWithCategorySourceAndTType> {
  double get _sumAllTransactions =>
      fold(0.0, (a, b) => a + b.transactions.amount);

  double get _sumCashTransactions => this
      .where((t) => t.sources.title == Sources.CASH)
      .toList()
      ._sumAllTransactions;

  double get _sumAccountTransactions => this
      .where((t) => t.sources.title == Sources.ACCOUNT)
      .toList()
      ._sumAllTransactions;

  List<TransactionWithCategorySourceAndTType> _filterTransactionsByType(
          String tType) =>
      this.where((t) => t.transactionTypes.title == tType).toList();

  Map<String, dynamic> get summary => this._calculateBalance();

  Map<String, dynamic> _calculateIncome() =>
      _calculate(TransactionTypes.INCOME);

  Map<String, dynamic> _calculateExpanse() =>
      _calculate(TransactionTypes.EXPANSE);

  Map<String, dynamic> _calculateBalance() {
    Map<String, dynamic> income = _calculateIncome();
    Map<String, dynamic> expanse = _calculateExpanse();
    Map<String, dynamic> investment = _calculateInvestment();
    double withdrawl = _calculateWithdrawl();

    Map<String, dynamic> _income = {
      "total": income['total'],
      "cash": income["cash"] + withdrawl,
      "account": income["account"] - withdrawl
    };

    Map<String, dynamic> _expanse = {
      "total": expanse["total"] + investment["total"],
      "cash": expanse["cash"] + investment["cash"],
      "account": expanse["account"] + investment["account"]
    };

    Map<String, dynamic> balance = {
      "total": _income["total"] - _expanse["total"],
      "cash": _income["cash"] - _expanse["cash"],
      "account": _income["account"] - _expanse["account"],
    };

    return {
      "income": _income,
      "expanse": _expanse,
      "investment": investment,
      "withdrawl": withdrawl,
      "balance": balance
    };
  }

  Map<String, dynamic> _calculateInvestment() =>
      _calculate(TransactionTypes.INVESTMENT);

  double _calculateWithdrawl() => this
      ._filterTransactionsByType(TransactionTypes.WITHDRAWL)
      ._sumAllTransactions;

  Map<String, dynamic> _calculate(String tType) {
    List<TransactionWithCategorySourceAndTType> rows =
        this._filterTransactionsByType(tType);

    return {
      "total": rows._sumAllTransactions,
      "cash": rows._sumCashTransactions,
      "account": rows._sumAccountTransactions,
    };
  }
}

// income = (cash + withdrawl)  + (account - withdarawl)

// expanse = cash exapnse + account expanse + cash investment + acc investment

// cash_balance = cashincome - (cash exapnse  + cash investment)
// acc_balance =  accincome - (acc exapnse  + acc investment)
