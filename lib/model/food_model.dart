class Food {
  String barcode;
  String name;
  String? certificate;

  Food({required this.barcode, required this.name, this.certificate});

  Food.fromJson(Map<dynamic, dynamic> json)
      : barcode = json["barcode"],
        name = json["name"],
        certificate = json["certificate"];
}
