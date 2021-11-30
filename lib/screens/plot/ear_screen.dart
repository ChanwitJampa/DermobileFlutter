
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class EarGalleryScreen extends StatefulWidget{

  _EarGalleryScreen createState() => _EarGalleryScreen() ;
}

class EarGalleryItem {
  EarGalleryItem({
    required this.id,
    required this.resource,
    this.isSvg = false,
  });

  final String id;
  final String resource;
  final bool isSvg;
}

class _EarGalleryScreen extends State<EarGalleryScreen>{

  bool verticalGallery = false;

  late List<EarGalleryItem> galleryItems ;

  void initState() {
    super.initState();
    //assert(_debugLifecycleState == _StateLifecycle.created);
    galleryItems  = <EarGalleryItem>[];

    for(int i = 0 ; i < 10 ; i++){
      galleryItems.add(
        EarGalleryItem(
          id: "tag1",
          resource: "assets/images/cornBorder.jpeg",
        ),
      );
    }

  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  Widget build(BuildContext context){

    return Scaffold(

      body:
          Container(

            height: 100,
           // width: ,

            child:ListView.builder(
              itemCount: galleryItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){

                return GestureDetector(
                  onTap: (){
                    open(context, index);
                  },
                  child: Hero(
                    tag: galleryItems[index].id,
                    child: Image.asset(galleryItems[index].resource, height: 80.0),

                  ),

                );
              },




            ) ,
          )


    );
  }

}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<EarGalleryItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final EarGalleryItem item = widget.galleryItems[index];
    return item.isSvg
        ? PhotoViewGalleryPageOptions.customChild(
      child: Container(
        width: 300,
        height: 300,
        child: SvgPicture.asset(
          item.resource,
          height: 200.0,
        ),
      ),
      childSize: const Size(300, 300),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    )
        : PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}