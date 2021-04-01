import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helper/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/screens/category.dart';
import 'package:flutter_budget_ui/widgets/bar_chart.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  buildCategory(Category category,double totalAmountSpent){
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>CategoryScreen(
          category: category,
        )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [BoxShadow(
            color: Colors.grey,
            offset: Offset(0,2),
            blurRadius: 6.0
          )]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.name,style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600
                ),),
                Text("\$${(category.maxAmount-totalAmountSpent).toStringAsFixed(2)}/\$${category.maxAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0
                ),
                ),
              ],
            ),
            SizedBox(height: 5.0,),
            LayoutBuilder(
              builder:(BuildContext context,BoxConstraints constraints){
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount-totalAmountSpent)/category.maxAmount;
                double barWidth = percent*maxBarWidth;
                if(barWidth<0){
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },

            )
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 100.0,
                forceElevated: true,
                floating: true,
                //pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Simple Budget"),
                ),
                leading:IconButton(
                  onPressed:(){},
                  icon:Icon(
                    Icons.settings,
                  ),
                  iconSize: 30.0,
                ),
                actions: [
                  IconButton(onPressed:(){},
                      icon:Icon(Icons.add),
                    iconSize: 30.0,
                  )
                ],
              ),
            SliverList(delegate:SliverChildBuilderDelegate((context,index){
                    if(index==0){
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: (6.0),
                              )
                            ]
                        ),
                        child: BarChart(expenses: weeklySpending),
                      );
                    }
                    else{
                        final Category category = categories[index -1];
                        double totalAmountSpent = 0;
                        category.expenses.forEach((Expense expense){
                          totalAmountSpent +=expense.cost;
                        });
                        return buildCategory(category,totalAmountSpent);
                    }
                        return null;

            },
              childCount: 1+categories.length,
            ),
            )
            ],
          ),
    );
  }
}
