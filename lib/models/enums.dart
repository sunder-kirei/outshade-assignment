enum Gender {
  prefer_not_to_say,
  male,
  female,
  other,
}

extension GetGenderTitle on Gender {
  String get title => name
      .split("_")
      .map(
        (subString) => subString[0].toUpperCase() + subString.substring(1),
      )
      .join(" ");
}
