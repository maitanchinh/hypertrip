class NearbyPlaceDetail {
  String? fsqId;
  List<Categories>? categories;
  List<Chains>? chains;
  Geocodes? geocodes;
  String? link;
  Location? location;
  String? name;
  RelatedPlaces? relatedPlaces;
  String? timezone;

  NearbyPlaceDetail(
      {this.fsqId,
      this.categories,
      this.chains,
      this.geocodes,
      this.link,
      this.location,
      this.name,
      this.relatedPlaces,
      this.timezone});

  NearbyPlaceDetail.fromJson(Map<String, dynamic> json) {
    fsqId = json['fsq_id'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['chains'] != null) {
      chains = <Chains>[];
      json['chains'].forEach((v) {
        chains!.add(new Chains.fromJson(v));
      });
    }
    geocodes = json['geocodes'] != null
        ? new Geocodes.fromJson(json['geocodes'])
        : null;
    link = json['link'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    relatedPlaces = json['related_places'] != null
        ? new RelatedPlaces.fromJson(json['related_places'])
        : null;
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fsq_id'] = this.fsqId;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.chains != null) {
      data['chains'] = this.chains!.map((v) => v.toJson()).toList();
    }
    if (this.geocodes != null) {
      data['geocodes'] = this.geocodes!.toJson();
    }
    data['link'] = this.link;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['name'] = this.name;
    if (this.relatedPlaces != null) {
      data['related_places'] = this.relatedPlaces!.toJson();
    }
    data['timezone'] = this.timezone;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  Icon? icon;

  Categories({this.id, this.name, this.icon});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }
    return data;
  }
}

class Icon {
  String? prefix;
  String? suffix;

  Icon({this.prefix, this.suffix});

  Icon.fromJson(Map<String, dynamic> json) {
    prefix = json['prefix'];
    suffix = json['suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prefix'] = this.prefix;
    data['suffix'] = this.suffix;
    return data;
  }
}

class Chains {
  String? id;
  String? name;

  Chains({this.id, this.name});

  Chains.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Geocodes {
  Main? main;
  Main? roof;

  Geocodes({this.main, this.roof});

  Geocodes.fromJson(Map<String, dynamic> json) {
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    roof = json['roof'] != null ? new Main.fromJson(json['roof']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.roof != null) {
      data['roof'] = this.roof!.toJson();
    }
    return data;
  }
}

class Main {
  double? latitude;
  double? longitude;

  Main({this.latitude, this.longitude});

  Main.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Location {
  String? address;
  String? country;
  String? crossStreet;
  String? formattedAddress;
  String? locality;
  String? postTown;
  String? region;

  Location(
      {this.address,
      this.country,
      this.crossStreet,
      this.formattedAddress,
      this.locality,
      this.postTown,
      this.region});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    country = json['country'];
    crossStreet = json['cross_street'];
    formattedAddress = json['formatted_address'];
    locality = json['locality'];
    postTown = json['post_town'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['country'] = this.country;
    data['cross_street'] = this.crossStreet;
    data['formatted_address'] = this.formattedAddress;
    data['locality'] = this.locality;
    data['post_town'] = this.postTown;
    data['region'] = this.region;
    return data;
  }
}

class RelatedPlaces {
  List<Children>? children;

  RelatedPlaces({this.children});

  RelatedPlaces.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? fsqId;
  String? name;

  Children({this.fsqId, this.name});

  Children.fromJson(Map<String, dynamic> json) {
    fsqId = json['fsq_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fsq_id'] = this.fsqId;
    data['name'] = this.name;
    return data;
  }
}
