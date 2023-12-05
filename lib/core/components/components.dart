import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  double radius = 10.0,
  double height = 40.0,
  bool isUpperCase = true,
  required String text,
  required Function function,
}) =>
    Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixButtonPressed,
}) =>
    SizedBox(
      height: 55.0,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            validate;
            return "Please enter your ${label}";
          }
        },
        controller: controller,
        onFieldSubmitted: (value) {
          onSubmit!();
        },
        onChanged: (value) {
          //onChange!();
        },
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffix: suffix != null
              ? IconButton(
                  //alignment: Alignment.center,
                  onPressed: () {
                    suffixButtonPressed!();
                  },
                  icon: Icon(
                    suffix,
                    color: Colors.blue,
                  ),
                )
              : null,
        ),
      ),
    );

/*void submit(context) {
  CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}*/

/*PreferredSizeWidget defaultAppBar({
  required context,
  required String title,
  required List<Widget> actions,
}) =>
    AppBar(
      titleSpacing: 5,
      title: Text(title),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconlyBroken.arrow_left_2),
      ),
      actions: actions,
    );*/
