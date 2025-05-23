import 'package:get/get.dart';

import '../constant/string.dart';
import 'show_coustom_snackbar.dart';

showErrorMessage(String? message) {
  if (message == null) {
    return;
  }
  if (message == '404') {
    showCustomSnackBar(
        message: Please_try_something_else.tr,
        title: No_valid_entry_found.tr,
        isError: true);
  } else {
    showCustomSnackBar(
        message: Please_try_agein_later.tr,
        title: Unexpected_Error.tr,
        isError: true);
  }
}

showNetworkError() {
  showCustomSnackBar(
      message: Ckeck_your_Internet.tr, title: Network_Info.tr, isError: true);
}
