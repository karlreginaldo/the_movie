import 'package:themovie/domain/entities/production_company.dart';

class ProductionCompanyModel extends ProductionCompany {
  ProductionCompanyModel({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  }) : super(
            id: id,
            logoPath: logoPath,
            name: name,
            originCountry: originCountry);

  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompanyModel(
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}
