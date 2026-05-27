import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gateway_payments_app/features/checkout/presentation/managers/stripe_cubit.dart';
import 'package:gateway_payments_app/features/checkout/presentation/views/payment_details.dart';

import 'package:gateway_payments_app/features/checkout/presentation/widgets/cart_info_item.dart';
import 'package:gateway_payments_app/features/checkout/presentation/widgets/payment_methods_bottom_sheet.dart';
import 'package:gateway_payments_app/features/checkout/presentation/widgets/total_price_widget.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../data/repos/checkout_repo.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: Image.asset(
              'assets/images/basket_image.png',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 40),
          const OrderInfoItem(title: 'Order Subtotal', value: r'42.97$'),
          const SizedBox(height: 3),
          const OrderInfoItem(title: 'Discount', value: r'0$'),
          const SizedBox(height: 3),
          const OrderInfoItem(title: 'Shipping', value: r'8$'),
          const Divider(thickness: 2, height: 34, color: Color(0xffC7C7C7)),
          const TotalPrice(title: 'Total', value: r'$50.97'),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Complete Payment',
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context){return PaymentDetailsView();}));
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                builder: (context) {
                  return BlocProvider<StripeCubit>(
                    create: (context) => StripeCubit(CheckoutRepoImpl()),
                    child: const PaymentMethodsBottomSheet(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
