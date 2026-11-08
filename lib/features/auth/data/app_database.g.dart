// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StoredUsersTable extends StoredUsers
    with TableInfo<$StoredUsersTable, StoredUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneE164Meta = const VerificationMeta(
    'phoneE164',
  );
  @override
  late final GeneratedColumn<String> phoneE164 = GeneratedColumn<String>(
    'phone_e164',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    phoneE164,
    firstName,
    lastName,
    birthDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone_e164')) {
      context.handle(
        _phoneE164Meta,
        phoneE164.isAcceptableOrUnknown(data['phone_e164']!, _phoneE164Meta),
      );
    } else if (isInserting) {
      context.missing(_phoneE164Meta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneE164};
  @override
  StoredUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredUser(
      phoneE164: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_e164'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_date'],
      )!,
    );
  }

  @override
  $StoredUsersTable createAlias(String alias) {
    return $StoredUsersTable(attachedDatabase, alias);
  }
}

class StoredUser extends DataClass implements Insertable<StoredUser> {
  final String phoneE164;
  final String firstName;
  final String lastName;
  final String birthDate;
  const StoredUser({
    required this.phoneE164,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone_e164'] = Variable<String>(phoneE164);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['birth_date'] = Variable<String>(birthDate);
    return map;
  }

  StoredUsersCompanion toCompanion(bool nullToAbsent) {
    return StoredUsersCompanion(
      phoneE164: Value(phoneE164),
      firstName: Value(firstName),
      lastName: Value(lastName),
      birthDate: Value(birthDate),
    );
  }

  factory StoredUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredUser(
      phoneE164: serializer.fromJson<String>(json['phoneE164']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      birthDate: serializer.fromJson<String>(json['birthDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phoneE164': serializer.toJson<String>(phoneE164),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'birthDate': serializer.toJson<String>(birthDate),
    };
  }

  StoredUser copyWith({
    String? phoneE164,
    String? firstName,
    String? lastName,
    String? birthDate,
  }) => StoredUser(
    phoneE164: phoneE164 ?? this.phoneE164,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    birthDate: birthDate ?? this.birthDate,
  );
  StoredUser copyWithCompanion(StoredUsersCompanion data) {
    return StoredUser(
      phoneE164: data.phoneE164.present ? data.phoneE164.value : this.phoneE164,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredUser(')
          ..write('phoneE164: $phoneE164, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(phoneE164, firstName, lastName, birthDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredUser &&
          other.phoneE164 == this.phoneE164 &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.birthDate == this.birthDate);
}

class StoredUsersCompanion extends UpdateCompanion<StoredUser> {
  final Value<String> phoneE164;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> birthDate;
  final Value<int> rowid;
  const StoredUsersCompanion({
    this.phoneE164 = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredUsersCompanion.insert({
    required String phoneE164,
    required String firstName,
    required String lastName,
    required String birthDate,
    this.rowid = const Value.absent(),
  }) : phoneE164 = Value(phoneE164),
       firstName = Value(firstName),
       lastName = Value(lastName),
       birthDate = Value(birthDate);
  static Insertable<StoredUser> custom({
    Expression<String>? phoneE164,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? birthDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phoneE164 != null) 'phone_e164': phoneE164,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (birthDate != null) 'birth_date': birthDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredUsersCompanion copyWith({
    Value<String>? phoneE164,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? birthDate,
    Value<int>? rowid,
  }) {
    return StoredUsersCompanion(
      phoneE164: phoneE164 ?? this.phoneE164,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phoneE164.present) {
      map['phone_e164'] = Variable<String>(phoneE164.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredUsersCompanion(')
          ..write('phoneE164: $phoneE164, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoredUsersTable storedUsers = $StoredUsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [storedUsers];
}

typedef $$StoredUsersTableCreateCompanionBuilder =
    StoredUsersCompanion Function({
      required String phoneE164,
      required String firstName,
      required String lastName,
      required String birthDate,
      Value<int> rowid,
    });
typedef $$StoredUsersTableUpdateCompanionBuilder =
    StoredUsersCompanion Function({
      Value<String> phoneE164,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> birthDate,
      Value<int> rowid,
    });

class $$StoredUsersTableFilterComposer
    extends Composer<_$AppDatabase, $StoredUsersTable> {
  $$StoredUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get phoneE164 => $composableBuilder(
    column: $table.phoneE164,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredUsersTable> {
  $$StoredUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get phoneE164 => $composableBuilder(
    column: $table.phoneE164,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredUsersTable> {
  $$StoredUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get phoneE164 =>
      $composableBuilder(column: $table.phoneE164, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);
}

class $$StoredUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredUsersTable,
          StoredUser,
          $$StoredUsersTableFilterComposer,
          $$StoredUsersTableOrderingComposer,
          $$StoredUsersTableAnnotationComposer,
          $$StoredUsersTableCreateCompanionBuilder,
          $$StoredUsersTableUpdateCompanionBuilder,
          (
            StoredUser,
            BaseReferences<_$AppDatabase, $StoredUsersTable, StoredUser>,
          ),
          StoredUser,
          PrefetchHooks Function()
        > {
  $$StoredUsersTableTableManager(_$AppDatabase db, $StoredUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> phoneE164 = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> birthDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredUsersCompanion(
                phoneE164: phoneE164,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String phoneE164,
                required String firstName,
                required String lastName,
                required String birthDate,
                Value<int> rowid = const Value.absent(),
              }) => StoredUsersCompanion.insert(
                phoneE164: phoneE164,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredUsersTable,
      StoredUser,
      $$StoredUsersTableFilterComposer,
      $$StoredUsersTableOrderingComposer,
      $$StoredUsersTableAnnotationComposer,
      $$StoredUsersTableCreateCompanionBuilder,
      $$StoredUsersTableUpdateCompanionBuilder,
      (
        StoredUser,
        BaseReferences<_$AppDatabase, $StoredUsersTable, StoredUser>,
      ),
      StoredUser,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoredUsersTableTableManager get storedUsers =>
      $$StoredUsersTableTableManager(_db, _db.storedUsers);
}
