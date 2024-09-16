// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiaryState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Diary> get userDiaries => throw _privateConstructorUsedError;
  List<Diary> get allDiaries => throw _privateConstructorUsedError;
  List<Diary> get followedUserDiaries => throw _privateConstructorUsedError;
  List<DiaryWithUser> get allDiariesWithUser =>
      throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  User? get currentUser => throw _privateConstructorUsedError;
  bool get isSaved => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  bool get showName => throw _privateConstructorUsedError;
  bool get showRegion => throw _privateConstructorUsedError;
  List<XFile> get imageFiles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiaryStateCopyWith<DiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryStateCopyWith<$Res> {
  factory $DiaryStateCopyWith(
          DiaryState value, $Res Function(DiaryState) then) =
      _$DiaryStateCopyWithImpl<$Res, DiaryState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<Diary> userDiaries,
      List<Diary> allDiaries,
      List<Diary> followedUserDiaries,
      List<DiaryWithUser> allDiariesWithUser,
      String? errorMessage,
      User? currentUser,
      bool isSaved,
      bool isPublic,
      bool showName,
      bool showRegion,
      List<XFile> imageFiles});

  $UserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$DiaryStateCopyWithImpl<$Res, $Val extends DiaryState>
    implements $DiaryStateCopyWith<$Res> {
  _$DiaryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? userDiaries = null,
    Object? allDiaries = null,
    Object? followedUserDiaries = null,
    Object? allDiariesWithUser = null,
    Object? errorMessage = freezed,
    Object? currentUser = freezed,
    Object? isSaved = null,
    Object? isPublic = null,
    Object? showName = null,
    Object? showRegion = null,
    Object? imageFiles = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      userDiaries: null == userDiaries
          ? _value.userDiaries
          : userDiaries // ignore: cast_nullable_to_non_nullable
              as List<Diary>,
      allDiaries: null == allDiaries
          ? _value.allDiaries
          : allDiaries // ignore: cast_nullable_to_non_nullable
              as List<Diary>,
      followedUserDiaries: null == followedUserDiaries
          ? _value.followedUserDiaries
          : followedUserDiaries // ignore: cast_nullable_to_non_nullable
              as List<Diary>,
      allDiariesWithUser: null == allDiariesWithUser
          ? _value.allDiariesWithUser
          : allDiariesWithUser // ignore: cast_nullable_to_non_nullable
              as List<DiaryWithUser>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      showName: null == showName
          ? _value.showName
          : showName // ignore: cast_nullable_to_non_nullable
              as bool,
      showRegion: null == showRegion
          ? _value.showRegion
          : showRegion // ignore: cast_nullable_to_non_nullable
              as bool,
      imageFiles: null == imageFiles
          ? _value.imageFiles
          : imageFiles // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiaryStateImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryStateImplCopyWith(
          _$DiaryStateImpl value, $Res Function(_$DiaryStateImpl) then) =
      __$$DiaryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<Diary> userDiaries,
      List<Diary> allDiaries,
      List<Diary> followedUserDiaries,
      List<DiaryWithUser> allDiariesWithUser,
      String? errorMessage,
      User? currentUser,
      bool isSaved,
      bool isPublic,
      bool showName,
      bool showRegion,
      List<XFile> imageFiles});

  @override
  $UserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$DiaryStateImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryStateImpl>
    implements _$$DiaryStateImplCopyWith<$Res> {
  __$$DiaryStateImplCopyWithImpl(
      _$DiaryStateImpl _value, $Res Function(_$DiaryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? userDiaries = null,
    Object? allDiaries = null,
    Object? followedUserDiaries = null,
    Object? allDiariesWithUser = null,
    Object? errorMessage = freezed,
    Object? currentUser = freezed,
    Object? isSaved = null,
    Object? isPublic = null,
    Object? showName = null,
    Object? showRegion = null,
    Object? imageFiles = null,
  }) {
    return _then(_$DiaryStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      userDiaries: null == userDiaries
          ? _value._userDiaries
          : userDiaries // ignore: cast_nullable_to_non_nullable
              as List<Diary>,
      allDiaries: null == allDiaries
          ? _value._allDiaries
          : allDiaries // ignore: cast_nullable_to_non_nullable
              as List<Diary>,
      followedUserDiaries: null == followedUserDiaries
          ? _value._followedUserDiaries
          : followedUserDiaries // ignore: cast_nullable_to_non_nullable
              as List<Diary>,
      allDiariesWithUser: null == allDiariesWithUser
          ? _value._allDiariesWithUser
          : allDiariesWithUser // ignore: cast_nullable_to_non_nullable
              as List<DiaryWithUser>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      showName: null == showName
          ? _value.showName
          : showName // ignore: cast_nullable_to_non_nullable
              as bool,
      showRegion: null == showRegion
          ? _value.showRegion
          : showRegion // ignore: cast_nullable_to_non_nullable
              as bool,
      imageFiles: null == imageFiles
          ? _value._imageFiles
          : imageFiles // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
    ));
  }
}

/// @nodoc

class _$DiaryStateImpl implements _DiaryState {
  const _$DiaryStateImpl(
      {this.isLoading = false,
      final List<Diary> userDiaries = const [],
      final List<Diary> allDiaries = const [],
      final List<Diary> followedUserDiaries = const [],
      final List<DiaryWithUser> allDiariesWithUser = const [],
      this.errorMessage,
      this.currentUser,
      this.isSaved = false,
      this.isPublic = false,
      this.showName = false,
      this.showRegion = false,
      final List<XFile> imageFiles = const []})
      : _userDiaries = userDiaries,
        _allDiaries = allDiaries,
        _followedUserDiaries = followedUserDiaries,
        _allDiariesWithUser = allDiariesWithUser,
        _imageFiles = imageFiles;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Diary> _userDiaries;
  @override
  @JsonKey()
  List<Diary> get userDiaries {
    if (_userDiaries is EqualUnmodifiableListView) return _userDiaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userDiaries);
  }

  final List<Diary> _allDiaries;
  @override
  @JsonKey()
  List<Diary> get allDiaries {
    if (_allDiaries is EqualUnmodifiableListView) return _allDiaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allDiaries);
  }

  final List<Diary> _followedUserDiaries;
  @override
  @JsonKey()
  List<Diary> get followedUserDiaries {
    if (_followedUserDiaries is EqualUnmodifiableListView)
      return _followedUserDiaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followedUserDiaries);
  }

  final List<DiaryWithUser> _allDiariesWithUser;
  @override
  @JsonKey()
  List<DiaryWithUser> get allDiariesWithUser {
    if (_allDiariesWithUser is EqualUnmodifiableListView)
      return _allDiariesWithUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allDiariesWithUser);
  }

  @override
  final String? errorMessage;
  @override
  final User? currentUser;
  @override
  @JsonKey()
  final bool isSaved;
  @override
  @JsonKey()
  final bool isPublic;
  @override
  @JsonKey()
  final bool showName;
  @override
  @JsonKey()
  final bool showRegion;
  final List<XFile> _imageFiles;
  @override
  @JsonKey()
  List<XFile> get imageFiles {
    if (_imageFiles is EqualUnmodifiableListView) return _imageFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageFiles);
  }

  @override
  String toString() {
    return 'DiaryState(isLoading: $isLoading, userDiaries: $userDiaries, allDiaries: $allDiaries, followedUserDiaries: $followedUserDiaries, allDiariesWithUser: $allDiariesWithUser, errorMessage: $errorMessage, currentUser: $currentUser, isSaved: $isSaved, isPublic: $isPublic, showName: $showName, showRegion: $showRegion, imageFiles: $imageFiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._userDiaries, _userDiaries) &&
            const DeepCollectionEquality()
                .equals(other._allDiaries, _allDiaries) &&
            const DeepCollectionEquality()
                .equals(other._followedUserDiaries, _followedUserDiaries) &&
            const DeepCollectionEquality()
                .equals(other._allDiariesWithUser, _allDiariesWithUser) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.showName, showName) ||
                other.showName == showName) &&
            (identical(other.showRegion, showRegion) ||
                other.showRegion == showRegion) &&
            const DeepCollectionEquality()
                .equals(other._imageFiles, _imageFiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_userDiaries),
      const DeepCollectionEquality().hash(_allDiaries),
      const DeepCollectionEquality().hash(_followedUserDiaries),
      const DeepCollectionEquality().hash(_allDiariesWithUser),
      errorMessage,
      currentUser,
      isSaved,
      isPublic,
      showName,
      showRegion,
      const DeepCollectionEquality().hash(_imageFiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryStateImplCopyWith<_$DiaryStateImpl> get copyWith =>
      __$$DiaryStateImplCopyWithImpl<_$DiaryStateImpl>(this, _$identity);
}

abstract class _DiaryState implements DiaryState {
  const factory _DiaryState(
      {final bool isLoading,
      final List<Diary> userDiaries,
      final List<Diary> allDiaries,
      final List<Diary> followedUserDiaries,
      final List<DiaryWithUser> allDiariesWithUser,
      final String? errorMessage,
      final User? currentUser,
      final bool isSaved,
      final bool isPublic,
      final bool showName,
      final bool showRegion,
      final List<XFile> imageFiles}) = _$DiaryStateImpl;

  @override
  bool get isLoading;
  @override
  List<Diary> get userDiaries;
  @override
  List<Diary> get allDiaries;
  @override
  List<Diary> get followedUserDiaries;
  @override
  List<DiaryWithUser> get allDiariesWithUser;
  @override
  String? get errorMessage;
  @override
  User? get currentUser;
  @override
  bool get isSaved;
  @override
  bool get isPublic;
  @override
  bool get showName;
  @override
  bool get showRegion;
  @override
  List<XFile> get imageFiles;
  @override
  @JsonKey(ignore: true)
  _$$DiaryStateImplCopyWith<_$DiaryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
