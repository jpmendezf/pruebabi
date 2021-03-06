import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/vendor/for_you_products.vm.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/list_items/grid_view_product.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/for_you_products.i18n.dart';

class ForYouProducts extends StatelessWidget {
  const ForYouProducts(this.vendorType, {Key key}) : super(key: key);
  final VendorType vendorType;
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForYouProductsViewModel>.reactive(
      viewModelBuilder: () => ForYouProductsViewModel(context,vendorType),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return VStack(
          [
            //
            "For You".i18n.text.xl.semiBold.make().p12(),

            //categories list
            CustomGridView(
              // scrollDirection: Axis.horizontal,
              noScrollPhysics: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              dataSet: model.products,
              isLoading: model.isBusy,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              itemBuilder: (context, index) {
                //
                return GridViewProductListItem(
                  product: model.products[index],
                  onPressed: model.productSelected,
                  qtyUpdated: model.addToCartDirectly,
                );
              },
            ),
          ],
        ).py12();
      },
    );
  }
}
