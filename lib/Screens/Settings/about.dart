import 'package:flutter/material.dart';

import '../../colors/color.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorId.lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'POCKET',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: colorId.white),
            ),
            const Text(
              "POCKET is an equal opportunity startup for everyone. Our team is made of individuals ready to “build from scratch” and so we’re always looking for members eager to learn and grow – regardless of whether they’re in the early years of their careers or senior level.An animation comprises of estimation (of type T) along with status. The status demonstrates whether the animation is thoughtfully running from start to finish or from the end back to the start, despite the fact that the real estimation of the animation probably won’t change monotonically. Animations additionally let different items tune in for changes to either their worth or their status. These callbacks are called during the “animation” period of the pipeline, only before rebuilding widgets.When it comes to creating a good user experience for your application, including all around made and liquid animations, are significant. They function as visual input for user activities and can likewise give the importance of connection and consolation.Animating buttons are what this article is about; explicitly, we’ll manufacture a small bouncing animation that is set off when the user clicks a button.Money management is the process of tracking expenses, investing, budgeting, banking, and assessing tax liabilities; it is also called investment management. Money management is a strategic technique to deliver the highest interest-output value for any amount spent on making money.It is a natural human tendency to spend money to fulfil the cravings regardless of whether they can be justifiably included in a budget. The idea of money management techniques was developed to reduce the amount that individuals, firms, and institutions spend on items that do not add any significant value to their standard of living, long-term portfolios, and assets.Understanding Money ManagementMoney management is a broad concept that encompasses and integrates resources and solutions around the investment industry as a whole. Consumers have access to a variety of resources and applications on the market, which helps them to manage almost every aspect of their personal finances individually.When investors increase their net worth, they often frequently pursue qualified money management advice from financial advisors. Generally, financial advisors are affiliated with private banking and investment services, offering resources for holistic money management programs that could include estate planning, retirement, and mor",
            ),
          ],
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
