



import 'package:maine_app/domain/repository_models/realm_models.dart';

UserNotification convertFirestoreNotificationToRealm(Map<String, dynamic> firestoreNotification) {
  return UserNotification(
    firestoreNotification['id'] as int,
    firestoreNotification['title'] as String,
    firestoreNotification['body'] as String,
    scheduledDate: firestoreNotification['scheduledDate'] as DateTime?,
  );
}

Map<String, dynamic> convertRealmNotificationToFirestore(UserNotification realmNotification) {
  return {
    'id': realmNotification.id,
    'title': realmNotification.title,
    'body': realmNotification.body,
    'scheduledDate': realmNotification.scheduledDate,
  };
}

Folder convertFirestoreFolderToRealm(Map<String, dynamic> firestoreFolder) {
  return Folder(
    firestoreFolder['uid'] as String,
    firestoreFolder['order'] as int,
    firestoreFolder['name'] as String,
  );
}

Task convertFirestoreTaskToRealm(Map<String, dynamic> firestoreTask) {
  return Task(
   firestoreTask['uid'] as String,
    firestoreTask['name'] as String,
    firestoreTask['comment'] as String,
    firestoreTask['isComplete'] as bool,
  );
}

CompleteTasks convertFirestoreCompleteTasksToRealm(Map<String, dynamic> firestoreCompleteTasks) {
  return CompleteTasks(
    tasks: (firestoreCompleteTasks['tasks'] as List)
        .map((task) => convertFirestoreTaskToRealm(task as Map<String, dynamic>))
        .toList(),
  );
}

RootTasks convertFirestoreRootTasksToRealm(Map<String, dynamic> firestoreRootTasks) {
  return RootTasks(
    firestoreRootTasks['uid'] as String,
    tasks: (firestoreRootTasks['tasks'] as List)
        .map((task) => convertFirestoreTaskToRealm(task as Map<String, dynamic>))
        .toList(),
  );
}

Subtasks convertFirestoreSubtasksToRealm(Map<String, dynamic> firestoreSubtasks) {
  return Subtasks(
    firestoreSubtasks['uid'] as String,
    firestoreSubtasks['countCompleteTasks'] as int,
    tasks: (firestoreSubtasks['tasks'] as List)
        .map((task) => convertFirestoreTaskToRealm(task as Map<String, dynamic>))
        .toList(),
  );
}

SubSubtasks convertFirestoreSubSubtasksToRealm(Map<String, dynamic> firestoreSubSubtasks) {
  return SubSubtasks(
    firestoreSubSubtasks['uid'] as String,
    firestoreSubSubtasks['countCompleteTasks'] as int,
    tasks: (firestoreSubSubtasks['tasks'] as List)
        .map((task) => convertFirestoreTaskToRealm(task as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> convertRealmFolderToFirestore(Folder realmFolder) {
  return {
    'uid': realmFolder.uid,
    'order': realmFolder.order,
    'name': realmFolder.name,
  };
}

Map<String, dynamic> convertRealmTaskToFirestore(Task realmTask) {
  return {
    'uid': realmTask.uid,
    'name': realmTask.name,
    'comment': realmTask.comment,
    'isComplete': realmTask.isComplete,
  };
}

Map<String, dynamic> convertRealmCompleteTasksToFirestore(CompleteTasks realmCompleteTasks) {
  return {
    'tasks': realmCompleteTasks.tasks.map(convertRealmTaskToFirestore).toList(),
  };
}

Map<String, dynamic> convertRealmRootTasksToFirestore(RootTasks realmRootTasks) {
  return {
    'uid': realmRootTasks.uid,
    'tasks': realmRootTasks.tasks.map(convertRealmTaskToFirestore).toList(),
  };
}

Map<String, dynamic> convertRealmSubtasksToFirestore(Subtasks realmSubtasks) {
  return {
    'uid': realmSubtasks.uid,
    'countCompleteTasks': realmSubtasks.countCompleteTasks,
    'tasks': realmSubtasks.tasks.map(convertRealmTaskToFirestore).toList(),
  };
}

Map<String, dynamic> convertRealmSubSubtasksToFirestore(SubSubtasks realmSubSubtasks) {
  return {
    'uid': realmSubSubtasks.uid,
    'countCompleteTasks': realmSubSubtasks.countCompleteTasks,
    'tasks': realmSubSubtasks.tasks.map(convertRealmTaskToFirestore).toList(),
  };
}
