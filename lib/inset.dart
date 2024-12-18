class Inset {
  final double left;
  final double right;
  final double top;
  final double bottom;
  const Inset.zero()
      : left = 0,
        right = 0,
        top = 0,
        bottom = 0;
  const Inset(
      {required this.left,
      required this.right,
      required this.top,
      required this.bottom});

  Inset copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Inset(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Inset &&
          runtimeType == other.runtimeType &&
          left == other.left &&
          right == other.right &&
          top == other.top &&
          bottom == other.bottom;

  @override
  int get hashCode => Object.hash(left, right, top, bottom);

  @override
  String toString() {
    return '$runtimeType('
        'left: $left, '
        'top: $top, '
        'right: $right, '
        'bottom: $bottom, )';
  }
}
