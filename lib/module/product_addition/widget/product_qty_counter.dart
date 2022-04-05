import 'package:branch_manager/widget/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../main_imports.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../../widget/simple_counter.dart';

//ignore: must_be_immutable
class ProductQtyCounter extends StatefulWidget {
  final int initialValue;
  final void Function(int counter) onTap;

  ProductQtyCounter({
    @required this.onTap,
    this.initialValue = 0,
    Key key,
  }) : super(key: key);

  @override
  _ProductQtyCounterState createState() => _ProductQtyCounterState();
}

class _ProductQtyCounterState extends State<ProductQtyCounter> {
  int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      color: Colors.white,
      height: 60.0,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      alignment: const Alignment(-0.8, 1.0),
                      child: CustomNumberPicker(
                        onChanged: (c) {
                          setState(() => counter = c);
                        },
                        initialValue: counter,
                      ),
                    ),
                  );
                },
              );
            },
            child: SimpleCounter(
              counter: counter,
              counterColor: AppData.secondaryColor,
              onChanged: (c) async {
                counter = c;
                return true;
              },
            ),
          ),
          const SizedBox(width: 30.0),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (widget.onTap != null) widget.onTap(counter);
              },
              child: Text('Add Product'.tr),
            ).toGradient(context),
          ),
        ],
      ),
    );
  }
}
