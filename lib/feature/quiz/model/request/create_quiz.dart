import 'dart:io';

final class CreateQuiz {
  CreateQuiz({
    this.userId,
    this.title,
    this.mainLanguage,
    this.description,
    this.categoryId,
    this.isAnonymous,
    this.tags,
    this.selections,
    this.coverImage,
  });

  factory CreateQuiz.empty() => CreateQuiz(
    title: '',
    mainLanguage: '',
    description: '',
    isAnonymous: false,
    tags: [],
    selections: [],
  );

  final String? userId;
  final String? title;
  final bool? isAnonymous;
  final String? mainLanguage;
  final String? description;
  final int? categoryId;
  final List<String>? tags;
  final List<SelectionInput>? selections;
  final File? coverImage;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'mainLanguage': mainLanguage,
      'description': description,
      'categoryId': categoryId,
      'tags': tags,
      'selections': selections?.map((e) => e.toJson()).toList(),
      'coverImage': coverImage?.path,
    };
  }

  CreateQuiz copyWith({
    String? userId,
    String? title,
    String? mainLanguage,
    String? description,
    int? categoryId,
    List<String>? tags,
    List<SelectionInput>? selections,
    File? coverImage,
  }) {
    return CreateQuiz(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      mainLanguage: mainLanguage ?? this.mainLanguage,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      tags: tags ?? this.tags,
      selections: selections ?? this.selections,
      coverImage: coverImage ?? this.coverImage,
    );
  }
}

final class SelectionInput {
  SelectionInput({
    required this.photo,
    required this.description,
    required this.photoFieldName,
  });

  final File photo;
  final String description;
  final String photoFieldName;

  Map<String, dynamic> toJson() {
    return {
      'photo': photo.path,
      'description': description,
      'photoFieldName': photoFieldName,
    };
  }

  SelectionInput copyWith({
    File? photo,
    String? description,
    String? photoFieldName,
  }) {
    return SelectionInput(
      photo: photo ?? this.photo,
      description: description ?? this.description,
      photoFieldName: photoFieldName ?? this.photoFieldName,
    );
  }
}
