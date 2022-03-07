class PhoneModel {
 late String device_name;
 late String first_price;
 late String second_price;
 late String image;
 late String qualifications;

 PhoneModel.createModel({dynamic data}){
   device_name = data['device_name'];
   first_price = data['first_price'];
   second_price = data['second_price'];
   image = data['image'];
   qualifications = data['qualifications'];
 }
}