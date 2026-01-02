IOS :şuan kullanılmıyor developer süresi bittiği için:  [# pick_champ](https://apps.apple.com/us/app/pick-champ/id6745738449)

https://play.google.com/store/apps/details?id=com.okok.pick_champ

Ürün videosu: https://www.instagram.com/p/DKr9zYcp1bv/

# Pick Champ 🎮

**Pick Champ**, eğlenceli ve etkileşimli quizler oluşturabileceğiniz ve oynayabileceğiniz bir mobil uygulamadır. Flutter ile geliştirilmiş olup, modern state management ve navigation yöntemleri kullanır.

---

## 🚀 Özellikler

- **Farklı Quiz Modları**
  - Bracket (Turnuva sistemi)
  - King of the Hill
  - Blind Ranking
- **Seçim Bazlı Turnuvalar**
  - Quizlerdeki seçim sayısına göre dinamik round/slot seçenekleri
  - Başlangıç için otomatik default seçim
- **Liderlik ve Profil**
  - Kullanıcı profili görüntüleme
  - Leaderboard sistemi
- **Çoklu Dil Desteği**
  - `easy_localization` ile yerelleştirme
- **Gelişmiş Navigation**
  - `auto_route` ile sayfalar arası geçişler
- **State Management**
  - `flutter_riverpod` kullanımı ile quiz state yönetimi
- **Multiplatform Ready**
  - Android ve iOS uyumlu
- **Medya ve Animasyonlar**
  - Lottie animasyonları
  - Resim seçme ve kırpma (`image_picker`, `image_cropper`)

---

## 📦 Kullanılan Paketler

- **State Management & Dependency Injection**
  - `flutter_riverpod`
- **Routing**
  - `auto_route` + `auto_route_generator`
- **Localization**
  - `easy_localization`
- **UI & Design**
  - `flutter_screenutil` (responsive tasarım)
  - `google_fonts`
  - `flutter_svg`
  - `stylish_bottom_bar`
- **Networking**
  - `dio`
  - `connectivity_plus`
- **Storage**
  - `shared_preferences`
  - `path_provider`
- **Authentication**
  - `google_sign_in`
  - `sign_in_with_apple`
- **Others**
  - `permission_handler`, `share_plus`, `flutter_dotenv`

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
