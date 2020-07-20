class Docpro {
  final String name, specs, degr, address;
  final double cost;
  final String imageUrl;

  Docpro(
      {this.address,
      this.imageUrl,
      this.name,
      this.specs,
      this.degr,
      this.cost});
}

final _doc0 = Docpro(
    address: 'Address1',
    imageUrl: 'images/Doc1.png',
    name: 'Dr Doctor One',
    specs: 'Dogs',
    degr: 'MBBS',
    cost: 1);

final _doc1 = Docpro(
    address: 'Address2',
    imageUrl: 'images/Doc2.png',
    name: 'Dr Doctor two',
    specs: 'Cat',
    degr: 'MBBS',
    cost: 1);

final _doc2 = Docpro(
    address: 'Address2',
    imageUrl: 'images/Doc3.png',
    name: 'Dr Doctor three',
    specs: 'Giraffe',
    degr: 'MBBS',
    cost: 1);

final _doc3 = Docpro(
    address: 'Address1',
    imageUrl: 'images/doc4.jpg',
    name: 'Dr Doctor Four',
    specs: 'Dogs',
    degr: 'MBBS',
    cost: 1);

final _doc4 = Docpro(
    address: 'Address2',
    imageUrl: 'images/Doc5.jpg',
    name: 'Dr Doctor Five',
    specs: 'Cat',
    degr: 'MBBS',
    cost: 1);

final _doc5 = Docpro(
    address: 'Address2',
    imageUrl: 'images/Doc1.png',
    name: 'Dr Doctor Six',
    specs: 'Giraffe',
    degr: 'MBBS',
    cost: 1);

final List<Docpro> docpros = [
  _doc0,
  _doc1,
  _doc2,
  _doc5,
  _doc4,
  _doc3,
];
