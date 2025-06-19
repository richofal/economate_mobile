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

      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username}, // Ini untuk user_metadata
      );

      // Update profiles table dengan lebih banyak field
      await _supabase.from('profiles').upsert({
        'id': response.user!.id,
        'full_name': username, // Default sama dengan username
        'display_name': username, // Gunakan username sebagai display_name
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      if (response.user == null) {
        throw Exception('Registrasi gagal: User tidak terdaftar');
      }

      // Login otomatis setelah registrasi
      await _supabase.auth.signInWithPassword(email: email, password: password);

      _isLoggedIn = true;
      _currentUser = response.user;
      notifyListeners();
    } on AuthException catch (e) {
      _setError('Error: ${e.message} (Kode: ${e.statusCode})');
    } catch (e) {
      _setError('Error tidak diketahui: $e');
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
        // Hapus navigasi dari sini
      } else {
        throw Exception('Login gagal: Sesi tidak valid');
      }
    } on AuthException catch (e) {
      _setError(e.message);
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
