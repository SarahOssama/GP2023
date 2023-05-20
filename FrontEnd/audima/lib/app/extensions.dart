// here i created these extensions which convert  nullable datatypes to non nullable as we need it in converting nullable responses to non null models as null values can't be in UI

import 'constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orZero() {
    if (this == null) {
      return Constants.zeroDouble;
    } else {
      return this!;
    }
  }
}

extension NonNullMap on Map<String, dynamic>? {
  Map<String, dynamic> orZero() {
    if (this == null) {
      return Constants.zeroMap;
    } else {
      return this!;
    }
  }
}
