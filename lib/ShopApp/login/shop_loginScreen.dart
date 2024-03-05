import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../shared/network/local/cachHelper.dart';
import '../../shared/comonents/components.dart';
import '../../shared/style/colors.dart';
import '../register/Sop_registerScreen.dart';
import '../shop_layout/shop_ayout.dart';
import 'cubit/cubit.dart';
import 'cubit/status.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStatus>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopLoginSucccessStatus){
            if (state.loginModel.status == true){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CachHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value){
                navegateAndFinish(context, ShopLayout());
              });
            }
            else{
              print(state.loginModel.message);
              showToast(
                  msg: state.loginModel.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "LOGIN",
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black,
                            )
                        ),
                        Text(
                            "login now to brows our hot offers",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            )
                        ),
                        SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            hintText: 'E-Maile',
                            labelText: 'Email Adress',
                            preFix: Icons.email_outlined,
                          OnTap: (){},
                        ),
                        SizedBox(height: 15,),

                        defaultTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          hintText: 'Password',
                          labelText: 'Password',
                          preFix: Icons.lock_outline,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suFix: ShopLoginCubit.get(context).suffixIcon,
                          suffixOnPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                            OnTap: (){},
                        ),

                        SizedBox(height: 55,),
                        ConditionalBuilder(
                            condition: state is ! ShopLoginLoadingStatus,
                            builder: (context) => defaultButton(
                              text: 'login',
                              function: (){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }

                              },
                              backgroundColor: defultColor,
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator())
                        ),
                        SizedBox(height: 15.0,),
                        Center(
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              Text("Don\'t have an account yet"),
                              defaultTextButton(
                                function: (){
                                  navigateTo(context, RegisterScreen());
                                },
                                buttonlable: "REGISTER",
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
