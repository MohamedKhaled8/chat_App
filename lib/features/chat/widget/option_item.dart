import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const OptionItem(
      {super.key, required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.width * .05,
              top: mq.height * .015,
              bottom: mq.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black54,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}
