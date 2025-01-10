class finance {
  String? id;
  String? topic;
  String? date;
  String? timestamp;
  String? name;
  double? income;
  double? expense;
  double? balance;
  String? note;

  finance(
      {this.id,
      this.topic,
      this.date,
      this.timestamp,
      this.name,
      this.income,
      this.expense,
      this.balance,
      this.note});

  

  finance.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    topic = json['Topic'];
    date = json['Date'];
    timestamp = json['Timestamp'];
    name = json['Name'];
    income = json['Income'];
    expense = json['Expense'];
    balance = json['Balance'];
    note = json['Note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Topic'] = this.topic;
    data['Date'] = this.date;
    data['Timestamp'] = this.timestamp;
    data['Name'] = this.name;
    data['Income'] = this.income;
    data['Expense'] = this.expense;
    data['Balance'] = this.balance;
    data['Note'] = this.note;
    return data;
  }
}