class VendorModel {
  String? id, vendor, inisialVendor, descVendor, iconData, hexColor;
  int? isAktif;

  VendorModel({
    this.id,
    this.vendor,
    this.inisialVendor,
    this.descVendor,
    this.iconData,
    this.hexColor,
    this.isAktif,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      vendor: json['vendor'],
      inisialVendor: json['inisial_vendor'],
      descVendor: json['desc_vendor'],
      iconData: json['icon_data'],
      hexColor: json['hex_color'],
      isAktif: json['is_aktif'],
    );
  }

  List<VendorModel> listFromListJson(List<dynamic> listJson) {
    return listJson.map((e) => VendorModel.fromJson(e)).toList();
  }
}
