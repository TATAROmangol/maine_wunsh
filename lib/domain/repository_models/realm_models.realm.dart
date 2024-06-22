// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class UserNotification extends _UserNotification
    with RealmEntity, RealmObjectBase, RealmObject {
  UserNotification(
    int id,
    String title,
    String body, {
    DateTime? scheduledDate,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'body', body);
    RealmObjectBase.set(this, 'scheduledDate', scheduledDate);
  }

  UserNotification._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get body => RealmObjectBase.get<String>(this, 'body') as String;
  @override
  set body(String value) => RealmObjectBase.set(this, 'body', value);

  @override
  DateTime? get scheduledDate =>
      RealmObjectBase.get<DateTime>(this, 'scheduledDate') as DateTime?;
  @override
  set scheduledDate(DateTime? value) =>
      RealmObjectBase.set(this, 'scheduledDate', value);

  @override
  Stream<RealmObjectChanges<UserNotification>> get changes =>
      RealmObjectBase.getChanges<UserNotification>(this);

  @override
  Stream<RealmObjectChanges<UserNotification>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<UserNotification>(this, keyPaths);

  @override
  UserNotification freeze() =>
      RealmObjectBase.freezeObject<UserNotification>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'body': body.toEJson(),
      'scheduledDate': scheduledDate.toEJson(),
    };
  }

  static EJsonValue _toEJson(UserNotification value) => value.toEJson();
  static UserNotification _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'body': EJsonValue body,
        'scheduledDate': EJsonValue scheduledDate,
      } =>
        UserNotification(
          fromEJson(id),
          fromEJson(title),
          fromEJson(body),
          scheduledDate: fromEJson(scheduledDate),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(UserNotification._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, UserNotification, 'UserNotification', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('body', RealmPropertyType.string),
      SchemaProperty('scheduledDate', RealmPropertyType.timestamp,
          optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CustomUserTheme extends _CustomUserTheme
    with RealmEntity, RealmObjectBase, RealmObject {
  CustomUserTheme({
    int? blocsColor,
    int? borderColor,
    String? imagePath,
    int? textColor,
    int? accentColor,
  }) {
    RealmObjectBase.set(this, 'blocsColor', blocsColor);
    RealmObjectBase.set(this, 'borderColor', borderColor);
    RealmObjectBase.set(this, 'imagePath', imagePath);
    RealmObjectBase.set(this, 'textColor', textColor);
    RealmObjectBase.set(this, 'accentColor', accentColor);
  }

  CustomUserTheme._();

  @override
  int? get blocsColor => RealmObjectBase.get<int>(this, 'blocsColor') as int?;
  @override
  set blocsColor(int? value) => RealmObjectBase.set(this, 'blocsColor', value);

  @override
  int? get borderColor => RealmObjectBase.get<int>(this, 'borderColor') as int?;
  @override
  set borderColor(int? value) =>
      RealmObjectBase.set(this, 'borderColor', value);

  @override
  String? get imagePath =>
      RealmObjectBase.get<String>(this, 'imagePath') as String?;
  @override
  set imagePath(String? value) => RealmObjectBase.set(this, 'imagePath', value);

  @override
  int? get textColor => RealmObjectBase.get<int>(this, 'textColor') as int?;
  @override
  set textColor(int? value) => RealmObjectBase.set(this, 'textColor', value);

  @override
  int? get accentColor => RealmObjectBase.get<int>(this, 'accentColor') as int?;
  @override
  set accentColor(int? value) =>
      RealmObjectBase.set(this, 'accentColor', value);

  @override
  Stream<RealmObjectChanges<CustomUserTheme>> get changes =>
      RealmObjectBase.getChanges<CustomUserTheme>(this);

  @override
  Stream<RealmObjectChanges<CustomUserTheme>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CustomUserTheme>(this, keyPaths);

  @override
  CustomUserTheme freeze() =>
      RealmObjectBase.freezeObject<CustomUserTheme>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'blocsColor': blocsColor.toEJson(),
      'borderColor': borderColor.toEJson(),
      'imagePath': imagePath.toEJson(),
      'textColor': textColor.toEJson(),
      'accentColor': accentColor.toEJson(),
    };
  }

  static EJsonValue _toEJson(CustomUserTheme value) => value.toEJson();
  static CustomUserTheme _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'blocsColor': EJsonValue blocsColor,
        'borderColor': EJsonValue borderColor,
        'imagePath': EJsonValue imagePath,
        'textColor': EJsonValue textColor,
        'accentColor': EJsonValue accentColor,
      } =>
        CustomUserTheme(
          blocsColor: fromEJson(blocsColor),
          borderColor: fromEJson(borderColor),
          imagePath: fromEJson(imagePath),
          textColor: fromEJson(textColor),
          accentColor: fromEJson(accentColor),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CustomUserTheme._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, CustomUserTheme, 'CustomUserTheme', [
      SchemaProperty('blocsColor', RealmPropertyType.int, optional: true),
      SchemaProperty('borderColor', RealmPropertyType.int, optional: true),
      SchemaProperty('imagePath', RealmPropertyType.string, optional: true),
      SchemaProperty('textColor', RealmPropertyType.int, optional: true),
      SchemaProperty('accentColor', RealmPropertyType.int, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class ActiveFolder extends _ActiveFolder
    with RealmEntity, RealmObjectBase, RealmObject {
  ActiveFolder({
    Folder? folder,
  }) {
    RealmObjectBase.set(this, 'folder', folder);
  }

  ActiveFolder._();

  @override
  Folder? get folder => RealmObjectBase.get<Folder>(this, 'folder') as Folder?;
  @override
  set folder(covariant Folder? value) =>
      RealmObjectBase.set(this, 'folder', value);

  @override
  Stream<RealmObjectChanges<ActiveFolder>> get changes =>
      RealmObjectBase.getChanges<ActiveFolder>(this);

  @override
  Stream<RealmObjectChanges<ActiveFolder>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ActiveFolder>(this, keyPaths);

  @override
  ActiveFolder freeze() => RealmObjectBase.freezeObject<ActiveFolder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'folder': folder.toEJson(),
    };
  }

  static EJsonValue _toEJson(ActiveFolder value) => value.toEJson();
  static ActiveFolder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'folder': EJsonValue folder,
      } =>
        ActiveFolder(
          folder: fromEJson(folder),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ActiveFolder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, ActiveFolder, 'ActiveFolder', [
      SchemaProperty('folder', RealmPropertyType.object,
          optional: true, linkTarget: 'Folder'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Folder extends _Folder with RealmEntity, RealmObjectBase, RealmObject {
  Folder(
    String uid,
    int order,
    String name,
  ) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'name', name);
  }

  Folder._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  int get order => RealmObjectBase.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObjectBase.set(this, 'order', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<Folder>> get changes =>
      RealmObjectBase.getChanges<Folder>(this);

  @override
  Stream<RealmObjectChanges<Folder>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Folder>(this, keyPaths);

  @override
  Folder freeze() => RealmObjectBase.freezeObject<Folder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'order': order.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(Folder value) => value.toEJson();
  static Folder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'order': EJsonValue order,
        'name': EJsonValue name,
      } =>
        Folder(
          fromEJson(uid),
          fromEJson(order),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Folder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Folder, 'Folder', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CompleteTasks extends _CompleteTasks
    with RealmEntity, RealmObjectBase, RealmObject {
  CompleteTasks({
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  CompleteTasks._();

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CompleteTasks>> get changes =>
      RealmObjectBase.getChanges<CompleteTasks>(this);

  @override
  Stream<RealmObjectChanges<CompleteTasks>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CompleteTasks>(this, keyPaths);

  @override
  CompleteTasks freeze() => RealmObjectBase.freezeObject<CompleteTasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(CompleteTasks value) => value.toEJson();
  static CompleteTasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'tasks': EJsonValue tasks,
      } =>
        CompleteTasks(
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CompleteTasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, CompleteTasks, 'CompleteTasks', [
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RootTasks extends _RootTasks
    with RealmEntity, RealmObjectBase, RealmObject {
  RootTasks(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  RootTasks._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RootTasks>> get changes =>
      RealmObjectBase.getChanges<RootTasks>(this);

  @override
  Stream<RealmObjectChanges<RootTasks>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RootTasks>(this, keyPaths);

  @override
  RootTasks freeze() => RealmObjectBase.freezeObject<RootTasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(RootTasks value) => value.toEJson();
  static RootTasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        RootTasks(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RootTasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, RootTasks, 'RootTasks', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Subtasks extends _Subtasks
    with RealmEntity, RealmObjectBase, RealmObject {
  Subtasks(
    String uid,
    int countCompleteTasks, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'countCompleteTasks', countCompleteTasks);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  Subtasks._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  int get countCompleteTasks =>
      RealmObjectBase.get<int>(this, 'countCompleteTasks') as int;
  @override
  set countCompleteTasks(int value) =>
      RealmObjectBase.set(this, 'countCompleteTasks', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Subtasks>> get changes =>
      RealmObjectBase.getChanges<Subtasks>(this);

  @override
  Stream<RealmObjectChanges<Subtasks>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Subtasks>(this, keyPaths);

  @override
  Subtasks freeze() => RealmObjectBase.freezeObject<Subtasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'countCompleteTasks': countCompleteTasks.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(Subtasks value) => value.toEJson();
  static Subtasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'countCompleteTasks': EJsonValue countCompleteTasks,
        'tasks': EJsonValue tasks,
      } =>
        Subtasks(
          fromEJson(uid),
          fromEJson(countCompleteTasks),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Subtasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Subtasks, 'Subtasks', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('countCompleteTasks', RealmPropertyType.int),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class SubSubtasks extends _SubSubtasks
    with RealmEntity, RealmObjectBase, RealmObject {
  SubSubtasks(
    String uid,
    int countCompleteTasks, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'countCompleteTasks', countCompleteTasks);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  SubSubtasks._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  int get countCompleteTasks =>
      RealmObjectBase.get<int>(this, 'countCompleteTasks') as int;
  @override
  set countCompleteTasks(int value) =>
      RealmObjectBase.set(this, 'countCompleteTasks', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<SubSubtasks>> get changes =>
      RealmObjectBase.getChanges<SubSubtasks>(this);

  @override
  Stream<RealmObjectChanges<SubSubtasks>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<SubSubtasks>(this, keyPaths);

  @override
  SubSubtasks freeze() => RealmObjectBase.freezeObject<SubSubtasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'countCompleteTasks': countCompleteTasks.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(SubSubtasks value) => value.toEJson();
  static SubSubtasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'countCompleteTasks': EJsonValue countCompleteTasks,
        'tasks': EJsonValue tasks,
      } =>
        SubSubtasks(
          fromEJson(uid),
          fromEJson(countCompleteTasks),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SubSubtasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, SubSubtasks, 'SubSubtasks', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('countCompleteTasks', RealmPropertyType.int),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  Task(
    String uid,
    String name,
    String comment,
    bool isComplete, {
    DateTime? closeData,
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'comment', comment);
    RealmObjectBase.set(this, 'isComplete', isComplete);
    RealmObjectBase.set(this, 'closeData', closeData);
  }

  Task._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get comment => RealmObjectBase.get<String>(this, 'comment') as String;
  @override
  set comment(String value) => RealmObjectBase.set(this, 'comment', value);

  @override
  bool get isComplete => RealmObjectBase.get<bool>(this, 'isComplete') as bool;
  @override
  set isComplete(bool value) => RealmObjectBase.set(this, 'isComplete', value);

  @override
  DateTime? get closeData =>
      RealmObjectBase.get<DateTime>(this, 'closeData') as DateTime?;
  @override
  set closeData(DateTime? value) =>
      RealmObjectBase.set(this, 'closeData', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Stream<RealmObjectChanges<Task>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Task>(this, keyPaths);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'name': name.toEJson(),
      'comment': comment.toEJson(),
      'isComplete': isComplete.toEJson(),
      'closeData': closeData.toEJson(),
    };
  }

  static EJsonValue _toEJson(Task value) => value.toEJson();
  static Task _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'name': EJsonValue name,
        'comment': EJsonValue comment,
        'isComplete': EJsonValue isComplete,
        'closeData': EJsonValue closeData,
      } =>
        Task(
          fromEJson(uid),
          fromEJson(name),
          fromEJson(comment),
          fromEJson(isComplete),
          closeData: fromEJson(closeData),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Task._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('comment', RealmPropertyType.string),
      SchemaProperty('isComplete', RealmPropertyType.bool),
      SchemaProperty('closeData', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
