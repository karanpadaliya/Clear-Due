import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/take_order/presentation/bloc/take_order_bloc.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/frequent_buy_card.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/side_by_side_buttons.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class FrequentsBuyScreen extends StatelessWidget {
  const FrequentsBuyScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FrequentProductsBloc, TakeOrderState>(
        builder: (context, state) {
          if (state is FrequentProductsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FrequentProductsErrorState) {
            return Center(child: Text(state.error));
          }

          if (state is FrequentProductsSuccessState) {
            final frequentProducts =
                state.getFrequentProductsEntity.products ?? [];
            if (frequentProducts.isEmpty) {
              return Center(child: Text(LanguageManager().get('no_data')));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: frequentProducts.length,
                    itemBuilder: (context, index) => FrequentBuyCard(
                      productId: frequentProducts[index].productId ?? '',
                      productName: frequentProducts[index].productName ?? '',
                      productVariantName:
                          frequentProducts[index].productVariantName ?? '',
                      unitMeasurementType:
                          frequentProducts[index].unitMeasurementName ?? '',
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
            );
          }
          return const Center(child: CustomText('something_went_wrong'));
        },
      );
}
