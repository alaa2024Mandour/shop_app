
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



/*=================================================*/
//Reusable Buttons
/*=================================================*/
Widget defaultTextButton ({
  required Function function,
  required String buttonlable,
}) => TextButton(
onPressed: (){
  function();
},
child: Text(
  "$buttonlable"
)
);

Widget defaultButton({
  Color backgroundColor = Colors.blue,
  double width = double.infinity,
  double radius = 10.0,
  required String text,
  required Function function,
}) => Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );

/*=================================================*/
//Reusable Text Form Field
/*=================================================*/
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? OnTap,
  required String hintText,
  required String labelText,
  required IconData preFix,
//=======for Password=========
  IconData? suFix,
  Function? suffixOnPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      //=======for Password=========
      onFieldSubmitted: (s) {
        onSubmit!(s);
       },

      onChanged: (s) {
        onChange!(s);
      },

      onTap: () {
        OnTap!();
      },
      validator: (value) {
        if (value == null || value.isEmpty) return 'Field is required.';
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(preFix),
        suffix: suFix != null
            ? IconButton(
                onPressed: () {
                  suffixOnPressed!();
                },
                icon: Icon(suFix),
              )
            : null,
        //=======for Password=========
        border: OutlineInputBorder(),
      ),
    );

/*=================================================*/


class AppCubit {
  static get(context) {}
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 2,
        width: double.infinity,
        color: Colors.black45,
      ),
    );

//=====================================================
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navegateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget),
        (route) => false
);

//===============================================
//########## Toast ###########
void showToast ({
  required String msg,
  required ToastStates state,
})=>  Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: choosToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates {SUCCESS, ERROR, WARNING}

Color choosToastColor (ToastStates state ){
  Color color ;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}