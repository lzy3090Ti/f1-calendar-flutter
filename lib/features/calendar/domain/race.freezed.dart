// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Race {

 String get season; String get round; String get raceName; Circuit get circuit; String get date; String? get time;@JsonKey(name: 'FirstPractice') RaceSession? get firstPractice;@JsonKey(name: 'SecondPractice') RaceSession? get secondPractice;@JsonKey(name: 'ThirdPractice') RaceSession? get thirdPractice;@JsonKey(name: 'Qualifying') RaceSession? get qualifying;@JsonKey(name: 'Sprint') RaceSession? get sprint;@JsonKey(name: 'SprintQualifying') RaceSession? get sprintQualifying;
/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RaceCopyWith<Race> get copyWith => _$RaceCopyWithImpl<Race>(this as Race, _$identity);

  /// Serializes this Race to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Race;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Race&&(identical(other.season, _this.season) || other.season == _this.season)&&(identical(other.round, _this.round) || other.round == _this.round)&&(identical(other.raceName, _this.raceName) || other.raceName == _this.raceName)&&(identical(other.circuit, _this.circuit) || other.circuit == _this.circuit)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.firstPractice, _this.firstPractice) || other.firstPractice == _this.firstPractice)&&(identical(other.secondPractice, _this.secondPractice) || other.secondPractice == _this.secondPractice)&&(identical(other.thirdPractice, _this.thirdPractice) || other.thirdPractice == _this.thirdPractice)&&(identical(other.qualifying, _this.qualifying) || other.qualifying == _this.qualifying)&&(identical(other.sprint, _this.sprint) || other.sprint == _this.sprint)&&(identical(other.sprintQualifying, _this.sprintQualifying) || other.sprintQualifying == _this.sprintQualifying));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Race;
  return Object.hash(runtimeType,_this.season,_this.round,_this.raceName,_this.circuit,_this.date,_this.time,_this.firstPractice,_this.secondPractice,_this.thirdPractice,_this.qualifying,_this.sprint,_this.sprintQualifying);
}

@override
String toString() {
  final _this = this as Race;
  return 'Race(season: ${_this.season}, round: ${_this.round}, raceName: ${_this.raceName}, circuit: ${_this.circuit}, date: ${_this.date}, time: ${_this.time}, firstPractice: ${_this.firstPractice}, secondPractice: ${_this.secondPractice}, thirdPractice: ${_this.thirdPractice}, qualifying: ${_this.qualifying}, sprint: ${_this.sprint}, sprintQualifying: ${_this.sprintQualifying})';
}


}

/// @nodoc
abstract mixin class $RaceCopyWith<$Res>  {
  factory $RaceCopyWith(Race value, $Res Function(Race) _then) = _$RaceCopyWithImpl;
@useResult
$Res call({
 String season, String round, String raceName, Circuit circuit, String date, String? time,@JsonKey(name: 'FirstPractice') RaceSession? firstPractice,@JsonKey(name: 'SecondPractice') RaceSession? secondPractice,@JsonKey(name: 'ThirdPractice') RaceSession? thirdPractice,@JsonKey(name: 'Qualifying') RaceSession? qualifying,@JsonKey(name: 'Sprint') RaceSession? sprint,@JsonKey(name: 'SprintQualifying') RaceSession? sprintQualifying
});


$CircuitCopyWith<$Res> get circuit;$RaceSessionCopyWith<$Res>? get firstPractice;$RaceSessionCopyWith<$Res>? get secondPractice;$RaceSessionCopyWith<$Res>? get thirdPractice;$RaceSessionCopyWith<$Res>? get qualifying;$RaceSessionCopyWith<$Res>? get sprint;$RaceSessionCopyWith<$Res>? get sprintQualifying;

}
/// @nodoc
class _$RaceCopyWithImpl<$Res>
    implements $RaceCopyWith<$Res> {
  _$RaceCopyWithImpl(this._self, this._then);

  final Race _self;
  final $Res Function(Race) _then;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? season = null,Object? round = null,Object? raceName = null,Object? circuit = null,Object? date = null,Object? time = freezed,Object? firstPractice = freezed,Object? secondPractice = freezed,Object? thirdPractice = freezed,Object? qualifying = freezed,Object? sprint = freezed,Object? sprintQualifying = freezed,}) {
  return _then(Race(
season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as String,raceName: null == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String,circuit: null == circuit ? _self.circuit : circuit // ignore: cast_nullable_to_non_nullable
as Circuit,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,firstPractice: freezed == firstPractice ? _self.firstPractice : firstPractice // ignore: cast_nullable_to_non_nullable
as RaceSession?,secondPractice: freezed == secondPractice ? _self.secondPractice : secondPractice // ignore: cast_nullable_to_non_nullable
as RaceSession?,thirdPractice: freezed == thirdPractice ? _self.thirdPractice : thirdPractice // ignore: cast_nullable_to_non_nullable
as RaceSession?,qualifying: freezed == qualifying ? _self.qualifying : qualifying // ignore: cast_nullable_to_non_nullable
as RaceSession?,sprint: freezed == sprint ? _self.sprint : sprint // ignore: cast_nullable_to_non_nullable
as RaceSession?,sprintQualifying: freezed == sprintQualifying ? _self.sprintQualifying : sprintQualifying // ignore: cast_nullable_to_non_nullable
as RaceSession?,
  ));
}
/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircuitCopyWith<$Res> get circuit {
  
  return $CircuitCopyWith<$Res>(_self.circuit, (value) {
    return _then(_self.copyWith(circuit: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get firstPractice {
    if (_self.firstPractice == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.firstPractice!, (value) {
    return _then(_self.copyWith(firstPractice: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get secondPractice {
    if (_self.secondPractice == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.secondPractice!, (value) {
    return _then(_self.copyWith(secondPractice: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get thirdPractice {
    if (_self.thirdPractice == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.thirdPractice!, (value) {
    return _then(_self.copyWith(thirdPractice: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get qualifying {
    if (_self.qualifying == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.qualifying!, (value) {
    return _then(_self.copyWith(qualifying: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get sprint {
    if (_self.sprint == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.sprint!, (value) {
    return _then(_self.copyWith(sprint: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get sprintQualifying {
    if (_self.sprintQualifying == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.sprintQualifying!, (value) {
    return _then(_self.copyWith(sprintQualifying: value));
  });
}
}


/// Adds pattern-matching-related methods to [Race].
extension RacePatterns on Race {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Race value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Race() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Race value)  $default,){
final _that = this;
switch (_that) {
case _Race():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Race value)?  $default,){
final _that = this;
switch (_that) {
case _Race() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String season,  String round,  String raceName,  Circuit circuit,  String date,  String? time, @JsonKey(name: 'FirstPractice')  RaceSession? firstPractice, @JsonKey(name: 'SecondPractice')  RaceSession? secondPractice, @JsonKey(name: 'ThirdPractice')  RaceSession? thirdPractice, @JsonKey(name: 'Qualifying')  RaceSession? qualifying, @JsonKey(name: 'Sprint')  RaceSession? sprint, @JsonKey(name: 'SprintQualifying')  RaceSession? sprintQualifying)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Race() when $default != null:
return $default(_that.season,_that.round,_that.raceName,_that.circuit,_that.date,_that.time,_that.firstPractice,_that.secondPractice,_that.thirdPractice,_that.qualifying,_that.sprint,_that.sprintQualifying);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String season,  String round,  String raceName,  Circuit circuit,  String date,  String? time, @JsonKey(name: 'FirstPractice')  RaceSession? firstPractice, @JsonKey(name: 'SecondPractice')  RaceSession? secondPractice, @JsonKey(name: 'ThirdPractice')  RaceSession? thirdPractice, @JsonKey(name: 'Qualifying')  RaceSession? qualifying, @JsonKey(name: 'Sprint')  RaceSession? sprint, @JsonKey(name: 'SprintQualifying')  RaceSession? sprintQualifying)  $default,) {final _that = this;
switch (_that) {
case _Race():
return $default(_that.season,_that.round,_that.raceName,_that.circuit,_that.date,_that.time,_that.firstPractice,_that.secondPractice,_that.thirdPractice,_that.qualifying,_that.sprint,_that.sprintQualifying);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String season,  String round,  String raceName,  Circuit circuit,  String date,  String? time, @JsonKey(name: 'FirstPractice')  RaceSession? firstPractice, @JsonKey(name: 'SecondPractice')  RaceSession? secondPractice, @JsonKey(name: 'ThirdPractice')  RaceSession? thirdPractice, @JsonKey(name: 'Qualifying')  RaceSession? qualifying, @JsonKey(name: 'Sprint')  RaceSession? sprint, @JsonKey(name: 'SprintQualifying')  RaceSession? sprintQualifying)?  $default,) {final _that = this;
switch (_that) {
case _Race() when $default != null:
return $default(_that.season,_that.round,_that.raceName,_that.circuit,_that.date,_that.time,_that.firstPractice,_that.secondPractice,_that.thirdPractice,_that.qualifying,_that.sprint,_that.sprintQualifying);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Race extends Race {
  const _Race({required this.season, required this.round, required this.raceName, required this.circuit, required this.date, this.time, @JsonKey(name: 'FirstPractice') this.firstPractice, @JsonKey(name: 'SecondPractice') this.secondPractice, @JsonKey(name: 'ThirdPractice') this.thirdPractice, @JsonKey(name: 'Qualifying') this.qualifying, @JsonKey(name: 'Sprint') this.sprint, @JsonKey(name: 'SprintQualifying') this.sprintQualifying}): super._();
  factory _Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);

@override final  String season;
@override final  String round;
@override final  String raceName;
@override final  Circuit circuit;
@override final  String date;
@override final  String? time;
@override@JsonKey(name: 'FirstPractice') final  RaceSession? firstPractice;
@override@JsonKey(name: 'SecondPractice') final  RaceSession? secondPractice;
@override@JsonKey(name: 'ThirdPractice') final  RaceSession? thirdPractice;
@override@JsonKey(name: 'Qualifying') final  RaceSession? qualifying;
@override@JsonKey(name: 'Sprint') final  RaceSession? sprint;
@override@JsonKey(name: 'SprintQualifying') final  RaceSession? sprintQualifying;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RaceCopyWith<_Race> get copyWith => __$RaceCopyWithImpl<_Race>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Race&&(identical(other.season, season) || other.season == season)&&(identical(other.round, round) || other.round == round)&&(identical(other.raceName, raceName) || other.raceName == raceName)&&(identical(other.circuit, circuit) || other.circuit == circuit)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.firstPractice, firstPractice) || other.firstPractice == firstPractice)&&(identical(other.secondPractice, secondPractice) || other.secondPractice == secondPractice)&&(identical(other.thirdPractice, thirdPractice) || other.thirdPractice == thirdPractice)&&(identical(other.qualifying, qualifying) || other.qualifying == qualifying)&&(identical(other.sprint, sprint) || other.sprint == sprint)&&(identical(other.sprintQualifying, sprintQualifying) || other.sprintQualifying == sprintQualifying));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,season,round,raceName,circuit,date,time,firstPractice,secondPractice,thirdPractice,qualifying,sprint,sprintQualifying);
}

@override
String toString() {
    return 'Race(season: $season, round: $round, raceName: $raceName, circuit: $circuit, date: $date, time: $time, firstPractice: $firstPractice, secondPractice: $secondPractice, thirdPractice: $thirdPractice, qualifying: $qualifying, sprint: $sprint, sprintQualifying: $sprintQualifying)';
}


}

/// @nodoc
abstract mixin class _$RaceCopyWith<$Res> implements $RaceCopyWith<$Res> {
  factory _$RaceCopyWith(_Race value, $Res Function(_Race) _then) = __$RaceCopyWithImpl;
@override @useResult
$Res call({
 String season, String round, String raceName, Circuit circuit, String date, String? time,@JsonKey(name: 'FirstPractice') RaceSession? firstPractice,@JsonKey(name: 'SecondPractice') RaceSession? secondPractice,@JsonKey(name: 'ThirdPractice') RaceSession? thirdPractice,@JsonKey(name: 'Qualifying') RaceSession? qualifying,@JsonKey(name: 'Sprint') RaceSession? sprint,@JsonKey(name: 'SprintQualifying') RaceSession? sprintQualifying
});


@override $CircuitCopyWith<$Res> get circuit;@override $RaceSessionCopyWith<$Res>? get firstPractice;@override $RaceSessionCopyWith<$Res>? get secondPractice;@override $RaceSessionCopyWith<$Res>? get thirdPractice;@override $RaceSessionCopyWith<$Res>? get qualifying;@override $RaceSessionCopyWith<$Res>? get sprint;@override $RaceSessionCopyWith<$Res>? get sprintQualifying;

}
/// @nodoc
class __$RaceCopyWithImpl<$Res>
    implements _$RaceCopyWith<$Res> {
  __$RaceCopyWithImpl(this._self, this._then);

  final _Race _self;
  final $Res Function(_Race) _then;

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? season = null,Object? round = null,Object? raceName = null,Object? circuit = null,Object? date = null,Object? time = freezed,Object? firstPractice = freezed,Object? secondPractice = freezed,Object? thirdPractice = freezed,Object? qualifying = freezed,Object? sprint = freezed,Object? sprintQualifying = freezed,}) {
  return _then(_Race(
season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as String,raceName: null == raceName ? _self.raceName : raceName // ignore: cast_nullable_to_non_nullable
as String,circuit: null == circuit ? _self.circuit : circuit // ignore: cast_nullable_to_non_nullable
as Circuit,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,firstPractice: freezed == firstPractice ? _self.firstPractice : firstPractice // ignore: cast_nullable_to_non_nullable
as RaceSession?,secondPractice: freezed == secondPractice ? _self.secondPractice : secondPractice // ignore: cast_nullable_to_non_nullable
as RaceSession?,thirdPractice: freezed == thirdPractice ? _self.thirdPractice : thirdPractice // ignore: cast_nullable_to_non_nullable
as RaceSession?,qualifying: freezed == qualifying ? _self.qualifying : qualifying // ignore: cast_nullable_to_non_nullable
as RaceSession?,sprint: freezed == sprint ? _self.sprint : sprint // ignore: cast_nullable_to_non_nullable
as RaceSession?,sprintQualifying: freezed == sprintQualifying ? _self.sprintQualifying : sprintQualifying // ignore: cast_nullable_to_non_nullable
as RaceSession?,
  ));
}

/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircuitCopyWith<$Res> get circuit {
  
  return $CircuitCopyWith<$Res>(_self.circuit, (value) {
    return _then(_self.copyWith(circuit: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get firstPractice {
    if (_self.firstPractice == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.firstPractice!, (value) {
    return _then(_self.copyWith(firstPractice: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get secondPractice {
    if (_self.secondPractice == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.secondPractice!, (value) {
    return _then(_self.copyWith(secondPractice: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get thirdPractice {
    if (_self.thirdPractice == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.thirdPractice!, (value) {
    return _then(_self.copyWith(thirdPractice: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get qualifying {
    if (_self.qualifying == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.qualifying!, (value) {
    return _then(_self.copyWith(qualifying: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get sprint {
    if (_self.sprint == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.sprint!, (value) {
    return _then(_self.copyWith(sprint: value));
  });
}/// Create a copy of Race
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<$Res>? get sprintQualifying {
    if (_self.sprintQualifying == null) {
    return null;
  }

  return $RaceSessionCopyWith<$Res>(_self.sprintQualifying!, (value) {
    return _then(_self.copyWith(sprintQualifying: value));
  });
}
}


/// @nodoc
mixin _$RaceSession {

 String get date; String? get time;
/// Create a copy of RaceSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RaceSessionCopyWith<RaceSession> get copyWith => _$RaceSessionCopyWithImpl<RaceSession>(this as RaceSession, _$identity);

  /// Serializes this RaceSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RaceSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RaceSession&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.time, _this.time) || other.time == _this.time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RaceSession;
  return Object.hash(runtimeType,_this.date,_this.time);
}

@override
String toString() {
  final _this = this as RaceSession;
  return 'RaceSession(date: ${_this.date}, time: ${_this.time})';
}


}

/// @nodoc
abstract mixin class $RaceSessionCopyWith<$Res>  {
  factory $RaceSessionCopyWith(RaceSession value, $Res Function(RaceSession) _then) = _$RaceSessionCopyWithImpl;
@useResult
$Res call({
 String date, String? time
});




}
/// @nodoc
class _$RaceSessionCopyWithImpl<$Res>
    implements $RaceSessionCopyWith<$Res> {
  _$RaceSessionCopyWithImpl(this._self, this._then);

  final RaceSession _self;
  final $Res Function(RaceSession) _then;

/// Create a copy of RaceSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? time = freezed,}) {
  return _then(RaceSession(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RaceSession].
extension RaceSessionPatterns on RaceSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RaceSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RaceSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RaceSession value)  $default,){
final _that = this;
switch (_that) {
case _RaceSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RaceSession value)?  $default,){
final _that = this;
switch (_that) {
case _RaceSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String? time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RaceSession() when $default != null:
return $default(_that.date,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String? time)  $default,) {final _that = this;
switch (_that) {
case _RaceSession():
return $default(_that.date,_that.time);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String? time)?  $default,) {final _that = this;
switch (_that) {
case _RaceSession() when $default != null:
return $default(_that.date,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RaceSession implements RaceSession {
  const _RaceSession({required this.date, this.time});
  factory _RaceSession.fromJson(Map<String, dynamic> json) => _$RaceSessionFromJson(json);

@override final  String date;
@override final  String? time;

/// Create a copy of RaceSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RaceSessionCopyWith<_RaceSession> get copyWith => __$RaceSessionCopyWithImpl<_RaceSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RaceSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RaceSession&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,time);
}

@override
String toString() {
    return 'RaceSession(date: $date, time: $time)';
}


}

/// @nodoc
abstract mixin class _$RaceSessionCopyWith<$Res> implements $RaceSessionCopyWith<$Res> {
  factory _$RaceSessionCopyWith(_RaceSession value, $Res Function(_RaceSession) _then) = __$RaceSessionCopyWithImpl;
@override @useResult
$Res call({
 String date, String? time
});




}
/// @nodoc
class __$RaceSessionCopyWithImpl<$Res>
    implements _$RaceSessionCopyWith<$Res> {
  __$RaceSessionCopyWithImpl(this._self, this._then);

  final _RaceSession _self;
  final $Res Function(_RaceSession) _then;

/// Create a copy of RaceSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? time = freezed,}) {
  return _then(_RaceSession(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Circuit {

 String get circuitId; String get circuitName; CircuitLocation get location;
/// Create a copy of Circuit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircuitCopyWith<Circuit> get copyWith => _$CircuitCopyWithImpl<Circuit>(this as Circuit, _$identity);

  /// Serializes this Circuit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Circuit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Circuit&&(identical(other.circuitId, _this.circuitId) || other.circuitId == _this.circuitId)&&(identical(other.circuitName, _this.circuitName) || other.circuitName == _this.circuitName)&&(identical(other.location, _this.location) || other.location == _this.location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Circuit;
  return Object.hash(runtimeType,_this.circuitId,_this.circuitName,_this.location);
}

@override
String toString() {
  final _this = this as Circuit;
  return 'Circuit(circuitId: ${_this.circuitId}, circuitName: ${_this.circuitName}, location: ${_this.location})';
}


}

/// @nodoc
abstract mixin class $CircuitCopyWith<$Res>  {
  factory $CircuitCopyWith(Circuit value, $Res Function(Circuit) _then) = _$CircuitCopyWithImpl;
@useResult
$Res call({
 String circuitId, String circuitName, CircuitLocation location
});


$CircuitLocationCopyWith<$Res> get location;

}
/// @nodoc
class _$CircuitCopyWithImpl<$Res>
    implements $CircuitCopyWith<$Res> {
  _$CircuitCopyWithImpl(this._self, this._then);

  final Circuit _self;
  final $Res Function(Circuit) _then;

/// Create a copy of Circuit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? circuitId = null,Object? circuitName = null,Object? location = null,}) {
  return _then(Circuit(
circuitId: null == circuitId ? _self.circuitId : circuitId // ignore: cast_nullable_to_non_nullable
as String,circuitName: null == circuitName ? _self.circuitName : circuitName // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CircuitLocation,
  ));
}
/// Create a copy of Circuit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircuitLocationCopyWith<$Res> get location {
  
  return $CircuitLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [Circuit].
extension CircuitPatterns on Circuit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Circuit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Circuit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Circuit value)  $default,){
final _that = this;
switch (_that) {
case _Circuit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Circuit value)?  $default,){
final _that = this;
switch (_that) {
case _Circuit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String circuitId,  String circuitName,  CircuitLocation location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Circuit() when $default != null:
return $default(_that.circuitId,_that.circuitName,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String circuitId,  String circuitName,  CircuitLocation location)  $default,) {final _that = this;
switch (_that) {
case _Circuit():
return $default(_that.circuitId,_that.circuitName,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String circuitId,  String circuitName,  CircuitLocation location)?  $default,) {final _that = this;
switch (_that) {
case _Circuit() when $default != null:
return $default(_that.circuitId,_that.circuitName,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Circuit extends Circuit {
  const _Circuit({required this.circuitId, required this.circuitName, required this.location}): super._();
  factory _Circuit.fromJson(Map<String, dynamic> json) => _$CircuitFromJson(json);

@override final  String circuitId;
@override final  String circuitName;
@override final  CircuitLocation location;

/// Create a copy of Circuit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircuitCopyWith<_Circuit> get copyWith => __$CircuitCopyWithImpl<_Circuit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircuitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Circuit&&(identical(other.circuitId, circuitId) || other.circuitId == circuitId)&&(identical(other.circuitName, circuitName) || other.circuitName == circuitName)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,circuitId,circuitName,location);
}

@override
String toString() {
    return 'Circuit(circuitId: $circuitId, circuitName: $circuitName, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CircuitCopyWith<$Res> implements $CircuitCopyWith<$Res> {
  factory _$CircuitCopyWith(_Circuit value, $Res Function(_Circuit) _then) = __$CircuitCopyWithImpl;
@override @useResult
$Res call({
 String circuitId, String circuitName, CircuitLocation location
});


@override $CircuitLocationCopyWith<$Res> get location;

}
/// @nodoc
class __$CircuitCopyWithImpl<$Res>
    implements _$CircuitCopyWith<$Res> {
  __$CircuitCopyWithImpl(this._self, this._then);

  final _Circuit _self;
  final $Res Function(_Circuit) _then;

/// Create a copy of Circuit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? circuitId = null,Object? circuitName = null,Object? location = null,}) {
  return _then(_Circuit(
circuitId: null == circuitId ? _self.circuitId : circuitId // ignore: cast_nullable_to_non_nullable
as String,circuitName: null == circuitName ? _self.circuitName : circuitName // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CircuitLocation,
  ));
}

/// Create a copy of Circuit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircuitLocationCopyWith<$Res> get location {
  
  return $CircuitLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$CircuitLocation {

 String get lat; String get long; String get locality; String get country;
/// Create a copy of CircuitLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircuitLocationCopyWith<CircuitLocation> get copyWith => _$CircuitLocationCopyWithImpl<CircuitLocation>(this as CircuitLocation, _$identity);

  /// Serializes this CircuitLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CircuitLocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircuitLocation&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.long, _this.long) || other.long == _this.long)&&(identical(other.locality, _this.locality) || other.locality == _this.locality)&&(identical(other.country, _this.country) || other.country == _this.country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CircuitLocation;
  return Object.hash(runtimeType,_this.lat,_this.long,_this.locality,_this.country);
}

@override
String toString() {
  final _this = this as CircuitLocation;
  return 'CircuitLocation(lat: ${_this.lat}, long: ${_this.long}, locality: ${_this.locality}, country: ${_this.country})';
}


}

/// @nodoc
abstract mixin class $CircuitLocationCopyWith<$Res>  {
  factory $CircuitLocationCopyWith(CircuitLocation value, $Res Function(CircuitLocation) _then) = _$CircuitLocationCopyWithImpl;
@useResult
$Res call({
 String lat, String long, String locality, String country
});




}
/// @nodoc
class _$CircuitLocationCopyWithImpl<$Res>
    implements $CircuitLocationCopyWith<$Res> {
  _$CircuitLocationCopyWithImpl(this._self, this._then);

  final CircuitLocation _self;
  final $Res Function(CircuitLocation) _then;

/// Create a copy of CircuitLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? long = null,Object? locality = null,Object? country = null,}) {
  return _then(CircuitLocation(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as String,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as String,locality: null == locality ? _self.locality : locality // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CircuitLocation].
extension CircuitLocationPatterns on CircuitLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircuitLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircuitLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircuitLocation value)  $default,){
final _that = this;
switch (_that) {
case _CircuitLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircuitLocation value)?  $default,){
final _that = this;
switch (_that) {
case _CircuitLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String lat,  String long,  String locality,  String country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircuitLocation() when $default != null:
return $default(_that.lat,_that.long,_that.locality,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String lat,  String long,  String locality,  String country)  $default,) {final _that = this;
switch (_that) {
case _CircuitLocation():
return $default(_that.lat,_that.long,_that.locality,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String lat,  String long,  String locality,  String country)?  $default,) {final _that = this;
switch (_that) {
case _CircuitLocation() when $default != null:
return $default(_that.lat,_that.long,_that.locality,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CircuitLocation implements CircuitLocation {
  const _CircuitLocation({required this.lat, required this.long, required this.locality, required this.country});
  factory _CircuitLocation.fromJson(Map<String, dynamic> json) => _$CircuitLocationFromJson(json);

@override final  String lat;
@override final  String long;
@override final  String locality;
@override final  String country;

/// Create a copy of CircuitLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircuitLocationCopyWith<_CircuitLocation> get copyWith => __$CircuitLocationCopyWithImpl<_CircuitLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircuitLocationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircuitLocation&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.long, long) || other.long == long)&&(identical(other.locality, locality) || other.locality == locality)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,lat,long,locality,country);
}

@override
String toString() {
    return 'CircuitLocation(lat: $lat, long: $long, locality: $locality, country: $country)';
}


}

/// @nodoc
abstract mixin class _$CircuitLocationCopyWith<$Res> implements $CircuitLocationCopyWith<$Res> {
  factory _$CircuitLocationCopyWith(_CircuitLocation value, $Res Function(_CircuitLocation) _then) = __$CircuitLocationCopyWithImpl;
@override @useResult
$Res call({
 String lat, String long, String locality, String country
});




}
/// @nodoc
class __$CircuitLocationCopyWithImpl<$Res>
    implements _$CircuitLocationCopyWith<$Res> {
  __$CircuitLocationCopyWithImpl(this._self, this._then);

  final _CircuitLocation _self;
  final $Res Function(_CircuitLocation) _then;

/// Create a copy of CircuitLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? long = null,Object? locality = null,Object? country = null,}) {
  return _then(_CircuitLocation(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as String,long: null == long ? _self.long : long // ignore: cast_nullable_to_non_nullable
as String,locality: null == locality ? _self.locality : locality // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
