// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getQuestionsHash() => r'f011306caaaa747012e02ae7abbaf6b4bd02983b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getQuestions].
@ProviderFor(getQuestions)
const getQuestionsProvider = GetQuestionsFamily();

/// See also [getQuestions].
class GetQuestionsFamily extends Family<AsyncValue<List<Question>>> {
  /// See also [getQuestions].
  const GetQuestionsFamily();

  /// See also [getQuestions].
  GetQuestionsProvider call(
    Difficulty difficulty,
    int amount,
  ) {
    return GetQuestionsProvider(
      difficulty,
      amount,
    );
  }

  @override
  GetQuestionsProvider getProviderOverride(
    covariant GetQuestionsProvider provider,
  ) {
    return call(
      provider.difficulty,
      provider.amount,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getQuestionsProvider';
}

/// See also [getQuestions].
class GetQuestionsProvider extends AutoDisposeFutureProvider<List<Question>> {
  /// See also [getQuestions].
  GetQuestionsProvider(
    Difficulty difficulty,
    int amount,
  ) : this._internal(
          (ref) => getQuestions(
            ref as GetQuestionsRef,
            difficulty,
            amount,
          ),
          from: getQuestionsProvider,
          name: r'getQuestionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getQuestionsHash,
          dependencies: GetQuestionsFamily._dependencies,
          allTransitiveDependencies:
              GetQuestionsFamily._allTransitiveDependencies,
          difficulty: difficulty,
          amount: amount,
        );

  GetQuestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.difficulty,
    required this.amount,
  }) : super.internal();

  final Difficulty difficulty;
  final int amount;

  @override
  Override overrideWith(
    FutureOr<List<Question>> Function(GetQuestionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetQuestionsProvider._internal(
        (ref) => create(ref as GetQuestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        difficulty: difficulty,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Question>> createElement() {
    return _GetQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetQuestionsProvider &&
        other.difficulty == difficulty &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, difficulty.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetQuestionsRef on AutoDisposeFutureProviderRef<List<Question>> {
  /// The parameter `difficulty` of this provider.
  Difficulty get difficulty;

  /// The parameter `amount` of this provider.
  int get amount;
}

class _GetQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Question>>
    with GetQuestionsRef {
  _GetQuestionsProviderElement(super.provider);

  @override
  Difficulty get difficulty => (origin as GetQuestionsProvider).difficulty;
  @override
  int get amount => (origin as GetQuestionsProvider).amount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
