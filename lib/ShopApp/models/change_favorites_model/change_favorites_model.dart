class ChangeFavModels{
  late bool status;
  late String message;

  ChangeFavModels.fromJason(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}