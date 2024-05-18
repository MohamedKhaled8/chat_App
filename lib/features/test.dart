import 'package:flutter/material.dart';

class DropDownExample extends StatefulWidget {
  const DropDownExample({Key? key}) : super(key: key);

  @override
  _DropDownExampleState createState() => _DropDownExampleState();
}

class _DropDownExampleState extends State<DropDownExample> {
  List<String?> selectedItems = List.filled(6, null);

  final List<String> listItems1 = ["item 1", "item 2", "item 3", "item 4"];
  final List<String> listItems2 = [
    "option A",
    "option B",
    "option C",
    "option D"
  ];
  final List<String> listItems3 = ["A", "B", "C", "D"];
  final List<String> listItems4 = [
    "option 1",
    "option 2",
    "option 3",
    "option 4"
  ];
  final List<String> listItems5 = [
    "salary 1",
    "salary 2",
    "salary 3",
    "salary 4"
  ];
  final List<String> listItems6 = ["min salary", "max salary", "avg salary"];

  final List<List<String>> allItems = [
    ["item 1", "item 2", "item 3", "item 4"],
    ["option A", "option B", "option C", "option D"],
    ["A", "B", "C", "D"],
    ["option 1", "option 2", "option 3", "option 4"],
    ["salary 1", "salary 2", "salary 3", "salary 4"],
    ["min salary", "max salary", "avg salary"]
  ];

  final List<String> titles = ["Data", "Time Availability", "Min-Max Salary"];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < selectedItems.length; i++) {
      selectedItems[i] = allItems[i].isNotEmpty ? allItems[i][0] : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          final title = titles[index];
          final dropDownIndex1 = index * 2;
          final dropDownIndex2 = dropDownIndex1 + 1;

          return CustomContainer(
            title: title,
            dropDown1: CustomDrobDownWidget(
              selectedItem: selectedItems[dropDownIndex1],
              items: allItems[dropDownIndex1],
              onChanged: (newValue) {
                setState(() {
                  selectedItems[dropDownIndex1] = newValue;
                });
              },
            ),
            dropDown2: CustomDrobDownWidget(
              selectedItem: selectedItems[dropDownIndex2],
              items: allItems[dropDownIndex2],
              onChanged: (newValue) {
                setState(() {
                  selectedItems[dropDownIndex2] = newValue;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final String? value;
  final String hint;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(hint),
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 36,
        underline: const SizedBox.shrink(),
        style: const TextStyle(color: Colors.black),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String title;
  final Widget dropDown1;
  final Widget dropDown2;

  const CustomContainer({
    Key? key,
    required this.title,
    required this.dropDown1,
    required this.dropDown2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 5),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dropDown1,
              const SizedBox(width: 20),
              dropDown2,
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDrobDownWidget extends StatelessWidget {
  final String? selectedItem;
  final List<String> items;
  final Function(String?) onChanged;
  const CustomDrobDownWidget({
    Key? key,
    this.selectedItem,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton(
      value: selectedItem,
      hint: "Select",
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
