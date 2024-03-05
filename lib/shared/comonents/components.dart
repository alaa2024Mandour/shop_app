
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
//Tasks Items in todoApp
/*=================================================*/

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (Direction) {
        AppCubit.get(context).deletDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                "${model['time']}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              radius: 40,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).UpdateDatabase(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: Icon(Icons.check_box),
              color: Colors.green,
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).UpdateDatabase(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(Icons.archive),
              color: Colors.black45,
            )
          ],
        ),
      ),
    );

class AppCubit {
  static get(context) {}
}

Widget TaskConditionItmeBulder({
  required List<Map> tasks,
}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) =>
            buildTaskItem(tasks[index], context), //
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length),
    fallback: (BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 55,
            ),
            Text(
              "There Is No Tasks Yet",
              style: TextStyle(fontSize: 25, color: Colors.black45),
            )
          ],
        ),
      );
    },
  );
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
//==========News App ==================================
Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Colors.black45),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

//======================================
Widget articleBulder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10),
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()));

//==================================================
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