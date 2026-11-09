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

class $StoredProductsTable extends StoredProducts
    with TableInfo<$StoredProductsTable, StoredProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  @override
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<int> discountPercent = GeneratedColumn<int>(
    'discount_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeSectionMeta = const VerificationMeta(
    'homeSection',
  );
  @override
  late final GeneratedColumn<String> homeSection = GeneratedColumn<String>(
    'home_section',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    description,
    homeSection,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    } else if (isInserting) {
      context.missing(_isNewMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('home_section')) {
      context.handle(
        _homeSectionMeta,
        homeSection.isAcceptableOrUnknown(
          data['home_section']!,
          _homeSectionMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_percent'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      homeSection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_section'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StoredProductsTable createAlias(String alias) {
    return $StoredProductsTable(attachedDatabase, alias);
  }
}

class StoredProduct extends DataClass implements Insertable<StoredProduct> {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageUrl;
  final String description;
  final String? homeSection;
  final int sortOrder;
  const StoredProduct({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.imageUrl,
    required this.description,
    this.homeSection,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercent != null) {
      map['discount_percent'] = Variable<int>(discountPercent);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || homeSection != null) {
      map['home_section'] = Variable<String>(homeSection);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StoredProductsCompanion toCompanion(bool nullToAbsent) {
    return StoredProductsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountPercent: discountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercent),
      imageUrl: Value(imageUrl),
      description: Value(description),
      homeSection: homeSection == null && nullToAbsent
          ? const Value.absent()
          : Value(homeSection),
      sortOrder: Value(sortOrder),
    );
  }

  factory StoredProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredProduct(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['priceMmk']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountPercent: serializer.fromJson<int?>(json['discountPercent']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      description: serializer.fromJson<String>(json['description']),
      homeSection: serializer.fromJson<String?>(json['homeSection']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priceMmk': serializer.toJson<int>(priceMmk),
      'isNew': serializer.toJson<bool>(isNew),
      'discountPercent': serializer.toJson<int?>(discountPercent),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'description': serializer.toJson<String>(description),
      'homeSection': serializer.toJson<String?>(homeSection),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StoredProduct copyWith({
    String? id,
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<int?> discountPercent = const Value.absent(),
    String? imageUrl,
    String? description,
    Value<String?> homeSection = const Value.absent(),
    int? sortOrder,
  }) => StoredProduct(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountPercent: discountPercent.present
        ? discountPercent.value
        : this.discountPercent,
    imageUrl: imageUrl ?? this.imageUrl,
    description: description ?? this.description,
    homeSection: homeSection.present ? homeSection.value : this.homeSection,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StoredProduct copyWithCompanion(StoredProductsCompanion data) {
    return StoredProduct(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      description: data.description.present
          ? data.description.value
          : this.description,
      homeSection: data.homeSection.present
          ? data.homeSection.value
          : this.homeSection,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredProduct(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('homeSection: $homeSection, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    imageUrl,
    description,
    homeSection,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredProduct &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountPercent == this.discountPercent &&
          other.imageUrl == this.imageUrl &&
          other.description == this.description &&
          other.homeSection == this.homeSection &&
          other.sortOrder == this.sortOrder);
}

class StoredProductsCompanion extends UpdateCompanion<StoredProduct> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<int?> discountPercent;
  final Value<String> imageUrl;
  final Value<String> description;
  final Value<String?> homeSection;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StoredProductsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.homeSection = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredProductsCompanion.insert({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required bool isNew,
    this.discountPercent = const Value.absent(),
    required String imageUrl,
    required String description,
    this.homeSection = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk),
       isNew = Value(isNew),
       imageUrl = Value(imageUrl),
       description = Value(description),
       sortOrder = Value(sortOrder);
  static Insertable<StoredProduct> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<int>? discountPercent,
    Expression<String>? imageUrl,
    Expression<String>? description,
    Expression<String>? homeSection,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (imageUrl != null) 'image_url': imageUrl,
      if (description != null) 'description': description,
      if (homeSection != null) 'home_section': homeSection,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<int?>? discountPercent,
    Value<String>? imageUrl,
    Value<String>? description,
    Value<String?>? homeSection,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StoredProductsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountPercent: discountPercent ?? this.discountPercent,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      homeSection: homeSection ?? this.homeSection,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<int>(discountPercent.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (homeSection.present) {
      map['home_section'] = Variable<String>(homeSection.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredProductsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('homeSection: $homeSection, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoredBannersTable extends StoredBanners
    with TableInfo<$StoredBannersTable, StoredBanner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredBannersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _badgeMeta = const VerificationMeta('badge');
  @override
  late final GeneratedColumn<String> badge = GeneratedColumn<String>(
    'badge',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, badge, imageUrl, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredBanner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('badge')) {
      context.handle(
        _badgeMeta,
        badge.isAcceptableOrUnknown(data['badge']!, _badgeMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredBanner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredBanner(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      badge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StoredBannersTable createAlias(String alias) {
    return $StoredBannersTable(attachedDatabase, alias);
  }
}

class StoredBanner extends DataClass implements Insertable<StoredBanner> {
  final String id;
  final String title;
  final String? badge;
  final String imageUrl;
  final int sortOrder;
  const StoredBanner({
    required this.id,
    required this.title,
    this.badge,
    required this.imageUrl,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || badge != null) {
      map['badge'] = Variable<String>(badge);
    }
    map['image_url'] = Variable<String>(imageUrl);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StoredBannersCompanion toCompanion(bool nullToAbsent) {
    return StoredBannersCompanion(
      id: Value(id),
      title: Value(title),
      badge: badge == null && nullToAbsent
          ? const Value.absent()
          : Value(badge),
      imageUrl: Value(imageUrl),
      sortOrder: Value(sortOrder),
    );
  }

  factory StoredBanner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredBanner(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      badge: serializer.fromJson<String?>(json['badge']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'badge': serializer.toJson<String?>(badge),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StoredBanner copyWith({
    String? id,
    String? title,
    Value<String?> badge = const Value.absent(),
    String? imageUrl,
    int? sortOrder,
  }) => StoredBanner(
    id: id ?? this.id,
    title: title ?? this.title,
    badge: badge.present ? badge.value : this.badge,
    imageUrl: imageUrl ?? this.imageUrl,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StoredBanner copyWithCompanion(StoredBannersCompanion data) {
    return StoredBanner(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      badge: data.badge.present ? data.badge.value : this.badge,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredBanner(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('badge: $badge, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, badge, imageUrl, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredBanner &&
          other.id == this.id &&
          other.title == this.title &&
          other.badge == this.badge &&
          other.imageUrl == this.imageUrl &&
          other.sortOrder == this.sortOrder);
}

class StoredBannersCompanion extends UpdateCompanion<StoredBanner> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> badge;
  final Value<String> imageUrl;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StoredBannersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.badge = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredBannersCompanion.insert({
    required String id,
    required String title,
    this.badge = const Value.absent(),
    required String imageUrl,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       imageUrl = Value(imageUrl),
       sortOrder = Value(sortOrder);
  static Insertable<StoredBanner> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? badge,
    Expression<String>? imageUrl,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (badge != null) 'badge': badge,
      if (imageUrl != null) 'image_url': imageUrl,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredBannersCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? badge,
    Value<String>? imageUrl,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StoredBannersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      badge: badge ?? this.badge,
      imageUrl: imageUrl ?? this.imageUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (badge.present) {
      map['badge'] = Variable<String>(badge.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredBannersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('badge: $badge, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoredShopsTable extends StoredShops
    with TableInfo<$StoredShopsTable, StoredShop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, imageUrl, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredShop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredShop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredShop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StoredShopsTable createAlias(String alias) {
    return $StoredShopsTable(attachedDatabase, alias);
  }
}

class StoredShop extends DataClass implements Insertable<StoredShop> {
  final String id;
  final String name;
  final String imageUrl;
  final int sortOrder;
  const StoredShop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StoredShopsCompanion toCompanion(bool nullToAbsent) {
    return StoredShopsCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      sortOrder: Value(sortOrder),
    );
  }

  factory StoredShop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredShop(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StoredShop copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? sortOrder,
  }) => StoredShop(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StoredShop copyWithCompanion(StoredShopsCompanion data) {
    return StoredShop(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredShop(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredShop &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.sortOrder == this.sortOrder);
}

class StoredShopsCompanion extends UpdateCompanion<StoredShop> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StoredShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredShopsCompanion.insert({
    required String id,
    required String name,
    required String imageUrl,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       imageUrl = Value(imageUrl),
       sortOrder = Value(sortOrder);
  static Insertable<StoredShop> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredShopsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StoredShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoredMembersTable extends StoredMembers
    with TableInfo<$StoredMembersTable, StoredMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextTierMeta = const VerificationMeta(
    'nextTier',
  );
  @override
  late final GeneratedColumn<String> nextTier = GeneratedColumn<String>(
    'next_tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsToNextTierMeta = const VerificationMeta(
    'pointsToNextTier',
  );
  @override
  late final GeneratedColumn<int> pointsToNextTier = GeneratedColumn<int>(
    'points_to_next_tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  @override
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardsBadgeCountMeta = const VerificationMeta(
    'rewardsBadgeCount',
  );
  @override
  late final GeneratedColumn<int> rewardsBadgeCount = GeneratedColumn<int>(
    'rewards_badge_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    photoUrl,
    tier,
    nextTier,
    points,
    pointsToNextTier,
    notificationCount,
    rewardsBadgeCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('next_tier')) {
      context.handle(
        _nextTierMeta,
        nextTier.isAcceptableOrUnknown(data['next_tier']!, _nextTierMeta),
      );
    } else if (isInserting) {
      context.missing(_nextTierMeta);
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('points_to_next_tier')) {
      context.handle(
        _pointsToNextTierMeta,
        pointsToNextTier.isAcceptableOrUnknown(
          data['points_to_next_tier']!,
          _pointsToNextTierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointsToNextTierMeta);
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationCountMeta);
    }
    if (data.containsKey('rewards_badge_count')) {
      context.handle(
        _rewardsBadgeCountMeta,
        rewardsBadgeCount.isAcceptableOrUnknown(
          data['rewards_badge_count']!,
          _rewardsBadgeCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardsBadgeCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      nextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_tier'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      pointsToNextTier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_to_next_tier'],
      )!,
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
      rewardsBadgeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rewards_badge_count'],
      )!,
    );
  }

  @override
  $StoredMembersTable createAlias(String alias) {
    return $StoredMembersTable(attachedDatabase, alias);
  }
}

class StoredMember extends DataClass implements Insertable<StoredMember> {
  final String id;
  final String name;
  final String photoUrl;
  final String tier;
  final String nextTier;
  final int points;
  final int pointsToNextTier;
  final int notificationCount;
  final int rewardsBadgeCount;
  const StoredMember({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.tier,
    required this.nextTier,
    required this.points,
    required this.pointsToNextTier,
    required this.notificationCount,
    required this.rewardsBadgeCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['photo_url'] = Variable<String>(photoUrl);
    map['tier'] = Variable<String>(tier);
    map['next_tier'] = Variable<String>(nextTier);
    map['points'] = Variable<int>(points);
    map['points_to_next_tier'] = Variable<int>(pointsToNextTier);
    map['notification_count'] = Variable<int>(notificationCount);
    map['rewards_badge_count'] = Variable<int>(rewardsBadgeCount);
    return map;
  }

  StoredMembersCompanion toCompanion(bool nullToAbsent) {
    return StoredMembersCompanion(
      id: Value(id),
      name: Value(name),
      photoUrl: Value(photoUrl),
      tier: Value(tier),
      nextTier: Value(nextTier),
      points: Value(points),
      pointsToNextTier: Value(pointsToNextTier),
      notificationCount: Value(notificationCount),
      rewardsBadgeCount: Value(rewardsBadgeCount),
    );
  }

  factory StoredMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredMember(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
      tier: serializer.fromJson<String>(json['tier']),
      nextTier: serializer.fromJson<String>(json['nextTier']),
      points: serializer.fromJson<int>(json['points']),
      pointsToNextTier: serializer.fromJson<int>(json['pointsToNextTier']),
      notificationCount: serializer.fromJson<int>(json['notificationCount']),
      rewardsBadgeCount: serializer.fromJson<int>(json['rewardsBadgeCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'photoUrl': serializer.toJson<String>(photoUrl),
      'tier': serializer.toJson<String>(tier),
      'nextTier': serializer.toJson<String>(nextTier),
      'points': serializer.toJson<int>(points),
      'pointsToNextTier': serializer.toJson<int>(pointsToNextTier),
      'notificationCount': serializer.toJson<int>(notificationCount),
      'rewardsBadgeCount': serializer.toJson<int>(rewardsBadgeCount),
    };
  }

  StoredMember copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? tier,
    String? nextTier,
    int? points,
    int? pointsToNextTier,
    int? notificationCount,
    int? rewardsBadgeCount,
  }) => StoredMember(
    id: id ?? this.id,
    name: name ?? this.name,
    photoUrl: photoUrl ?? this.photoUrl,
    tier: tier ?? this.tier,
    nextTier: nextTier ?? this.nextTier,
    points: points ?? this.points,
    pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
    notificationCount: notificationCount ?? this.notificationCount,
    rewardsBadgeCount: rewardsBadgeCount ?? this.rewardsBadgeCount,
  );
  StoredMember copyWithCompanion(StoredMembersCompanion data) {
    return StoredMember(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      tier: data.tier.present ? data.tier.value : this.tier,
      nextTier: data.nextTier.present ? data.nextTier.value : this.nextTier,
      points: data.points.present ? data.points.value : this.points,
      pointsToNextTier: data.pointsToNextTier.present
          ? data.pointsToNextTier.value
          : this.pointsToNextTier,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
      rewardsBadgeCount: data.rewardsBadgeCount.present
          ? data.rewardsBadgeCount.value
          : this.rewardsBadgeCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredMember(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('tier: $tier, ')
          ..write('nextTier: $nextTier, ')
          ..write('points: $points, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardsBadgeCount: $rewardsBadgeCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    photoUrl,
    tier,
    nextTier,
    points,
    pointsToNextTier,
    notificationCount,
    rewardsBadgeCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredMember &&
          other.id == this.id &&
          other.name == this.name &&
          other.photoUrl == this.photoUrl &&
          other.tier == this.tier &&
          other.nextTier == this.nextTier &&
          other.points == this.points &&
          other.pointsToNextTier == this.pointsToNextTier &&
          other.notificationCount == this.notificationCount &&
          other.rewardsBadgeCount == this.rewardsBadgeCount);
}

class StoredMembersCompanion extends UpdateCompanion<StoredMember> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> photoUrl;
  final Value<String> tier;
  final Value<String> nextTier;
  final Value<int> points;
  final Value<int> pointsToNextTier;
  final Value<int> notificationCount;
  final Value<int> rewardsBadgeCount;
  final Value<int> rowid;
  const StoredMembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.tier = const Value.absent(),
    this.nextTier = const Value.absent(),
    this.points = const Value.absent(),
    this.pointsToNextTier = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.rewardsBadgeCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredMembersCompanion.insert({
    required String id,
    required String name,
    required String photoUrl,
    required String tier,
    required String nextTier,
    required int points,
    required int pointsToNextTier,
    required int notificationCount,
    required int rewardsBadgeCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       photoUrl = Value(photoUrl),
       tier = Value(tier),
       nextTier = Value(nextTier),
       points = Value(points),
       pointsToNextTier = Value(pointsToNextTier),
       notificationCount = Value(notificationCount),
       rewardsBadgeCount = Value(rewardsBadgeCount);
  static Insertable<StoredMember> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? photoUrl,
    Expression<String>? tier,
    Expression<String>? nextTier,
    Expression<int>? points,
    Expression<int>? pointsToNextTier,
    Expression<int>? notificationCount,
    Expression<int>? rewardsBadgeCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (tier != null) 'tier': tier,
      if (nextTier != null) 'next_tier': nextTier,
      if (points != null) 'points': points,
      if (pointsToNextTier != null) 'points_to_next_tier': pointsToNextTier,
      if (notificationCount != null) 'notification_count': notificationCount,
      if (rewardsBadgeCount != null) 'rewards_badge_count': rewardsBadgeCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredMembersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? photoUrl,
    Value<String>? tier,
    Value<String>? nextTier,
    Value<int>? points,
    Value<int>? pointsToNextTier,
    Value<int>? notificationCount,
    Value<int>? rewardsBadgeCount,
    Value<int>? rowid,
  }) {
    return StoredMembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      tier: tier ?? this.tier,
      nextTier: nextTier ?? this.nextTier,
      points: points ?? this.points,
      pointsToNextTier: pointsToNextTier ?? this.pointsToNextTier,
      notificationCount: notificationCount ?? this.notificationCount,
      rewardsBadgeCount: rewardsBadgeCount ?? this.rewardsBadgeCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (nextTier.present) {
      map['next_tier'] = Variable<String>(nextTier.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (pointsToNextTier.present) {
      map['points_to_next_tier'] = Variable<int>(pointsToNextTier.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    if (rewardsBadgeCount.present) {
      map['rewards_badge_count'] = Variable<int>(rewardsBadgeCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredMembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('tier: $tier, ')
          ..write('nextTier: $nextTier, ')
          ..write('points: $points, ')
          ..write('pointsToNextTier: $pointsToNextTier, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardsBadgeCount: $rewardsBadgeCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoredTiersTable extends StoredTiers
    with TableInfo<$StoredTiersTable, StoredTier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredTiersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, caption, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tiers';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredTier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    } else if (isInserting) {
      context.missing(_captionMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredTier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredTier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StoredTiersTable createAlias(String alias) {
    return $StoredTiersTable(attachedDatabase, alias);
  }
}

class StoredTier extends DataClass implements Insertable<StoredTier> {
  final String id;
  final String name;
  final String caption;
  final int sortOrder;
  const StoredTier({
    required this.id,
    required this.name,
    required this.caption,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['caption'] = Variable<String>(caption);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StoredTiersCompanion toCompanion(bool nullToAbsent) {
    return StoredTiersCompanion(
      id: Value(id),
      name: Value(name),
      caption: Value(caption),
      sortOrder: Value(sortOrder),
    );
  }

  factory StoredTier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredTier(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      caption: serializer.fromJson<String>(json['caption']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'caption': serializer.toJson<String>(caption),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StoredTier copyWith({
    String? id,
    String? name,
    String? caption,
    int? sortOrder,
  }) => StoredTier(
    id: id ?? this.id,
    name: name ?? this.name,
    caption: caption ?? this.caption,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StoredTier copyWithCompanion(StoredTiersCompanion data) {
    return StoredTier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      caption: data.caption.present ? data.caption.value : this.caption,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredTier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('caption: $caption, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, caption, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredTier &&
          other.id == this.id &&
          other.name == this.name &&
          other.caption == this.caption &&
          other.sortOrder == this.sortOrder);
}

class StoredTiersCompanion extends UpdateCompanion<StoredTier> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> caption;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StoredTiersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.caption = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredTiersCompanion.insert({
    required String id,
    required String name,
    required String caption,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       caption = Value(caption),
       sortOrder = Value(sortOrder);
  static Insertable<StoredTier> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? caption,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (caption != null) 'caption': caption,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredTiersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? caption,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StoredTiersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      caption: caption ?? this.caption,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredTiersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('caption: $caption, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoredChallengesTable extends StoredChallenges
    with TableInfo<$StoredChallengesTable, StoredChallenge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoredChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<int> goal = GeneratedColumn<int>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artworkMeta = const VerificationMeta(
    'artwork',
  );
  @override
  late final GeneratedColumn<String> artwork = GeneratedColumn<String>(
    'artwork',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tabMeta = const VerificationMeta('tab');
  @override
  late final GeneratedColumn<String> tab = GeneratedColumn<String>(
    'tab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    progress,
    goal,
    points,
    artwork,
    tab,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredChallenge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('artwork')) {
      context.handle(
        _artworkMeta,
        artwork.isAcceptableOrUnknown(data['artwork']!, _artworkMeta),
      );
    } else if (isInserting) {
      context.missing(_artworkMeta);
    }
    if (data.containsKey('tab')) {
      context.handle(
        _tabMeta,
        tab.isAcceptableOrUnknown(data['tab']!, _tabMeta),
      );
    } else if (isInserting) {
      context.missing(_tabMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredChallenge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredChallenge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      artwork: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork'],
      )!,
      tab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tab'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StoredChallengesTable createAlias(String alias) {
    return $StoredChallengesTable(attachedDatabase, alias);
  }
}

class StoredChallenge extends DataClass implements Insertable<StoredChallenge> {
  final String id;
  final String title;
  final int progress;
  final int goal;
  final int points;
  final String artwork;
  final String tab;
  final int sortOrder;
  const StoredChallenge({
    required this.id,
    required this.title,
    required this.progress,
    required this.goal,
    required this.points,
    required this.artwork,
    required this.tab,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['progress'] = Variable<int>(progress);
    map['goal'] = Variable<int>(goal);
    map['points'] = Variable<int>(points);
    map['artwork'] = Variable<String>(artwork);
    map['tab'] = Variable<String>(tab);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StoredChallengesCompanion toCompanion(bool nullToAbsent) {
    return StoredChallengesCompanion(
      id: Value(id),
      title: Value(title),
      progress: Value(progress),
      goal: Value(goal),
      points: Value(points),
      artwork: Value(artwork),
      tab: Value(tab),
      sortOrder: Value(sortOrder),
    );
  }

  factory StoredChallenge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredChallenge(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      progress: serializer.fromJson<int>(json['progress']),
      goal: serializer.fromJson<int>(json['goal']),
      points: serializer.fromJson<int>(json['points']),
      artwork: serializer.fromJson<String>(json['artwork']),
      tab: serializer.fromJson<String>(json['tab']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'progress': serializer.toJson<int>(progress),
      'goal': serializer.toJson<int>(goal),
      'points': serializer.toJson<int>(points),
      'artwork': serializer.toJson<String>(artwork),
      'tab': serializer.toJson<String>(tab),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StoredChallenge copyWith({
    String? id,
    String? title,
    int? progress,
    int? goal,
    int? points,
    String? artwork,
    String? tab,
    int? sortOrder,
  }) => StoredChallenge(
    id: id ?? this.id,
    title: title ?? this.title,
    progress: progress ?? this.progress,
    goal: goal ?? this.goal,
    points: points ?? this.points,
    artwork: artwork ?? this.artwork,
    tab: tab ?? this.tab,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StoredChallenge copyWithCompanion(StoredChallengesCompanion data) {
    return StoredChallenge(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      progress: data.progress.present ? data.progress.value : this.progress,
      goal: data.goal.present ? data.goal.value : this.goal,
      points: data.points.present ? data.points.value : this.points,
      artwork: data.artwork.present ? data.artwork.value : this.artwork,
      tab: data.tab.present ? data.tab.value : this.tab,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredChallenge(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('progress: $progress, ')
          ..write('goal: $goal, ')
          ..write('points: $points, ')
          ..write('artwork: $artwork, ')
          ..write('tab: $tab, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, progress, goal, points, artwork, tab, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredChallenge &&
          other.id == this.id &&
          other.title == this.title &&
          other.progress == this.progress &&
          other.goal == this.goal &&
          other.points == this.points &&
          other.artwork == this.artwork &&
          other.tab == this.tab &&
          other.sortOrder == this.sortOrder);
}

class StoredChallengesCompanion extends UpdateCompanion<StoredChallenge> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> progress;
  final Value<int> goal;
  final Value<int> points;
  final Value<String> artwork;
  final Value<String> tab;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StoredChallengesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.progress = const Value.absent(),
    this.goal = const Value.absent(),
    this.points = const Value.absent(),
    this.artwork = const Value.absent(),
    this.tab = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoredChallengesCompanion.insert({
    required String id,
    required String title,
    required int progress,
    required int goal,
    required int points,
    required String artwork,
    required String tab,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       progress = Value(progress),
       goal = Value(goal),
       points = Value(points),
       artwork = Value(artwork),
       tab = Value(tab),
       sortOrder = Value(sortOrder);
  static Insertable<StoredChallenge> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? progress,
    Expression<int>? goal,
    Expression<int>? points,
    Expression<String>? artwork,
    Expression<String>? tab,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (progress != null) 'progress': progress,
      if (goal != null) 'goal': goal,
      if (points != null) 'points': points,
      if (artwork != null) 'artwork': artwork,
      if (tab != null) 'tab': tab,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoredChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? progress,
    Value<int>? goal,
    Value<int>? points,
    Value<String>? artwork,
    Value<String>? tab,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StoredChallengesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      goal: goal ?? this.goal,
      points: points ?? this.points,
      artwork: artwork ?? this.artwork,
      tab: tab ?? this.tab,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (goal.present) {
      map['goal'] = Variable<int>(goal.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (artwork.present) {
      map['artwork'] = Variable<String>(artwork.value);
    }
    if (tab.present) {
      map['tab'] = Variable<String>(tab.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoredChallengesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('progress: $progress, ')
          ..write('goal: $goal, ')
          ..write('points: $points, ')
          ..write('artwork: $artwork, ')
          ..write('tab: $tab, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoredUsersTable storedUsers = $StoredUsersTable(this);
  late final $StoredProductsTable storedProducts = $StoredProductsTable(this);
  late final $StoredBannersTable storedBanners = $StoredBannersTable(this);
  late final $StoredShopsTable storedShops = $StoredShopsTable(this);
  late final $StoredMembersTable storedMembers = $StoredMembersTable(this);
  late final $StoredTiersTable storedTiers = $StoredTiersTable(this);
  late final $StoredChallengesTable storedChallenges = $StoredChallengesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    storedUsers,
    storedProducts,
    storedBanners,
    storedShops,
    storedMembers,
    storedTiers,
    storedChallenges,
  ];
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
typedef $$StoredProductsTableCreateCompanionBuilder =
    StoredProductsCompanion Function({
      required String id,
      required String code,
      required String name,
      required int priceMmk,
      required bool isNew,
      Value<int?> discountPercent,
      required String imageUrl,
      required String description,
      Value<String?> homeSection,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$StoredProductsTableUpdateCompanionBuilder =
    StoredProductsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> name,
      Value<int> priceMmk,
      Value<bool> isNew,
      Value<int?> discountPercent,
      Value<String> imageUrl,
      Value<String> description,
      Value<String?> homeSection,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$StoredProductsTableFilterComposer
    extends Composer<_$AppDatabase, $StoredProductsTable> {
  $$StoredProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeSection => $composableBuilder(
    column: $table.homeSection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredProductsTable> {
  $$StoredProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeSection => $composableBuilder(
    column: $table.homeSection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredProductsTable> {
  $$StoredProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get homeSection => $composableBuilder(
    column: $table.homeSection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$StoredProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredProductsTable,
          StoredProduct,
          $$StoredProductsTableFilterComposer,
          $$StoredProductsTableOrderingComposer,
          $$StoredProductsTableAnnotationComposer,
          $$StoredProductsTableCreateCompanionBuilder,
          $$StoredProductsTableUpdateCompanionBuilder,
          (
            StoredProduct,
            BaseReferences<_$AppDatabase, $StoredProductsTable, StoredProduct>,
          ),
          StoredProduct,
          PrefetchHooks Function()
        > {
  $$StoredProductsTableTableManager(
    _$AppDatabase db,
    $StoredProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> homeSection = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredProductsCompanion(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                description: description,
                homeSection: homeSection,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required int priceMmk,
                required bool isNew,
                Value<int?> discountPercent = const Value.absent(),
                required String imageUrl,
                required String description,
                Value<String?> homeSection = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => StoredProductsCompanion.insert(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                imageUrl: imageUrl,
                description: description,
                homeSection: homeSection,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredProductsTable,
      StoredProduct,
      $$StoredProductsTableFilterComposer,
      $$StoredProductsTableOrderingComposer,
      $$StoredProductsTableAnnotationComposer,
      $$StoredProductsTableCreateCompanionBuilder,
      $$StoredProductsTableUpdateCompanionBuilder,
      (
        StoredProduct,
        BaseReferences<_$AppDatabase, $StoredProductsTable, StoredProduct>,
      ),
      StoredProduct,
      PrefetchHooks Function()
    >;
typedef $$StoredBannersTableCreateCompanionBuilder =
    StoredBannersCompanion Function({
      required String id,
      required String title,
      Value<String?> badge,
      required String imageUrl,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$StoredBannersTableUpdateCompanionBuilder =
    StoredBannersCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> badge,
      Value<String> imageUrl,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$StoredBannersTableFilterComposer
    extends Composer<_$AppDatabase, $StoredBannersTable> {
  $$StoredBannersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredBannersTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredBannersTable> {
  $$StoredBannersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredBannersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredBannersTable> {
  $$StoredBannersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get badge =>
      $composableBuilder(column: $table.badge, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$StoredBannersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredBannersTable,
          StoredBanner,
          $$StoredBannersTableFilterComposer,
          $$StoredBannersTableOrderingComposer,
          $$StoredBannersTableAnnotationComposer,
          $$StoredBannersTableCreateCompanionBuilder,
          $$StoredBannersTableUpdateCompanionBuilder,
          (
            StoredBanner,
            BaseReferences<_$AppDatabase, $StoredBannersTable, StoredBanner>,
          ),
          StoredBanner,
          PrefetchHooks Function()
        > {
  $$StoredBannersTableTableManager(_$AppDatabase db, $StoredBannersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredBannersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredBannersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredBannersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> badge = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredBannersCompanion(
                id: id,
                title: title,
                badge: badge,
                imageUrl: imageUrl,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> badge = const Value.absent(),
                required String imageUrl,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => StoredBannersCompanion.insert(
                id: id,
                title: title,
                badge: badge,
                imageUrl: imageUrl,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredBannersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredBannersTable,
      StoredBanner,
      $$StoredBannersTableFilterComposer,
      $$StoredBannersTableOrderingComposer,
      $$StoredBannersTableAnnotationComposer,
      $$StoredBannersTableCreateCompanionBuilder,
      $$StoredBannersTableUpdateCompanionBuilder,
      (
        StoredBanner,
        BaseReferences<_$AppDatabase, $StoredBannersTable, StoredBanner>,
      ),
      StoredBanner,
      PrefetchHooks Function()
    >;
typedef $$StoredShopsTableCreateCompanionBuilder =
    StoredShopsCompanion Function({
      required String id,
      required String name,
      required String imageUrl,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$StoredShopsTableUpdateCompanionBuilder =
    StoredShopsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> imageUrl,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$StoredShopsTableFilterComposer
    extends Composer<_$AppDatabase, $StoredShopsTable> {
  $$StoredShopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredShopsTable> {
  $$StoredShopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredShopsTable> {
  $$StoredShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$StoredShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredShopsTable,
          StoredShop,
          $$StoredShopsTableFilterComposer,
          $$StoredShopsTableOrderingComposer,
          $$StoredShopsTableAnnotationComposer,
          $$StoredShopsTableCreateCompanionBuilder,
          $$StoredShopsTableUpdateCompanionBuilder,
          (
            StoredShop,
            BaseReferences<_$AppDatabase, $StoredShopsTable, StoredShop>,
          ),
          StoredShop,
          PrefetchHooks Function()
        > {
  $$StoredShopsTableTableManager(_$AppDatabase db, $StoredShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredShopsCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String imageUrl,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => StoredShopsCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredShopsTable,
      StoredShop,
      $$StoredShopsTableFilterComposer,
      $$StoredShopsTableOrderingComposer,
      $$StoredShopsTableAnnotationComposer,
      $$StoredShopsTableCreateCompanionBuilder,
      $$StoredShopsTableUpdateCompanionBuilder,
      (
        StoredShop,
        BaseReferences<_$AppDatabase, $StoredShopsTable, StoredShop>,
      ),
      StoredShop,
      PrefetchHooks Function()
    >;
typedef $$StoredMembersTableCreateCompanionBuilder =
    StoredMembersCompanion Function({
      required String id,
      required String name,
      required String photoUrl,
      required String tier,
      required String nextTier,
      required int points,
      required int pointsToNextTier,
      required int notificationCount,
      required int rewardsBadgeCount,
      Value<int> rowid,
    });
typedef $$StoredMembersTableUpdateCompanionBuilder =
    StoredMembersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> photoUrl,
      Value<String> tier,
      Value<String> nextTier,
      Value<int> points,
      Value<int> pointsToNextTier,
      Value<int> notificationCount,
      Value<int> rewardsBadgeCount,
      Value<int> rowid,
    });

class $$StoredMembersTableFilterComposer
    extends Composer<_$AppDatabase, $StoredMembersTable> {
  $$StoredMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextTier => $composableBuilder(
    column: $table.nextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardsBadgeCount => $composableBuilder(
    column: $table.rewardsBadgeCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredMembersTable> {
  $$StoredMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextTier => $composableBuilder(
    column: $table.nextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardsBadgeCount => $composableBuilder(
    column: $table.rewardsBadgeCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredMembersTable> {
  $$StoredMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get nextTier =>
      $composableBuilder(column: $table.nextTier, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<int> get pointsToNextTier => $composableBuilder(
    column: $table.pointsToNextTier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rewardsBadgeCount => $composableBuilder(
    column: $table.rewardsBadgeCount,
    builder: (column) => column,
  );
}

class $$StoredMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredMembersTable,
          StoredMember,
          $$StoredMembersTableFilterComposer,
          $$StoredMembersTableOrderingComposer,
          $$StoredMembersTableAnnotationComposer,
          $$StoredMembersTableCreateCompanionBuilder,
          $$StoredMembersTableUpdateCompanionBuilder,
          (
            StoredMember,
            BaseReferences<_$AppDatabase, $StoredMembersTable, StoredMember>,
          ),
          StoredMember,
          PrefetchHooks Function()
        > {
  $$StoredMembersTableTableManager(_$AppDatabase db, $StoredMembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String> nextTier = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<int> pointsToNextTier = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> rewardsBadgeCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredMembersCompanion(
                id: id,
                name: name,
                photoUrl: photoUrl,
                tier: tier,
                nextTier: nextTier,
                points: points,
                pointsToNextTier: pointsToNextTier,
                notificationCount: notificationCount,
                rewardsBadgeCount: rewardsBadgeCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String photoUrl,
                required String tier,
                required String nextTier,
                required int points,
                required int pointsToNextTier,
                required int notificationCount,
                required int rewardsBadgeCount,
                Value<int> rowid = const Value.absent(),
              }) => StoredMembersCompanion.insert(
                id: id,
                name: name,
                photoUrl: photoUrl,
                tier: tier,
                nextTier: nextTier,
                points: points,
                pointsToNextTier: pointsToNextTier,
                notificationCount: notificationCount,
                rewardsBadgeCount: rewardsBadgeCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredMembersTable,
      StoredMember,
      $$StoredMembersTableFilterComposer,
      $$StoredMembersTableOrderingComposer,
      $$StoredMembersTableAnnotationComposer,
      $$StoredMembersTableCreateCompanionBuilder,
      $$StoredMembersTableUpdateCompanionBuilder,
      (
        StoredMember,
        BaseReferences<_$AppDatabase, $StoredMembersTable, StoredMember>,
      ),
      StoredMember,
      PrefetchHooks Function()
    >;
typedef $$StoredTiersTableCreateCompanionBuilder =
    StoredTiersCompanion Function({
      required String id,
      required String name,
      required String caption,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$StoredTiersTableUpdateCompanionBuilder =
    StoredTiersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> caption,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$StoredTiersTableFilterComposer
    extends Composer<_$AppDatabase, $StoredTiersTable> {
  $$StoredTiersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredTiersTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredTiersTable> {
  $$StoredTiersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredTiersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredTiersTable> {
  $$StoredTiersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$StoredTiersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredTiersTable,
          StoredTier,
          $$StoredTiersTableFilterComposer,
          $$StoredTiersTableOrderingComposer,
          $$StoredTiersTableAnnotationComposer,
          $$StoredTiersTableCreateCompanionBuilder,
          $$StoredTiersTableUpdateCompanionBuilder,
          (
            StoredTier,
            BaseReferences<_$AppDatabase, $StoredTiersTable, StoredTier>,
          ),
          StoredTier,
          PrefetchHooks Function()
        > {
  $$StoredTiersTableTableManager(_$AppDatabase db, $StoredTiersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredTiersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredTiersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredTiersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> caption = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredTiersCompanion(
                id: id,
                name: name,
                caption: caption,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String caption,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => StoredTiersCompanion.insert(
                id: id,
                name: name,
                caption: caption,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredTiersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredTiersTable,
      StoredTier,
      $$StoredTiersTableFilterComposer,
      $$StoredTiersTableOrderingComposer,
      $$StoredTiersTableAnnotationComposer,
      $$StoredTiersTableCreateCompanionBuilder,
      $$StoredTiersTableUpdateCompanionBuilder,
      (
        StoredTier,
        BaseReferences<_$AppDatabase, $StoredTiersTable, StoredTier>,
      ),
      StoredTier,
      PrefetchHooks Function()
    >;
typedef $$StoredChallengesTableCreateCompanionBuilder =
    StoredChallengesCompanion Function({
      required String id,
      required String title,
      required int progress,
      required int goal,
      required int points,
      required String artwork,
      required String tab,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$StoredChallengesTableUpdateCompanionBuilder =
    StoredChallengesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> progress,
      Value<int> goal,
      Value<int> points,
      Value<String> artwork,
      Value<String> tab,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$StoredChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $StoredChallengesTable> {
  $$StoredChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artwork => $composableBuilder(
    column: $table.artwork,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoredChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoredChallengesTable> {
  $$StoredChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artwork => $composableBuilder(
    column: $table.artwork,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tab => $composableBuilder(
    column: $table.tab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoredChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoredChallengesTable> {
  $$StoredChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get artwork =>
      $composableBuilder(column: $table.artwork, builder: (column) => column);

  GeneratedColumn<String> get tab =>
      $composableBuilder(column: $table.tab, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$StoredChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoredChallengesTable,
          StoredChallenge,
          $$StoredChallengesTableFilterComposer,
          $$StoredChallengesTableOrderingComposer,
          $$StoredChallengesTableAnnotationComposer,
          $$StoredChallengesTableCreateCompanionBuilder,
          $$StoredChallengesTableUpdateCompanionBuilder,
          (
            StoredChallenge,
            BaseReferences<
              _$AppDatabase,
              $StoredChallengesTable,
              StoredChallenge
            >,
          ),
          StoredChallenge,
          PrefetchHooks Function()
        > {
  $$StoredChallengesTableTableManager(
    _$AppDatabase db,
    $StoredChallengesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoredChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoredChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoredChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int> goal = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<String> artwork = const Value.absent(),
                Value<String> tab = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoredChallengesCompanion(
                id: id,
                title: title,
                progress: progress,
                goal: goal,
                points: points,
                artwork: artwork,
                tab: tab,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int progress,
                required int goal,
                required int points,
                required String artwork,
                required String tab,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => StoredChallengesCompanion.insert(
                id: id,
                title: title,
                progress: progress,
                goal: goal,
                points: points,
                artwork: artwork,
                tab: tab,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoredChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoredChallengesTable,
      StoredChallenge,
      $$StoredChallengesTableFilterComposer,
      $$StoredChallengesTableOrderingComposer,
      $$StoredChallengesTableAnnotationComposer,
      $$StoredChallengesTableCreateCompanionBuilder,
      $$StoredChallengesTableUpdateCompanionBuilder,
      (
        StoredChallenge,
        BaseReferences<_$AppDatabase, $StoredChallengesTable, StoredChallenge>,
      ),
      StoredChallenge,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoredUsersTableTableManager get storedUsers =>
      $$StoredUsersTableTableManager(_db, _db.storedUsers);
  $$StoredProductsTableTableManager get storedProducts =>
      $$StoredProductsTableTableManager(_db, _db.storedProducts);
  $$StoredBannersTableTableManager get storedBanners =>
      $$StoredBannersTableTableManager(_db, _db.storedBanners);
  $$StoredShopsTableTableManager get storedShops =>
      $$StoredShopsTableTableManager(_db, _db.storedShops);
  $$StoredMembersTableTableManager get storedMembers =>
      $$StoredMembersTableTableManager(_db, _db.storedMembers);
  $$StoredTiersTableTableManager get storedTiers =>
      $$StoredTiersTableTableManager(_db, _db.storedTiers);
  $$StoredChallengesTableTableManager get storedChallenges =>
      $$StoredChallengesTableTableManager(_db, _db.storedChallenges);
}
