import 'package:flutter/material.dart';
import 'package:mtp_live/core/viewmodels/views/login_view_model.dart';
import 'package:mtp_live/ui/pages/base_page.dart';
import 'package:mtp_live/ui/shared/app_colors.dart';
import 'package:mtp_live/ui/shared/ui_helpers.dart';
import 'package:mtp_live/ui/widgets/busy_button.dart';
import 'package:mtp_live/ui/widgets/google_login_button.dart';
import 'package:mtp_live/ui/widgets/input_field.dart';
import 'package:mtp_live/ui/widgets/text_link.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BasePage<LoginViewModel>(
      model: LoginViewModel(authenticationService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.asset('assets/images/title.png',),
                ),
                InputField(
                  placeholder: 'Email',
                  controller: emailController,
                ),
                UIHelper.verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                ),
                UIHelper.verticalSpaceMedium,
                Expanded(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      BusyButton(
                        title: 'Login',
                        busy: model.state,
                        onPressed: () async {
                          var loginSuccess = model.login;
                          if (loginSuccess != null) {
                            Navigator.pushNamed(context, 'home');
                          }
                        },
                      ),

                      BusyButton(
                        title: 'Visit',
                        busy: model.state,
                        onPressed: () async {
                          var loginSuccess = model.ghostMode;
                          if (loginSuccess != null) {
                            Navigator.pushNamed(context, 'home');
                          }
                        },
                      ),

                      googleLoginButton(),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                TextLink(
                  'Create an Account if you\'re new.',
                  onPressed: () async {
                    var currentUserA = model.createUserWithCredential;
                    if (currentUserA != null) {
                      Navigator.pushNamed(context, 'home');
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
