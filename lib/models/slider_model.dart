class PhoneModel {
 late String device_name;
 late String first_price;
 late String second_price;
 late String first_image;
 late String second_image;
 late String third_image;
 late String qualifications;
  List<String> images=[] ;
 PhoneModel.createModel({dynamic data}){
   device_name = data['device_name'];
   first_price = data['first_price'];
   second_price = data['second_price'];
   first_image =data['first_image'];
   second_image =data['second_image'];
   third_image =data['third_image'];
   qualifications = data['qualifications'];
   images.add(first_image);
   if(second_image!='null'){
      images.add(second_image);
    }
   if(third_image!='null'){
     images.add(third_image);
   }
 }
}