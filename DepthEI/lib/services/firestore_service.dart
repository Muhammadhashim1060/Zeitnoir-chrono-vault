import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import '../models/debt.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> ensureUserProfile(UserProfile profile) async {
    final ref = _db.collection('users').doc(profile.uid);
    await ref.set(profile.toMap(), SetOptions(merge: true));
  }

  Stream<UserProfile?> watchUserProfile(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((doc) => doc.exists ? UserProfile.fromMap(doc.id, doc.data()!) : null);
  }

  Stream<List<DebtItem>> watchDebts(String uid) {
    return _db.collection('debts').doc(uid).collection('items').orderBy('priority').snapshots().map(
          (snap) => snap.docs.map((d) => DebtItem.fromMap(d.id, d.data())).toList(),
        );
  }

  Future<void> addDebt(String uid, DebtItem debt) async {
    final ref = _db.collection('debts').doc(uid).collection('items').doc();
    await ref.set(debt.toMap());
  }

  Future<void> deleteDebt(String uid, String debtId) async {
    final ref = _db.collection('debts').doc(uid).collection('items').doc(debtId);
    await ref.delete();
  }

  Future<void> recordTransaction(String uid, Map<String, dynamic> tx) async {
    final ref = _db.collection('transactions').doc(uid).collection('items').doc();
    await ref.set(tx);
  }
}
