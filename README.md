IOS  : [# pick_champ](https://apps.apple.com/us/app/pick-champ/id6745738449)

Android: https://play.google.com/store/apps/details?id=com.okok.pick_champ

Ürün videosu: https://www.instagram.com/p/DKr9zYcp1bv/

Pick Champ 🎮

Pick Champ is a mobile app where you can create and play fun, interactive quizzes. It is developed with Flutter and uses modern state management and navigation techniques.

🚀 Features

Different Quiz Modes

Bracket (Tournament system)

King of the Hill

Blind Ranking

Selection-Based Tournaments

Dynamic round/slot options based on the number of choices in quizzes

Automatic default selection for starting

Leaderboard & Profile

User profile viewing

Leaderboard system

Multilingual Support

Localization with easy_localization

Advanced Navigation

Page transitions with auto_route

State Management

Quiz state management using flutter_riverpod

Multiplatform Ready

Compatible with Android and iOS

Media & Animations

Lottie animations

Image picking and cropping (image_picker, image_cropper)

---

📦 Packages Used

State Management & Dependency Injection
flutter_riverpod
auto_route + auto_route_generator
easy_localization
flutter_screenutil (responsive design)
google_fonts
flutter_svg
stylish_bottom_bar
dio
connectivity_plus
shared_preferences
path_provider
google_sign_in
sign_in_with_apple
permission_handler, share_plus, flutter_dotenv

---

## 🏗 Proje Yapısı
```
lib/
├─ core/ # App temeli, extensions, constants
├─ feature/
│ ├─ auth/ # Giriş ve kullanıcı auth
│ ├─ home/ # Ana sayfa
│ ├─ profile/ # Kullanıcı profili, leaderboards
│ ├─ quiz/ # Quiz modülleri
├─ generated/ # Freezed ve JSON modelleri
├─ main.dart
├─ app.dart
└─ bootstrap.dart
```
