import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required String id,
    required String name,
    required String image,
    required String generation,
    required List<EffectEntry> effectEntries,
    String? customOrder,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}

@freezed
class EffectEntry with _$EffectEntry {
  const factory EffectEntry({
    required String effect,
    required String language,
  }) = _EffectEntry;

  factory EffectEntry.fromJson(Map<String, dynamic> json) => _$EffectEntryFromJson(json);
}

Map<String, dynamic> effectEntryToJson(EffectEntry entry) {
  return {
    'effect': entry.effect,
    'language': entry.language,
  };
}

EffectEntry effectEntryFromJson(Map<String, dynamic> json) {
  return EffectEntry(
    effect: json['effect'] as String? ?? '',
    language: json['language'] as String? ?? '',
  );
} 