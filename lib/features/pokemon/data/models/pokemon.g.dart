// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      generation: json['generation'] as String,
      effectEntries:
          (json['effectEntries'] as List<dynamic>)
              .map((e) => EffectEntry.fromJson(e as Map<String, dynamic>))
              .toList(),
      customOrder: json['customOrder'] as String?,
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'generation': instance.generation,
      'effectEntries': instance.effectEntries,
      'customOrder': instance.customOrder,
    };

_$EffectEntryImpl _$$EffectEntryImplFromJson(Map<String, dynamic> json) =>
    _$EffectEntryImpl(
      effect: json['effect'] as String,
      language: json['language'] as String,
    );

Map<String, dynamic> _$$EffectEntryImplToJson(_$EffectEntryImpl instance) =>
    <String, dynamic>{'effect': instance.effect, 'language': instance.language};
