class SajdaClass {
  final int id;
  final bool recommended;
  final bool obligatory;

  SajdaClass({
    required this.id,
    required this.recommended,
    required this.obligatory,
  });

  factory SajdaClass.fromMap(Map<String, dynamic> json) => SajdaClass(
        id: json["id"],
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "recommended": recommended,
        "obligatory": obligatory,
      };
}
