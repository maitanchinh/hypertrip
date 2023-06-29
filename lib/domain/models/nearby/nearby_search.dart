class SearchPlaceResponse {
  List<SearchResults>? results;
  Context? context;

  SearchPlaceResponse({this.results, this.context});

  SearchPlaceResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <SearchResults>[];
      json['results'].forEach((v) {
        results!.add(new SearchResults.fromJson(v));
      });
    }
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    if (this.context != null) {
      data['context'] = this.context!.toJson();
    }
    return data;
  }
}

class SearchResults {
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

  SearchResults(
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

  SearchResults.fromJson(Map<String, dynamic> json) {
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
  Main? main;
  Main? roof;
  Main? dropOff;

  Geocodes({this.main, this.roof, this.dropOff});

  Geocodes.fromJson(Map<String, dynamic> json) {
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    roof = json['roof'] != null ? new Main.fromJson(json['roof']) : null;
    dropOff =
        json['drop_off'] != null ? new Main.fromJson(json['drop_off']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.roof != null) {
      data['roof'] = this.roof!.toJson();
    }
    if (this.dropOff != null) {
      data['drop_off'] = this.dropOff!.toJson();
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
  String? censusBlock;
  String? country;
  String? crossStreet;
  String? dma;
  String? formattedAddress;
  String? locality;
  String? postcode;
  String? region;
  String? addressExtended;

  Location(
      {this.address,
      this.censusBlock,
      this.country,
      this.crossStreet,
      this.dma,
      this.formattedAddress,
      this.locality,
      this.postcode,
      this.region,
      this.addressExtended});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    censusBlock = json['census_block'];
    country = json['country'];
    crossStreet = json['cross_street'];
    dma = json['dma'];
    formattedAddress = json['formatted_address'];
    locality = json['locality'];
    postcode = json['postcode'];
    region = json['region'];
    addressExtended = json['address_extended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['census_block'] = this.censusBlock;
    data['country'] = this.country;
    data['cross_street'] = this.crossStreet;
    data['dma'] = this.dma;
    data['formatted_address'] = this.formattedAddress;
    data['locality'] = this.locality;
    data['postcode'] = this.postcode;
    data['region'] = this.region;
    data['address_extended'] = this.addressExtended;
    return data;
  }
}

class RelatedPlaces {
  Parent? parent;

  RelatedPlaces({this.parent});

  RelatedPlaces.fromJson(Map<String, dynamic> json) {
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
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

class Context {
  GeoBounds? geoBounds;

  Context({this.geoBounds});

  Context.fromJson(Map<String, dynamic> json) {
    geoBounds = json['geo_bounds'] != null
        ? new GeoBounds.fromJson(json['geo_bounds'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geoBounds != null) {
      data['geo_bounds'] = this.geoBounds!.toJson();
    }
    return data;
  }
}

class GeoBounds {
  Circle? circle;

  GeoBounds({this.circle});

  GeoBounds.fromJson(Map<String, dynamic> json) {
    circle =
        json['circle'] != null ? new Circle.fromJson(json['circle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.circle != null) {
      data['circle'] = this.circle!.toJson();
    }
    return data;
  }
}

class Circle {
  Main? center;
  int? radius;

  Circle({this.center, this.radius});

  Circle.fromJson(Map<String, dynamic> json) {
    center = json['center'] != null ? new Main.fromJson(json['center']) : null;
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    data['radius'] = this.radius;
    return data;
  }
}
