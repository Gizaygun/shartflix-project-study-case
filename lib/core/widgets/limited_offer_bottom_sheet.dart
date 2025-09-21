import 'package:flutter/material.dart';

import 'bottom_sheet/coin_offer_sheet.dart';

@Deprecated('Use showCoinOfferSheet instead')
Future<String?> showLimitedOfferSheet(BuildContext context) {

  return showCoinOfferSheet(context);
}
