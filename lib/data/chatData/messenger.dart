class messenger {
  String content;
  int type; //1: khách hàng, 2: admin

  messenger({required this.type, required this.content});

  Map<dynamic, dynamic> toJson() => {
    'content': content,
    'type': type,
  };

  factory messenger.fromJson(Map<dynamic, dynamic> json) {
    return messenger(
      type: int.parse(json['type'].toString()),
      content: json['content'].toString(),
    );
  }
}