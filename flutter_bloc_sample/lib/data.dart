class UserData {
  String name;
  String family;
  int age;
  double weight;

  UserData({
    this.name,
    this.family,
    this.age,
    this.weight
  });

  @override
  List<Object> get props =>
      [name, family, age, weight];

  @override
  String toString() =>
      'User Info { name: $name, family: $family, age: $age, weight: $weight }';

}