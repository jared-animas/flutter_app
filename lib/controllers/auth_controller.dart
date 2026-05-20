import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // Iniciar sesión en Firebase con email y contraseña
  Future<String?> intentarLogin({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.iniciarSesion(email.trim(), password.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No existe un usuario con este correo.';
        case 'wrong-password':
          return 'La contraseña es incorrecta.';
        case 'invalid-email':
          return 'El formato del correo no es válido.';
        default:
          return 'Error de autenticación: ${e.message}';
      }
    } catch (e) {
      return 'Ocurrió un error inesperado. Inténtalo de nuevo.';
    }
  }

  // Cerrar sesión de Firebase
  Future<bool> ejecutarLogout() async {
    try {
      await _authService.cerrarSesion();
      return true;
    } catch (e) {
      // print("Error al cerrar sesión en controlador: $e");
      return false;
    }
  }

  // Registrarse en Firebase con email y contraseña
  Future<String?> intentarRegistro({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.registrarCuenta(email.trim(), password.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Ya existe una cuenta con este correo.';
        case 'invalid-email':
          return 'El formato del correo no es válido.';
        default:
          return 'Error de registro: ${e.message}';
      }
    } catch (e) {
      return 'Ocurrido un error inesperado. Inténtalo de nuevo.';
    }
  }
}
