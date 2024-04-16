import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5FA),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Text("مرحبا، محمد",textAlign: TextAlign.center,
              style: GoogleFonts.almarai(
                  color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold
              ),),
            const SizedBox(height: 50,),
            Pinput(
              defaultPinTheme: PinTheme(
                width: 21,
                height: 21,
                padding: const EdgeInsets.only(bottom: 5,right: 20,left: 0),
                textStyle: const TextStyle(height: 0.1,fontSize: 40, color: Colors.black, fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  color: const Color(0xffAFBFD5),
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
              length: 4,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              focusedPinTheme: PinTheme(
                width: 21,
                height: 21,
                padding: const EdgeInsets.only(bottom: 5,right: 20,left: 0),
                textStyle: const TextStyle(height: 1,fontSize: 40, color: Colors.black, fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
              validator: (s) {},
              errorTextStyle: const TextStyle(height: 1,fontSize: 15,color: Colors.red),
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              controller: controller,
              onCompleted: (pin){},
            ),
            const SizedBox(height: 50,),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return circleButton(index+1);
              },
            )
          ],
        ),
      ),
    );
  }
  TextEditingController controller = TextEditingController();

  circleButton(int value){
    return GestureDetector(
      onTap: (){
        if(value < 10 || value == 11){
          if(controller.text.length < 4){
            if(value < 10){
              controller.text = controller.text + value.toString();
            }else{
              controller.text = '${controller.text}0';
            }
          }
        }else if(value == 12){
          int lengthOfText = controller.text.length;
          if(lengthOfText > 0){
            controller.text = controller.text.substring(0,lengthOfText-1);
          }
        }
        setState(() {

        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xffFFFFFF),
          boxShadow: [
            BoxShadow(
              color: const Color(0x3F101010).withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(2, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: returnValueOfButton(value) is String
            ? Center(
              child: Text(returnValueOfButton(value).toString(),textAlign: TextAlign.center,
                      style: GoogleFonts.almarai(
                color: Colors.green,fontSize: 30,fontWeight: FontWeight.bold
                      ),),
            )
            : Center(
          child: returnValueOfButton(value)!,
        ),
      ),
    );
  }
  dynamic returnValueOfButton(int index){
    if(index < 10){
      return index.toString();
    }else if(index == 10){
      return SvgPicture.asset('assets/faceid.svg',height: 35,);
    }else if(index == 12){
      return SvgPicture.asset('assets/delete.svg',height: 35,);
    }else if(index == 11){
      return '0';
    }
  }
}
