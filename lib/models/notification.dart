class MedicineNotification {
  final int? id;
  final int idMedicine;
  final String time;

  MedicineNotification({this.id, required this.idMedicine, required this.time});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idMedicine': idMedicine,
      'time': time,
    };
  }
}
