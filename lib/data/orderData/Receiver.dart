class Receiver {
  String name;
  String nation;
  String province;
  String city;
  String district;
  String podcode;
  String address;
  String phoneNumber;

  Receiver({required this.name, required this.nation, required this.phoneNumber, required this.city, required this.district, required this.podcode, required this.province, required this.address});

  Map<dynamic, dynamic> toJson() => {
    'name': name,
    'nation': nation,
    'province': province,
    'city': city,
    'district': district,
    'podcode': podcode,
    'phoneNumber': phoneNumber,
    'address': address,
  };

  factory Receiver.fromJson(Map<dynamic, dynamic> json) {
    return Receiver(
        name: json['name'].toString(),
        nation: json['nation'].toString(),
        phoneNumber: json['phoneNumber'].toString(),
        city: json['city'].toString(),
        district: json['district'].toString(),
        podcode: json['podcode'].toString(),
        province: json['province'].toString(),
        address: json['address'].toString(),
    );
  }
}