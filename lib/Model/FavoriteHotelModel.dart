class FavoriteHotelModel {
  final int id;
  final int userId;
  final int hotelId;
  final String hotelName;
  final String hotelImage;
  final double hotelRating;
  final double hotelPrice;
  final String hotelAddress;
  final int availableRooms;

  FavoriteHotelModel({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.hotelName,
    required this.hotelImage,
    required this.hotelRating,
    required this.hotelPrice,
    required this.hotelAddress,
    required this.availableRooms,
  });

  factory FavoriteHotelModel.fromMap(Map<String, dynamic> map) {
    return FavoriteHotelModel(
      id: map['id'],
      userId: map['userId'],
      hotelId: map['hotelId'],
      hotelName: map['hotelName'],
      hotelImage: map['hotelImage'],
      hotelRating: (map['hotelRating'] as num).toDouble(),
      hotelPrice: (map['hotelPrice'] as num).toDouble(),
      hotelAddress: map['hotelAddress'],
      availableRooms: map['availableRooms'],
    );
  }
}
