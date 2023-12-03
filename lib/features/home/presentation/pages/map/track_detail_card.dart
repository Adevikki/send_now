import 'package:flutter/material.dart';
import 'package:send_now_test/core/utils/colors.dart';
import 'package:send_now_test/presentation/widgets/text_form_field.dart';
import 'package:send_now_test/core/utils/validators.dart';

class TrackDetailCard extends StatelessWidget {
  TrackDetailCard({super.key});
  final TextEditingController _receiptController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: SendNowColors.yellow,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Sukabumi, Indonesia",
                  style: TextStyle(
                    color: Color(0XFF2E3E5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomFormField(
                  controller: _receiptController,
                  hintText: 'No receipt : SCP6653728497',
                  fontSize: 12.0,
                  textColor: Colors.black,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  noBorder: InputBorder.none,
                  validateFunction: Validators.notEmpty(),
                ),
                const Divider(height: 20),
                const Text(
                  "2,50 USD",
                  style: TextStyle(
                    color: Color(0XFF2E3E5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomFormField(
                  controller: _postalController,
                  hintText: 'Postal fee',
                  fontSize: 12.0,
                  textColor: Colors.black,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  noBorder: InputBorder.none,
                  validateFunction: Validators.notEmpty(),
                ),
                const Divider(height: 20),
                const Text(
                  "Bali, Indonesia",
                  style: TextStyle(
                    color: Color(0XFF2E3E5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomFormField(
                  controller: _weightController,
                  hintText: 'Parcel, 24kg',
                  fontSize: 12.0,
                  textColor: Colors.black,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  noBorder: InputBorder.none,
                  validateFunction: Validators.notEmpty(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
