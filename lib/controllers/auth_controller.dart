import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<String?> intentarLogin({required String email, required String password}) async {
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
      return true; // Retorna éxito
    } catch (e) {
      // print("Error al cerrar sesión en controlador: $e");
      return false; // Retorna fallo
    }
  }
}
