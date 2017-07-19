/// Holds an immutable symbol, the value of which is set once and only once.
class Constant<T> extends Variable<T> {
  Constant(String name, T value) : super(name, value: value) {
    lock();
  }
}

/// Holds a mutable symbol, the value of which may change.
class Variable<T> {
  bool _locked = false, _private = false;
  T _value;
  final String name;

  Variable(this.name, {T value}) {
    _value = value;
  }

  /// If `true`, then the value of this variable cannot be overwritten.
  bool get isImmutable => _locked;

  /// This flag has no meaning within the context of this library, but if you
  /// are implementing some sort of interpreter, you may consider acting based on
  /// whether a variable is private.
  bool get isPrivate => _private;

  T get value => _value;

  void set value(T value) {
    if (_locked)
      throw new StateError(
          'The value of constant "$name" cannot be overwritten.');
    _value = value;
  }

  /// Locks this symbol, and prevents its [value] from being overwritten.
  ///
  /// Also see [Constant].
  void lock() {
    _locked = true;
  }

  /// Marks this symbol as private.
  void markAsPrivate() {
    _private = true;
  }
}
