// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'standing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConstructorStanding {

 String get position; String get positionText; String get points; String get wins; ConstructorInfo get constructor;/// 与上一轮缓存相比的名次变化：正数为上升，负数为下降，0 为不变。
@JsonKey(includeFromJson: false, includeToJson: false) int get positionChange;
/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConstructorStandingCopyWith<ConstructorStanding> get copyWith => _$ConstructorStandingCopyWithImpl<ConstructorStanding>(this as ConstructorStanding, _$identity);

  /// Serializes this ConstructorStanding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConstructorStanding;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConstructorStanding&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.positionText, _this.positionText) || other.positionText == _this.positionText)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.wins, _this.wins) || other.wins == _this.wins)&&(identical(other.constructor, _this.constructor) || other.constructor == _this.constructor)&&(identical(other.positionChange, _this.positionChange) || other.positionChange == _this.positionChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConstructorStanding;
  return Object.hash(runtimeType,_this.position,_this.positionText,_this.points,_this.wins,_this.constructor,_this.positionChange);
}

@override
String toString() {
  final _this = this as ConstructorStanding;
  return 'ConstructorStanding(position: ${_this.position}, positionText: ${_this.positionText}, points: ${_this.points}, wins: ${_this.wins}, constructor: ${_this.constructor}, positionChange: ${_this.positionChange})';
}


}

/// @nodoc
abstract mixin class $ConstructorStandingCopyWith<$Res>  {
  factory $ConstructorStandingCopyWith(ConstructorStanding value, $Res Function(ConstructorStanding) _then) = _$ConstructorStandingCopyWithImpl;
@useResult
$Res call({
 String position, String positionText, String points, String wins, ConstructorInfo constructor,@JsonKey(includeFromJson: false, includeToJson: false) int positionChange
});


$ConstructorInfoCopyWith<$Res> get constructor;

}
/// @nodoc
class _$ConstructorStandingCopyWithImpl<$Res>
    implements $ConstructorStandingCopyWith<$Res> {
  _$ConstructorStandingCopyWithImpl(this._self, this._then);

  final ConstructorStanding _self;
  final $Res Function(ConstructorStanding) _then;

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? positionText = null,Object? points = null,Object? wins = null,Object? constructor = null,Object? positionChange = null,}) {
  return _then(ConstructorStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,positionText: null == positionText ? _self.positionText : positionText // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as String,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as String,constructor: null == constructor ? _self.constructor : constructor // ignore: cast_nullable_to_non_nullable
as ConstructorInfo,positionChange: null == positionChange ? _self.positionChange : positionChange // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConstructorInfoCopyWith<$Res> get constructor {
  
  return $ConstructorInfoCopyWith<$Res>(_self.constructor, (value) {
    return _then(_self.copyWith(constructor: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConstructorStanding].
extension ConstructorStandingPatterns on ConstructorStanding {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConstructorStanding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConstructorStanding value)  $default,){
final _that = this;
switch (_that) {
case _ConstructorStanding():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConstructorStanding value)?  $default,){
final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String position,  String positionText,  String points,  String wins,  ConstructorInfo constructor, @JsonKey(includeFromJson: false, includeToJson: false)  int positionChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
return $default(_that.position,_that.positionText,_that.points,_that.wins,_that.constructor,_that.positionChange);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String position,  String positionText,  String points,  String wins,  ConstructorInfo constructor, @JsonKey(includeFromJson: false, includeToJson: false)  int positionChange)  $default,) {final _that = this;
switch (_that) {
case _ConstructorStanding():
return $default(_that.position,_that.positionText,_that.points,_that.wins,_that.constructor,_that.positionChange);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String position,  String positionText,  String points,  String wins,  ConstructorInfo constructor, @JsonKey(includeFromJson: false, includeToJson: false)  int positionChange)?  $default,) {final _that = this;
switch (_that) {
case _ConstructorStanding() when $default != null:
return $default(_that.position,_that.positionText,_that.points,_that.wins,_that.constructor,_that.positionChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConstructorStanding extends ConstructorStanding {
  const _ConstructorStanding({required this.position, required this.positionText, required this.points, required this.wins, required this.constructor, @JsonKey(includeFromJson: false, includeToJson: false) this.positionChange = 0}): super._();
  factory _ConstructorStanding.fromJson(Map<String, dynamic> json) => _$ConstructorStandingFromJson(json);

@override final  String position;
@override final  String positionText;
@override final  String points;
@override final  String wins;
@override final  ConstructorInfo constructor;
/// 与上一轮缓存相比的名次变化：正数为上升，负数为下降，0 为不变。
@override@JsonKey(includeFromJson: false, includeToJson: false) final  int positionChange;

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConstructorStandingCopyWith<_ConstructorStanding> get copyWith => __$ConstructorStandingCopyWithImpl<_ConstructorStanding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConstructorStandingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConstructorStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.positionText, positionText) || other.positionText == positionText)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.constructor, constructor) || other.constructor == constructor)&&(identical(other.positionChange, positionChange) || other.positionChange == positionChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,position,positionText,points,wins,constructor,positionChange);
}

@override
String toString() {
    return 'ConstructorStanding(position: $position, positionText: $positionText, points: $points, wins: $wins, constructor: $constructor, positionChange: $positionChange)';
}


}

/// @nodoc
abstract mixin class _$ConstructorStandingCopyWith<$Res> implements $ConstructorStandingCopyWith<$Res> {
  factory _$ConstructorStandingCopyWith(_ConstructorStanding value, $Res Function(_ConstructorStanding) _then) = __$ConstructorStandingCopyWithImpl;
@override @useResult
$Res call({
 String position, String positionText, String points, String wins, ConstructorInfo constructor,@JsonKey(includeFromJson: false, includeToJson: false) int positionChange
});


@override $ConstructorInfoCopyWith<$Res> get constructor;

}
/// @nodoc
class __$ConstructorStandingCopyWithImpl<$Res>
    implements _$ConstructorStandingCopyWith<$Res> {
  __$ConstructorStandingCopyWithImpl(this._self, this._then);

  final _ConstructorStanding _self;
  final $Res Function(_ConstructorStanding) _then;

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? positionText = null,Object? points = null,Object? wins = null,Object? constructor = null,Object? positionChange = null,}) {
  return _then(_ConstructorStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,positionText: null == positionText ? _self.positionText : positionText // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as String,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as String,constructor: null == constructor ? _self.constructor : constructor // ignore: cast_nullable_to_non_nullable
as ConstructorInfo,positionChange: null == positionChange ? _self.positionChange : positionChange // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ConstructorStanding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConstructorInfoCopyWith<$Res> get constructor {
  
  return $ConstructorInfoCopyWith<$Res>(_self.constructor, (value) {
    return _then(_self.copyWith(constructor: value));
  });
}
}


/// @nodoc
mixin _$ConstructorInfo {

 String get constructorId; String get name; String get nationality;
/// Create a copy of ConstructorInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConstructorInfoCopyWith<ConstructorInfo> get copyWith => _$ConstructorInfoCopyWithImpl<ConstructorInfo>(this as ConstructorInfo, _$identity);

  /// Serializes this ConstructorInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConstructorInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConstructorInfo&&(identical(other.constructorId, _this.constructorId) || other.constructorId == _this.constructorId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.nationality, _this.nationality) || other.nationality == _this.nationality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConstructorInfo;
  return Object.hash(runtimeType,_this.constructorId,_this.name,_this.nationality);
}

@override
String toString() {
  final _this = this as ConstructorInfo;
  return 'ConstructorInfo(constructorId: ${_this.constructorId}, name: ${_this.name}, nationality: ${_this.nationality})';
}


}

/// @nodoc
abstract mixin class $ConstructorInfoCopyWith<$Res>  {
  factory $ConstructorInfoCopyWith(ConstructorInfo value, $Res Function(ConstructorInfo) _then) = _$ConstructorInfoCopyWithImpl;
@useResult
$Res call({
 String constructorId, String name, String nationality
});




}
/// @nodoc
class _$ConstructorInfoCopyWithImpl<$Res>
    implements $ConstructorInfoCopyWith<$Res> {
  _$ConstructorInfoCopyWithImpl(this._self, this._then);

  final ConstructorInfo _self;
  final $Res Function(ConstructorInfo) _then;

/// Create a copy of ConstructorInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? constructorId = null,Object? name = null,Object? nationality = null,}) {
  return _then(ConstructorInfo(
constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConstructorInfo].
extension ConstructorInfoPatterns on ConstructorInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConstructorInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConstructorInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConstructorInfo value)  $default,){
final _that = this;
switch (_that) {
case _ConstructorInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConstructorInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ConstructorInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String constructorId,  String name,  String nationality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConstructorInfo() when $default != null:
return $default(_that.constructorId,_that.name,_that.nationality);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String constructorId,  String name,  String nationality)  $default,) {final _that = this;
switch (_that) {
case _ConstructorInfo():
return $default(_that.constructorId,_that.name,_that.nationality);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String constructorId,  String name,  String nationality)?  $default,) {final _that = this;
switch (_that) {
case _ConstructorInfo() when $default != null:
return $default(_that.constructorId,_that.name,_that.nationality);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConstructorInfo implements ConstructorInfo {
  const _ConstructorInfo({required this.constructorId, required this.name, required this.nationality});
  factory _ConstructorInfo.fromJson(Map<String, dynamic> json) => _$ConstructorInfoFromJson(json);

@override final  String constructorId;
@override final  String name;
@override final  String nationality;

/// Create a copy of ConstructorInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConstructorInfoCopyWith<_ConstructorInfo> get copyWith => __$ConstructorInfoCopyWithImpl<_ConstructorInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConstructorInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConstructorInfo&&(identical(other.constructorId, constructorId) || other.constructorId == constructorId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nationality, nationality) || other.nationality == nationality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,constructorId,name,nationality);
}

@override
String toString() {
    return 'ConstructorInfo(constructorId: $constructorId, name: $name, nationality: $nationality)';
}


}

/// @nodoc
abstract mixin class _$ConstructorInfoCopyWith<$Res> implements $ConstructorInfoCopyWith<$Res> {
  factory _$ConstructorInfoCopyWith(_ConstructorInfo value, $Res Function(_ConstructorInfo) _then) = __$ConstructorInfoCopyWithImpl;
@override @useResult
$Res call({
 String constructorId, String name, String nationality
});




}
/// @nodoc
class __$ConstructorInfoCopyWithImpl<$Res>
    implements _$ConstructorInfoCopyWith<$Res> {
  __$ConstructorInfoCopyWithImpl(this._self, this._then);

  final _ConstructorInfo _self;
  final $Res Function(_ConstructorInfo) _then;

/// Create a copy of ConstructorInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? constructorId = null,Object? name = null,Object? nationality = null,}) {
  return _then(_ConstructorInfo(
constructorId: null == constructorId ? _self.constructorId : constructorId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
