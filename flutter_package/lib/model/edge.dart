class Edge {
  String? id;
  int? source;
  String? target;
  Map<String, dynamic>? data;
  String? type;
  bool? animated;
  String? label;
  String? sourceHandle;
  MarkerEnd? markerEnd;

  Edge(
      {this.id,
      this.source,
      this.target,
      this.type,
      this.animated,
      this.label,
      this.sourceHandle,
      this.markerEnd});

  Edge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    target = json['target'];
    data = json['data'];
    type = json['type'];
    animated = json['animated'];
    label = json['label'];
    sourceHandle = json['sourceHandle'];
    markerEnd = json['markerEnd'] != null
        ? MarkerEnd.fromJson(json['markerEnd'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['source'] = source;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    data['target'] = target;
    data['type'] = type;
    data['animated'] = animated;
    data['label'] = label;
    data['sourceHandle'] = sourceHandle;
    if (markerEnd != null) {
      data['markerEnd'] = markerEnd!.toJson();
    }
    return data;
  }
}

class MarkerEnd {
  String? type;

  MarkerEnd({this.type});

  MarkerEnd.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }
}
