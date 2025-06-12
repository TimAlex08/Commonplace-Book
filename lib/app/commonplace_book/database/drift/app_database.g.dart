// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NotebookItemsTable extends NotebookItems
    with TableInfo<$NotebookItemsTable, NotebookItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotebookItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverImagePathMeta =
      const VerificationMeta('coverImagePath');
  @override
  late final GeneratedColumn<String> coverImagePath = GeneratedColumn<String>(
      'cover_image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backCoverImagePathMeta =
      const VerificationMeta('backCoverImagePath');
  @override
  late final GeneratedColumn<String> backCoverImagePath =
      GeneratedColumn<String>('back_cover_image_path', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isLockedMeta =
      const VerificationMeta('isLocked');
  @override
  late final GeneratedColumn<bool> isLocked = GeneratedColumn<bool>(
      'is_locked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_locked" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        createdAt,
        updatedAt,
        color,
        coverImagePath,
        backCoverImagePath,
        isFavorite,
        isArchived,
        isLocked
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notebook_items';
  @override
  VerificationContext validateIntegrity(Insertable<NotebookItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('cover_image_path')) {
      context.handle(
          _coverImagePathMeta,
          coverImagePath.isAcceptableOrUnknown(
              data['cover_image_path']!, _coverImagePathMeta));
    } else if (isInserting) {
      context.missing(_coverImagePathMeta);
    }
    if (data.containsKey('back_cover_image_path')) {
      context.handle(
          _backCoverImagePathMeta,
          backCoverImagePath.isAcceptableOrUnknown(
              data['back_cover_image_path']!, _backCoverImagePathMeta));
    } else if (isInserting) {
      context.missing(_backCoverImagePathMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('is_locked')) {
      context.handle(_isLockedMeta,
          isLocked.isAcceptableOrUnknown(data['is_locked']!, _isLockedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotebookItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotebookItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      coverImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cover_image_path'])!,
      backCoverImagePath: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}back_cover_image_path'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      isLocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_locked'])!,
    );
  }

  @override
  $NotebookItemsTable createAlias(String alias) {
    return $NotebookItemsTable(attachedDatabase, alias);
  }
}

class NotebookItem extends DataClass implements Insertable<NotebookItem> {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String color;
  final String coverImagePath;
  final String backCoverImagePath;
  final bool isFavorite;
  final bool isArchived;
  final bool isLocked;
  const NotebookItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.color,
      required this.coverImagePath,
      required this.backCoverImagePath,
      required this.isFavorite,
      required this.isArchived,
      required this.isLocked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['color'] = Variable<String>(color);
    map['cover_image_path'] = Variable<String>(coverImagePath);
    map['back_cover_image_path'] = Variable<String>(backCoverImagePath);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_locked'] = Variable<bool>(isLocked);
    return map;
  }

  NotebookItemsCompanion toCompanion(bool nullToAbsent) {
    return NotebookItemsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      color: Value(color),
      coverImagePath: Value(coverImagePath),
      backCoverImagePath: Value(backCoverImagePath),
      isFavorite: Value(isFavorite),
      isArchived: Value(isArchived),
      isLocked: Value(isLocked),
    );
  }

  factory NotebookItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotebookItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      color: serializer.fromJson<String>(json['color']),
      coverImagePath: serializer.fromJson<String>(json['coverImagePath']),
      backCoverImagePath:
          serializer.fromJson<String>(json['backCoverImagePath']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'color': serializer.toJson<String>(color),
      'coverImagePath': serializer.toJson<String>(coverImagePath),
      'backCoverImagePath': serializer.toJson<String>(backCoverImagePath),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isLocked': serializer.toJson<bool>(isLocked),
    };
  }

  NotebookItem copyWith(
          {String? id,
          String? name,
          String? description,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? color,
          String? coverImagePath,
          String? backCoverImagePath,
          bool? isFavorite,
          bool? isArchived,
          bool? isLocked}) =>
      NotebookItem(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        color: color ?? this.color,
        coverImagePath: coverImagePath ?? this.coverImagePath,
        backCoverImagePath: backCoverImagePath ?? this.backCoverImagePath,
        isFavorite: isFavorite ?? this.isFavorite,
        isArchived: isArchived ?? this.isArchived,
        isLocked: isLocked ?? this.isLocked,
      );
  NotebookItem copyWithCompanion(NotebookItemsCompanion data) {
    return NotebookItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      color: data.color.present ? data.color.value : this.color,
      coverImagePath: data.coverImagePath.present
          ? data.coverImagePath.value
          : this.coverImagePath,
      backCoverImagePath: data.backCoverImagePath.present
          ? data.backCoverImagePath.value
          : this.backCoverImagePath,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotebookItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('color: $color, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('backCoverImagePath: $backCoverImagePath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isArchived: $isArchived, ')
          ..write('isLocked: $isLocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      createdAt,
      updatedAt,
      color,
      coverImagePath,
      backCoverImagePath,
      isFavorite,
      isArchived,
      isLocked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotebookItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.color == this.color &&
          other.coverImagePath == this.coverImagePath &&
          other.backCoverImagePath == this.backCoverImagePath &&
          other.isFavorite == this.isFavorite &&
          other.isArchived == this.isArchived &&
          other.isLocked == this.isLocked);
}

class NotebookItemsCompanion extends UpdateCompanion<NotebookItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> color;
  final Value<String> coverImagePath;
  final Value<String> backCoverImagePath;
  final Value<bool> isFavorite;
  final Value<bool> isArchived;
  final Value<bool> isLocked;
  final Value<int> rowid;
  const NotebookItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.color = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    this.backCoverImagePath = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotebookItemsCompanion.insert({
    required String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String color,
    required String coverImagePath,
    required String backCoverImagePath,
    this.isFavorite = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        color = Value(color),
        coverImagePath = Value(coverImagePath),
        backCoverImagePath = Value(backCoverImagePath);
  static Insertable<NotebookItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? color,
    Expression<String>? coverImagePath,
    Expression<String>? backCoverImagePath,
    Expression<bool>? isFavorite,
    Expression<bool>? isArchived,
    Expression<bool>? isLocked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (color != null) 'color': color,
      if (coverImagePath != null) 'cover_image_path': coverImagePath,
      if (backCoverImagePath != null)
        'back_cover_image_path': backCoverImagePath,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isArchived != null) 'is_archived': isArchived,
      if (isLocked != null) 'is_locked': isLocked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotebookItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? color,
      Value<String>? coverImagePath,
      Value<String>? backCoverImagePath,
      Value<bool>? isFavorite,
      Value<bool>? isArchived,
      Value<bool>? isLocked,
      Value<int>? rowid}) {
    return NotebookItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      backCoverImagePath: backCoverImagePath ?? this.backCoverImagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      isArchived: isArchived ?? this.isArchived,
      isLocked: isLocked ?? this.isLocked,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (coverImagePath.present) {
      map['cover_image_path'] = Variable<String>(coverImagePath.value);
    }
    if (backCoverImagePath.present) {
      map['back_cover_image_path'] = Variable<String>(backCoverImagePath.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotebookItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('color: $color, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('backCoverImagePath: $backCoverImagePath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isArchived: $isArchived, ')
          ..write('isLocked: $isLocked, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotebookStructureItemsTable extends NotebookStructureItems
    with TableInfo<$NotebookStructureItemsTable, NotebookStructureItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotebookStructureItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notebookIdMeta =
      const VerificationMeta('notebookId');
  @override
  late final GeneratedColumn<String> notebookId = GeneratedColumn<String>(
      'notebook_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES notebook_items(id) ON DELETE CASCADE');
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES notebook_content(id) ON DELETE CASCADE');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'CHECK (type IN (\'folder\', \'page\'))');
  static const VerificationMeta _folderIdMeta =
      const VerificationMeta('folderId');
  @override
  late final GeneratedColumn<String> folderId = GeneratedColumn<String>(
      'folder_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES notebook_content(id) ON DELETE CASCADE');
  static const VerificationMeta _pageIdMeta = const VerificationMeta('pageId');
  @override
  late final GeneratedColumn<String> pageId = GeneratedColumn<String>(
      'page_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES notebook_content(id) ON DELETE CASCADE');
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
      'depth', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, notebookId, parentId, type, folderId, pageId, position, depth];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notebook_structure_items';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotebookStructureItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('notebook_id')) {
      context.handle(
          _notebookIdMeta,
          notebookId.isAcceptableOrUnknown(
              data['notebook_id']!, _notebookIdMeta));
    } else if (isInserting) {
      context.missing(_notebookIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));
    }
    if (data.containsKey('page_id')) {
      context.handle(_pageIdMeta,
          pageId.isAcceptableOrUnknown(data['page_id']!, _pageIdMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
          _depthMeta, depth.isAcceptableOrUnknown(data['depth']!, _depthMeta));
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotebookStructureItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotebookStructureItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      notebookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notebook_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      folderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folder_id']),
      pageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}page_id']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth'])!,
    );
  }

  @override
  $NotebookStructureItemsTable createAlias(String alias) {
    return $NotebookStructureItemsTable(attachedDatabase, alias);
  }
}

class NotebookStructureItem extends DataClass
    implements Insertable<NotebookStructureItem> {
  final String id;
  final String notebookId;
  final String? parentId;
  final String type;
  final String? folderId;
  final String? pageId;
  final int position;
  final int depth;
  const NotebookStructureItem(
      {required this.id,
      required this.notebookId,
      this.parentId,
      required this.type,
      this.folderId,
      this.pageId,
      required this.position,
      required this.depth});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['notebook_id'] = Variable<String>(notebookId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<String>(folderId);
    }
    if (!nullToAbsent || pageId != null) {
      map['page_id'] = Variable<String>(pageId);
    }
    map['position'] = Variable<int>(position);
    map['depth'] = Variable<int>(depth);
    return map;
  }

  NotebookStructureItemsCompanion toCompanion(bool nullToAbsent) {
    return NotebookStructureItemsCompanion(
      id: Value(id),
      notebookId: Value(notebookId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      type: Value(type),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
      pageId:
          pageId == null && nullToAbsent ? const Value.absent() : Value(pageId),
      position: Value(position),
      depth: Value(depth),
    );
  }

  factory NotebookStructureItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotebookStructureItem(
      id: serializer.fromJson<String>(json['id']),
      notebookId: serializer.fromJson<String>(json['notebookId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      type: serializer.fromJson<String>(json['type']),
      folderId: serializer.fromJson<String?>(json['folderId']),
      pageId: serializer.fromJson<String?>(json['pageId']),
      position: serializer.fromJson<int>(json['position']),
      depth: serializer.fromJson<int>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'notebookId': serializer.toJson<String>(notebookId),
      'parentId': serializer.toJson<String?>(parentId),
      'type': serializer.toJson<String>(type),
      'folderId': serializer.toJson<String?>(folderId),
      'pageId': serializer.toJson<String?>(pageId),
      'position': serializer.toJson<int>(position),
      'depth': serializer.toJson<int>(depth),
    };
  }

  NotebookStructureItem copyWith(
          {String? id,
          String? notebookId,
          Value<String?> parentId = const Value.absent(),
          String? type,
          Value<String?> folderId = const Value.absent(),
          Value<String?> pageId = const Value.absent(),
          int? position,
          int? depth}) =>
      NotebookStructureItem(
        id: id ?? this.id,
        notebookId: notebookId ?? this.notebookId,
        parentId: parentId.present ? parentId.value : this.parentId,
        type: type ?? this.type,
        folderId: folderId.present ? folderId.value : this.folderId,
        pageId: pageId.present ? pageId.value : this.pageId,
        position: position ?? this.position,
        depth: depth ?? this.depth,
      );
  NotebookStructureItem copyWithCompanion(
      NotebookStructureItemsCompanion data) {
    return NotebookStructureItem(
      id: data.id.present ? data.id.value : this.id,
      notebookId:
          data.notebookId.present ? data.notebookId.value : this.notebookId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      type: data.type.present ? data.type.value : this.type,
      folderId: data.folderId.present ? data.folderId.value : this.folderId,
      pageId: data.pageId.present ? data.pageId.value : this.pageId,
      position: data.position.present ? data.position.value : this.position,
      depth: data.depth.present ? data.depth.value : this.depth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotebookStructureItem(')
          ..write('id: $id, ')
          ..write('notebookId: $notebookId, ')
          ..write('parentId: $parentId, ')
          ..write('type: $type, ')
          ..write('folderId: $folderId, ')
          ..write('pageId: $pageId, ')
          ..write('position: $position, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, notebookId, parentId, type, folderId, pageId, position, depth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotebookStructureItem &&
          other.id == this.id &&
          other.notebookId == this.notebookId &&
          other.parentId == this.parentId &&
          other.type == this.type &&
          other.folderId == this.folderId &&
          other.pageId == this.pageId &&
          other.position == this.position &&
          other.depth == this.depth);
}

class NotebookStructureItemsCompanion
    extends UpdateCompanion<NotebookStructureItem> {
  final Value<String> id;
  final Value<String> notebookId;
  final Value<String?> parentId;
  final Value<String> type;
  final Value<String?> folderId;
  final Value<String?> pageId;
  final Value<int> position;
  final Value<int> depth;
  final Value<int> rowid;
  const NotebookStructureItemsCompanion({
    this.id = const Value.absent(),
    this.notebookId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.type = const Value.absent(),
    this.folderId = const Value.absent(),
    this.pageId = const Value.absent(),
    this.position = const Value.absent(),
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotebookStructureItemsCompanion.insert({
    required String id,
    required String notebookId,
    this.parentId = const Value.absent(),
    required String type,
    this.folderId = const Value.absent(),
    this.pageId = const Value.absent(),
    required int position,
    required int depth,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        notebookId = Value(notebookId),
        type = Value(type),
        position = Value(position),
        depth = Value(depth);
  static Insertable<NotebookStructureItem> custom({
    Expression<String>? id,
    Expression<String>? notebookId,
    Expression<String>? parentId,
    Expression<String>? type,
    Expression<String>? folderId,
    Expression<String>? pageId,
    Expression<int>? position,
    Expression<int>? depth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notebookId != null) 'notebook_id': notebookId,
      if (parentId != null) 'parent_id': parentId,
      if (type != null) 'type': type,
      if (folderId != null) 'folder_id': folderId,
      if (pageId != null) 'page_id': pageId,
      if (position != null) 'position': position,
      if (depth != null) 'depth': depth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotebookStructureItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? notebookId,
      Value<String?>? parentId,
      Value<String>? type,
      Value<String?>? folderId,
      Value<String?>? pageId,
      Value<int>? position,
      Value<int>? depth,
      Value<int>? rowid}) {
    return NotebookStructureItemsCompanion(
      id: id ?? this.id,
      notebookId: notebookId ?? this.notebookId,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
      folderId: folderId ?? this.folderId,
      pageId: pageId ?? this.pageId,
      position: position ?? this.position,
      depth: depth ?? this.depth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (notebookId.present) {
      map['notebook_id'] = Variable<String>(notebookId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<String>(folderId.value);
    }
    if (pageId.present) {
      map['page_id'] = Variable<String>(pageId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotebookStructureItemsCompanion(')
          ..write('id: $id, ')
          ..write('notebookId: $notebookId, ')
          ..write('parentId: $parentId, ')
          ..write('type: $type, ')
          ..write('folderId: $folderId, ')
          ..write('pageId: $pageId, ')
          ..write('position: $position, ')
          ..write('depth: $depth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FolderItemsTable extends FolderItems
    with TableInfo<$FolderItemsTable, FolderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FolderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folder_items';
  @override
  VerificationContext validateIntegrity(Insertable<FolderItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FolderItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $FolderItemsTable createAlias(String alias) {
    return $FolderItemsTable(attachedDatabase, alias);
  }
}

class FolderItem extends DataClass implements Insertable<FolderItem> {
  final String id;
  final String title;
  const FolderItem({required this.id, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  FolderItemsCompanion toCompanion(bool nullToAbsent) {
    return FolderItemsCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory FolderItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolderItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  FolderItem copyWith({String? id, String? title}) => FolderItem(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  FolderItem copyWithCompanion(FolderItemsCompanion data) {
    return FolderItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FolderItem(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolderItem && other.id == this.id && other.title == this.title);
}

class FolderItemsCompanion extends UpdateCompanion<FolderItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> rowid;
  const FolderItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FolderItemsCompanion.insert({
    required String id,
    required String title,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<FolderItem> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FolderItemsCompanion copyWith(
      {Value<String>? id, Value<String>? title, Value<int>? rowid}) {
    return FolderItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FolderItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PageItemsTable extends PageItems
    with TableInfo<$PageItemsTable, PageItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PageItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'page_items';
  @override
  VerificationContext validateIntegrity(Insertable<PageItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PageItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PageItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PageItemsTable createAlias(String alias) {
    return $PageItemsTable(attachedDatabase, alias);
  }
}

class PageItem extends DataClass implements Insertable<PageItem> {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PageItem(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PageItemsCompanion toCompanion(bool nullToAbsent) {
    return PageItemsCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PageItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PageItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PageItem copyWith(
          {String? id,
          String? title,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PageItem(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PageItem copyWithCompanion(PageItemsCompanion data) {
    return PageItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PageItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PageItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PageItemsCompanion extends UpdateCompanion<PageItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PageItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PageItemsCompanion.insert({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PageItem> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PageItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PageItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PageItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotebookItemsTable notebookItems = $NotebookItemsTable(this);
  late final $NotebookStructureItemsTable notebookStructureItems =
      $NotebookStructureItemsTable(this);
  late final $FolderItemsTable folderItems = $FolderItemsTable(this);
  late final $PageItemsTable pageItems = $PageItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [notebookItems, notebookStructureItems, folderItems, pageItems];
}

typedef $$NotebookItemsTableCreateCompanionBuilder = NotebookItemsCompanion
    Function({
  required String id,
  required String name,
  required String description,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String color,
  required String coverImagePath,
  required String backCoverImagePath,
  Value<bool> isFavorite,
  Value<bool> isArchived,
  Value<bool> isLocked,
  Value<int> rowid,
});
typedef $$NotebookItemsTableUpdateCompanionBuilder = NotebookItemsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> color,
  Value<String> coverImagePath,
  Value<String> backCoverImagePath,
  Value<bool> isFavorite,
  Value<bool> isArchived,
  Value<bool> isLocked,
  Value<int> rowid,
});

class $$NotebookItemsTableFilterComposer
    extends Composer<_$AppDatabase, $NotebookItemsTable> {
  $$NotebookItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverImagePath => $composableBuilder(
      column: $table.coverImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backCoverImagePath => $composableBuilder(
      column: $table.backCoverImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLocked => $composableBuilder(
      column: $table.isLocked, builder: (column) => ColumnFilters(column));
}

class $$NotebookItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotebookItemsTable> {
  $$NotebookItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverImagePath => $composableBuilder(
      column: $table.coverImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backCoverImagePath => $composableBuilder(
      column: $table.backCoverImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLocked => $composableBuilder(
      column: $table.isLocked, builder: (column) => ColumnOrderings(column));
}

class $$NotebookItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotebookItemsTable> {
  $$NotebookItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get coverImagePath => $composableBuilder(
      column: $table.coverImagePath, builder: (column) => column);

  GeneratedColumn<String> get backCoverImagePath => $composableBuilder(
      column: $table.backCoverImagePath, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<bool> get isLocked =>
      $composableBuilder(column: $table.isLocked, builder: (column) => column);
}

class $$NotebookItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotebookItemsTable,
    NotebookItem,
    $$NotebookItemsTableFilterComposer,
    $$NotebookItemsTableOrderingComposer,
    $$NotebookItemsTableAnnotationComposer,
    $$NotebookItemsTableCreateCompanionBuilder,
    $$NotebookItemsTableUpdateCompanionBuilder,
    (
      NotebookItem,
      BaseReferences<_$AppDatabase, $NotebookItemsTable, NotebookItem>
    ),
    NotebookItem,
    PrefetchHooks Function()> {
  $$NotebookItemsTableTableManager(_$AppDatabase db, $NotebookItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotebookItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotebookItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotebookItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<String> coverImagePath = const Value.absent(),
            Value<String> backCoverImagePath = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<bool> isLocked = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotebookItemsCompanion(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            color: color,
            coverImagePath: coverImagePath,
            backCoverImagePath: backCoverImagePath,
            isFavorite: isFavorite,
            isArchived: isArchived,
            isLocked: isLocked,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            required DateTime createdAt,
            required DateTime updatedAt,
            required String color,
            required String coverImagePath,
            required String backCoverImagePath,
            Value<bool> isFavorite = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<bool> isLocked = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotebookItemsCompanion.insert(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            color: color,
            coverImagePath: coverImagePath,
            backCoverImagePath: backCoverImagePath,
            isFavorite: isFavorite,
            isArchived: isArchived,
            isLocked: isLocked,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotebookItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotebookItemsTable,
    NotebookItem,
    $$NotebookItemsTableFilterComposer,
    $$NotebookItemsTableOrderingComposer,
    $$NotebookItemsTableAnnotationComposer,
    $$NotebookItemsTableCreateCompanionBuilder,
    $$NotebookItemsTableUpdateCompanionBuilder,
    (
      NotebookItem,
      BaseReferences<_$AppDatabase, $NotebookItemsTable, NotebookItem>
    ),
    NotebookItem,
    PrefetchHooks Function()>;
typedef $$NotebookStructureItemsTableCreateCompanionBuilder
    = NotebookStructureItemsCompanion Function({
  required String id,
  required String notebookId,
  Value<String?> parentId,
  required String type,
  Value<String?> folderId,
  Value<String?> pageId,
  required int position,
  required int depth,
  Value<int> rowid,
});
typedef $$NotebookStructureItemsTableUpdateCompanionBuilder
    = NotebookStructureItemsCompanion Function({
  Value<String> id,
  Value<String> notebookId,
  Value<String?> parentId,
  Value<String> type,
  Value<String?> folderId,
  Value<String?> pageId,
  Value<int> position,
  Value<int> depth,
  Value<int> rowid,
});

class $$NotebookStructureItemsTableFilterComposer
    extends Composer<_$AppDatabase, $NotebookStructureItemsTable> {
  $$NotebookStructureItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notebookId => $composableBuilder(
      column: $table.notebookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folderId => $composableBuilder(
      column: $table.folderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pageId => $composableBuilder(
      column: $table.pageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnFilters(column));
}

class $$NotebookStructureItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotebookStructureItemsTable> {
  $$NotebookStructureItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notebookId => $composableBuilder(
      column: $table.notebookId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folderId => $composableBuilder(
      column: $table.folderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pageId => $composableBuilder(
      column: $table.pageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnOrderings(column));
}

class $$NotebookStructureItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotebookStructureItemsTable> {
  $$NotebookStructureItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get notebookId => $composableBuilder(
      column: $table.notebookId, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get folderId =>
      $composableBuilder(column: $table.folderId, builder: (column) => column);

  GeneratedColumn<String> get pageId =>
      $composableBuilder(column: $table.pageId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);
}

class $$NotebookStructureItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotebookStructureItemsTable,
    NotebookStructureItem,
    $$NotebookStructureItemsTableFilterComposer,
    $$NotebookStructureItemsTableOrderingComposer,
    $$NotebookStructureItemsTableAnnotationComposer,
    $$NotebookStructureItemsTableCreateCompanionBuilder,
    $$NotebookStructureItemsTableUpdateCompanionBuilder,
    (
      NotebookStructureItem,
      BaseReferences<_$AppDatabase, $NotebookStructureItemsTable,
          NotebookStructureItem>
    ),
    NotebookStructureItem,
    PrefetchHooks Function()> {
  $$NotebookStructureItemsTableTableManager(
      _$AppDatabase db, $NotebookStructureItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotebookStructureItemsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$NotebookStructureItemsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotebookStructureItemsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> notebookId = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> folderId = const Value.absent(),
            Value<String?> pageId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> depth = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotebookStructureItemsCompanion(
            id: id,
            notebookId: notebookId,
            parentId: parentId,
            type: type,
            folderId: folderId,
            pageId: pageId,
            position: position,
            depth: depth,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String notebookId,
            Value<String?> parentId = const Value.absent(),
            required String type,
            Value<String?> folderId = const Value.absent(),
            Value<String?> pageId = const Value.absent(),
            required int position,
            required int depth,
            Value<int> rowid = const Value.absent(),
          }) =>
              NotebookStructureItemsCompanion.insert(
            id: id,
            notebookId: notebookId,
            parentId: parentId,
            type: type,
            folderId: folderId,
            pageId: pageId,
            position: position,
            depth: depth,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotebookStructureItemsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $NotebookStructureItemsTable,
        NotebookStructureItem,
        $$NotebookStructureItemsTableFilterComposer,
        $$NotebookStructureItemsTableOrderingComposer,
        $$NotebookStructureItemsTableAnnotationComposer,
        $$NotebookStructureItemsTableCreateCompanionBuilder,
        $$NotebookStructureItemsTableUpdateCompanionBuilder,
        (
          NotebookStructureItem,
          BaseReferences<_$AppDatabase, $NotebookStructureItemsTable,
              NotebookStructureItem>
        ),
        NotebookStructureItem,
        PrefetchHooks Function()>;
typedef $$FolderItemsTableCreateCompanionBuilder = FolderItemsCompanion
    Function({
  required String id,
  required String title,
  Value<int> rowid,
});
typedef $$FolderItemsTableUpdateCompanionBuilder = FolderItemsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<int> rowid,
});

class $$FolderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FolderItemsTable> {
  $$FolderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));
}

class $$FolderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FolderItemsTable> {
  $$FolderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));
}

class $$FolderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FolderItemsTable> {
  $$FolderItemsTableAnnotationComposer({
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
}

class $$FolderItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FolderItemsTable,
    FolderItem,
    $$FolderItemsTableFilterComposer,
    $$FolderItemsTableOrderingComposer,
    $$FolderItemsTableAnnotationComposer,
    $$FolderItemsTableCreateCompanionBuilder,
    $$FolderItemsTableUpdateCompanionBuilder,
    (FolderItem, BaseReferences<_$AppDatabase, $FolderItemsTable, FolderItem>),
    FolderItem,
    PrefetchHooks Function()> {
  $$FolderItemsTableTableManager(_$AppDatabase db, $FolderItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FolderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FolderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FolderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FolderItemsCompanion(
            id: id,
            title: title,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<int> rowid = const Value.absent(),
          }) =>
              FolderItemsCompanion.insert(
            id: id,
            title: title,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FolderItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FolderItemsTable,
    FolderItem,
    $$FolderItemsTableFilterComposer,
    $$FolderItemsTableOrderingComposer,
    $$FolderItemsTableAnnotationComposer,
    $$FolderItemsTableCreateCompanionBuilder,
    $$FolderItemsTableUpdateCompanionBuilder,
    (FolderItem, BaseReferences<_$AppDatabase, $FolderItemsTable, FolderItem>),
    FolderItem,
    PrefetchHooks Function()>;
typedef $$PageItemsTableCreateCompanionBuilder = PageItemsCompanion Function({
  required String id,
  required String title,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PageItemsTableUpdateCompanionBuilder = PageItemsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PageItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PageItemsTable> {
  $$PageItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PageItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PageItemsTable> {
  $$PageItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PageItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PageItemsTable> {
  $$PageItemsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PageItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PageItemsTable,
    PageItem,
    $$PageItemsTableFilterComposer,
    $$PageItemsTableOrderingComposer,
    $$PageItemsTableAnnotationComposer,
    $$PageItemsTableCreateCompanionBuilder,
    $$PageItemsTableUpdateCompanionBuilder,
    (PageItem, BaseReferences<_$AppDatabase, $PageItemsTable, PageItem>),
    PageItem,
    PrefetchHooks Function()> {
  $$PageItemsTableTableManager(_$AppDatabase db, $PageItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PageItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PageItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PageItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PageItemsCompanion(
            id: id,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PageItemsCompanion.insert(
            id: id,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PageItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PageItemsTable,
    PageItem,
    $$PageItemsTableFilterComposer,
    $$PageItemsTableOrderingComposer,
    $$PageItemsTableAnnotationComposer,
    $$PageItemsTableCreateCompanionBuilder,
    $$PageItemsTableUpdateCompanionBuilder,
    (PageItem, BaseReferences<_$AppDatabase, $PageItemsTable, PageItem>),
    PageItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotebookItemsTableTableManager get notebookItems =>
      $$NotebookItemsTableTableManager(_db, _db.notebookItems);
  $$NotebookStructureItemsTableTableManager get notebookStructureItems =>
      $$NotebookStructureItemsTableTableManager(
          _db, _db.notebookStructureItems);
  $$FolderItemsTableTableManager get folderItems =>
      $$FolderItemsTableTableManager(_db, _db.folderItems);
  $$PageItemsTableTableManager get pageItems =>
      $$PageItemsTableTableManager(_db, _db.pageItems);
}
