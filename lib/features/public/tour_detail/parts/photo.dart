part of '../view.dart';

class Photo extends StatefulWidget {
  final List<Carousel>? carousels;
  final int currentPhotoIndex;

  Photo({required this.carousels, required this.currentPhotoIndex});

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  late PageController _pageController;
  int _currentPhotoIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPhotoIndex = widget.currentPhotoIndex;
    _pageController = PageController(initialPage: _currentPhotoIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPhotoIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryLightColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: ActionButton(
              icon: Resource.iconsXmark,
              onPressed: () {
                Navigator.pop(context);
              }).paddingLeft(16)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.carousels!.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FadeInImage.assetNetwork(
                          placeholder: Resource.imagesPlaceholder,
                          image: widget.carousels![index].url.toString()),
                    ).paddingSymmetric(horizontal: 16),
                  );
                },
              ),
            ),
            DotIndicator(
              pageController: _pageController,
              pages: widget.carousels as List<dynamic>,
              indicatorColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
