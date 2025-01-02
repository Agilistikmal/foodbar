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

class HalalData {
  int customerId;
  String expireDate;
  String namaProduk;
  String namaProdusen;
  String nomorSertifikat;
  String productGroup;
  String productGroupCode;
  int productId;

  HalalData({
    required this.customerId,
    required this.expireDate,
    required this.namaProduk,
    required this.namaProdusen,
    required this.nomorSertifikat,
    required this.productGroup,
    required this.productGroupCode,
    required this.productId,
  });

  HalalData.fromJson(Map<dynamic, dynamic> json)
      : customerId = json["customer_id"],
        expireDate = json["expire_date"],
        namaProduk = json["nama_produk"],
        namaProdusen = json["nama_produsen"],
        nomorSertifikat = json["nomor_sertifikat"],
        productGroup = json["product_group"],
        productGroupCode = json["product_group_code"],
        productId = json["product_id"];
}

class FoodWithHalalData {
  Food food;
  HalalData halalData;

  FoodWithHalalData({required this.food, required this.halalData});

  FoodWithHalalData.fromJson(Map<dynamic, dynamic> json)
      : food = Food.fromJson(json["product"]),
        halalData = HalalData.fromJson(json["halal_data"]);
}
