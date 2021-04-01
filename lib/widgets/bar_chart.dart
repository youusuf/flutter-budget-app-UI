import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
class BarChart extends StatelessWidget {

  final List<double> expenses;
  BarChart({this.expenses});

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price){
    if(price>mostExpensive)
    {
      mostExpensive = price;
    }
    });
    return Padding(
      padding:  EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "weekly Spending",
            style:TextStyle(
              fontSize:20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2
            ),
          ),
          SizedBox(height: 2.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround ,
            children: [
              IconButton(
                  onPressed:(){},
                  icon:Icon(
                  Icons.arrow_back
                  ),
                iconSize: 18.0,
              ),
              Text("Nov 10,2019 - Nov 16 2019",
                style:TextStyle(
                fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2
              ),),
              IconButton(
                onPressed:(){},
                icon:Icon(
                    Icons.arrow_forward
                ),
                iconSize: 18.0,
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(label:"su",amountSpend:expenses[0],
                  mostExpenses:mostExpensive
              ),
              Bar(label:"mo",amountSpend:expenses[1],
                  mostExpenses:mostExpensive
              ),
              Bar(label:"tu",amountSpend:expenses[2],
                  mostExpenses:mostExpensive
              ),
              Bar(label:"we",amountSpend:expenses[3],
                  mostExpenses:mostExpensive
              ),
              Bar(label:"th",amountSpend:expenses[4],
                  mostExpenses:mostExpensive
              ),
              Bar(label:"fr",amountSpend:expenses[5],
                  mostExpenses:mostExpensive
              ),
              Bar(label:"sa",amountSpend:expenses[6],
                  mostExpenses:mostExpensive
              ),
            ],
          )
        ],
      ),
    );
  }
}
class Bar extends StatelessWidget {
  final String label;
  final double amountSpend;
  final double mostExpenses;
  final double _maxBarHeight = 150.0;
  Bar({this.label,this.amountSpend,this.mostExpenses});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpend/mostExpenses*_maxBarHeight;
    return Column(
      children: [
        Text('\$${amountSpend.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
        ),
        SizedBox(height: 5.0,),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(6.0)
          ),
        ),
        SizedBox(height: 8.0,),
        Text(label,style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        ),)
      ],
    );
  }
}

