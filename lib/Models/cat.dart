class Cat {
    final String id;
    final String url;
    final int width;
    final int height;

    final String? breedID;
    final String? breedName;

    Cat({
        required this.id,
        required this.url,
        required this.width,
        required this.height,

        this.breedID,
        this.breedName,
    });

    factory Cat.fromJson(Map<String, dynamic> json) {
        final breeds = json['breeds'] as List<dynamic>?;

        return Cat(
            id: json['id'], 
            url: json['url'], 
            width: json['width'] ?? 0, 
            height: json['height'] ?? 0,
            breedID: breeds != null && breeds.isNotEmpty ? breeds[0]['id'] : null,
            breedName: breeds != null && breeds.isNotEmpty ? breeds[0]['name'] : null
        );
    }
 }