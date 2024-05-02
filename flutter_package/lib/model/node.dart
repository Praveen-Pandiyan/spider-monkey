class Node {
  String? id;
  String? type;
  Map<String, dynamic>? data;
  String? className;
  Style? style;
  Position? position;
  String? sourcePosition;
  String? targetPosition;
  bool? draggable;
  bool? selectable;

  Node(
      {this.id,
      this.type,
      this.data,
      this.className,
      this.style,
      this.position,
      this.sourcePosition,
      this.targetPosition,
      this.draggable=true,
      this.selectable=true});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    data = json['data'];
    className = json['className'];
    style = json['style'] != null ? Style.fromJson(json['style']) : null;
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    sourcePosition = json['sourcePosition'];
    targetPosition = json['targetPosition'];
    draggable = json['draggable'];
    selectable = json['selectable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    data['className'] = className;
    if (style != null) {
      data['style'] = style!.toJson();
    }
    if (position != null) {
      data['position'] = position!.toJson();
    }
    data['sourcePosition'] = sourcePosition;
    data['targetPosition'] = targetPosition;
    data['draggable'] = draggable;
    data['selectable'] = selectable;
    return data;
  }
}

class Data {
  String? label;

  Data({this.label});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    return data;
  }
}

class Style {
  String? background;
  String? color;

  Style({this.background, this.color});

  Style.fromJson(Map<String, dynamic> json) {
    background = json['background'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['background'] = background;
    data['color'] = color;
    return data;
  }
}

class Position {
  int? x;
  int? y;

  Position({this.x, this.y});

  Position.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}
