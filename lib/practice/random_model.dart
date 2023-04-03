class RandomModel {
  int? id;
  String? uid;
  String? password;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? avatar;
  String? gender;
  String? phoneNumber;
  String? socialInsuranceNumber;
  String? dateOfBirth;
  Employment? employment;
  Address? address;
  CreditCard? creditCard;
  Subscription? subscription;

  RandomModel(
      {this.id,
        this.uid,
        this.password,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.avatar,
        this.gender,
        this.phoneNumber,
        this.socialInsuranceNumber,
        this.dateOfBirth,
        this.employment,
        this.address,
        this.creditCard,
        this.subscription});

  RandomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    socialInsuranceNumber = json['social_insurance_number'];
    dateOfBirth = json['date_of_birth'];
    employment = json['employment'] != null
        ? new Employment.fromJson(json['employment'])
        : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    creditCard = json['credit_card'] != null
        ? new CreditCard.fromJson(json['credit_card'])
        : null;
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['social_insurance_number'] = this.socialInsuranceNumber;
    data['date_of_birth'] = this.dateOfBirth;
    if (this.employment != null) {
      data['employment'] = this.employment!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.creditCard != null) {
      data['credit_card'] = this.creditCard!.toJson();
    }
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    return data;
  }
}

class Employment {
  String? title;
  String? keySkill;

  Employment({this.title, this.keySkill});

  Employment.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    keySkill = json['key_skill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['key_skill'] = this.keySkill;
    return data;
  }
}

class Address {
  String? city;
  String? streetName;
  String? streetAddress;
  String? zipCode;
  String? state;
  String? country;
  Coordinates? coordinates;

  Address(
      {this.city,
        this.streetName,
        this.streetAddress,
        this.zipCode,
        this.state,
        this.country,
        this.coordinates});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    streetName = json['street_name'];
    streetAddress = json['street_address'];
    zipCode = json['zip_code'];
    state = json['state'];
    country = json['country'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['street_name'] = this.streetName;
    data['street_address'] = this.streetAddress;
    data['zip_code'] = this.zipCode;
    data['state'] = this.state;
    data['country'] = this.country;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    return data;
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class CreditCard {
  String? ccNumber;

  CreditCard({this.ccNumber});

  CreditCard.fromJson(Map<String, dynamic> json) {
    ccNumber = json['cc_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cc_number'] = this.ccNumber;
    return data;
  }
}

class Subscription {
  String? plan;
  String? status;
  String? paymentMethod;
  String? term;

  Subscription({this.plan, this.status, this.paymentMethod, this.term});

  Subscription.fromJson(Map<String, dynamic> json) {
    plan = json['plan'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    term = json['term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan'] = this.plan;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['term'] = this.term;
    return data;
  }
}
