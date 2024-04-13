class ExpensesModel {
  int? id, total;
  String? name, financialSource, createdAt, updatedAt;

  ExpensesModel(
      {this.id,
      this.total,
      this.name,
      this.financialSource,
      this.createdAt,
      this.updatedAt});

  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
        id: json['id'],
        total: json['total'],
        name: json['name'],
        financialSource: json['financialSource'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
