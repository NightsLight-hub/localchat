// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'common.dart';

class NetworkCardMapper extends ClassMapperBase<NetworkCard> {
  NetworkCardMapper._();

  static NetworkCardMapper? _instance;
  static NetworkCardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NetworkCardMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'NetworkCard';

  static String _$name(NetworkCard v) => v.name;
  static const Field<NetworkCard, String> _f$name = Field('name', _$name);
  static String _$ip(NetworkCard v) => v.ip;
  static const Field<NetworkCard, String> _f$ip = Field('ip', _$ip);

  @override
  final Map<Symbol, Field<NetworkCard, dynamic>> fields = const {
    #name: _f$name,
    #ip: _f$ip,
  };

  static NetworkCard _instantiate(DecodingData data) {
    return NetworkCard(data.dec(_f$name), data.dec(_f$ip));
  }

  @override
  final Function instantiate = _instantiate;

  static NetworkCard fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NetworkCard>(map);
  }

  static NetworkCard deserialize(String json) {
    return ensureInitialized().decodeJson<NetworkCard>(json);
  }
}

mixin NetworkCardMappable {
  String serialize() {
    return NetworkCardMapper.ensureInitialized()
        .encodeJson<NetworkCard>(this as NetworkCard);
  }

  Map<String, dynamic> toJson() {
    return NetworkCardMapper.ensureInitialized()
        .encodeMap<NetworkCard>(this as NetworkCard);
  }

  NetworkCardCopyWith<NetworkCard, NetworkCard, NetworkCard> get copyWith =>
      _NetworkCardCopyWithImpl(this as NetworkCard, $identity, $identity);
  @override
  String toString() {
    return NetworkCardMapper.ensureInitialized()
        .stringifyValue(this as NetworkCard);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NetworkCardMapper.ensureInitialized()
                .isValueEqual(this as NetworkCard, other));
  }

  @override
  int get hashCode {
    return NetworkCardMapper.ensureInitialized().hashValue(this as NetworkCard);
  }
}

extension NetworkCardValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NetworkCard, $Out> {
  NetworkCardCopyWith<$R, NetworkCard, $Out> get $asNetworkCard =>
      $base.as((v, t, t2) => _NetworkCardCopyWithImpl(v, t, t2));
}

abstract class NetworkCardCopyWith<$R, $In extends NetworkCard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? ip});
  NetworkCardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NetworkCardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NetworkCard, $Out>
    implements NetworkCardCopyWith<$R, NetworkCard, $Out> {
  _NetworkCardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NetworkCard> $mapper =
      NetworkCardMapper.ensureInitialized();
  @override
  $R call({String? name, String? ip}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (ip != null) #ip: ip}));
  @override
  NetworkCard $make(CopyWithData data) => NetworkCard(
      data.get(#name, or: $value.name), data.get(#ip, or: $value.ip));

  @override
  NetworkCardCopyWith<$R2, NetworkCard, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NetworkCardCopyWithImpl($value, $cast, t);
}
