import '../otherdata/Time.dart';

class noticeData {
  String id;
  String title;
  String sub;
  String content;
  int status; // 1 : chưa thông báo , 2 : đang thông báo
  Time create;
  Time send;

  noticeData({required this.id ,required this.title ,required this.sub, required this.create, required this.send, required this.status, required this.content});

  Map<dynamic, dynamic> toJson() => {
    'id' : id,
    'title': title,
    'sub' : sub,
    'create' : create.toJson(),
    'send' : send.toJson(),
    'status' : status,
    'content' : content
  };

  factory noticeData.fromJson(Map<dynamic, dynamic> json) {
    return noticeData(
        title: json['title'].toString(),
        sub: json['sub'].toString(),
        create: Time.fromJson(json['create']),
        send: Time.fromJson(json['send']),
        id: json['id'].toString(),
        status: int.parse(json['status'].toString()),
        content: json['content'].toString()
    );
  }
}