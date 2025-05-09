enum ReactionType { like, favorite, laugh, shocked, sad, angry }

extension ReactionTypeExtension on ReactionType {
  static ReactionType fromString(String? value) {
    switch (value) {
      case 'like':
        return ReactionType.like;
      case 'favorite':
        return ReactionType.favorite;
      case 'laugh':
        return ReactionType.laugh;
      case 'shocked':
        return ReactionType.shocked;
      case 'sad':
        return ReactionType.sad;
      case 'angry':
        return ReactionType.angry;
      default:
        return ReactionType.like;
    }
  }
}
