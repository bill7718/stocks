import 'dart:math';

class StockData {
  final String code;
  late final List<BalanceSheet> balanceSheets;
  late final List<IncomeStatement> incomeStatements;

  static const permanentGrowth = 1.035;
  static const convergenceRate = 0.10;
  static const numberOfIterations = 100;
  static const discountRate = 1 / 1.06 ;
  static const targetDividendRatio = 0.4;

  StockData(this.code) {
    balanceSheets = <BalanceSheet>[];
    incomeStatements = <IncomeStatement>[];
  }

  num growth() {
    var firstIndex = incomeStatements.first.index;
    var lastIndex = incomeStatements.last.index;

    var growth = pow(lastIndex / firstIndex, 0.25);
    return growth;
  }

  num presentValue( { double? initialDividend, double? initialGrowth }) {

    var presentValue = 0.00;
    var iterationIndex = 0;

    var currentGrowth = initialGrowth ?? growth();
    var currentDividendRatio = initialDividend == null
              ? incomeStatements.last.dividendRatio
              : initialDividend / incomeStatements.last.eps;
    var currentEPS = incomeStatements.last.eps;
    var currentDiscountRate = discountRate;

    while (iterationIndex < numberOfIterations) {
      currentDividendRatio = currentDividendRatio +
          (targetDividendRatio - currentDividendRatio) * convergenceRate;
      currentGrowth =
          currentGrowth + (permanentGrowth - currentGrowth) * convergenceRate;
      currentEPS = currentEPS * currentGrowth;
      var dividend = currentEPS * currentDividendRatio;
      presentValue = presentValue + dividend * currentDiscountRate;
      currentDiscountRate = currentDiscountRate * discountRate;

      iterationIndex++;
    }

    return presentValue;
  }

  void parseBalanceSheet(String balanceSheetData) {
    final lines = balanceSheetData.split('\n');

    // years
    final years = lines[1].split('\t');
    BalanceSheet current = BalanceSheet(int.parse(years[1]));
    BalanceSheet previous = BalanceSheet(int.parse(years[2]));
    BalanceSheet previous1 = BalanceSheet(int.parse(years[3]));
    BalanceSheet previous2 = BalanceSheet(int.parse(years[4]));
    BalanceSheet previous3 = BalanceSheet(int.parse(years[5]));

    // year ends
    final yearEnds = lines[2].split('\t');
    current.yearEnd = yearEnds[1];
    previous.yearEnd = yearEnds[2];
    previous1.yearEnd = yearEnds[3];
    previous2.yearEnd = yearEnds[4];
    previous3.yearEnd = yearEnds[5];

    // intangibles
    final intangibles = lines[5].split('\t');
    current.intangibles = double.parse(intangibles[1]);
    previous.intangibles = double.parse(intangibles[2]);
    previous1.intangibles = double.parse(intangibles[3]);
    previous2.intangibles = double.parse(intangibles[4]);
    previous3.intangibles = double.parse(intangibles[5]);

    // tangibles
    final tangibles = lines[6].split('\t');
    current.tangibles = double.parse(tangibles[1]);
    previous.tangibles = double.parse(tangibles[2]);
    previous1.tangibles = double.parse(tangibles[3]);
    previous2.tangibles = double.parse(tangibles[4]);
    previous3.tangibles = double.parse(tangibles[5]);

    // investments
    final investments = lines[7].split('\t');
    current.investments = double.parse(investments[1]);
    previous.investments = double.parse(investments[2]);
    previous1.investments = double.parse(investments[3]);
    previous2.investments = double.parse(investments[4]);
    previous3.investments = double.parse(investments[5]);

    // other
    final other = lines[8].split('\t');
    current.other = double.parse(other[1]);
    previous.other = double.parse(other[2]);
    previous1.other = double.parse(other[3]);
    previous2.other = double.parse(other[4]);
    previous3.other = double.parse(other[5]);

    // stock
    final stock = lines[11].split('\t');
    current.stock = double.parse(stock[1]);
    previous.stock = double.parse(stock[2]);
    previous1.stock = double.parse(stock[3]);
    previous2.stock = double.parse(stock[4]);
    previous3.stock = double.parse(stock[5]);

    // debtors
    final debtors = lines[12].split('\t');
    current.debtors = double.parse(debtors[1]);
    previous.debtors = double.parse(debtors[2]);
    previous1.debtors = double.parse(debtors[3]);
    previous2.debtors = double.parse(debtors[4]);
    previous3.debtors = double.parse(debtors[5]);

    // cash
    final cash = lines[13].split('\t');
    current.cash = double.parse(cash[1]);
    previous.cash = double.parse(cash[2]);
    previous1.cash = double.parse(cash[3]);
    previous2.cash = double.parse(cash[4]);
    previous3.cash = double.parse(cash[5]);

    // current liabilities
    final currentL = lines[18].split('\t');
    current.current = double.parse(currentL[1]);
    previous.current = double.parse(currentL[2]);
    previous1.current = double.parse(currentL[3]);
    previous2.current = double.parse(currentL[4]);
    previous3.current = double.parse(currentL[5]);

    // non current liabilities
    final nonCurrent = lines[19].split('\t');
    current.nonCurrent = double.parse(nonCurrent[1]);
    previous.nonCurrent = double.parse(nonCurrent[2]);
    previous1.nonCurrent = double.parse(nonCurrent[3]);
    previous2.nonCurrent = double.parse(nonCurrent[4]);
    previous3.nonCurrent = double.parse(nonCurrent[5]);

    // share capital
    final shareCapital = lines[22].split('\t');
    current.shareCapital = double.parse(shareCapital[1]);
    previous.shareCapital = double.parse(shareCapital[2]);
    previous1.shareCapital = double.parse(shareCapital[3]);
    previous2.shareCapital = double.parse(shareCapital[4]);
    previous3.shareCapital = double.parse(shareCapital[5]);

    // reserves
    final reserves = lines[23].split('\t');
    current.reserves = double.parse(reserves[1]);
    previous.reserves = double.parse(reserves[2]);
    previous1.reserves = double.parse(reserves[3]);
    previous2.reserves = double.parse(reserves[4]);
    previous3.reserves = double.parse(reserves[5]);

    // minorities
    final minorities = lines[25].split('\t');
    current.minorities = double.parse(minorities[1]);
    previous.minorities = double.parse(minorities[2]);
    previous1.minorities = double.parse(minorities[3]);
    previous2.minorities = double.parse(minorities[4]);
    previous3.minorities = double.parse(minorities[5]);

    // net borrowing
    final netBorrowing = lines[28].split('\t');
    current.netBorrowing = double.parse(netBorrowing[1]);
    previous.netBorrowing = double.parse(netBorrowing[2]);
    previous1.netBorrowing = double.parse(netBorrowing[3]);
    previous2.netBorrowing = double.parse(netBorrowing[4]);
    previous3.netBorrowing = double.parse(netBorrowing[5]);

    // tangible assets per share
    final tangiblePS = lines[30].split('\t');
    current.tangiblePS = double.parse(tangiblePS[1]);
    previous.tangiblePS = double.parse(tangiblePS[2]);
    previous1.tangiblePS = double.parse(tangiblePS[3]);
    previous2.tangiblePS = double.parse(tangiblePS[4]);
    previous3.tangiblePS = double.parse(tangiblePS[5]);

    balanceSheets.addAll([previous3, previous2, previous1, previous, current]);
  }

  void parseIncomeStatement(String incomeStatementData) {
    final lines = incomeStatementData.split('\n');

    // years
    final years = lines[1].split('\t');
    IncomeStatement current = IncomeStatement(int.parse(years[1]));
    IncomeStatement previous = IncomeStatement(int.parse(years[2]));
    IncomeStatement previous1 = IncomeStatement(int.parse(years[3]));
    IncomeStatement previous2 = IncomeStatement(int.parse(years[4]));
    IncomeStatement previous3 = IncomeStatement(int.parse(years[5]));

    // year ends
    final yearEnds = lines[2].split('\t');
    current.yearEnd = yearEnds[1];
    previous.yearEnd = yearEnds[2];
    previous1.yearEnd = yearEnds[3];
    previous2.yearEnd = yearEnds[4];
    previous3.yearEnd = yearEnds[5];

    // turnover
    final turnover = lines[3].split('\t');
    current.turnover = double.parse(turnover[1]);
    previous.turnover = double.parse(turnover[2]);
    previous1.turnover = double.parse(turnover[3]);
    previous2.turnover = double.parse(turnover[4]);
    previous3.turnover = double.parse(turnover[5]);

    // expenses
    final expenses = lines[4].split('\t');
    current.expenses = double.parse(expenses[1]);
    previous.expenses = double.parse(expenses[2]);
    previous1.expenses = double.parse(expenses[3]);
    previous2.expenses = double.parse(expenses[4]);
    previous3.expenses = double.parse(expenses[5]);

    // net interest
    final netInterest = lines[11].split('\t');
    current.netInterest = double.parse(netInterest[1]);
    previous.netInterest = double.parse(netInterest[2]);
    previous1.netInterest = double.parse(netInterest[3]);
    previous2.netInterest = double.parse(netInterest[4]);
    previous3.netInterest = double.parse(netInterest[5]);

    // pre tax profit
    final preTaxProfit = lines[12].split('\t');
    current.preTaxProfit = double.parse(preTaxProfit[1]);
    previous.preTaxProfit = double.parse(preTaxProfit[2]);
    previous1.preTaxProfit = double.parse(preTaxProfit[3]);
    previous2.preTaxProfit = double.parse(preTaxProfit[4]);
    previous3.preTaxProfit = double.parse(preTaxProfit[5]);

    // pre tax profit
    final tax = lines[13].split('\t');
    current.tax = double.parse(tax[1]);
    previous.tax = double.parse(tax[2]);
    previous1.tax = double.parse(tax[3]);
    previous2.tax = double.parse(tax[4]);
    previous3.tax = double.parse(tax[5]);

    // dividend per share
    final dps = lines[21].split('\t');
    current.dps = double.parse(dps[1]);
    previous.dps = double.parse(dps[2]);
    previous1.dps = double.parse(dps[3]);
    previous2.dps = double.parse(dps[4]);
    previous3.dps = double.parse(dps[5]);

    // normalised earnings per share
    final normEPS = lines[22].split('\t');
    current.normEPS = double.parse(normEPS[1]);
    previous.normEPS = double.parse(normEPS[2]);
    previous1.normEPS = double.parse(normEPS[3]);
    previous2.normEPS = double.parse(normEPS[4]);
    previous3.normEPS = double.parse(normEPS[5]);

    // normalised earnings per share
    final reportedEPS = lines[23].split('\t');
    current.reportedEPS = double.parse(reportedEPS[1]);
    previous.reportedEPS = double.parse(reportedEPS[2]);
    previous1.reportedEPS = double.parse(reportedEPS[3]);
    previous2.reportedEPS = double.parse(reportedEPS[4]);
    previous3.reportedEPS = double.parse(reportedEPS[5]);

    incomeStatements
        .addAll([previous3, previous2, previous1, previous, current]);
  }
}

class BalanceSheet {
  final int year;
  late String yearEnd;
  late double intangibles;
  late double tangibles;
  late double investments;
  late double other;
  late double stock;
  late double debtors;
  late double cash;
  late double current;
  late double nonCurrent;
  late double shareCapital;
  late double reserves;
  late double minorities;
  late double netBorrowing;
  late double tangiblePS;

  BalanceSheet(this.year);

  @override
  String toString() {
    return '$year $yearEnd $intangibles $tangibles $investments $other $stock $debtors $cash $current $nonCurrent $shareCapital $reserves $minorities $netBorrowing $tangiblePS';
  }
}

class IncomeStatement {
  final int year;
  late String yearEnd;

  late double turnover;
  late double expenses;
  late double netInterest;
  late double preTaxProfit;
  late double tax;
  late double dps;
  late double normEPS;
  late double reportedEPS;

  IncomeStatement(this.year);

  /// an arbitrary value index derived from the earnings and dividend per share
  double get index => 2.5 * dps + normEPS + reportedEPS;

  double get dividendRatio => 2 * dps / (normEPS + reportedEPS);

  double get eps => (normEPS + reportedEPS) / 2;

  @override
  String toString() {
    return '$year $yearEnd $turnover $expenses $netInterest $preTaxProfit $tax $dps $normEPS $reportedEPS';
  }
}
