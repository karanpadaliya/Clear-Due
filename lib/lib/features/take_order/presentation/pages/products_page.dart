import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';
import 'package:myco_flutter/features/take_order/presentation/pages/take_order_page.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/frequent_buy_card.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/side_by_side_buttons.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';

class ProductsPage extends StatelessWidget {
  List<ProductEntity> products;
  ProductsPage({super.key, this.products = const []});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppTheme.getColor(context).surface,
    appBar: CustomAppbar(title: LanguageManager().get('products')),
    body: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.08 * Responsive.getWidth(context),
      ),
      child: Column(
        children: [
          CustomSearchField(
            hintText: 'Search',
            onChanged: (value) {
              // TODO: Implement search functionality
              // Implement search functionality
            },
          ),
          SizedBox(height: 0.03 * Responsive.getHeight(context)),
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) => FrequentBuyCard(
                productId: products[index].productId ?? '',
                productName: products[index].productName ?? '',
                productVariantName: products[index].productVariantName ?? '',
                unitMeasurementType: products[index].unitMeasurementName ?? '',
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: 0.015 * Responsive.getHeight(context)),
            ),
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
          SideBySideButtons(
            button1Name: LanguageManager().get('reset_cart'),
            button2Name: LanguageManager().get('add_order'),
            onTap1: () {},
            onTap2: () {
              context.pushNamed(RoutePaths.orderSummary);
            },
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
        ],
      ),
    ),
  );
}
