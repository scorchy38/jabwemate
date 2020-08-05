class AppointmentData {
  String bookingTime,
      doctorUID,
      docName,
      docDegree,
      status,
      dogAge,
      dogBreed,
      dogName,
      ownerEmail,
      ownerName,
      ownerPhone,
      patientUID,
      from,
      to,
      docId,
      bookingDate,
      appDate;

  bool isConfirmed, isPaid;

  AppointmentData(
      this.bookingTime,
      this.doctorUID,
      this.docName,
      this.docDegree,
      this.status,
      this.dogAge,
      this.dogBreed,
      this.dogName,
      this.ownerEmail,
      this.ownerName,
      this.ownerPhone,
      this.patientUID,
      this.from,
      this.to,
      this.docId,
      this.appDate,
      this.bookingDate,
      this.isConfirmed,
      this.isPaid);
}
