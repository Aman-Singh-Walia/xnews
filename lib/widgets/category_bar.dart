import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int i) onSelected;
  const CategoryBar(
      {Key? key,
      required this.categories,
      required this.selectedIndex,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onSelected(index);
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.purple.withAlpha(50)
                        : Colors.transparent,
                    border: Border.all(
                        color: selectedIndex == index
                            ? Colors.purple
                            : CupertinoColors.black,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  categories[index],
                  style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.purple
                          : CupertinoColors.black),
                ),
              ),
            );
          }),
    );
  }
}
