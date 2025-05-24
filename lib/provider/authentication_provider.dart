import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  // State management
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _errorMessage;
  User? _currentUser;

  // Form keys
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Getters
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  // Constructor
  AuthenticationProvider() {
    _initializeAuthListener();
  }

  // Initialize auth state listener
  void _initializeAuthListener() {
    _supabase.auth.onAuthStateChange.listen((AuthState data) {
      final Session? session = data.session;
      if (session != null) {
        _isLoggedIn = true;
        _currentUser = session.user;
      } else {
        _isLoggedIn = false;
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  // Sign up with email and password
  // Update the signUp method to automatically sign in after successful registration
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      // 1. Sign up the user
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('User registration failed');
      }

      // 2. Insert profile data with error handling
      try {
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'email': email,
          'username': username,
          'created_at': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        // If profile insertion fails, delete the auth user to keep consistency
        await _supabase.auth.admin.deleteUser(response.user!.id);
        throw Exception('Failed to create user profile');
      }

      // Remove the automatic sign-in part
      _currentUser = response.user;
      _isLoggedIn = false; // Set to false to force sign in after registration
      notifyListeners();
    } on AuthException catch (e) {
      _setError('Registration failed: ${e.message}');
      rethrow;
    } on PostgrestException catch (e) {
      _setError('Profile creation failed: ${e.message}');
      rethrow;
    } catch (e) {
      _setError('An unexpected error occurred');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Sign in with email and password
  Future<void> signIn({required String email, required String password}) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        _isLoggedIn = true;
        _currentUser = response.user;
        notifyListeners();
      }
    } on AuthException catch (e) {
      _setError('Login failed: ${e.message}');
      rethrow;
    } catch (e) {
      _setError('An unexpected error occurred');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      await _supabase.auth.signOut();
      _isLoggedIn = false;
      _currentUser = null;
    } catch (e) {
      _setError('Gagal keluar');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Get current session
  Future<void> getCurrentSession() async {
    try {
      _setLoading(true);
      final Session? session = _supabase.auth.currentSession;

      if (session != null) {
        _currentUser = session.user;
        _isLoggedIn = true;
      } else {
        _isLoggedIn = false;
        _currentUser = null;
      }
    } catch (e) {
      _setError('Gagal memeriksa sesi');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> checkAuthState() async {
    try {
      _setLoading(true);
      final session = _supabase.auth.currentSession;

      if (session != null) {
        _isLoggedIn = true;
        _currentUser = session.user;
      } else {
        _isLoggedIn = false;
        _currentUser = null;
      }
      notifyListeners();
    } catch (e) {
      _setError('Failed to check auth state');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
