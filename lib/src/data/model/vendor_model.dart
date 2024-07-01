import 'package:bangli_service_center_bloc/src/domain/entities/vendor_entity.dart';

class VendorModel extends VendorEntity {
  VendorModel({
    String? id,
    String? vendor,
    String? inisialVendor,
    String? descVendor,
    String? iconData,
    String? hexColor,
    int? isAktif,
  }) : super(
          id: id,
          vendor: vendor,
          inisialVendor: inisialVendor,
          descVendor: descVendor,
          iconData: iconData,
          hexColor: hexColor,
          isAktif: isAktif,
        );

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
