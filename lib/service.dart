import 'package:flutter/material.dart';
import 'package:intro_docs_run/model.dart';

class Service extends StatefulWidget {
  const Service({Key? key}) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  int? _sortColumnIndex;
  bool _sortAscending = false;
  List<Item>? _items;

  @override
  void initState() {
    setState(() {
      _items = _generateItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            horizontalMargin: 10,
            dividerThickness: 5,
            showBottomBorder: true,
            showCheckboxColumn: true,
            dataRowHeight: 80,
            headingRowHeight: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 10)),
            headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.teal),
            dataRowColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.blue
                      : Color.fromARGB(100, 215, 217, 219),
            ),
            dataTextStyle: const TextStyle(
                fontStyle: FontStyle.italic, color: Colors.black),
            onSelectAll: (bool? isSelected) {
              if (isSelected != null) {
                _items?.forEach((item) {
                  item.isSelected = isSelected;
                });
                setState(() {});
              }
            },
            columns: _createDataColumns(),
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            rows: _items!.map((item) => _createDataRow(item)).toList()),
      ),
    );
  }

  List<DataColumn> _createDataColumns() {
    return [
      DataColumn(
        label: const Text('No'),
        numeric: false,
      ),
      DataColumn(
        label: const Text('Name'),
        numeric: false,
        tooltip: "Name of Item",
      ),
      DataColumn(
        label: const Text('Price'),
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items?.sort((item1, item2) => item1.price.compareTo(item2.price));
          } else {
            _items?.sort((item1, item2) => item2.price.compareTo(item1.price));
          }
          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
        numeric: false,
        tooltip: "Price of Item",
      ),
      DataColumn(
        label: const Text('Description'),
        numeric: false,
        tooltip: "Description of Item",
      ),
    ];
  }

  DataRow _createDataRow(Item item) {
    return DataRow(
      // It's useful to ensure that if a row is added or removed,
      //the stateful widgets related to the row would remain on the right row.
      key: ValueKey(item.id),
      selected: item.isSelected,
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
          states.contains(MaterialState.selected) ? Colors.grey : Colors.white),
      onSelectChanged: (bool? isSelected) {
        if (isSelected != null) {
          item.isSelected = isSelected;

          setState(() {});
        }
      },
      cells: [
        DataCell(
          Text(
            item.id.toString(),
          ),
        ),
        DataCell(
          Text(item.name),
          placeholder: false,
          showEditIcon: true,
          onTap: () {
            print('onTap');
          },
        ),
        DataCell(Text(item.price.toString())),
        DataCell(
          Text(item.description),
        ),
      ],
    );
  }

  List<Item> _generateItems() {
    return List.generate(
        15,
        (index) => Item(
              id: index + 1,
              name: 'Item ${index + 1}',
              price: index * 1000.00,
              description: 'Details of Item ${index + 1}',
              isSelected: false,
            ));
  }
}
