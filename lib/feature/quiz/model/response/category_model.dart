import 'package:easy_localization/easy_localization.dart';
import 'package:pick_champ/generated/assets.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

final class CategoryModel {
  CategoryModel(this.id, this.photo, this.name);
  final int id;
  final String photo;
  final String name;
}

final class Categories {
  final List<CategoryModel> categories = [
    CategoryModel(1, Assets.imageAnimal, LocaleKeys.category_animals.tr()),
    CategoryModel(2, Assets.imageAnime, LocaleKeys.category_anime.tr()),
    CategoryModel(3, Assets.imageBeauty, LocaleKeys.category_beauty.tr()),
    CategoryModel(
      4,
      Assets.imageEntertainment,
      LocaleKeys.category_entertainment.tr(),
    ),
    CategoryModel(
      5,
      Assets.imageFashion,
      LocaleKeys.category_fashion.tr(),
    ),
    CategoryModel(6, Assets.imageFood, LocaleKeys.category_food.tr()),
    CategoryModel(7, Assets.imageGaming, LocaleKeys.category_gaming.tr()),
    CategoryModel(
      8,
      Assets.imageHistory,
      LocaleKeys.category_history.tr(),
    ),
    CategoryModel(
      9,
      Assets.imageLifestyles,
      LocaleKeys.category_lifestyle.tr(),
    ),
    CategoryModel(10, Assets.imageLove, LocaleKeys.category_love.tr()),
    CategoryModel(11, Assets.imageMovie, LocaleKeys.category_movie.tr()),
    CategoryModel(12, Assets.imageMusical, LocaleKeys.category_music.tr()),
    CategoryModel(13, Assets.imageNature, LocaleKeys.category_nature.tr()),
    CategoryModel(
      14,
      Assets.imagePolitics,
      LocaleKeys.category_politics.tr(),
    ),
    CategoryModel(
      15,
      Assets.imageScience,
      LocaleKeys.category_science.tr(),
    ),
    CategoryModel(16, Assets.imageShop, LocaleKeys.category_shopping.tr()),
    CategoryModel(
      17,
      Assets.imageStreamer,
      LocaleKeys.category_streamer.tr(),
    ),
    CategoryModel(18, Assets.imageTech, LocaleKeys.category_tech.tr()),
    CategoryModel(19, Assets.imageWorking, LocaleKeys.category_work.tr()),
  ];
}
