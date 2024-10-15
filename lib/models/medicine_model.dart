class Medicine {
  final int? id;
  final String? name;
  final int? frequency;

  Medicine({
    this.id,
    this.name,
    this.frequency
  });

  Map<String, dynamic> toJson(){
    return{'id':id, 'name':name, 'frequency' : frequency};
  }

}
