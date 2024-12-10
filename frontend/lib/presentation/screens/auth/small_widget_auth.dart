

import 'package:animated_background/animated_background.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/data/remote/firebase_auth_adpter.dart';
import 'package:frontend/domain/services/auth_service.dart';
import 'package:frontend/domain/services/logs.dart';
import 'package:frontend/data/utils/paths.dart';
import 'package:frontend/domain/utils/text_fields_validators.dart';

import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/app_bar.dart';
import 'package:frontend/presentation/boilerplate/form_fields.dart';
import 'package:frontend/presentation/utils/navigation.dart';


class SmallWidgetAuth extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SmallWidgetAuth({
    super.key, required this.onLocaleChange
    });

  @override
  SmallWidgetAuthState createState() => SmallWidgetAuthState();
}

class SmallWidgetAuthState extends State<SmallWidgetAuth>  with TickerProviderStateMixin {

  FirebaseAuthAdapter firebaseAuth = FirebaseAuthAdapter();

  AppLogger logger = AppLogger();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // swtichable vars
  bool _isLoading = false;
  bool isSignUp = false;

  
  void _toggleState() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }
  

  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService(
      formKey: _formKey,
      onLocaleChange: widget.onLocaleChange,  // Define properly
      navigateToMainScreen: AppNavigation.navigateToPage,
      setLoading: (bool isLoading) {
        setState(() {
          _isLoading = isLoading;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    
    return Stack(
        children: [ 
          
          AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options:  ParticleOptions(
            baseColor: Theme.of(context).colorScheme.primary,
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 20,
            spawnMaxSpeed: 20,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            
            // image: Image(image: AssetImage('assets/images/elephant.png')),
          ),
        ),
        vsync: this,
        child: Scaffold(
             extendBodyBehindAppBar: true, // Allows content to extend behind the AppBar
            backgroundColor: Colors.transparent,
        appBar: MyAppBar(onLocaleChange: widget.onLocaleChange, logoColor: Colors.transparent),

        body: SingleChildScrollView(
          
          
            child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Ensures full height
          ),
          child: IntrinsicHeight(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(height: 1,),
              Spacer(),
                Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space evenly
        crossAxisAlignment: CrossAxisAlignment.center, // Centers vertically
        children: [
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                '${DirPath.media}logo.svg', // Path to your logo
                height: 40,
              ),
            ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "HeartBeats",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Segoe UI",
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            )
          
        ],
      ),
    ),
    Spacer(),
    Text(
                isSignUp ? S.of(context).authGreetingsSignUp : S.of(context).authGreetingsLogin,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Segoe UI",
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
    Spacer(),
    Form(
        key: _formKey,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.75, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                crossAxisAlignment: CrossAxisAlignment.stretch, 
                children: [
                  CustomTextFormField(
                    controller: _emailController,  
                    validator: (value) => FieldValidator.email(context, value),          
                    labelText:  S.of(context).email,
                    hintText:  S.of(context).emailTip
                    ),
                  SizedBox(height: 12),
                  CustomTextFormField(
                    controller: _passwordController,
                    validator: (value) => FieldValidator.password(context, value),
                    labelText: S.of(context).password,
                    hintText: S.of(context).passwordTip,
                    obscureText: true,

                  ),
                  SizedBox(height: 10),
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Centers the text horizontally
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Action for first text
                          
                        },
                        child: Text(
                          S.of(context).forgotPwd,
                          style: TextStyle(
                            color: Colors.blue, // Makes the text look clickable
                          ),
                        ),
                      ),
                      //SizedBox(width: 10), // Spacing between the texts
                      GestureDetector(
                        onTap: _toggleState,
                        child: Text(
                          isSignUp ? S.of(context).hasAccount : S.of(context).noAccount ,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? LinearProgressIndicator(
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
                      )
                      : ElevatedButton.icon(
                        onPressed: () {
                          authService.submitForm(
                            context: context, 
                            email: _emailController.text.trim(), 
                            password: _passwordController.text.trim(), 
                            isSignUp: isSignUp
                            );
                          
                        },
                        icon: const Icon(Icons.double_arrow_sharp),
                        label: Text(
                          isSignUp ? S.of(context).signUp : S.of(context).login,
                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          
                          backgroundColor: Theme.of(context).colorScheme.onSurface,
                          shape: RoundedRectangleBorder(
                            //side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                            borderRadius: BorderRadius.circular(5), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ), // Padding inside the button
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      Spacer(),
          Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 20.0,
          endIndent: 20.0,
        ),

          Spacer(),
         ElevatedButton.icon(
            onPressed: () {
              authService.loginWithProvider("Google");
              
            },
            icon: FaIcon(
              FontAwesomeIcons.google
            ), // Your icon
            label: Text(
               isSignUp ? S.of(context).signUpWith("Google") : S.of(context).loginWith("Google"),
               // style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              
              // backgroundColor: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                borderRadius: BorderRadius.circular(5), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ), // Padding inside the button
            ),
          ),
         Spacer(),
         ElevatedButton.icon(
            onPressed: () {
              authService.loginWithProvider("Facebook");
            },
            icon: FaIcon(
              FontAwesomeIcons.facebook
            ), // Your icon
            label: Text(
               isSignUp ? S.of(context).signUpWith("Facebook") : S.of(context).loginWith("Facebook"),
               // style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              
              // backgroundColor: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.onSurface),
                borderRadius: BorderRadius.circular(5), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ), // Padding inside the button
            ),
          ),
          
      
          Spacer()
          
          ]))))))]);

  }

}