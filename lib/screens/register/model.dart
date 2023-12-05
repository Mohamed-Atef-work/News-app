class UserModel {
  late String name;
  late String uId;
  late String phone;
  late String email;
  late String language;
  late String country;
  late String image;
  late int age;
  late String bio;

  UserModel({
    required this.name,
    required this.uId,
    required this.phone,
    required this.email,
    required this.language,
    required this.country,
    required this.image,
    required this.age,
    required this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    uId = json["uId"];
    phone = json["phone"];
    email = json["email"];
    language = json["language"];
    country = json["country"];
    image = json["image"];
    age = json["age"];
    bio = json["bio"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "uId": uId,
      "phone": phone,
      "email": email,
      "language": language,
      "country": country,
      "image": image,
      "bio": bio,
      "age": age,
    };
  }
}
