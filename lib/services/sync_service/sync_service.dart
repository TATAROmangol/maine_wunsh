import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/repository.dart';
import 'package:maine_app/domain/repository_models/realm_models.dart';
import 'package:maine_app/services/notification_service.dart';
import 'package:maine_app/services/sync_service/convert_methods.dart';
import 'package:realm/realm.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SyncService {
  SyncService({required this.realm});

  final Realm realm;
  final Repository repository = GetIt.I.get<Repository>();

  Future<void> loadDataFromFirebaseToRealm() async {
    final firebase_auth.User? user =
        firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String userId = user.uid;
    final DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    await NotificationService.cancelAllNotifications();
    final CollectionReference notificationsCollection =
        userDoc.collection('Notifications');
    var snapshotNotifications = await notificationsCollection.get();
    var notifications = snapshotNotifications.docs
        .map((doc) => convertFirestoreNotificationToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference subSubtasksCollection =
        userDoc.collection('SubSubtasks');
    var snapshotSubSubtasks = await subSubtasksCollection.get();
    var subSubtasks = snapshotSubSubtasks.docs
        .map((doc) => convertFirestoreSubSubtasksToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference subtasksCollection =
        userDoc.collection('Subtasks');
    var snapshotSubtasks = await subtasksCollection.get();
    var subtasks = snapshotSubtasks.docs
        .map((doc) =>
            convertFirestoreSubtasksToRealm(doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference rootTasksCollection =
        userDoc.collection('RootTasks');
    var snapshotRootTasks = await rootTasksCollection.get();
    var rootTasks = snapshotRootTasks.docs
        .map((doc) => convertFirestoreRootTasksToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference foldersCollection = userDoc.collection('Folder');
    var snapshotFolders = await foldersCollection.get();
    var folders = snapshotFolders.docs
        .map((doc) =>
            convertFirestoreFolderToRealm(doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference completeTasksCollection =
        userDoc.collection('CompleteTasks');
    var snapshotCompleteTasks = await completeTasksCollection.get();
    var completeTasks = snapshotCompleteTasks.docs
        .map((doc) => convertFirestoreCompleteTasksToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    realm.write(() {
      for (var notification in notifications) {
        realm.add<UserNotification>(notification);
        NotificationService.scheduleNotification(
            title: notification.title,
            body: notification.body,
            scheduledDate: notification.scheduledDate);
      }
      for (var subSubtask in subSubtasks) {
        realm.add<SubSubtasks>(subSubtask);
      }
      for (var subtask in subtasks) {
        realm.add<Subtasks>(subtask);
      }
      for (var rootTask in rootTasks) {
        realm.add<RootTasks>(rootTask);
      }
      for (var folder in folders) {
        realm.add<Folder>(folder);
      }
      for (var completeTask in completeTasks) {
        realm.add<CompleteTasks>(completeTask);
      }
    });
  }

  Future<void> updateDataBetweenFirebaseAndRealm() async {
    final firebase_auth.User? user =
        firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String userId = user.uid;
    final DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Получаем данные из Realm
    var realmNotifications = realm.all<UserNotification>().toList();
    var realmSubSubtasks = realm.all<SubSubtasks>().toList();
    var realmSubtasks = realm.all<Subtasks>().toList();
    var realmRootTasks = realm.all<RootTasks>().toList();
    var realmFolders = realm.all<Folder>().toList();
    var realmCompleteTasks = realm.all<CompleteTasks>().toList();

    // Удаляем старые документы из коллекций
    await _clearFirestoreCollection(userDoc.collection('Notifications'));
    await NotificationService.cancelAllNotifications();
    await _clearFirestoreCollection(userDoc.collection('SubSubtasks'));
    await _clearFirestoreCollection(userDoc.collection('Subtasks'));
    await _clearFirestoreCollection(userDoc.collection('RootTasks'));
    await _clearFirestoreCollection(userDoc.collection('Folder'));
    await _clearFirestoreCollection(userDoc.collection('CompleteTasks'));

    // Обновляем уведомления
    for (var notification in realmNotifications) {
      // Check if notification has a scheduled date and if it's in the future
      if (notification.scheduledDate != null &&
          notification.scheduledDate!.isAfter(DateTime.now())) {
        // Save notification data to Firestore
        await userDoc
            .collection('Notifications')
            .doc(notification.id.toString())
            .set(convertRealmNotificationToFirestore(notification));

        // Schedule the notification using NotificationService
        NotificationService.scheduleNotification(
          title: notification.title,
          body: notification.body,
          scheduledDate: notification.scheduledDate,
        );
      }
    }

    // Обновляем под-подзадачи
    for (var subSubtask in realmSubSubtasks) {
      await userDoc
          .collection('SubSubtasks')
          .doc(subSubtask.uid)
          .set(convertRealmSubSubtasksToFirestore(subSubtask));
    }

    // Обновляем подзадачи
    for (var subtask in realmSubtasks) {
      await userDoc
          .collection('Subtasks')
          .doc(subtask.uid)
          .set(convertRealmSubtasksToFirestore(subtask));
    }

    // Обновляем корневые задачи
    for (var rootTask in realmRootTasks) {
      await userDoc
          .collection('RootTasks')
          .doc(rootTask.uid)
          .set(convertRealmRootTasksToFirestore(rootTask));
    }

    // Обновляем папки
    for (var folder in realmFolders) {
      await userDoc
          .collection('Folder')
          .doc(folder.uid)
          .set(convertRealmFolderToFirestore(folder));
    }

    // Обновляем завершенные задачи
    if (realmCompleteTasks.isNotEmpty) {
      var completeTasks = realmCompleteTasks.first;
      await userDoc
          .collection('CompleteTasks')
          .doc('completeTasks')
          .set(convertRealmCompleteTasksToFirestore(completeTasks));
    }
  }

  Future<void> _clearFirestoreCollection(CollectionReference collection) async {
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> clearRealmData() async {
    repository.goClearRepository();
    NotificationService.cancelAllNotifications();
  }
}
