import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class GetXSwitchState extends GetxController{

  var isSwitcheded = false;
   final switchdatacontroller = GetStorage();

  GetXSwitchState(){
    if(switchdatacontroller.read('getXIsSwitched') != null){
      isSwitcheded = switchdatacontroller.read('getXIsSwitched');
      update();
    }
  }

  changeSwitchState(bool value){
    isSwitcheded = value;
    switchdatacontroller.write('getXIsSwitched', isSwitcheded);
    update();
  }

}

class GetXSwitchStateTime extends GetxController{


  var isSwitchededTime = false;
  final switchdatacontrollerTime = GetStorage();

  GetXSwitchStateTime(){
    if(switchdatacontrollerTime.read('getXIsSwitched') != null){
      isSwitchededTime = switchdatacontrollerTime.read('getXIsSwitched');
      update();
    }
  }

  changeSwitchStateTime(bool value){
    isSwitchededTime = value;
    switchdatacontrollerTime.write('getXIsSwitched', isSwitchededTime);
    update();
  }
}