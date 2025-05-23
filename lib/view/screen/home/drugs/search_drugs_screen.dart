import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/string.dart';
import '../../../../core/functions/get_device_locale.dart';
import 'drugs_detail_screen.dart';
import 'widget/cart_widget.dart';

class DrugsSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Get.focusScope!.unfocus();
          await Future.delayed(const Duration(milliseconds: 400));
          Get.close(1);
        },
        icon: Icon(getdeviceLocale(
            en: Icons.arrow_back_ios_new, ar: Icons.arrow_back_ios)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchWidget(query: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchWidget(query: query);
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GetBuilder<DrugsController>(builder: (controller) {
        final drigsData = controller.filter(query);

        return drigsData == null
            ? Center(child: Text(No_data.tr))
            : HandlingDataView(
                statusReq: controller.statusReq,
                widget: drigsData.isEmpty
                    ? Center(child: Text(No_Match_Fond.tr))
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: drigsData.isEmpty
                            ? 1
                            : drigsData.length > 25
                                ? 25
                                : drigsData.length,
                        itemBuilder: (context, index) {
                          // final drigsData = controller.drigsData2!.product!;
                          return controller.drigsData2 == null
                              ? Center(child: Text(No_Match_Fond.tr))
                              : CartWidget(
                                  onTapIcon: () {
                                    controller.addToCart(drigsData[index]);
                                  },
                                  onTap: () {
                                    Get.focusScope!.unfocus();

                                    Get.to(
                                      () => DrugsDetailScrren(
                                          product: drigsData[index]),
                                    );
                                  },
                                  drigs: drigsData[index],
                                  buttomIcon: ImageAssetSVG.addIcon,
                                );
                        }),
              );
      }),
    );
  }
}
