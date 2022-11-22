import 'package:estimate/helpers/text_field.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

 addItems({
  required BuildContext context,
  required TextEditingController itemName,
  required TextEditingController itemQuantity,
  required TextEditingController itemUnitPrice,
  required VoidCallback ontap,
}) =>
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'ADD ITEM',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    controller: itemName,
                    label: 'Item Name',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 30),
                  InputField(
                    controller: itemQuantity,
                    label: 'Quantity',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  InputField(
                    controller: itemUnitPrice,
                    label: 'Unit Price',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SlideAction(
                        height: 60,
                        text: 'Slide to add',
                        submittedIcon: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        innerColor: Colors.white,
                        outerColor: Colors.black,
                        onSubmit: ontap,
                      ))
                ],
              ),
            ),
          ));
        });
