// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mz_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ItemLocalModel extends DataClass implements Insertable<ItemLocalModel> {
  final String id;
  final String title;
  final String author;
  final String subtitle;
  final String poster;
  final String body;
  final bool highlighted;
  final String roomId;
  final String roomTitle;
  final int roomFloor;
  final int roomNumber;
  final String companyTitle;
  final String companyPoster;
  final bool companyStillActive;
  final String companyBody;
  ItemLocalModel(
      {@required this.id,
      @required this.title,
      @required this.author,
      @required this.subtitle,
      @required this.poster,
      @required this.body,
      @required this.highlighted,
      @required this.roomId,
      @required this.roomTitle,
      @required this.roomFloor,
      @required this.roomNumber,
      @required this.companyTitle,
      @required this.companyPoster,
      @required this.companyStillActive,
      @required this.companyBody});
  factory ItemLocalModel.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final intType = db.typeSystem.forDartType<int>();
    return ItemLocalModel(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      subtitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}subtitle']),
      poster:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}poster']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      highlighted: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}highlighted']),
      roomId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}room_id']),
      roomTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}room_title']),
      roomFloor:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}room_floor']),
      roomNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}room_number']),
      companyTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_title']),
      companyPoster: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_poster']),
      companyStillActive: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}company_still_active']),
      companyBody: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}company_body']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || poster != null) {
      map['poster'] = Variable<String>(poster);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || highlighted != null) {
      map['highlighted'] = Variable<bool>(highlighted);
    }
    if (!nullToAbsent || roomId != null) {
      map['room_id'] = Variable<String>(roomId);
    }
    if (!nullToAbsent || roomTitle != null) {
      map['room_title'] = Variable<String>(roomTitle);
    }
    if (!nullToAbsent || roomFloor != null) {
      map['room_floor'] = Variable<int>(roomFloor);
    }
    if (!nullToAbsent || roomNumber != null) {
      map['room_number'] = Variable<int>(roomNumber);
    }
    if (!nullToAbsent || companyTitle != null) {
      map['company_title'] = Variable<String>(companyTitle);
    }
    if (!nullToAbsent || companyPoster != null) {
      map['company_poster'] = Variable<String>(companyPoster);
    }
    if (!nullToAbsent || companyStillActive != null) {
      map['company_still_active'] = Variable<bool>(companyStillActive);
    }
    if (!nullToAbsent || companyBody != null) {
      map['company_body'] = Variable<String>(companyBody);
    }
    return map;
  }

  ItemsTableCompanion toCompanion(bool nullToAbsent) {
    return ItemsTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      poster:
          poster == null && nullToAbsent ? const Value.absent() : Value(poster),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      highlighted: highlighted == null && nullToAbsent
          ? const Value.absent()
          : Value(highlighted),
      roomId:
          roomId == null && nullToAbsent ? const Value.absent() : Value(roomId),
      roomTitle: roomTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(roomTitle),
      roomFloor: roomFloor == null && nullToAbsent
          ? const Value.absent()
          : Value(roomFloor),
      roomNumber: roomNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(roomNumber),
      companyTitle: companyTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(companyTitle),
      companyPoster: companyPoster == null && nullToAbsent
          ? const Value.absent()
          : Value(companyPoster),
      companyStillActive: companyStillActive == null && nullToAbsent
          ? const Value.absent()
          : Value(companyStillActive),
      companyBody: companyBody == null && nullToAbsent
          ? const Value.absent()
          : Value(companyBody),
    );
  }

  factory ItemLocalModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemLocalModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      poster: serializer.fromJson<String>(json['poster']),
      body: serializer.fromJson<String>(json['body']),
      highlighted: serializer.fromJson<bool>(json['highlighted']),
      roomId: serializer.fromJson<String>(json['roomId']),
      roomTitle: serializer.fromJson<String>(json['roomTitle']),
      roomFloor: serializer.fromJson<int>(json['roomFloor']),
      roomNumber: serializer.fromJson<int>(json['roomNumber']),
      companyTitle: serializer.fromJson<String>(json['companyTitle']),
      companyPoster: serializer.fromJson<String>(json['companyPoster']),
      companyStillActive: serializer.fromJson<bool>(json['companyStillActive']),
      companyBody: serializer.fromJson<String>(json['companyBody']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'subtitle': serializer.toJson<String>(subtitle),
      'poster': serializer.toJson<String>(poster),
      'body': serializer.toJson<String>(body),
      'highlighted': serializer.toJson<bool>(highlighted),
      'roomId': serializer.toJson<String>(roomId),
      'roomTitle': serializer.toJson<String>(roomTitle),
      'roomFloor': serializer.toJson<int>(roomFloor),
      'roomNumber': serializer.toJson<int>(roomNumber),
      'companyTitle': serializer.toJson<String>(companyTitle),
      'companyPoster': serializer.toJson<String>(companyPoster),
      'companyStillActive': serializer.toJson<bool>(companyStillActive),
      'companyBody': serializer.toJson<String>(companyBody),
    };
  }

  ItemLocalModel copyWith(
          {String id,
          String title,
          String author,
          String subtitle,
          String poster,
          String body,
          bool highlighted,
          String roomId,
          String roomTitle,
          int roomFloor,
          int roomNumber,
          String companyTitle,
          String companyPoster,
          bool companyStillActive,
          String companyBody}) =>
      ItemLocalModel(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        subtitle: subtitle ?? this.subtitle,
        poster: poster ?? this.poster,
        body: body ?? this.body,
        highlighted: highlighted ?? this.highlighted,
        roomId: roomId ?? this.roomId,
        roomTitle: roomTitle ?? this.roomTitle,
        roomFloor: roomFloor ?? this.roomFloor,
        roomNumber: roomNumber ?? this.roomNumber,
        companyTitle: companyTitle ?? this.companyTitle,
        companyPoster: companyPoster ?? this.companyPoster,
        companyStillActive: companyStillActive ?? this.companyStillActive,
        companyBody: companyBody ?? this.companyBody,
      );
  @override
  String toString() {
    return (StringBuffer('ItemLocalModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('subtitle: $subtitle, ')
          ..write('poster: $poster, ')
          ..write('body: $body, ')
          ..write('highlighted: $highlighted, ')
          ..write('roomId: $roomId, ')
          ..write('roomTitle: $roomTitle, ')
          ..write('roomFloor: $roomFloor, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('companyTitle: $companyTitle, ')
          ..write('companyPoster: $companyPoster, ')
          ..write('companyStillActive: $companyStillActive, ')
          ..write('companyBody: $companyBody')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              author.hashCode,
              $mrjc(
                  subtitle.hashCode,
                  $mrjc(
                      poster.hashCode,
                      $mrjc(
                          body.hashCode,
                          $mrjc(
                              highlighted.hashCode,
                              $mrjc(
                                  roomId.hashCode,
                                  $mrjc(
                                      roomTitle.hashCode,
                                      $mrjc(
                                          roomFloor.hashCode,
                                          $mrjc(
                                              roomNumber.hashCode,
                                              $mrjc(
                                                  companyTitle.hashCode,
                                                  $mrjc(
                                                      companyPoster.hashCode,
                                                      $mrjc(
                                                          companyStillActive
                                                              .hashCode,
                                                          companyBody
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ItemLocalModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.subtitle == this.subtitle &&
          other.poster == this.poster &&
          other.body == this.body &&
          other.highlighted == this.highlighted &&
          other.roomId == this.roomId &&
          other.roomTitle == this.roomTitle &&
          other.roomFloor == this.roomFloor &&
          other.roomNumber == this.roomNumber &&
          other.companyTitle == this.companyTitle &&
          other.companyPoster == this.companyPoster &&
          other.companyStillActive == this.companyStillActive &&
          other.companyBody == this.companyBody);
}

class ItemsTableCompanion extends UpdateCompanion<ItemLocalModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> subtitle;
  final Value<String> poster;
  final Value<String> body;
  final Value<bool> highlighted;
  final Value<String> roomId;
  final Value<String> roomTitle;
  final Value<int> roomFloor;
  final Value<int> roomNumber;
  final Value<String> companyTitle;
  final Value<String> companyPoster;
  final Value<bool> companyStillActive;
  final Value<String> companyBody;
  const ItemsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.poster = const Value.absent(),
    this.body = const Value.absent(),
    this.highlighted = const Value.absent(),
    this.roomId = const Value.absent(),
    this.roomTitle = const Value.absent(),
    this.roomFloor = const Value.absent(),
    this.roomNumber = const Value.absent(),
    this.companyTitle = const Value.absent(),
    this.companyPoster = const Value.absent(),
    this.companyStillActive = const Value.absent(),
    this.companyBody = const Value.absent(),
  });
  ItemsTableCompanion.insert({
    @required String id,
    @required String title,
    @required String author,
    @required String subtitle,
    @required String poster,
    @required String body,
    @required bool highlighted,
    @required String roomId,
    @required String roomTitle,
    @required int roomFloor,
    @required int roomNumber,
    @required String companyTitle,
    @required String companyPoster,
    @required bool companyStillActive,
    @required String companyBody,
  })  : id = Value(id),
        title = Value(title),
        author = Value(author),
        subtitle = Value(subtitle),
        poster = Value(poster),
        body = Value(body),
        highlighted = Value(highlighted),
        roomId = Value(roomId),
        roomTitle = Value(roomTitle),
        roomFloor = Value(roomFloor),
        roomNumber = Value(roomNumber),
        companyTitle = Value(companyTitle),
        companyPoster = Value(companyPoster),
        companyStillActive = Value(companyStillActive),
        companyBody = Value(companyBody);
  static Insertable<ItemLocalModel> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<String> author,
    Expression<String> subtitle,
    Expression<String> poster,
    Expression<String> body,
    Expression<bool> highlighted,
    Expression<String> roomId,
    Expression<String> roomTitle,
    Expression<int> roomFloor,
    Expression<int> roomNumber,
    Expression<String> companyTitle,
    Expression<String> companyPoster,
    Expression<bool> companyStillActive,
    Expression<String> companyBody,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (subtitle != null) 'subtitle': subtitle,
      if (poster != null) 'poster': poster,
      if (body != null) 'body': body,
      if (highlighted != null) 'highlighted': highlighted,
      if (roomId != null) 'room_id': roomId,
      if (roomTitle != null) 'room_title': roomTitle,
      if (roomFloor != null) 'room_floor': roomFloor,
      if (roomNumber != null) 'room_number': roomNumber,
      if (companyTitle != null) 'company_title': companyTitle,
      if (companyPoster != null) 'company_poster': companyPoster,
      if (companyStillActive != null)
        'company_still_active': companyStillActive,
      if (companyBody != null) 'company_body': companyBody,
    });
  }

  ItemsTableCompanion copyWith(
      {Value<String> id,
      Value<String> title,
      Value<String> author,
      Value<String> subtitle,
      Value<String> poster,
      Value<String> body,
      Value<bool> highlighted,
      Value<String> roomId,
      Value<String> roomTitle,
      Value<int> roomFloor,
      Value<int> roomNumber,
      Value<String> companyTitle,
      Value<String> companyPoster,
      Value<bool> companyStillActive,
      Value<String> companyBody}) {
    return ItemsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      subtitle: subtitle ?? this.subtitle,
      poster: poster ?? this.poster,
      body: body ?? this.body,
      highlighted: highlighted ?? this.highlighted,
      roomId: roomId ?? this.roomId,
      roomTitle: roomTitle ?? this.roomTitle,
      roomFloor: roomFloor ?? this.roomFloor,
      roomNumber: roomNumber ?? this.roomNumber,
      companyTitle: companyTitle ?? this.companyTitle,
      companyPoster: companyPoster ?? this.companyPoster,
      companyStillActive: companyStillActive ?? this.companyStillActive,
      companyBody: companyBody ?? this.companyBody,
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
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (poster.present) {
      map['poster'] = Variable<String>(poster.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (highlighted.present) {
      map['highlighted'] = Variable<bool>(highlighted.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (roomTitle.present) {
      map['room_title'] = Variable<String>(roomTitle.value);
    }
    if (roomFloor.present) {
      map['room_floor'] = Variable<int>(roomFloor.value);
    }
    if (roomNumber.present) {
      map['room_number'] = Variable<int>(roomNumber.value);
    }
    if (companyTitle.present) {
      map['company_title'] = Variable<String>(companyTitle.value);
    }
    if (companyPoster.present) {
      map['company_poster'] = Variable<String>(companyPoster.value);
    }
    if (companyStillActive.present) {
      map['company_still_active'] = Variable<bool>(companyStillActive.value);
    }
    if (companyBody.present) {
      map['company_body'] = Variable<String>(companyBody.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('subtitle: $subtitle, ')
          ..write('poster: $poster, ')
          ..write('body: $body, ')
          ..write('highlighted: $highlighted, ')
          ..write('roomId: $roomId, ')
          ..write('roomTitle: $roomTitle, ')
          ..write('roomFloor: $roomFloor, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('companyTitle: $companyTitle, ')
          ..write('companyPoster: $companyPoster, ')
          ..write('companyStillActive: $companyStillActive, ')
          ..write('companyBody: $companyBody')
          ..write(')'))
        .toString();
  }
}

class $ItemsTableTable extends ItemsTable
    with TableInfo<$ItemsTableTable, ItemLocalModel> {
  final GeneratedDatabase _db;
  final String _alias;
  $ItemsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      false,
    );
  }

  final VerificationMeta _subtitleMeta = const VerificationMeta('subtitle');
  GeneratedTextColumn _subtitle;
  @override
  GeneratedTextColumn get subtitle => _subtitle ??= _constructSubtitle();
  GeneratedTextColumn _constructSubtitle() {
    return GeneratedTextColumn(
      'subtitle',
      $tableName,
      false,
    );
  }

  final VerificationMeta _posterMeta = const VerificationMeta('poster');
  GeneratedTextColumn _poster;
  @override
  GeneratedTextColumn get poster => _poster ??= _constructPoster();
  GeneratedTextColumn _constructPoster() {
    return GeneratedTextColumn(
      'poster',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  final VerificationMeta _highlightedMeta =
      const VerificationMeta('highlighted');
  GeneratedBoolColumn _highlighted;
  @override
  GeneratedBoolColumn get highlighted =>
      _highlighted ??= _constructHighlighted();
  GeneratedBoolColumn _constructHighlighted() {
    return GeneratedBoolColumn(
      'highlighted',
      $tableName,
      false,
    );
  }

  final VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  GeneratedTextColumn _roomId;
  @override
  GeneratedTextColumn get roomId => _roomId ??= _constructRoomId();
  GeneratedTextColumn _constructRoomId() {
    return GeneratedTextColumn(
      'room_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _roomTitleMeta = const VerificationMeta('roomTitle');
  GeneratedTextColumn _roomTitle;
  @override
  GeneratedTextColumn get roomTitle => _roomTitle ??= _constructRoomTitle();
  GeneratedTextColumn _constructRoomTitle() {
    return GeneratedTextColumn(
      'room_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _roomFloorMeta = const VerificationMeta('roomFloor');
  GeneratedIntColumn _roomFloor;
  @override
  GeneratedIntColumn get roomFloor => _roomFloor ??= _constructRoomFloor();
  GeneratedIntColumn _constructRoomFloor() {
    return GeneratedIntColumn(
      'room_floor',
      $tableName,
      false,
    );
  }

  final VerificationMeta _roomNumberMeta = const VerificationMeta('roomNumber');
  GeneratedIntColumn _roomNumber;
  @override
  GeneratedIntColumn get roomNumber => _roomNumber ??= _constructRoomNumber();
  GeneratedIntColumn _constructRoomNumber() {
    return GeneratedIntColumn(
      'room_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyTitleMeta =
      const VerificationMeta('companyTitle');
  GeneratedTextColumn _companyTitle;
  @override
  GeneratedTextColumn get companyTitle =>
      _companyTitle ??= _constructCompanyTitle();
  GeneratedTextColumn _constructCompanyTitle() {
    return GeneratedTextColumn(
      'company_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyPosterMeta =
      const VerificationMeta('companyPoster');
  GeneratedTextColumn _companyPoster;
  @override
  GeneratedTextColumn get companyPoster =>
      _companyPoster ??= _constructCompanyPoster();
  GeneratedTextColumn _constructCompanyPoster() {
    return GeneratedTextColumn(
      'company_poster',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyStillActiveMeta =
      const VerificationMeta('companyStillActive');
  GeneratedBoolColumn _companyStillActive;
  @override
  GeneratedBoolColumn get companyStillActive =>
      _companyStillActive ??= _constructCompanyStillActive();
  GeneratedBoolColumn _constructCompanyStillActive() {
    return GeneratedBoolColumn(
      'company_still_active',
      $tableName,
      false,
    );
  }

  final VerificationMeta _companyBodyMeta =
      const VerificationMeta('companyBody');
  GeneratedTextColumn _companyBody;
  @override
  GeneratedTextColumn get companyBody =>
      _companyBody ??= _constructCompanyBody();
  GeneratedTextColumn _constructCompanyBody() {
    return GeneratedTextColumn(
      'company_body',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        author,
        subtitle,
        poster,
        body,
        highlighted,
        roomId,
        roomTitle,
        roomFloor,
        roomNumber,
        companyTitle,
        companyPoster,
        companyStillActive,
        companyBody
      ];
  @override
  $ItemsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'items_table';
  @override
  final String actualTableName = 'items_table';
  @override
  VerificationContext validateIntegrity(Insertable<ItemLocalModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle'], _subtitleMeta));
    } else if (isInserting) {
      context.missing(_subtitleMeta);
    }
    if (data.containsKey('poster')) {
      context.handle(_posterMeta,
          poster.isAcceptableOrUnknown(data['poster'], _posterMeta));
    } else if (isInserting) {
      context.missing(_posterMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body'], _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('highlighted')) {
      context.handle(
          _highlightedMeta,
          highlighted.isAcceptableOrUnknown(
              data['highlighted'], _highlightedMeta));
    } else if (isInserting) {
      context.missing(_highlightedMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(_roomIdMeta,
          roomId.isAcceptableOrUnknown(data['room_id'], _roomIdMeta));
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('room_title')) {
      context.handle(_roomTitleMeta,
          roomTitle.isAcceptableOrUnknown(data['room_title'], _roomTitleMeta));
    } else if (isInserting) {
      context.missing(_roomTitleMeta);
    }
    if (data.containsKey('room_floor')) {
      context.handle(_roomFloorMeta,
          roomFloor.isAcceptableOrUnknown(data['room_floor'], _roomFloorMeta));
    } else if (isInserting) {
      context.missing(_roomFloorMeta);
    }
    if (data.containsKey('room_number')) {
      context.handle(
          _roomNumberMeta,
          roomNumber.isAcceptableOrUnknown(
              data['room_number'], _roomNumberMeta));
    } else if (isInserting) {
      context.missing(_roomNumberMeta);
    }
    if (data.containsKey('company_title')) {
      context.handle(
          _companyTitleMeta,
          companyTitle.isAcceptableOrUnknown(
              data['company_title'], _companyTitleMeta));
    } else if (isInserting) {
      context.missing(_companyTitleMeta);
    }
    if (data.containsKey('company_poster')) {
      context.handle(
          _companyPosterMeta,
          companyPoster.isAcceptableOrUnknown(
              data['company_poster'], _companyPosterMeta));
    } else if (isInserting) {
      context.missing(_companyPosterMeta);
    }
    if (data.containsKey('company_still_active')) {
      context.handle(
          _companyStillActiveMeta,
          companyStillActive.isAcceptableOrUnknown(
              data['company_still_active'], _companyStillActiveMeta));
    } else if (isInserting) {
      context.missing(_companyStillActiveMeta);
    }
    if (data.containsKey('company_body')) {
      context.handle(
          _companyBodyMeta,
          companyBody.isAcceptableOrUnknown(
              data['company_body'], _companyBodyMeta));
    } else if (isInserting) {
      context.missing(_companyBodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemLocalModel map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ItemLocalModel.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ItemsTableTable createAlias(String alias) {
    return $ItemsTableTable(_db, alias);
  }
}

class RoomLocalModel extends DataClass implements Insertable<RoomLocalModel> {
  final String id;
  final String title;
  final int floor;
  final int number;
  final double offsetX;
  final double offsetY;
  RoomLocalModel(
      {@required this.id,
      @required this.title,
      @required this.floor,
      @required this.number,
      this.offsetX,
      this.offsetY});
  factory RoomLocalModel.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return RoomLocalModel(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      floor: intType.mapFromDatabaseResponse(data['${effectivePrefix}floor']),
      number: intType.mapFromDatabaseResponse(data['${effectivePrefix}number']),
      offsetX: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}offset_x']),
      offsetY: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}offset_y']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || floor != null) {
      map['floor'] = Variable<int>(floor);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<int>(number);
    }
    if (!nullToAbsent || offsetX != null) {
      map['offset_x'] = Variable<double>(offsetX);
    }
    if (!nullToAbsent || offsetY != null) {
      map['offset_y'] = Variable<double>(offsetY);
    }
    return map;
  }

  RoomsTableCompanion toCompanion(bool nullToAbsent) {
    return RoomsTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      floor:
          floor == null && nullToAbsent ? const Value.absent() : Value(floor),
      number:
          number == null && nullToAbsent ? const Value.absent() : Value(number),
      offsetX: offsetX == null && nullToAbsent
          ? const Value.absent()
          : Value(offsetX),
      offsetY: offsetY == null && nullToAbsent
          ? const Value.absent()
          : Value(offsetY),
    );
  }

  factory RoomLocalModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RoomLocalModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      floor: serializer.fromJson<int>(json['floor']),
      number: serializer.fromJson<int>(json['number']),
      offsetX: serializer.fromJson<double>(json['offsetX']),
      offsetY: serializer.fromJson<double>(json['offsetY']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'floor': serializer.toJson<int>(floor),
      'number': serializer.toJson<int>(number),
      'offsetX': serializer.toJson<double>(offsetX),
      'offsetY': serializer.toJson<double>(offsetY),
    };
  }

  RoomLocalModel copyWith(
          {String id,
          String title,
          int floor,
          int number,
          double offsetX,
          double offsetY}) =>
      RoomLocalModel(
        id: id ?? this.id,
        title: title ?? this.title,
        floor: floor ?? this.floor,
        number: number ?? this.number,
        offsetX: offsetX ?? this.offsetX,
        offsetY: offsetY ?? this.offsetY,
      );
  @override
  String toString() {
    return (StringBuffer('RoomLocalModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('floor: $floor, ')
          ..write('number: $number, ')
          ..write('offsetX: $offsetX, ')
          ..write('offsetY: $offsetY')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              floor.hashCode,
              $mrjc(number.hashCode,
                  $mrjc(offsetX.hashCode, offsetY.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RoomLocalModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.floor == this.floor &&
          other.number == this.number &&
          other.offsetX == this.offsetX &&
          other.offsetY == this.offsetY);
}

class RoomsTableCompanion extends UpdateCompanion<RoomLocalModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> floor;
  final Value<int> number;
  final Value<double> offsetX;
  final Value<double> offsetY;
  const RoomsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.floor = const Value.absent(),
    this.number = const Value.absent(),
    this.offsetX = const Value.absent(),
    this.offsetY = const Value.absent(),
  });
  RoomsTableCompanion.insert({
    @required String id,
    @required String title,
    @required int floor,
    @required int number,
    this.offsetX = const Value.absent(),
    this.offsetY = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        floor = Value(floor),
        number = Value(number);
  static Insertable<RoomLocalModel> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<int> floor,
    Expression<int> number,
    Expression<double> offsetX,
    Expression<double> offsetY,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (floor != null) 'floor': floor,
      if (number != null) 'number': number,
      if (offsetX != null) 'offset_x': offsetX,
      if (offsetY != null) 'offset_y': offsetY,
    });
  }

  RoomsTableCompanion copyWith(
      {Value<String> id,
      Value<String> title,
      Value<int> floor,
      Value<int> number,
      Value<double> offsetX,
      Value<double> offsetY}) {
    return RoomsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      floor: floor ?? this.floor,
      number: number ?? this.number,
      offsetX: offsetX ?? this.offsetX,
      offsetY: offsetY ?? this.offsetY,
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
    if (floor.present) {
      map['floor'] = Variable<int>(floor.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (offsetX.present) {
      map['offset_x'] = Variable<double>(offsetX.value);
    }
    if (offsetY.present) {
      map['offset_y'] = Variable<double>(offsetY.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('floor: $floor, ')
          ..write('number: $number, ')
          ..write('offsetX: $offsetX, ')
          ..write('offsetY: $offsetY')
          ..write(')'))
        .toString();
  }
}

class $RoomsTableTable extends RoomsTable
    with TableInfo<$RoomsTableTable, RoomLocalModel> {
  final GeneratedDatabase _db;
  final String _alias;
  $RoomsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _floorMeta = const VerificationMeta('floor');
  GeneratedIntColumn _floor;
  @override
  GeneratedIntColumn get floor => _floor ??= _constructFloor();
  GeneratedIntColumn _constructFloor() {
    return GeneratedIntColumn(
      'floor',
      $tableName,
      false,
    );
  }

  final VerificationMeta _numberMeta = const VerificationMeta('number');
  GeneratedIntColumn _number;
  @override
  GeneratedIntColumn get number => _number ??= _constructNumber();
  GeneratedIntColumn _constructNumber() {
    return GeneratedIntColumn(
      'number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _offsetXMeta = const VerificationMeta('offsetX');
  GeneratedRealColumn _offsetX;
  @override
  GeneratedRealColumn get offsetX => _offsetX ??= _constructOffsetX();
  GeneratedRealColumn _constructOffsetX() {
    return GeneratedRealColumn(
      'offset_x',
      $tableName,
      true,
    );
  }

  final VerificationMeta _offsetYMeta = const VerificationMeta('offsetY');
  GeneratedRealColumn _offsetY;
  @override
  GeneratedRealColumn get offsetY => _offsetY ??= _constructOffsetY();
  GeneratedRealColumn _constructOffsetY() {
    return GeneratedRealColumn(
      'offset_y',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, floor, number, offsetX, offsetY];
  @override
  $RoomsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'rooms_table';
  @override
  final String actualTableName = 'rooms_table';
  @override
  VerificationContext validateIntegrity(Insertable<RoomLocalModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('floor')) {
      context.handle(
          _floorMeta, floor.isAcceptableOrUnknown(data['floor'], _floorMeta));
    } else if (isInserting) {
      context.missing(_floorMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number'], _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('offset_x')) {
      context.handle(_offsetXMeta,
          offsetX.isAcceptableOrUnknown(data['offset_x'], _offsetXMeta));
    }
    if (data.containsKey('offset_y')) {
      context.handle(_offsetYMeta,
          offsetY.isAcceptableOrUnknown(data['offset_y'], _offsetYMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoomLocalModel map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RoomLocalModel.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RoomsTableTable createAlias(String alias) {
    return $RoomsTableTable(_db, alias);
  }
}

abstract class _$MZDatabase extends GeneratedDatabase {
  _$MZDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ItemsTableTable _itemsTable;
  $ItemsTableTable get itemsTable => _itemsTable ??= $ItemsTableTable(this);
  $RoomsTableTable _roomsTable;
  $RoomsTableTable get roomsTable => _roomsTable ??= $RoomsTableTable(this);
  ItemsLocalDatasource _itemsLocalDatasource;
  ItemsLocalDatasource get itemsLocalDatasource =>
      _itemsLocalDatasource ??= ItemsLocalDatasource(this as MZDatabase);
  RoomsLocalDatasource _roomsLocalDatasource;
  RoomsLocalDatasource get roomsLocalDatasource =>
      _roomsLocalDatasource ??= RoomsLocalDatasource(this as MZDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [itemsTable, roomsTable];
}
