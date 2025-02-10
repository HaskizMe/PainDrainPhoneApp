import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pain_drain_mobile_app/screens/home/home_screen.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              SizedBox(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset("assets/stim_control.png", fit: BoxFit.contain,),
              ),
              const SizedBox(height: 20,),
              const Text("Open Stimulus Controls", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Text("Simply click on one of the", style: TextStyle(fontSize: 24),),
              const Text("summary boxes to open up", style: TextStyle(fontSize: 24),),
              const Text("the adjust sliders menu.", style: TextStyle(fontSize: 24),),

            ],
          ),
        ),

        PageViewModel(
          title: "",
          //body: "This is a description on a page with a custom button below.",
          //image: Image.asset("assets/adjust_sliders.png", height: 300.0, width: 200,),
          bodyWidget: Column(
            children: [
              SizedBox(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset("assets/adjust_stim.png", fit: BoxFit.contain,),
              ),
              const SizedBox(height: 20,),
              const Text("Stimulus Controls", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Text("Use the slider controls to adjust", style: TextStyle(fontSize: 24),),
              const Text("stimulus to your comfort level.", style: TextStyle(fontSize: 24),),

            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              SizedBox(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset("assets/add_preset.png", fit: BoxFit.contain,),
              ),
              const SizedBox(height: 20,),
              const Text("Add Presets", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Text("Press the 'Add' button to add", style: TextStyle(fontSize: 24),),
              const Text("a custom preset to your profile.", style: TextStyle(fontSize: 24),),

            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              SizedBox(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset("assets/load_preset.png", fit: BoxFit.contain,),
              ),
              const SizedBox(height: 20,),
              const Text("Load Presets", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Text("Select a preset from the drop", style: TextStyle(fontSize: 24),),
              const Text("down-box and press the 'Load'", style: TextStyle(fontSize: 24),),
              const Text("button to load a custom preset.", style: TextStyle(fontSize: 24),),

            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              SizedBox(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset("assets/delete_preset.png", fit: BoxFit.contain,),
              ),
              const SizedBox(height: 20,),
              const Text("Delete Presets", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Text("Select a preset from the drop", style: TextStyle(fontSize: 24),),
              const Text("down-box and press the 'Delete'", style: TextStyle(fontSize: 24),),
              const Text("button to delete a custom preset.", style: TextStyle(fontSize: 24),),
            ],
          ),
        ),
      ],
      showSkipButton: true,
      showNextButton: false,
      skip: const Text("Skip", style: TextStyle(color: Colors.blue),),
      done: const Text("Done", style: TextStyle(color: Colors.blue),),
      onDone: () {
        context.go("/home");
      },
      skipStyle: TextButton.styleFrom(
          overlayColor: Colors.blue
      ),
      doneStyle: TextButton.styleFrom(
          overlayColor: Colors.blue
      ),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.blue
      ),
    );
  }
}

