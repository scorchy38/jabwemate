class DogProfile {
  String iamgeURL, name, breed, gender, owner, city, ownerId, address, phone;
  List otherImages;
  int age;
  DogProfile(this.iamgeURL, this.name, this.city, this.age, this.breed,
      this.gender, this.owner, this.ownerId, this.address, this.phone,
      {this.otherImages});
}
