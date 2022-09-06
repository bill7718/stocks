class StockData {

  final String code;
  late final List<BalanceSheet> balanceSheets;

  StockData(this.code) {
    balanceSheets = <BalanceSheet>[];
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

    print(current.toString());
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

  BalanceSheet(this.year);

  @override
  String toString() {
    return '$year $yearEnd $intangibles $tangibles $investments $other $stock';
  }
}