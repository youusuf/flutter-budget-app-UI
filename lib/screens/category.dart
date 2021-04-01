import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helper/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  buildExpenses(){
    List<Widget> expenseList = [];
    widget.category.expenses.forEach((Expense expense){
      expenseList.add(Container(
        alignment: Alignment.center,
        height: 80.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow:[BoxShadow(
            color: Colors.black12,
            offset: Offset(0,2),
            blurRadius: 6.0
          )]
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(expense.name,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
              Text("-\$${expense.cost.toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),)
            ],
          ),
        ),
      ));

    });
      return Column(
        children: expenseList,
      );
  }


  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense){
      totalAmountSpent +=expense.cost;
    });
    final double amountLeft = widget.category.maxAmount-totalAmountSpent;
    final double percent = amountLeft/widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
              onPressed:(){},
              icon:Icon(Icons.add),
            iconSize: 25.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [BoxShadow(
                    color: Colors.black12,
                  offset: Offset(0,2),
                  blurRadius: 6.0
                )],
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(percent),
                  percent: percent,
                  width: 15.0
                ),
                child: Center(
                  child: Text("\$${amountLeft.toStringAsFixed(2)}/\$${widget.category.maxAmount}",
                    style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600
                    ) ,
                  ),
                ),
              ),
            ),
            buildExpenses(),
          ],
        ),
      ),
    );
  }
}
