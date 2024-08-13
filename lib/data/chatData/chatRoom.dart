import '../Account/Account.dart';
import 'messenger.dart';

class chatRoom {
  Account account;
  List<messenger> messengerList;

  chatRoom({required this.account, required this.messengerList});

  Map<dynamic, dynamic> toJson() => {
    'account': account.toJson(),
    'messengerList': messengerList.map((e) => e.toJson()).toList(),
  };

  factory chatRoom.fromJson(Map<dynamic, dynamic> json) {
    List<messenger> mesList = [];

    if (json["messengerList"] != null) {
      for (final result in json["messengerList"]) {
        mesList.add(messenger.fromJson(result));
      }
    }

    return chatRoom(
      account: Account.fromJson(json['account']),
      messengerList: mesList,
    );
  }
}