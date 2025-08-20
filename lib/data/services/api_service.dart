import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔥 User Sign Up with Firebase
  Future<Map<String, dynamic>> signup(
      String name,
      String phone,
      String email,
      String password,
      String referralCode,
      ) async {
    try {
      // Check if a distributor with this referral code exists
      final distributorQuery = await _firestore
          .collection('users')
          .where('phone', isEqualTo: referralCode)
          .limit(1)
          .get();

      String referredBy = '';
      if (distributorQuery.docs.isNotEmpty &&
          distributorQuery.docs.first.data()['role'] == 'distributor') {
        referredBy = referralCode;
      }

      // Create user with Firebase Authentication
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        // Create user document in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'phone': phone,
          'email': email,
          'role': 'user', // Default role is 'user'
          'referredBy': referredBy,
          'createdAt': FieldValue.serverTimestamp(),
          'isActive': true,
        });

        return {
          'success': true,
          'message': 'Registration successful!',
          'uid': user.uid,
        };
      }
      return {'success': false, 'message': 'Failed to create user.'};
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'message': e.message ?? 'Authentication failed.',
      };
    } on FirebaseException catch (e) {
      return {
        'success': false,
        'message': e.message ?? 'Firebase error occurred.',
      };
    } catch (e) {
      return {'success': false, 'message': 'An unknown error occurred.'};
    }
  }

  /// 🔑 User Login with Firebase
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        final userDoc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          return {
            'success': true,
            'message': 'Login successful!',
            'uid': user.uid,
            'role': userDoc.data()?['role'],
          };
        } else {
          await _auth.signOut();
          return {'success': false, 'message': 'User data not found.'};
        }
      }
      return {'success': false, 'message': 'Login failed.'};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': e.message ?? 'Invalid credentials.'};
    } catch (e) {
      return {'success': false, 'message': 'An unknown error occurred.'};
    }
  }

  /// 👥 Get Referred Users for a Distributor
  Future<List<Map<String, dynamic>>> getReferredUsers(
      String distributorPhone,
      ) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('referredBy', isEqualTo: distributorPhone)
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting referred users: $e');
      return [];
    }
  }

  /// 📊 Get All Users for Admin
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting all users: $e');
      return [];
    }
  }
}