class Docpro {
  String name, specs, degree, address, docId;
  int cost;
  String imageUrl;
  List<TimeSlots> slots;

  Docpro(
      {this.address,
      this.imageUrl,
      this.name,
      this.specs,
      this.degree,
      this.cost,
      this.slots,
      this.docId});
}

class TimeSlots {
  final String from, to, available;
  TimeSlots({
    this.from,
    this.to,
    this.available,
  });
}
