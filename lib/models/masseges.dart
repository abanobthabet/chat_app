class Masseges {
  String massege;
  String id;

  Masseges(this.massege,this.id);

  factory Masseges.fromjson(json) {
    return Masseges(json['massege'],json['id']);
  }
}
