import 'package:flutter/material.dart';

class LabledGrid extends StatelessWidget {
  const LabledGrid(
      {super.key,
      required this.lable,
      required this.gridItems,
      this.mainAxisExtent = 55,
      this.maxHeight = 80,
      this.corssAxisCount = 5});
  final String lable;
  final List<Widget> gridItems;
  final int corssAxisCount;
  final double maxHeight;
  final double mainAxisExtent;
  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Center(
                    // padding: EdgeInsets.only(top: 5, left: width * 0.5),
                    child: Text(
                      lable,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    //color: backgroundColor,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gridItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: corssAxisCount,
                          mainAxisExtent: mainAxisExtent),
                      itemBuilder: (context, index) {
                        return gridItems[index];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
