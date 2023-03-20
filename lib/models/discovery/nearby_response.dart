class NearbyPlacesResponse {
  List<Results>? results;

  NearbyPlacesResponse({this.results});

  NearbyPlacesResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? fsqId;
  List<Categories>? categories;
  List<Chains>? chains;
  int? distance;
  Geocodes? geocodes;
  String? link;
  Location? location;
  String? name;
  RelatedPlaces? relatedPlaces;
  String? timezone;

  Results(
      {this.fsqId,
      this.categories,
      this.chains,
      this.distance,
      this.geocodes,
      this.link,
      this.location,
      this.name,
      this.relatedPlaces,
      this.timezone});

  Results.fromJson(Map<String, dynamic> json) {
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
    distance = json['distance'];
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
    data['distance'] = this.distance;
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
  DropOff? dropOff;
  DropOff? main;
  DropOff? roof;

  Geocodes({this.dropOff, this.main, this.roof});

  Geocodes.fromJson(Map<String, dynamic> json) {
    dropOff = json['drop_off'] != null
        ? new DropOff.fromJson(json['drop_off'])
        : null;
    main = json['main'] != null ? new DropOff.fromJson(json['main']) : null;
    roof = json['roof'] != null ? new DropOff.fromJson(json['roof']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dropOff != null) {
      data['drop_off'] = this.dropOff!.toJson();
    }
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.roof != null) {
      data['roof'] = this.roof!.toJson();
    }
    return data;
  }
}

class DropOff {
  double? latitude;
  double? longitude;

  DropOff({this.latitude, this.longitude});

  DropOff.fromJson(Map<String, dynamic> json) {
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
  String? region;
  String? postTown;

  Location(
      {this.address,
      this.country,
      this.crossStreet,
      this.formattedAddress,
      this.locality,
      this.region,
      this.postTown});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    country = json['country'];
    crossStreet = json['cross_street'];
    formattedAddress = json['formatted_address'];
    locality = json['locality'];
    region = json['region'];
    postTown = json['post_town'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['country'] = this.country;
    data['cross_street'] = this.crossStreet;
    data['formatted_address'] = this.formattedAddress;
    data['locality'] = this.locality;
    data['region'] = this.region;
    data['post_town'] = this.postTown;
    return data;
  }
}

class RelatedPlaces {
  Parent? parent;
  List<Children>? children;

  RelatedPlaces({this.parent, this.children});

  RelatedPlaces.fromJson(Map<String, dynamic> json) {
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parent {
  String? fsqId;
  String? name;

  Parent({this.fsqId, this.name});

  Parent.fromJson(Map<String, dynamic> json) {
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
