class chartday {
  chartday(this.hours, this.money);
  String hours;
  double money;
}

class chartweek {
  chartweek(this.day, this.money);
  String day;
  double money;
}

class chartmonth {
  chartmonth(this.week, this.money);
  String week;
  double money;
}

class chartyear {
  chartyear(this.month, this.money);
  String month;
  double money;
}
