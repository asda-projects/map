

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/domain/utils/paths.dart';

import 'package:frontend/presentation/assets/l10n/generated/l10n.dart';
import 'package:frontend/presentation/boilerplate/app_bar.dart';


class SmallWidgetAuth extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SmallWidgetAuth({
    super.key, required this.onLocaleChange
    });

  @override
  SmallWidgetAuthState createState() => SmallWidgetAuthState();
}

class SmallWidgetAuthState extends State<SmallWidgetAuth>  with TickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLoading = false;

  


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
    Form(
        key: _formKey,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.75, // Form width proportional to the screen
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space items evenly
                crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch elements to fill width
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                    labelText:  S.of(context).email,
                    hintText:  S.of(context).emailTip,
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                      borderSide: BorderSide(color: Colors.blueGrey), // Border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners for focused state
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2), // Border color when focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Default border corners
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Error border corners
                      borderSide: BorderSide(color: Colors.red), // Error border color
                    ),
                  ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                    labelText: S.of(context).password,
                    hintText: S.of(context).passwordTip,
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                      borderSide: BorderSide(color: Colors.blueGrey), // Border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners for focused state
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2), // Border color when focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Default border corners
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5), // Error border corners
                      borderSide: BorderSide(color: Colors.red), // Error border color
                    ),
                  ),
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
                        onTap: () {
                          // Action for second text
                          
                        },
                        child: Text(
                          S.of(context).noAccount,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton.icon(
                        onPressed: () {
                          
                        },
                        icon: const Icon(Icons.double_arrow_sharp),
                        label: Text(
                          S.of(context).login,
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
              
            },
            icon: FaIcon(
              FontAwesomeIcons.google
            ), // Your icon
            label: Text(
               S.of(context).loginWith("Google"),
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
              
            },
            icon: FaIcon(
              FontAwesomeIcons.facebook
            ), // Your icon
            label: Text(
               S.of(context).loginWith("Facebook"),
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