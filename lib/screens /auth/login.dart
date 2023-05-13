import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../util/styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailFocus = FocusNode();
  final passFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _hidePass = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  late AuthBloc _authBloc;

  void _fieldFocusChanged(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Positioned(
            top: 550,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: Container(
                height: 550.h,
                decoration: const BoxDecoration(
                  color: ColorStyles.bodyColor,
                ),
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(
                height: 100.h,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/img/logo.svg',
                  height: 25.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: REdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 3,
                  child: Container(
                    padding: REdgeInsets.all(8),
                    height: 260.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        const Text(
                          'Вход в аккаунт',
                          style: TextStyles.loginTitle,
                        ),
                        SizedBox(height: 30.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                focusNode: emailFocus,
                                onFieldSubmitted: (term) {
                                  _fieldFocusChanged(
                                      context, emailFocus, passFocus);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Введите email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              TextFormField(
                                controller: _passController,
                                focusNode: passFocus,
                                onFieldSubmitted: (term) {
                                  passFocus.unfocus();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Введите пароль';
                                  }
                                  return null;
                                },
                                obscureText: _hidePass,
                                decoration: InputDecoration(
                                  labelText: 'Пароль',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hidePass = !_hidePass;
                                      });
                                    },
                                    icon: Icon(
                                      _hidePass
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _authBloc.add(LoginEvent(
                                          context: context,
                                          email: _emailController.text,
                                          password: _passController.text));
                                    }
                                  },
                                  child: const Text(
                                    'Войти',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text(
//         'Профиль',
//       ),
//       centerTitle: false,
//     ),
//     resizeToAvoidBottomInset: true,
//     body: Center(
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: MediaQuery.of(context).size.height * 0.01,
//               horizontal: MediaQuery.of(context).size.width * 0.05),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Вход в аккаунт',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 25),
//                 TextFormField(
//                   focusNode: emailFocus,
//                   autofocus: true,
//                   onFieldSubmitted: (_) {
//                     _fieldFocusChanged(context, emailFocus, passFocus);
//                   },
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     label: const Text('Email *'),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     contentPadding: const EdgeInsets.all(20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide:
//                       const BorderSide(color: Colors.red, width: 1),
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   focusNode: passFocus,
//                   controller: _passController,
//                   obscureText: _hidePass,
//                   decoration: InputDecoration(
//                     labelText: 'Пароль *',
//                     hintText: 'Введите пароль',
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     contentPadding: const EdgeInsets.all(20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide:
//                       const BorderSide(color: Colors.red, width: 1),
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _hidePass ? Icons.visibility : Icons.visibility_off,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _hidePass = !_hidePass;
//                         });
//                       },
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Expanded(
//                   flex: 0,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       minimumSize:
//                       MaterialStateProperty.all(const Size(400, 50)),
//                       shape:
//                       MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0)),
//                       ),
//                     ),
//                     onPressed: () {
//                       _authBloc.add(LoginEvent(
//                           context: context,
//                           email: _emailController.text,
//                           password: _passController.text));
//                     },
//                     child: const Text(
//                       'Войти',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
