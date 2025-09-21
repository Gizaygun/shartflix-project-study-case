import 'package:flutter/material.dart';
import 'package:shartflix/core/helpers/bottom_sheet/bottom_sheet_helpers.dart';

final class BottomSheetHelpersImpl implements BottomSheetHelpers {
  @override
  Future<void> offerBottomSheet(BuildContext context, Widget content) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return content;
      },
    );
  }
}
