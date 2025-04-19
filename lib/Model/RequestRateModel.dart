import 'dart:convert';
 
 class Requestaddrate {
   int? idUser;
   int idHotel;
   String? comment;
   double rateStar;
 
   Requestaddrate({
     this.comment,
     this.idUser,
     required this.idHotel,
     required this.rateStar,
   });
 
   Map<String, dynamic> toMap() {
     return {
       'idUser': idUser,
       'idHotel': idHotel,
       if (comment != null) 'comment': comment,
       'rateStar': rateStar,
     };
   }
 
   factory Requestaddrate.fromMap(Map<String, dynamic> map) {
     return Requestaddrate(
       idUser: map['idUser'],
       idHotel: map['idHotel'],
       comment: map['comment'],
       rateStar: (map['rateStar'] as num).toDouble(),
     );
   }
 
   String toJson() => json.encode(toMap());
 
   factory Requestaddrate.fromJson(String source) =>
       Requestaddrate.fromMap(json.decode(source));
 
   @override
   String toString() {
     return 'Requestaddrate(idUser: $idUser, idHotel: $idHotel, comment: $comment, rateStar: $rateStar)';
   }
 }