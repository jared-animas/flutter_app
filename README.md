# flutter_app

A new Flutter project.

## Prerrequisitos de Compilación
Para que este proyecto compile correctamente en su entorno local, es necesario generar las credenciales de Firebase:

1. Asegúrese de tener instalado el **Firebase CLI** (`npm install -g firebase-tools`).
2. Inicie sesión en su cuenta de Firebase mediante `firebase login`.
3. Ejecute en la raíz del proyecto:
   ```bash
   flutterfire configure
   ```
4. Seleccione su propio proyecto de Firebase para generar de forma local el archivo obligatorio `lib/firebase_options.dart`.
5. Ejecute `flutter pub get` y proceda a compilar.