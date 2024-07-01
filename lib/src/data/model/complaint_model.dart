import 'package:bangli_service_center_bloc/src/domain/entities/complaint_entity.dart';

class ComplaintModel extends ComplaintEntity {
  ComplaintModel({
    String? id,
    String? vendor,
    String? descVendor,
    String? inisialVendor,
    int? count,
    String? hexColor,
    String? iconData,
  }) : super(
          id: id,
          vendor: vendor,
          descVendor: descVendor,
          inisialVendor: inisialVendor,
          count: count,
          hexColor: hexColor,
          iconData: iconData,
        );

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      vendor: json['vendor'],
      descVendor: json['desc_vendor'],
      inisialVendor: json['inisial_vendor'],
      count: json['count'],
      hexColor: json['hex_color'],
      iconData: json['icon_data'],
    );
  }

  List<ComplaintModel> listComplaintFromJson(
      List<Map<String, dynamic>> listJson) {
    return listJson.map((e) => ComplaintModel.fromJson(e)).toList();
  }

  List<ComplaintModel> listComplaintFromJsonDynamic(List<dynamic> listJson) {
    return listJson.map((e) => ComplaintModel.fromJson(e)).toList();
  }

  @override
  String toString() {
    return '''{
              'id' : $id,
              'vendor' : $vendor,
              'desc_vendor' : $descVendor,
              'inisial_vendor' : $inisialVendor,
              'count' : $count,
              'hex_color' : $hexColor,
              'icon_data' : $iconData,
              }''';
  }
}
