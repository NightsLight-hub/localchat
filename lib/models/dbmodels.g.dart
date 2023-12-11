// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbmodels.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMessageModelCollection on Isar {
  IsarCollection<MessageModel> get messageModels => this.collection();
}

const MessageModelSchema = CollectionSchema(
  name: r'MessageModel',
  id: -902762555029995869,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.longList,
    ),
    r'contentType': PropertySchema(
      id: 1,
      name: r'contentType',
      type: IsarType.long,
    ),
    r'createTime': PropertySchema(
      id: 2,
      name: r'createTime',
      type: IsarType.double,
    ),
    r'msgID': PropertySchema(
      id: 3,
      name: r'msgID',
      type: IsarType.string,
    ),
    r'senderID': PropertySchema(
      id: 4,
      name: r'senderID',
      type: IsarType.string,
    ),
    r'senderNickname': PropertySchema(
      id: 5,
      name: r'senderNickname',
      type: IsarType.string,
    ),
    r'senderPlatformID': PropertySchema(
      id: 6,
      name: r'senderPlatformID',
      type: IsarType.long,
    )
  },
  estimateSize: _messageModelEstimateSize,
  serialize: _messageModelSerialize,
  deserialize: _messageModelDeserialize,
  deserializeProp: _messageModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'msgID': IndexSchema(
      id: -2161408481992123632,
      name: r'msgID',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'msgID',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createTime': IndexSchema(
      id: -7085130145048818916,
      name: r'createTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _messageModelGetId,
  getLinks: _messageModelGetLinks,
  attach: _messageModelAttach,
  version: '3.1.0+1',
);

int _messageModelEstimateSize(
  MessageModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.msgID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.senderID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.senderNickname;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _messageModelSerialize(
  MessageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.content);
  writer.writeLong(offsets[1], object.contentType);
  writer.writeDouble(offsets[2], object.createTime);
  writer.writeString(offsets[3], object.msgID);
  writer.writeString(offsets[4], object.senderID);
  writer.writeString(offsets[5], object.senderNickname);
  writer.writeLong(offsets[6], object.senderPlatformID);
}

MessageModel _messageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageModel();
  object.content = reader.readLongList(offsets[0]);
  object.contentType = reader.readLongOrNull(offsets[1]);
  object.createTime = reader.readDoubleOrNull(offsets[2]);
  object.id = id;
  object.msgID = reader.readStringOrNull(offsets[3]);
  object.senderID = reader.readStringOrNull(offsets[4]);
  object.senderNickname = reader.readStringOrNull(offsets[5]);
  object.senderPlatformID = reader.readLongOrNull(offsets[6]);
  return object;
}

P _messageModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _messageModelGetId(MessageModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _messageModelGetLinks(MessageModel object) {
  return [];
}

void _messageModelAttach(
    IsarCollection<dynamic> col, Id id, MessageModel object) {
  object.id = id;
}

extension MessageModelByIndex on IsarCollection<MessageModel> {
  Future<MessageModel?> getByMsgID(String? msgID) {
    return getByIndex(r'msgID', [msgID]);
  }

  MessageModel? getByMsgIDSync(String? msgID) {
    return getByIndexSync(r'msgID', [msgID]);
  }

  Future<bool> deleteByMsgID(String? msgID) {
    return deleteByIndex(r'msgID', [msgID]);
  }

  bool deleteByMsgIDSync(String? msgID) {
    return deleteByIndexSync(r'msgID', [msgID]);
  }

  Future<List<MessageModel?>> getAllByMsgID(List<String?> msgIDValues) {
    final values = msgIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'msgID', values);
  }

  List<MessageModel?> getAllByMsgIDSync(List<String?> msgIDValues) {
    final values = msgIDValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'msgID', values);
  }

  Future<int> deleteAllByMsgID(List<String?> msgIDValues) {
    final values = msgIDValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'msgID', values);
  }

  int deleteAllByMsgIDSync(List<String?> msgIDValues) {
    final values = msgIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'msgID', values);
  }

  Future<Id> putByMsgID(MessageModel object) {
    return putByIndex(r'msgID', object);
  }

  Id putByMsgIDSync(MessageModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'msgID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMsgID(List<MessageModel> objects) {
    return putAllByIndex(r'msgID', objects);
  }

  List<Id> putAllByMsgIDSync(List<MessageModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'msgID', objects, saveLinks: saveLinks);
  }
}

extension MessageModelQueryWhereSort
    on QueryBuilder<MessageModel, MessageModel, QWhere> {
  QueryBuilder<MessageModel, MessageModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhere> anyCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createTime'),
      );
    });
  }
}

extension MessageModelQueryWhere
    on QueryBuilder<MessageModel, MessageModel, QWhereClause> {
  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> msgIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'msgID',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> msgIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'msgID',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> msgIDEqualTo(
      String? msgID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'msgID',
        value: [msgID],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> msgIDNotEqualTo(
      String? msgID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgID',
              lower: [],
              upper: [msgID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgID',
              lower: [msgID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgID',
              lower: [msgID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'msgID',
              lower: [],
              upper: [msgID],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause>
      createTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createTime',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause>
      createTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createTime',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> createTimeEqualTo(
      double? createTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createTime',
        value: [createTime],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause>
      createTimeNotEqualTo(double? createTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createTime',
              lower: [],
              upper: [createTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createTime',
              lower: [createTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createTime',
              lower: [createTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createTime',
              lower: [],
              upper: [createTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause>
      createTimeGreaterThan(
    double? createTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createTime',
        lower: [createTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause>
      createTimeLessThan(
    double? createTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createTime',
        lower: [],
        upper: [createTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterWhereClause> createTimeBetween(
    double? lowerCreateTime,
    double? upperCreateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createTime',
        lower: [lowerCreateTime],
        includeLower: includeLower,
        upper: [upperCreateTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessageModelQueryFilter
    on QueryBuilder<MessageModel, MessageModel, QFilterCondition> {
  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'content',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contentType',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contentType',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentTypeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentTypeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      contentTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createTime',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createTime',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createTimeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createTimeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createTimeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      createTimeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      msgIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'msgID',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      msgIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'msgID',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> msgIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'msgID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      msgIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'msgID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> msgIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'msgID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> msgIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'msgID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      msgIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'msgID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> msgIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'msgID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> msgIDContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'msgID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition> msgIDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'msgID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      msgIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'msgID',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      msgIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'msgID',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senderID',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senderID',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderID',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderID',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senderNickname',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senderNickname',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderNickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderNickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderNickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderNicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderNickname',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderPlatformIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senderPlatformID',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderPlatformIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senderPlatformID',
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderPlatformIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderPlatformID',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderPlatformIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderPlatformID',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderPlatformIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderPlatformID',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterFilterCondition>
      senderPlatformIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderPlatformID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessageModelQueryObject
    on QueryBuilder<MessageModel, MessageModel, QFilterCondition> {}

extension MessageModelQueryLinks
    on QueryBuilder<MessageModel, MessageModel, QFilterCondition> {}

extension MessageModelQuerySortBy
    on QueryBuilder<MessageModel, MessageModel, QSortBy> {
  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> sortByMsgID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgID', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> sortByMsgIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgID', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> sortBySenderID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderID', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> sortBySenderIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderID', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      sortBySenderNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderNickname', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      sortBySenderNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderNickname', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      sortBySenderPlatformID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderPlatformID', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      sortBySenderPlatformIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderPlatformID', Sort.desc);
    });
  }
}

extension MessageModelQuerySortThenBy
    on QueryBuilder<MessageModel, MessageModel, QSortThenBy> {
  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenByMsgID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgID', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenByMsgIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'msgID', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenBySenderID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderID', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy> thenBySenderIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderID', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      thenBySenderNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderNickname', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      thenBySenderNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderNickname', Sort.desc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      thenBySenderPlatformID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderPlatformID', Sort.asc);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QAfterSortBy>
      thenBySenderPlatformIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderPlatformID', Sort.desc);
    });
  }
}

extension MessageModelQueryWhereDistinct
    on QueryBuilder<MessageModel, MessageModel, QDistinct> {
  QueryBuilder<MessageModel, MessageModel, QDistinct> distinctByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QDistinct> distinctByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QDistinct> distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createTime');
    });
  }

  QueryBuilder<MessageModel, MessageModel, QDistinct> distinctByMsgID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'msgID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QDistinct> distinctBySenderID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QDistinct> distinctBySenderNickname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderNickname',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageModel, MessageModel, QDistinct>
      distinctBySenderPlatformID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderPlatformID');
    });
  }
}

extension MessageModelQueryProperty
    on QueryBuilder<MessageModel, MessageModel, QQueryProperty> {
  QueryBuilder<MessageModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessageModel, List<int>?, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<MessageModel, int?, QQueryOperations> contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<MessageModel, double?, QQueryOperations> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createTime');
    });
  }

  QueryBuilder<MessageModel, String?, QQueryOperations> msgIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'msgID');
    });
  }

  QueryBuilder<MessageModel, String?, QQueryOperations> senderIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderID');
    });
  }

  QueryBuilder<MessageModel, String?, QQueryOperations>
      senderNicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderNickname');
    });
  }

  QueryBuilder<MessageModel, int?, QQueryOperations>
      senderPlatformIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderPlatformID');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUsersModelCollection on Isar {
  IsarCollection<UsersModel> get usersModels => this.collection();
}

const UsersModelSchema = CollectionSchema(
  name: r'UsersModel',
  id: 549196197991969672,
  properties: {
    r'me': PropertySchema(
      id: 0,
      name: r'me',
      type: IsarType.long,
    ),
    r'nickName': PropertySchema(
      id: 1,
      name: r'nickName',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 2,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _usersModelEstimateSize,
  serialize: _usersModelSerialize,
  deserialize: _usersModelDeserialize,
  deserializeProp: _usersModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _usersModelGetId,
  getLinks: _usersModelGetLinks,
  attach: _usersModelAttach,
  version: '3.1.0+1',
);

int _usersModelEstimateSize(
  UsersModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.nickName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _usersModelSerialize(
  UsersModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.me);
  writer.writeString(offsets[1], object.nickName);
  writer.writeString(offsets[2], object.userId);
}

UsersModel _usersModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UsersModel();
  object.id = id;
  object.me = reader.readLong(offsets[0]);
  object.nickName = reader.readStringOrNull(offsets[1]);
  object.userId = reader.readStringOrNull(offsets[2]);
  return object;
}

P _usersModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _usersModelGetId(UsersModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _usersModelGetLinks(UsersModel object) {
  return [];
}

void _usersModelAttach(IsarCollection<dynamic> col, Id id, UsersModel object) {
  object.id = id;
}

extension UsersModelByIndex on IsarCollection<UsersModel> {
  Future<UsersModel?> getByUserId(String? userId) {
    return getByIndex(r'userId', [userId]);
  }

  UsersModel? getByUserIdSync(String? userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String? userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String? userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<UsersModel?>> getAllByUserId(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<UsersModel?> getAllByUserIdSync(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(UsersModel object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(UsersModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<UsersModel> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<UsersModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension UsersModelQueryWhereSort
    on QueryBuilder<UsersModel, UsersModel, QWhere> {
  QueryBuilder<UsersModel, UsersModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UsersModelQueryWhere
    on QueryBuilder<UsersModel, UsersModel, QWhereClause> {
  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [null],
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> userIdEqualTo(
      String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterWhereClause> userIdNotEqualTo(
      String? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UsersModelQueryFilter
    on QueryBuilder<UsersModel, UsersModel, QFilterCondition> {
  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> meEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'me',
        value: value,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> meGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'me',
        value: value,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> meLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'me',
        value: value,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> meBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'me',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nickName',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      nickNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nickName',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      nickNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      nickNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> nickNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      nickNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickName',
        value: '',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      nickNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickName',
        value: '',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension UsersModelQueryObject
    on QueryBuilder<UsersModel, UsersModel, QFilterCondition> {}

extension UsersModelQueryLinks
    on QueryBuilder<UsersModel, UsersModel, QFilterCondition> {}

extension UsersModelQuerySortBy
    on QueryBuilder<UsersModel, UsersModel, QSortBy> {
  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> sortByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'me', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> sortByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'me', Sort.desc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> sortByNickName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickName', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> sortByNickNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickName', Sort.desc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UsersModelQuerySortThenBy
    on QueryBuilder<UsersModel, UsersModel, QSortThenBy> {
  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'me', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'me', Sort.desc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByNickName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickName', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByNickNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickName', Sort.desc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UsersModelQueryWhereDistinct
    on QueryBuilder<UsersModel, UsersModel, QDistinct> {
  QueryBuilder<UsersModel, UsersModel, QDistinct> distinctByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'me');
    });
  }

  QueryBuilder<UsersModel, UsersModel, QDistinct> distinctByNickName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nickName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UsersModel, UsersModel, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UsersModelQueryProperty
    on QueryBuilder<UsersModel, UsersModel, QQueryProperty> {
  QueryBuilder<UsersModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UsersModel, int, QQueryOperations> meProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'me');
    });
  }

  QueryBuilder<UsersModel, String?, QQueryOperations> nickNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nickName');
    });
  }

  QueryBuilder<UsersModel, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
