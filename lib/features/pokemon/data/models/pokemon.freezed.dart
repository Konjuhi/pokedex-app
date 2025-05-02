// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return _Pokemon.fromJson(json);
}

/// @nodoc
mixin _$Pokemon {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get generation => throw _privateConstructorUsedError;
  List<EffectEntry> get effectEntries => throw _privateConstructorUsedError;
  String? get customOrder => throw _privateConstructorUsedError;

  /// Serializes this Pokemon to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PokemonCopyWith<Pokemon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonCopyWith<$Res> {
  factory $PokemonCopyWith(Pokemon value, $Res Function(Pokemon) then) =
      _$PokemonCopyWithImpl<$Res, Pokemon>;
  @useResult
  $Res call({
    String id,
    String name,
    String image,
    String generation,
    List<EffectEntry> effectEntries,
    String? customOrder,
  });
}

/// @nodoc
class _$PokemonCopyWithImpl<$Res, $Val extends Pokemon>
    implements $PokemonCopyWith<$Res> {
  _$PokemonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = null,
    Object? generation = null,
    Object? effectEntries = null,
    Object? customOrder = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            image:
                null == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String,
            generation:
                null == generation
                    ? _value.generation
                    : generation // ignore: cast_nullable_to_non_nullable
                        as String,
            effectEntries:
                null == effectEntries
                    ? _value.effectEntries
                    : effectEntries // ignore: cast_nullable_to_non_nullable
                        as List<EffectEntry>,
            customOrder:
                freezed == customOrder
                    ? _value.customOrder
                    : customOrder // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PokemonImplCopyWith<$Res> implements $PokemonCopyWith<$Res> {
  factory _$$PokemonImplCopyWith(
    _$PokemonImpl value,
    $Res Function(_$PokemonImpl) then,
  ) = __$$PokemonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String image,
    String generation,
    List<EffectEntry> effectEntries,
    String? customOrder,
  });
}

/// @nodoc
class __$$PokemonImplCopyWithImpl<$Res>
    extends _$PokemonCopyWithImpl<$Res, _$PokemonImpl>
    implements _$$PokemonImplCopyWith<$Res> {
  __$$PokemonImplCopyWithImpl(
    _$PokemonImpl _value,
    $Res Function(_$PokemonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? image = null,
    Object? generation = null,
    Object? effectEntries = null,
    Object? customOrder = freezed,
  }) {
    return _then(
      _$PokemonImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        image:
            null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String,
        generation:
            null == generation
                ? _value.generation
                : generation // ignore: cast_nullable_to_non_nullable
                    as String,
        effectEntries:
            null == effectEntries
                ? _value._effectEntries
                : effectEntries // ignore: cast_nullable_to_non_nullable
                    as List<EffectEntry>,
        customOrder:
            freezed == customOrder
                ? _value.customOrder
                : customOrder // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PokemonImpl implements _Pokemon {
  const _$PokemonImpl({
    required this.id,
    required this.name,
    required this.image,
    required this.generation,
    required final List<EffectEntry> effectEntries,
    this.customOrder,
  }) : _effectEntries = effectEntries;

  factory _$PokemonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String image;
  @override
  final String generation;
  final List<EffectEntry> _effectEntries;
  @override
  List<EffectEntry> get effectEntries {
    if (_effectEntries is EqualUnmodifiableListView) return _effectEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_effectEntries);
  }

  @override
  final String? customOrder;

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, image: $image, generation: $generation, effectEntries: $effectEntries, customOrder: $customOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.generation, generation) ||
                other.generation == generation) &&
            const DeepCollectionEquality().equals(
              other._effectEntries,
              _effectEntries,
            ) &&
            (identical(other.customOrder, customOrder) ||
                other.customOrder == customOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    image,
    generation,
    const DeepCollectionEquality().hash(_effectEntries),
    customOrder,
  );

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonImplCopyWith<_$PokemonImpl> get copyWith =>
      __$$PokemonImplCopyWithImpl<_$PokemonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PokemonImplToJson(this);
  }
}

abstract class _Pokemon implements Pokemon {
  const factory _Pokemon({
    required final String id,
    required final String name,
    required final String image,
    required final String generation,
    required final List<EffectEntry> effectEntries,
    final String? customOrder,
  }) = _$PokemonImpl;

  factory _Pokemon.fromJson(Map<String, dynamic> json) = _$PokemonImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get image;
  @override
  String get generation;
  @override
  List<EffectEntry> get effectEntries;
  @override
  String? get customOrder;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PokemonImplCopyWith<_$PokemonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EffectEntry _$EffectEntryFromJson(Map<String, dynamic> json) {
  return _EffectEntry.fromJson(json);
}

/// @nodoc
mixin _$EffectEntry {
  String get effect => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Serializes this EffectEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EffectEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EffectEntryCopyWith<EffectEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EffectEntryCopyWith<$Res> {
  factory $EffectEntryCopyWith(
    EffectEntry value,
    $Res Function(EffectEntry) then,
  ) = _$EffectEntryCopyWithImpl<$Res, EffectEntry>;
  @useResult
  $Res call({String effect, String language});
}

/// @nodoc
class _$EffectEntryCopyWithImpl<$Res, $Val extends EffectEntry>
    implements $EffectEntryCopyWith<$Res> {
  _$EffectEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EffectEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? effect = null, Object? language = null}) {
    return _then(
      _value.copyWith(
            effect:
                null == effect
                    ? _value.effect
                    : effect // ignore: cast_nullable_to_non_nullable
                        as String,
            language:
                null == language
                    ? _value.language
                    : language // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EffectEntryImplCopyWith<$Res>
    implements $EffectEntryCopyWith<$Res> {
  factory _$$EffectEntryImplCopyWith(
    _$EffectEntryImpl value,
    $Res Function(_$EffectEntryImpl) then,
  ) = __$$EffectEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String effect, String language});
}

/// @nodoc
class __$$EffectEntryImplCopyWithImpl<$Res>
    extends _$EffectEntryCopyWithImpl<$Res, _$EffectEntryImpl>
    implements _$$EffectEntryImplCopyWith<$Res> {
  __$$EffectEntryImplCopyWithImpl(
    _$EffectEntryImpl _value,
    $Res Function(_$EffectEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EffectEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? effect = null, Object? language = null}) {
    return _then(
      _$EffectEntryImpl(
        effect:
            null == effect
                ? _value.effect
                : effect // ignore: cast_nullable_to_non_nullable
                    as String,
        language:
            null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EffectEntryImpl implements _EffectEntry {
  const _$EffectEntryImpl({required this.effect, required this.language});

  factory _$EffectEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EffectEntryImplFromJson(json);

  @override
  final String effect;
  @override
  final String language;

  @override
  String toString() {
    return 'EffectEntry(effect: $effect, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EffectEntryImpl &&
            (identical(other.effect, effect) || other.effect == effect) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, effect, language);

  /// Create a copy of EffectEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EffectEntryImplCopyWith<_$EffectEntryImpl> get copyWith =>
      __$$EffectEntryImplCopyWithImpl<_$EffectEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EffectEntryImplToJson(this);
  }
}

abstract class _EffectEntry implements EffectEntry {
  const factory _EffectEntry({
    required final String effect,
    required final String language,
  }) = _$EffectEntryImpl;

  factory _EffectEntry.fromJson(Map<String, dynamic> json) =
      _$EffectEntryImpl.fromJson;

  @override
  String get effect;
  @override
  String get language;

  /// Create a copy of EffectEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EffectEntryImplCopyWith<_$EffectEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
