# AnimatedLauncherUI

**AnimatedLauncherUI** proporciona una pantalla de lanzamiento animada y personalizable para tus aplicaciones SwiftUI en iOS.

## Características

- Pantalla de inicio animada al lanzar la app.
- Personalización de logo, colores de fondo y animación.
- Integración sencilla a través de Swift Package Manager.
- Compatible con iOS 17 en adelante.
- Opcional: puedes definir parámetros en tu `Info.plist` (imagen y color de fondo).

---

## Instalación

Puedes agregar este paquete con Swift Package Manager:

1. Abre tu proyecto en Xcode.
2. Ve a **File > Add Packages…**
3. Ingresa la URL del repositorio del paquete.
4. Selecciona `AnimatedLauncherUI`.

---

## Configuración en Info.plist (opcional)

Para definir parámetros globales del launcher, añade esto en tu `Info.plist`:

```xml
<key>LauncherScreen</key>
<dict>
    <key>ImageName</key>
    <string>NombreDeTuImagen</string>
    <key>Background Color</key>
    <string>#FFFFFF</string>
</dict>
