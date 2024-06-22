class RoutesModifier {
  bool? avoidTolls;
  bool? avoidHighways;
  bool? avoidFerries;

  RoutesModifier(
      {this.avoidTolls = false,
      this.avoidHighways = false,
      this.avoidFerries = false});

  factory RoutesModifier.fromJson(Map<String, dynamic> json) {
    return RoutesModifier(
      avoidTolls: json['avoidTolls'] as bool?,
      avoidHighways: json['avoidHighways'] as bool?,
      avoidFerries: json['avoidFerries'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'avoidTolls': avoidTolls,
        'avoidHighways': avoidHighways,
        'avoidFerries': avoidFerries,
      };
}