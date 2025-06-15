// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetTodoModelCollection on Isar {
  IsarCollection<int, TodoModel> get todoModels => this.collection();
}

const TodoModelSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'todo',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'kTitle',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'kDescription',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'kDateTime',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'kIsCompleted',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'kCategory',
        type: IsarType.byte,
        enumMap: {
          "food": 0,
          "transport": 1,
          "shopping": 2,
          "entertainment": 3,
          "health": 4,
          "bills": 5,
          "others": 6
        },
      ),
      IsarPropertySchema(
        name: 'ID',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'title',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'dateTime',
        type: IsarType.dateTime,
      ),
      IsarPropertySchema(
        name: 'description',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'category',
        type: IsarType.byte,
        enumMap: {
          "food": 0,
          "transport": 1,
          "shopping": 2,
          "entertainment": 3,
          "health": 4,
          "bills": 5,
          "others": 6
        },
      ),
      IsarPropertySchema(
        name: 'isCompleted',
        type: IsarType.bool,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'title',
        properties: [
          "kTitle",
        ],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'description',
        properties: [
          "kDescription",
        ],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'dateTime',
        properties: [
          "kDateTime",
        ],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'isCompleted',
        properties: [
          "kIsCompleted",
        ],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'category',
        properties: [
          "kCategory",
        ],
        unique: false,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, TodoModel>(
    serialize: serializeTodoModel,
    deserialize: deserializeTodoModel,
    deserializeProperty: deserializeTodoModelProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeTodoModel(IsarWriter writer, TodoModel object) {
  IsarCore.writeString(writer, 1, object.kTitle);
  {
    final value = object.kDescription;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  IsarCore.writeLong(
      writer, 3, object.kDateTime.toUtc().microsecondsSinceEpoch);
  IsarCore.writeBool(writer, 4, object.kIsCompleted);
  IsarCore.writeByte(writer, 5, object.kCategory.index);
  IsarCore.writeLong(writer, 6, object.ID);
  IsarCore.writeString(writer, 7, object.title);
  IsarCore.writeLong(writer, 8, object.dateTime.toUtc().microsecondsSinceEpoch);
  {
    final value = object.description;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  IsarCore.writeByte(writer, 10, object.category.index);
  IsarCore.writeBool(writer, 11, object.isCompleted);
  return object.id;
}

@isarProtected
TodoModel deserializeTodoModel(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _kTitle;
  _kTitle = IsarCore.readString(reader, 1) ?? '';
  final String? _kDescription;
  _kDescription = IsarCore.readString(reader, 2);
  final DateTime _kDateTime;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _kDateTime =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _kDateTime =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final bool _kIsCompleted;
  _kIsCompleted = IsarCore.readBool(reader, 4);
  final TodoCategory _kCategory;
  {
    if (IsarCore.readNull(reader, 5)) {
      _kCategory = TodoCategory.food;
    } else {
      _kCategory = _todoModelKCategory[IsarCore.readByte(reader, 5)] ??
          TodoCategory.food;
    }
  }
  final object = TodoModel(
    id: _id,
    kTitle: _kTitle,
    kDescription: _kDescription,
    kDateTime: _kDateTime,
    kIsCompleted: _kIsCompleted,
    kCategory: _kCategory,
  );
  object.title = IsarCore.readString(reader, 7) ?? '';
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      object.dateTime =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      object.dateTime =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  object.description = IsarCore.readString(reader, 9);
  {
    if (IsarCore.readNull(reader, 10)) {
      object.category = TodoCategory.food;
    } else {
      object.category = _todoModelCategory[IsarCore.readByte(reader, 10)] ??
          TodoCategory.food;
    }
  }
  object.isCompleted = IsarCore.readBool(reader, 11);
  return object;
}

@isarProtected
dynamic deserializeTodoModelProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2);
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 4:
      return IsarCore.readBool(reader, 4);
    case 5:
      {
        if (IsarCore.readNull(reader, 5)) {
          return TodoCategory.food;
        } else {
          return _todoModelKCategory[IsarCore.readByte(reader, 5)] ??
              TodoCategory.food;
        }
      }
    case 6:
      return IsarCore.readLong(reader, 6);
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    case 9:
      return IsarCore.readString(reader, 9);
    case 10:
      {
        if (IsarCore.readNull(reader, 10)) {
          return TodoCategory.food;
        } else {
          return _todoModelCategory[IsarCore.readByte(reader, 10)] ??
              TodoCategory.food;
        }
      }
    case 11:
      return IsarCore.readBool(reader, 11);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _TodoModelUpdate {
  bool call({
    required int id,
    String? kTitle,
    String? kDescription,
    DateTime? kDateTime,
    bool? kIsCompleted,
    TodoCategory? kCategory,
    int? ID,
    String? title,
    DateTime? dateTime,
    String? description,
    TodoCategory? category,
    bool? isCompleted,
  });
}

class _TodoModelUpdateImpl implements _TodoModelUpdate {
  const _TodoModelUpdateImpl(this.collection);

  final IsarCollection<int, TodoModel> collection;

  @override
  bool call({
    required int id,
    Object? kTitle = ignore,
    Object? kDescription = ignore,
    Object? kDateTime = ignore,
    Object? kIsCompleted = ignore,
    Object? kCategory = ignore,
    Object? ID = ignore,
    Object? title = ignore,
    Object? dateTime = ignore,
    Object? description = ignore,
    Object? category = ignore,
    Object? isCompleted = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (kTitle != ignore) 1: kTitle as String?,
          if (kDescription != ignore) 2: kDescription as String?,
          if (kDateTime != ignore) 3: kDateTime as DateTime?,
          if (kIsCompleted != ignore) 4: kIsCompleted as bool?,
          if (kCategory != ignore) 5: kCategory as TodoCategory?,
          if (ID != ignore) 6: ID as int?,
          if (title != ignore) 7: title as String?,
          if (dateTime != ignore) 8: dateTime as DateTime?,
          if (description != ignore) 9: description as String?,
          if (category != ignore) 10: category as TodoCategory?,
          if (isCompleted != ignore) 11: isCompleted as bool?,
        }) >
        0;
  }
}

sealed class _TodoModelUpdateAll {
  int call({
    required List<int> id,
    String? kTitle,
    String? kDescription,
    DateTime? kDateTime,
    bool? kIsCompleted,
    TodoCategory? kCategory,
    int? ID,
    String? title,
    DateTime? dateTime,
    String? description,
    TodoCategory? category,
    bool? isCompleted,
  });
}

class _TodoModelUpdateAllImpl implements _TodoModelUpdateAll {
  const _TodoModelUpdateAllImpl(this.collection);

  final IsarCollection<int, TodoModel> collection;

  @override
  int call({
    required List<int> id,
    Object? kTitle = ignore,
    Object? kDescription = ignore,
    Object? kDateTime = ignore,
    Object? kIsCompleted = ignore,
    Object? kCategory = ignore,
    Object? ID = ignore,
    Object? title = ignore,
    Object? dateTime = ignore,
    Object? description = ignore,
    Object? category = ignore,
    Object? isCompleted = ignore,
  }) {
    return collection.updateProperties(id, {
      if (kTitle != ignore) 1: kTitle as String?,
      if (kDescription != ignore) 2: kDescription as String?,
      if (kDateTime != ignore) 3: kDateTime as DateTime?,
      if (kIsCompleted != ignore) 4: kIsCompleted as bool?,
      if (kCategory != ignore) 5: kCategory as TodoCategory?,
      if (ID != ignore) 6: ID as int?,
      if (title != ignore) 7: title as String?,
      if (dateTime != ignore) 8: dateTime as DateTime?,
      if (description != ignore) 9: description as String?,
      if (category != ignore) 10: category as TodoCategory?,
      if (isCompleted != ignore) 11: isCompleted as bool?,
    });
  }
}

extension TodoModelUpdate on IsarCollection<int, TodoModel> {
  _TodoModelUpdate get update => _TodoModelUpdateImpl(this);

  _TodoModelUpdateAll get updateAll => _TodoModelUpdateAllImpl(this);
}

sealed class _TodoModelQueryUpdate {
  int call({
    String? kTitle,
    String? kDescription,
    DateTime? kDateTime,
    bool? kIsCompleted,
    TodoCategory? kCategory,
    int? ID,
    String? title,
    DateTime? dateTime,
    String? description,
    TodoCategory? category,
    bool? isCompleted,
  });
}

class _TodoModelQueryUpdateImpl implements _TodoModelQueryUpdate {
  const _TodoModelQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<TodoModel> query;
  final int? limit;

  @override
  int call({
    Object? kTitle = ignore,
    Object? kDescription = ignore,
    Object? kDateTime = ignore,
    Object? kIsCompleted = ignore,
    Object? kCategory = ignore,
    Object? ID = ignore,
    Object? title = ignore,
    Object? dateTime = ignore,
    Object? description = ignore,
    Object? category = ignore,
    Object? isCompleted = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (kTitle != ignore) 1: kTitle as String?,
      if (kDescription != ignore) 2: kDescription as String?,
      if (kDateTime != ignore) 3: kDateTime as DateTime?,
      if (kIsCompleted != ignore) 4: kIsCompleted as bool?,
      if (kCategory != ignore) 5: kCategory as TodoCategory?,
      if (ID != ignore) 6: ID as int?,
      if (title != ignore) 7: title as String?,
      if (dateTime != ignore) 8: dateTime as DateTime?,
      if (description != ignore) 9: description as String?,
      if (category != ignore) 10: category as TodoCategory?,
      if (isCompleted != ignore) 11: isCompleted as bool?,
    });
  }
}

extension TodoModelQueryUpdate on IsarQuery<TodoModel> {
  _TodoModelQueryUpdate get updateFirst =>
      _TodoModelQueryUpdateImpl(this, limit: 1);

  _TodoModelQueryUpdate get updateAll => _TodoModelQueryUpdateImpl(this);
}

class _TodoModelQueryBuilderUpdateImpl implements _TodoModelQueryUpdate {
  const _TodoModelQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<TodoModel, TodoModel, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? kTitle = ignore,
    Object? kDescription = ignore,
    Object? kDateTime = ignore,
    Object? kIsCompleted = ignore,
    Object? kCategory = ignore,
    Object? ID = ignore,
    Object? title = ignore,
    Object? dateTime = ignore,
    Object? description = ignore,
    Object? category = ignore,
    Object? isCompleted = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (kTitle != ignore) 1: kTitle as String?,
        if (kDescription != ignore) 2: kDescription as String?,
        if (kDateTime != ignore) 3: kDateTime as DateTime?,
        if (kIsCompleted != ignore) 4: kIsCompleted as bool?,
        if (kCategory != ignore) 5: kCategory as TodoCategory?,
        if (ID != ignore) 6: ID as int?,
        if (title != ignore) 7: title as String?,
        if (dateTime != ignore) 8: dateTime as DateTime?,
        if (description != ignore) 9: description as String?,
        if (category != ignore) 10: category as TodoCategory?,
        if (isCompleted != ignore) 11: isCompleted as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension TodoModelQueryBuilderUpdate
    on QueryBuilder<TodoModel, TodoModel, QOperations> {
  _TodoModelQueryUpdate get updateFirst =>
      _TodoModelQueryBuilderUpdateImpl(this, limit: 1);

  _TodoModelQueryUpdate get updateAll => _TodoModelQueryBuilderUpdateImpl(this);
}

const _todoModelKCategory = {
  0: TodoCategory.food,
  1: TodoCategory.transport,
  2: TodoCategory.shopping,
  3: TodoCategory.entertainment,
  4: TodoCategory.health,
  5: TodoCategory.bills,
  6: TodoCategory.others,
};
const _todoModelCategory = {
  0: TodoCategory.food,
  1: TodoCategory.transport,
  2: TodoCategory.shopping,
  3: TodoCategory.entertainment,
  4: TodoCategory.health,
  5: TodoCategory.bills,
  6: TodoCategory.others,
};

extension TodoModelQueryFilter
    on QueryBuilder<TodoModel, TodoModel, QFilterCondition> {
  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kTitleGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kTitleLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kDescriptionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kDescriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kDateTimeEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDateTimeGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDateTimeGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kDateTimeLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kDateTimeLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kDateTimeBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kIsCompletedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kCategoryEqualTo(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kCategoryGreaterThan(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kCategoryGreaterThanOrEqualTo(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kCategoryLessThan(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      kCategoryLessThanOrEqualTo(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> kCategoryBetween(
    TodoCategory lower,
    TodoCategory upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> iDEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> iDGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      iDGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> iDLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> iDLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> iDBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      titleGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      titleLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> dateTimeEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> dateTimeGreaterThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      dateTimeGreaterThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> dateTimeLessThan(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      dateTimeLessThanOrEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> categoryEqualTo(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> categoryGreaterThan(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      categoryGreaterThanOrEqualTo(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> categoryLessThan(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition>
      categoryLessThanOrEqualTo(
    TodoCategory value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> categoryBetween(
    TodoCategory lower,
    TodoCategory upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower.index,
          upper: upper.index,
        ),
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterFilterCondition> isCompletedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
        ),
      );
    });
  }
}

extension TodoModelQueryObject
    on QueryBuilder<TodoModel, TodoModel, QFilterCondition> {}

extension TodoModelQuerySortBy on QueryBuilder<TodoModel, TodoModel, QSortBy> {
  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByKCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }
}

extension TodoModelQuerySortThenBy
    on QueryBuilder<TodoModel, TodoModel, QSortThenBy> {
  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByKCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByTitleDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }
}

extension TodoModelQueryWhereDistinct
    on QueryBuilder<TodoModel, TodoModel, QDistinct> {
  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByKTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByKDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByKDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByKIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByKCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<TodoModel, TodoModel, QAfterDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }
}

extension TodoModelQueryProperty1
    on QueryBuilder<TodoModel, TodoModel, QProperty> {
  QueryBuilder<TodoModel, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TodoModel, String, QAfterProperty> kTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TodoModel, String?, QAfterProperty> kDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TodoModel, DateTime, QAfterProperty> kDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TodoModel, bool, QAfterProperty> kIsCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<TodoModel, TodoCategory, QAfterProperty> kCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<TodoModel, int, QAfterProperty> IDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<TodoModel, String, QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<TodoModel, DateTime, QAfterProperty> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<TodoModel, String?, QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<TodoModel, TodoCategory, QAfterProperty> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<TodoModel, bool, QAfterProperty> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension TodoModelQueryProperty2<R>
    on QueryBuilder<TodoModel, R, QAfterProperty> {
  QueryBuilder<TodoModel, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TodoModel, (R, String), QAfterProperty> kTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TodoModel, (R, String?), QAfterProperty> kDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TodoModel, (R, DateTime), QAfterProperty> kDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TodoModel, (R, bool), QAfterProperty> kIsCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<TodoModel, (R, TodoCategory), QAfterProperty>
      kCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<TodoModel, (R, int), QAfterProperty> IDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<TodoModel, (R, String), QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<TodoModel, (R, DateTime), QAfterProperty> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<TodoModel, (R, String?), QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<TodoModel, (R, TodoCategory), QAfterProperty>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<TodoModel, (R, bool), QAfterProperty> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension TodoModelQueryProperty3<R1, R2>
    on QueryBuilder<TodoModel, (R1, R2), QAfterProperty> {
  QueryBuilder<TodoModel, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, String), QOperations> kTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, String?), QOperations>
      kDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, DateTime), QOperations> kDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, bool), QOperations> kIsCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, TodoCategory), QOperations>
      kCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, int), QOperations> IDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, String), QOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, DateTime), QOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, String?), QOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, TodoCategory), QOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<TodoModel, (R1, R2, bool), QOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}
