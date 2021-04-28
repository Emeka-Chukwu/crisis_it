import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

class HelpScreenDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: Responsive.screenWidth(5, context),
            right: Responsive.screenWidth(5, context),
            top: Responsive.screenHeight(4, context)),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                YMargin(Responsive.screenHeight(3, context)),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffC7CAD9),
                        size: 20,
                      ),
                    ),
                    XMargin(40),
                    Text(
                      "How to use First Aid Kit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGreen,
                      ),
                    ),
                  ],
                ),
                YMargin(15),
                Text(
                  """At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat\n

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias 
excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. 
Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.
""",
                  style: TextStyle(
                    color: Color(0xff535C66),
                    fontSize: 14,
                    height: 1.5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
