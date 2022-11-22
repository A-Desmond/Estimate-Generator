import 'package:estimate/model/estimate.dart';
import 'package:estimate/constant/const.dart';
import 'package:estimate/helpers/estimate_view.dart';
import 'package:estimate/helpers/input_dialog.dart';
import 'package:estimate/pdf/pdf_creator.dart';
import 'package:estimate/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pdf/widgets.dart' as pw;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

TextEditingController _item = TextEditingController();
TextEditingController _price = TextEditingController();
TextEditingController _quantity = TextEditingController();

List<Estimate> estimateList = [];
List<int> totalCost = [];
int sum = 0;
final pdf = pw.Document();

class _HomePageState extends ConsumerState<HomePage> {
  addToList() {
    if (_item.text.isEmpty || _price.text.isEmpty || _quantity.text.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Error! Make sure you entered the correct data',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    } else {
      int price = int.parse(_price.text);
      int quantity = int.parse(_quantity.text);
      int totalPerItem = price * quantity;
      totalCost.add(totalPerItem);
      estimateList.add(Estimate(
        itemName: _item.text,
        price: price,
        quantity: quantity,
        totalCost: totalPerItem,
      ));
      int value = totalCost.fold(
          0, (previousValue, element) => previousValue + element);
      sum = value;
      _item.clear();
      _price.clear();
      _quantity.clear();
      Navigator.pop(context);
    }
  }

  removeEstimate(int index) {
    estimateList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('EVER'),
          actions: [
            IconButton(
              onPressed: () async {
                final pdfController = ref.watch(pdfProvider);
                final pdf = await pdfController.generate(
                    estimateList: estimateList, totalAmount: sum);

                pdfController.viewPdf(pdf);
              },
              icon: const Icon(Icons.print),
            ),
            Center(
              child: IconButton(
                  onPressed: () {
                    ref.watch(themeProvider.notifier).changeTheme();
                  },
                  icon: const Icon(Icons.dark_mode)),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () => addItems(
                  context: context,
                  itemName: _item,
                  itemQuantity: _quantity,
                  itemUnitPrice: _price,
                  ontap: () => setState(() {
                    addToList();
                  }),
                ),
            child: const Text(
              'Create Estimate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: estimateList.isEmpty
            ? const Center(
                child: Text(
                  'No Item added',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'TOTAL: $sum',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(header[0],
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(header[1],
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(header[2],
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(header[3],
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: estimateList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) => setState(() {
                                            removeEstimate(index);
                                          }),
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          icon: Icons.delete_forever,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: EstimateView(
                                        estimate: estimateList[index]))),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}
