class TransactionHis {
  String id;
  String content;
  double money;
  String owner;
  int type; // 0: trừ tiền, 1: cộng tiền

  TransactionHis({required this.id, required this.content, required this.money, required this.owner, required this.type});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'content': content,
    'money': money,
    'owner': owner,
    'type': type,
  };

  factory TransactionHis.fromJson(Map<dynamic, dynamic> json) {
    return TransactionHis (
      id: json['id'].toString(),
      content: json['content'].toString(),
      owner: json['owner'].toString(),
      type: int.parse(json['type'].toString()),
      money: double.parse(json['money'].toString()),
    );
  }
}