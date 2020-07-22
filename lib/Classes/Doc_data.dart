class Docpro {
  final String name, specs, degree, address;
  final int cost;
  final String imageUrl;
  final List<TimeSlots> slots;

  Docpro({
    this.address,
    this.imageUrl,
    this.name,
    this.specs,
    this.degree,
    this.cost,
    this.slots,
  });
}

class TimeSlots {
  final String from, to, available;
  TimeSlots({
    this.from,
    this.to,
    this.available,
  });
}
