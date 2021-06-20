class Item {

  int id;
  String name;
  String note;
  String priority;
  int status;

  Item({this.name, this.note, this.priority, this.status});
  Item.withId({this.id, this.name, this.note, this.priority, this.status});

  Map<String, dynamic> toMap() {

    final map = Map<String, dynamic>();

    if (id != null) { map['id'] = id; }

    map['name'] = name;
    map['note'] = note; 
    map['priority'] = priority;
    map['status'] = status;
  
    return map;
  }

  factory Item.fromMap(Map<String, dynamic> map) {

    return Item.withId(
      id: map['id'],
      name: map['name'],
      note: map['note'],
      priority: map['priority'],
      status: map['status'],
    );
  }

}