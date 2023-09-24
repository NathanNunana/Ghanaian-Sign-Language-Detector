part of models;

@HiveType(typeId: 0)
class ResultAdapter {
  @HiveField(0)
  double? confidence;
  @HiveField(1)
  String? label;
  @HiveField(2)
  DateTime? date = DateTime.now();

  ResultAdapter({this.confidence, this.label, this.date});

  factory ResultAdapter.fromJson(dynamic json) => ResultAdapter(
        confidence: json["confidence"],
        label: json["label"],
      );
}
