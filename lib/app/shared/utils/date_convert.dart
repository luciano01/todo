class DateConvert {
  // List of Months
  List<String> _listOfMonths = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Convert the number of months into the name of months
  String? monthIntoName(int? monthNumber) {
    var monthName = _listOfMonths[monthNumber! - 1];
    return monthName;
  }
}
