class NearbyPlace {
  List<NearbyResults>? results;

  NearbyPlace({this.results});

  NearbyPlace.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <NearbyResults>[];
      json['results'].forEach((v) {
        results!.add(new NearbyResults.fromJson(v));
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

class NearbyResults {
  String? fsqId;
  List<Categories>? categories;
  int? distance;
  Hours? hours;
  Location? location;
  String? name;
  List<Photos>? photos;
  SocialMedia? socialMedia;
  List<Tips>? tips;
  String? tel;
  String? website;
  Features? features;
  int? price;
  double? rating;
  Geocodes? geocodes;

  NearbyResults(
      {this.fsqId,
      this.categories,
      this.distance,
      this.hours,
      this.location,
      this.name,
      this.photos,
      this.socialMedia,
      this.tips,
      this.tel,
      this.website,
      this.features,
      this.price,
      this.rating,
      this.geocodes});

  NearbyResults.fromJson(Map<String, dynamic> json) {
    fsqId = json['fsq_id'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    distance = json['distance'];
    hours = json['hours'] != null ? new Hours.fromJson(json['hours']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    socialMedia = json['social_media'] != null
        ? new SocialMedia.fromJson(json['social_media'])
        : null;
    if (json['tips'] != null) {
      tips = <Tips>[];
      json['tips'].forEach((v) {
        tips!.add(new Tips.fromJson(v));
      });
    }
    tel = json['tel'];
    website = json['website'];
    features = json['features'] != null
        ? new Features.fromJson(json['features'])
        : null;
    price = json['price'];
    rating = json['rating'];
    geocodes = json['geocodes'] != null
        ? new Geocodes.fromJson(json['geocodes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fsq_id'] = this.fsqId;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    if (this.hours != null) {
      data['hours'] = this.hours!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['name'] = this.name;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.toJson();
    }
    if (this.tips != null) {
      data['tips'] = this.tips!.map((v) => v.toJson()).toList();
    }
    data['tel'] = this.tel;
    data['website'] = this.website;
    if (this.features != null) {
      data['features'] = this.features!.toJson();
    }
    data['price'] = this.price;
    data['rating'] = this.rating;
    if (this.geocodes != null) {
      data['geocodes'] = this.geocodes!.toJson();
    }
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

class Hours {
  bool? isLocalHoliday;
  bool? openNow;
  String? display;
  List<Regular>? regular;

  Hours({this.isLocalHoliday, this.openNow, this.display, this.regular});

  Hours.fromJson(Map<String, dynamic> json) {
    isLocalHoliday = json['is_local_holiday'];
    openNow = json['open_now'];
    display = json['display'];
    if (json['regular'] != null) {
      regular = <Regular>[];
      json['regular'].forEach((v) {
        regular!.add(new Regular.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_local_holiday'] = this.isLocalHoliday;
    data['open_now'] = this.openNow;
    data['display'] = this.display;
    if (this.regular != null) {
      data['regular'] = this.regular!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regular {
  String? close;
  int? day;
  String? open;

  Regular({this.close, this.day, this.open});

  Regular.fromJson(Map<String, dynamic> json) {
    close = json['close'];
    day = json['day'];
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['close'] = this.close;
    data['day'] = this.day;
    data['open'] = this.open;
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

class Photos {
  String? id;
  String? createdAt;
  String? prefix;
  String? suffix;
  int? width;
  int? height;

  Photos({
    this.id,
    this.createdAt,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    prefix = json['prefix'];
    suffix = json['suffix'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['prefix'] = this.prefix;
    data['suffix'] = this.suffix;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class SocialMedia {
  String? facebookId;

  SocialMedia({this.facebookId});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebookId = json['facebook_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook_id'] = this.facebookId;
    return data;
  }
}

class Tips {
  String? createdAt;
  String? text;

  Tips({this.createdAt, this.text});

  Tips.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['text'] = this.text;
    return data;
  }
}

class Features {
  Services? services;
  Payment? payment;
  Amenities? amenities;
  Attributes? attributes;

  Features({this.services, this.payment, this.amenities, this.attributes});

  Features.fromJson(Map<String, dynamic> json) {
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
        : null;
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    amenities = json['amenities'] != null
        ? new Amenities.fromJson(json['amenities'])
        : null;
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Services {
  DineIn? dineIn;
  bool? delivery;

  Services({this.dineIn, this.delivery});

  Services.fromJson(Map<String, dynamic> json) {
    dineIn =
        json['dine_in'] != null ? new DineIn.fromJson(json['dine_in']) : null;
    delivery = json['delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dineIn != null) {
      data['dine_in'] = this.dineIn!.toJson();
    }
    data['delivery'] = this.delivery;
    return data;
  }
}

class DineIn {
  bool? reservations;

  DineIn({this.reservations});

  DineIn.fromJson(Map<String, dynamic> json) {
    reservations = json['reservations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservations'] = this.reservations;
    return data;
  }
}

class Payment {
  CreditCards? creditCards;
  DigitalWallet? digitalWallet;

  Payment({this.creditCards, this.digitalWallet});

  Payment.fromJson(Map<String, dynamic> json) {
    creditCards = json['credit_cards'] != null
        ? new CreditCards.fromJson(json['credit_cards'])
        : null;
    digitalWallet = json['digital_wallet'] != null
        ? new DigitalWallet.fromJson(json['digital_wallet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.creditCards != null) {
      data['credit_cards'] = this.creditCards!.toJson();
    }
    if (this.digitalWallet != null) {
      data['digital_wallet'] = this.digitalWallet!.toJson();
    }
    return data;
  }
}

class CreditCards {
  bool? acceptsCreditCards;
  bool? amex;
  bool? discover;
  bool? visa;
  bool? dinersClub;
  bool? masterCard;
  bool? unionPay;

  CreditCards(
      {this.acceptsCreditCards,
      this.amex,
      this.discover,
      this.visa,
      this.dinersClub,
      this.masterCard,
      this.unionPay});

  CreditCards.fromJson(Map<String, dynamic> json) {
    acceptsCreditCards = json['accepts_credit_cards'];
    amex = json['amex'];
    discover = json['discover'];
    visa = json['visa'];
    dinersClub = json['diners_club'];
    masterCard = json['master_card'];
    unionPay = json['union_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepts_credit_cards'] = this.acceptsCreditCards;
    data['amex'] = this.amex;
    data['discover'] = this.discover;
    data['visa'] = this.visa;
    data['diners_club'] = this.dinersClub;
    data['master_card'] = this.masterCard;
    data['union_pay'] = this.unionPay;
    return data;
  }
}

class DigitalWallet {
  bool? acceptsNfc;

  DigitalWallet({this.acceptsNfc});

  DigitalWallet.fromJson(Map<String, dynamic> json) {
    acceptsNfc = json['accepts_nfc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepts_nfc'] = this.acceptsNfc;
    return data;
  }
}

class Amenities {
  bool? outdoorSeating;
  String? wifi;

  Amenities({this.outdoorSeating, this.wifi});

  Amenities.fromJson(Map<String, dynamic> json) {
    outdoorSeating = json['outdoor_seating'];
    wifi = json['wifi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outdoor_seating'] = this.outdoorSeating;
    data['wifi'] = this.wifi;
    return data;
  }
}

class Attributes {
  String? datesPopular;
  String? businessMeeting;
  String? crowded;

  Attributes({this.datesPopular, this.businessMeeting, this.crowded});

  Attributes.fromJson(Map<String, dynamic> json) {
    datesPopular = json['dates_popular'];
    businessMeeting = json['business_meeting'];
    crowded = json['crowded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dates_popular'] = this.datesPopular;
    data['business_meeting'] = this.businessMeeting;
    data['crowded'] = this.crowded;
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
