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

### Estructura del proyecto
Arbol de organizacion de archivos del proyecto
lib/
│
├─ models/                        <-- (M) MODELOS DE DATOS
│   └── item_model.dart           <-- Estructura de de datos Promociones
│
│
├─ controllers/                   <-- (C) LÓGICA Y CONEXIÓN A FIREBASE
│   ├─ auth_controller.dart       <-- Métodos: login(), registro(), logout()
│   ├─ send_controller.dart       <-- Métodos: registrarEnvioPromocion()
│   └─ promocion_controller.dart  <-- Métodos: obtenerPromocionesStream(), registrarPromocion(),
│                                     actualizarPromocion(), eliminarPromocion()
│
│
├─ views/                         <-- (V) LA INTERFAZ DE USUARIO (PANTALLAS)
│   ├─ authenticate/
│   │   └─ login_view.dart        <-- Pantalla de inicio de sesión
│   ├─ home/
│   │   └─ home_view.dart         <-- Pantalla que muestra la lista de datos
│   ├─ widgets/
│   │   └─ custom_input.dart      <-- Diseño de campos de texto reutilizables
│   │   └─ custom_form.dart       <-- Diseño de formularios reutilizables
│   │   └─ custom_popup.dart      <-- Diseño de widgets popup reutilizables
│   │   └─ custom_switch.dart     <-- Diseño de switch reutilizable
│   └─ entry/
│       └─ add_promociones_view.dart    <-- Pantalla con el formulario para agregar datos
│
│
├─ firebase_options.dart         <-- Archivo de conf para conectar con firebase
└─ main.dart                     <-- Inicialización de Firebase y arranque de la app