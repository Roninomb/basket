class Player {
  final String? id;
  final String name;
  final String team;
  final String position;
  final String photoUrl;

  Player({
    this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.photoUrl,
  });

  factory Player.fromMap(Map<String, dynamic> map, String documentId) {
    return Player(
      id: documentId,
      name: map['Nombre'],
      team: map['Equipo'],
      position: map['Posicion'],
      photoUrl: map['Photourl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Nombre': name,
      'Equipo': team,
      'Posicion': position,
      'Photourl': photoUrl,
    };
  }

  Player copyWith({
    String? id,
    String? name,
    String? team,
    String? position,
    String? photoUrl,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      team: team ?? this.team,
      position: position ?? this.position,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}