import 'package:pick_champ/generated/assets.dart';

final class GetCategoryDetail {
  String img(int categoryId) {
    switch (categoryId) {
      case 1:
        return Assets.imageAnimal;
      case 2:
        return Assets.imageAnime;
      case 3:
        return Assets.imageBeauty;
      case 4:
        return Assets.imageEntertainment;
      case 5:
        return Assets.imageFashion;
      case 6:
        return Assets.imageFood;
      case 7:
        return Assets.imageGaming;
      case 8:
        return Assets.imageHistory;
      case 9:
        return Assets.imageLifestyles;
      case 10:
        return Assets.imageLove;
      case 11:
        return Assets.imageMovie;
      case 12:
        return Assets.imageMusical;
      case 13:
        return Assets.imageNature;
      case 14:
        return Assets.imagePolitics;
      case 15:
        return Assets.imageScience;
      case 16:
        return Assets.imageShop;
      case 17:
        return Assets.imageStreamer;
      case 18:
        return Assets.imageTech;
      case 19:
        return Assets.imageWorking;
      default:
        return Assets.imageUs;
    }
  }

  String name(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'Animals';
      case 2:
        return 'Anime';
      case 3:
        return 'Beauty';
      case 4:
        return 'Entertainment';
      case 5:
        return 'Fashion';
      case 6:
        return 'Food';
      case 7:
        return 'Gaming';
      case 8:
        return 'History';
      case 9:
        return 'Lifestyle';
      case 10:
        return 'Love';
      case 11:
        return 'Movie';
      case 12:
        return 'Music';
      case 13:
        return 'Nature';
      case 14:
        return 'Politics';
      case 15:
        return 'Science';
      case 16:
        return 'Shopping';
      case 17:
        return 'Streamer';
      case 18:
        return 'Tech';
      case 19:
        return 'Work';
      default:
        return 'Unknown Category';
    }
  }
}
