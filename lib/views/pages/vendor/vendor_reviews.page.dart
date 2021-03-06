import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_reviews.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/review.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor.i18n.dart';

class VendorReviewsPage extends StatefulWidget {
  const VendorReviewsPage(this.vendor, {Key key}) : super(key: key);

  final Vendor vendor;
  @override
  _VendorReviewsPageState createState() => _VendorReviewsPageState();
}

class _VendorReviewsPageState extends State<VendorReviewsPage> {
  GlobalKey pageKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      showLeadingAction: true,
      title: "${widget.vendor.name} " + "Reviews".i18n,
      key: pageKey,
      body: ViewModelBuilder<VendorReviewsViewModel>.reactive(
        viewModelBuilder: () => VendorReviewsViewModel(context, widget.vendor),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return CustomListView(
            canPullUp: true,
            canRefresh: true,
            refreshController: vm.refreshController,
            onRefresh: vm.getVendorReviews,
            onLoading: () => vm.getVendorReviews(initialLoading: false),
            //
            isLoading: vm.isBusy,
            loadingWidget: BusyIndicator().centered(),
            dataSet: vm.reviews,
            separatorBuilder: (context, index) => UiSpacer.verticalSpace(space: 15),
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) {
              //
              final review = vm.reviews[index];
              return ReviewListItem(review);
            },
          );
        },
      ),
    );
  }
}
