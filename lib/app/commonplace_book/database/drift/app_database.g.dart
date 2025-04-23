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

class $NotebookContentTableTable extends NotebookContentTable
    with TableInfo<$NotebookContentTableTable, NotebookContentTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotebookContentTableTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, notebookId, parentId, position, depth, folderId, pageId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notebook_content_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotebookContentTableData> instance,
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
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));
    }
    if (data.containsKey('page_id')) {
      context.handle(_pageIdMeta,
          pageId.isAcceptableOrUnknown(data['page_id']!, _pageIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotebookContentTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotebookContentTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      notebookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notebook_id'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth'])!,
      folderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folder_id']),
      pageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}page_id']),
    );
  }

  @override
  $NotebookContentTableTable createAlias(String alias) {
    return $NotebookContentTableTable(attachedDatabase, alias);
  }
}

class NotebookContentTableData extends DataClass
    implements Insertable<NotebookContentTableData> {
  final String id;
  final String notebookId;
  final String? parentId;
  final int position;
  final int depth;
  final String? folderId;
  final String? pageId;
  const NotebookContentTableData(
      {required this.id,
      required this.notebookId,
      this.parentId,
      required this.position,
      required this.depth,
      this.folderId,
      this.pageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['notebook_id'] = Variable<String>(notebookId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['position'] = Variable<int>(position);
    map['depth'] = Variable<int>(depth);
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<String>(folderId);
    }
    if (!nullToAbsent || pageId != null) {
      map['page_id'] = Variable<String>(pageId);
    }
    return map;
  }

  NotebookContentTableCompanion toCompanion(bool nullToAbsent) {
    return NotebookContentTableCompanion(
      id: Value(id),
      notebookId: Value(notebookId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      position: Value(position),
      depth: Value(depth),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
      pageId:
          pageId == null && nullToAbsent ? const Value.absent() : Value(pageId),
    );
  }

  factory NotebookContentTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotebookContentTableData(
      id: serializer.fromJson<String>(json['id']),
      notebookId: serializer.fromJson<String>(json['notebookId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      position: serializer.fromJson<int>(json['position']),
      depth: serializer.fromJson<int>(json['depth']),
      folderId: serializer.fromJson<String?>(json['folderId']),
      pageId: serializer.fromJson<String?>(json['pageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'notebookId': serializer.toJson<String>(notebookId),
      'parentId': serializer.toJson<String?>(parentId),
      'position': serializer.toJson<int>(position),
      'depth': serializer.toJson<int>(depth),
      'folderId': serializer.toJson<String?>(folderId),
      'pageId': serializer.toJson<String?>(pageId),
    };
  }

  NotebookContentTableData copyWith(
          {String? id,
          String? notebookId,
          Value<String?> parentId = const Value.absent(),
          int? position,
          int? depth,
          Value<String?> folderId = const Value.absent(),
          Value<String?> pageId = const Value.absent()}) =>
      NotebookContentTableData(
        id: id ?? this.id,
        notebookId: notebookId ?? this.notebookId,
        parentId: parentId.present ? parentId.value : this.parentId,
        position: position ?? this.position,
        depth: depth ?? this.depth,
        folderId: folderId.present ? folderId.value : this.folderId,
        pageId: pageId.present ? pageId.value : this.pageId,
      );
  NotebookContentTableData copyWithCompanion(
      NotebookContentTableCompanion data) {
    return NotebookContentTableData(
      id: data.id.present ? data.id.value : this.id,
      notebookId:
          data.notebookId.present ? data.notebookId.value : this.notebookId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      position: data.position.present ? data.position.value : this.position,
      depth: data.depth.present ? data.depth.value : this.depth,
      folderId: data.folderId.present ? data.folderId.value : this.folderId,
      pageId: data.pageId.present ? data.pageId.value : this.pageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotebookContentTableData(')
          ..write('id: $id, ')
          ..write('notebookId: $notebookId, ')
          ..write('parentId: $parentId, ')
          ..write('position: $position, ')
          ..write('depth: $depth, ')
          ..write('folderId: $folderId, ')
          ..write('pageId: $pageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, notebookId, parentId, position, depth, folderId, pageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotebookContentTableData &&
          other.id == this.id &&
          other.notebookId == this.notebookId &&
          other.parentId == this.parentId &&
          other.position == this.position &&
          other.depth == this.depth &&
          other.folderId == this.folderId &&
          other.pageId == this.pageId);
}

class NotebookContentTableCompanion
    extends UpdateCompanion<NotebookContentTableData> {
  final Value<String> id;
  final Value<String> notebookId;
  final Value<String?> parentId;
  final Value<int> position;
  final Value<int> depth;
  final Value<String?> folderId;
  final Value<String?> pageId;
  final Value<int> rowid;
  const NotebookContentTableCompanion({
    this.id = const Value.absent(),
    this.notebookId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.position = const Value.absent(),
    this.depth = const Value.absent(),
    this.folderId = const Value.absent(),
    this.pageId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotebookContentTableCompanion.insert({
    required String id,
    required String notebookId,
    this.parentId = const Value.absent(),
    required int position,
    required int depth,
    this.folderId = const Value.absent(),
    this.pageId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        notebookId = Value(notebookId),
        position = Value(position),
        depth = Value(depth);
  static Insertable<NotebookContentTableData> custom({
    Expression<String>? id,
    Expression<String>? notebookId,
    Expression<String>? parentId,
    Expression<int>? position,
    Expression<int>? depth,
    Expression<String>? folderId,
    Expression<String>? pageId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notebookId != null) 'notebook_id': notebookId,
      if (parentId != null) 'parent_id': parentId,
      if (position != null) 'position': position,
      if (depth != null) 'depth': depth,
      if (folderId != null) 'folder_id': folderId,
      if (pageId != null) 'page_id': pageId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotebookContentTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? notebookId,
      Value<String?>? parentId,
      Value<int>? position,
      Value<int>? depth,
      Value<String?>? folderId,
      Value<String?>? pageId,
      Value<int>? rowid}) {
    return NotebookContentTableCompanion(
      id: id ?? this.id,
      notebookId: notebookId ?? this.notebookId,
      parentId: parentId ?? this.parentId,
      position: position ?? this.position,
      depth: depth ?? this.depth,
      folderId: folderId ?? this.folderId,
      pageId: pageId ?? this.pageId,
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
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<String>(folderId.value);
    }
    if (pageId.present) {
      map['page_id'] = Variable<String>(pageId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotebookContentTableCompanion(')
          ..write('id: $id, ')
          ..write('notebookId: $notebookId, ')
          ..write('parentId: $parentId, ')
          ..write('position: $position, ')
          ..write('depth: $depth, ')
          ..write('folderId: $folderId, ')
          ..write('pageId: $pageId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<Folder> instance,
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
  Folder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Folder(
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
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(attachedDatabase, alias);
  }
}

class Folder extends DataClass implements Insertable<Folder> {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Folder(
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

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Folder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Folder(
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

  Folder copyWith(
          {String? id,
          String? title,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Folder(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Folder copyWithCompanion(FoldersCompanion data) {
    return Folder(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Folder(')
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
      (other is Folder &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoldersCompanion extends UpdateCompanion<Folder> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoldersCompanion.insert({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Folder> custom({
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

  FoldersCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return FoldersCompanion(
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
    return (StringBuffer('FoldersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PageTable extends Page with TableInfo<$PageTable, PageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PageTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'page';
  @override
  VerificationContext validateIntegrity(Insertable<PageData> instance,
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
  PageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PageData(
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
  $PageTable createAlias(String alias) {
    return $PageTable(attachedDatabase, alias);
  }
}

class PageData extends DataClass implements Insertable<PageData> {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PageData(
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

  PageCompanion toCompanion(bool nullToAbsent) {
    return PageCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PageData(
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

  PageData copyWith(
          {String? id,
          String? title,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PageData(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PageData copyWithCompanion(PageCompanion data) {
    return PageData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PageData(')
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
      (other is PageData &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PageCompanion extends UpdateCompanion<PageData> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PageCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PageCompanion.insert({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PageData> custom({
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

  PageCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PageCompanion(
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
    return (StringBuffer('PageCompanion(')
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
  late final $NotebookContentTableTable notebookContentTable =
      $NotebookContentTableTable(this);
  late final $FoldersTable folders = $FoldersTable(this);
  late final $PageTable page = $PageTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [notebookItems, notebookContentTable, folders, page];
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
typedef $$NotebookContentTableTableCreateCompanionBuilder
    = NotebookContentTableCompanion Function({
  required String id,
  required String notebookId,
  Value<String?> parentId,
  required int position,
  required int depth,
  Value<String?> folderId,
  Value<String?> pageId,
  Value<int> rowid,
});
typedef $$NotebookContentTableTableUpdateCompanionBuilder
    = NotebookContentTableCompanion Function({
  Value<String> id,
  Value<String> notebookId,
  Value<String?> parentId,
  Value<int> position,
  Value<int> depth,
  Value<String?> folderId,
  Value<String?> pageId,
  Value<int> rowid,
});

class $$NotebookContentTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotebookContentTableTable> {
  $$NotebookContentTableTableFilterComposer({
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

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folderId => $composableBuilder(
      column: $table.folderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pageId => $composableBuilder(
      column: $table.pageId, builder: (column) => ColumnFilters(column));
}

class $$NotebookContentTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotebookContentTableTable> {
  $$NotebookContentTableTableOrderingComposer({
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

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get depth => $composableBuilder(
      column: $table.depth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folderId => $composableBuilder(
      column: $table.folderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pageId => $composableBuilder(
      column: $table.pageId, builder: (column) => ColumnOrderings(column));
}

class $$NotebookContentTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotebookContentTableTable> {
  $$NotebookContentTableTableAnnotationComposer({
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

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<String> get folderId =>
      $composableBuilder(column: $table.folderId, builder: (column) => column);

  GeneratedColumn<String> get pageId =>
      $composableBuilder(column: $table.pageId, builder: (column) => column);
}

class $$NotebookContentTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotebookContentTableTable,
    NotebookContentTableData,
    $$NotebookContentTableTableFilterComposer,
    $$NotebookContentTableTableOrderingComposer,
    $$NotebookContentTableTableAnnotationComposer,
    $$NotebookContentTableTableCreateCompanionBuilder,
    $$NotebookContentTableTableUpdateCompanionBuilder,
    (
      NotebookContentTableData,
      BaseReferences<_$AppDatabase, $NotebookContentTableTable,
          NotebookContentTableData>
    ),
    NotebookContentTableData,
    PrefetchHooks Function()> {
  $$NotebookContentTableTableTableManager(
      _$AppDatabase db, $NotebookContentTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotebookContentTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotebookContentTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotebookContentTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> notebookId = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> depth = const Value.absent(),
            Value<String?> folderId = const Value.absent(),
            Value<String?> pageId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotebookContentTableCompanion(
            id: id,
            notebookId: notebookId,
            parentId: parentId,
            position: position,
            depth: depth,
            folderId: folderId,
            pageId: pageId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String notebookId,
            Value<String?> parentId = const Value.absent(),
            required int position,
            required int depth,
            Value<String?> folderId = const Value.absent(),
            Value<String?> pageId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotebookContentTableCompanion.insert(
            id: id,
            notebookId: notebookId,
            parentId: parentId,
            position: position,
            depth: depth,
            folderId: folderId,
            pageId: pageId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotebookContentTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $NotebookContentTableTable,
        NotebookContentTableData,
        $$NotebookContentTableTableFilterComposer,
        $$NotebookContentTableTableOrderingComposer,
        $$NotebookContentTableTableAnnotationComposer,
        $$NotebookContentTableTableCreateCompanionBuilder,
        $$NotebookContentTableTableUpdateCompanionBuilder,
        (
          NotebookContentTableData,
          BaseReferences<_$AppDatabase, $NotebookContentTableTable,
              NotebookContentTableData>
        ),
        NotebookContentTableData,
        PrefetchHooks Function()>;
typedef $$FoldersTableCreateCompanionBuilder = FoldersCompanion Function({
  required String id,
  required String title,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$FoldersTableUpdateCompanionBuilder = FoldersCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$FoldersTableFilterComposer
    extends Composer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableFilterComposer({
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

class $$FoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableOrderingComposer({
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

class $$FoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableAnnotationComposer({
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

class $$FoldersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableAnnotationComposer,
    $$FoldersTableCreateCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder,
    (Folder, BaseReferences<_$AppDatabase, $FoldersTable, Folder>),
    Folder,
    PrefetchHooks Function()> {
  $$FoldersTableTableManager(_$AppDatabase db, $FoldersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoldersCompanion(
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
              FoldersCompanion.insert(
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

typedef $$FoldersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableAnnotationComposer,
    $$FoldersTableCreateCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder,
    (Folder, BaseReferences<_$AppDatabase, $FoldersTable, Folder>),
    Folder,
    PrefetchHooks Function()>;
typedef $$PageTableCreateCompanionBuilder = PageCompanion Function({
  required String id,
  required String title,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PageTableUpdateCompanionBuilder = PageCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PageTableFilterComposer extends Composer<_$AppDatabase, $PageTable> {
  $$PageTableFilterComposer({
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

class $$PageTableOrderingComposer extends Composer<_$AppDatabase, $PageTable> {
  $$PageTableOrderingComposer({
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

class $$PageTableAnnotationComposer
    extends Composer<_$AppDatabase, $PageTable> {
  $$PageTableAnnotationComposer({
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

class $$PageTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PageTable,
    PageData,
    $$PageTableFilterComposer,
    $$PageTableOrderingComposer,
    $$PageTableAnnotationComposer,
    $$PageTableCreateCompanionBuilder,
    $$PageTableUpdateCompanionBuilder,
    (PageData, BaseReferences<_$AppDatabase, $PageTable, PageData>),
    PageData,
    PrefetchHooks Function()> {
  $$PageTableTableManager(_$AppDatabase db, $PageTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PageTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PageCompanion(
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
              PageCompanion.insert(
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

typedef $$PageTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PageTable,
    PageData,
    $$PageTableFilterComposer,
    $$PageTableOrderingComposer,
    $$PageTableAnnotationComposer,
    $$PageTableCreateCompanionBuilder,
    $$PageTableUpdateCompanionBuilder,
    (PageData, BaseReferences<_$AppDatabase, $PageTable, PageData>),
    PageData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotebookItemsTableTableManager get notebookItems =>
      $$NotebookItemsTableTableManager(_db, _db.notebookItems);
  $$NotebookContentTableTableTableManager get notebookContentTable =>
      $$NotebookContentTableTableTableManager(_db, _db.notebookContentTable);
  $$FoldersTableTableManager get folders =>
      $$FoldersTableTableManager(_db, _db.folders);
  $$PageTableTableManager get page => $$PageTableTableManager(_db, _db.page);
}
