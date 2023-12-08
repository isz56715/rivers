class River {
  num? year;
  num? month;
  String? city;
  String? county;
  String? town;
  String? dong;
  String? rivername;
  num? waterTemp;
  num? hydrogen;
  num? oxygen;
  num? bioOxygen;
  num? chemicalOxygen;
  num? matter;
  num? nitrogen;
  num? phosphorus;
  double? lon;
  double? lat;
  num? x;
  num? y;
  num? date;
  num? km;
  double? ym;

  River(
      {this.year,
      this.month,
      this.city,
      this.county,
      this.town,
      this.dong,
      this.rivername,
      this.waterTemp,
      this.hydrogen,
      this.oxygen,
      this.bioOxygen,
      this.chemicalOxygen,
      this.matter,
      this.nitrogen,
      this.phosphorus,
      this.lon,
      this.lat,
      this.x,
      this.y,
      this.date,
      this.ym
      });

  River.fromJson(Map<String, dynamic> json) {
    year = json['연도'];
    month = json['월'];
    city = json['시도 명'];
    county = json['시군구 명'];
    town = json['읍면동 명'];
    dong = json['동리 명'];
    rivername = json['측정소 명'];
    waterTemp = json['수온'];
    hydrogen = json['수소이온농도'];
    oxygen = json['용존산소'];
    bioOxygen = json['생화학적 산소요구량'];
    chemicalOxygen = json['화학적 산소요구량'];
    matter = json['부유물질'];
    nitrogen = json['총질소'];
    phosphorus = json['총인'];
    lon = json['경도'];
    lat = json['위도'];
    x = json['X'];
    y = json['Y'];
    date = json['날짜'];
    ym = json['연도월'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['city'] = this.city;
    data['county'] = this.county;
    data['town'] = this.town;
    data['dong'] = this.dong;
    data['rivername'] = this.rivername;
    data['water_temp'] = this.waterTemp;
    data['hydrogen'] = this.hydrogen;
    data['oxygen'] = this.oxygen;
    data['bio_oxygen'] = this.bioOxygen;
    data['chemical_oxygen'] = this.chemicalOxygen;
    data['matter'] = this.matter;
    data['nitrogen'] = this.nitrogen;
    data['phosphorus'] = this.phosphorus;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['x'] = this.x;
    data['y'] = this.y;
    data['date'] = this.date;
    data['ym'] = this.ym;
    return data;
  }
}