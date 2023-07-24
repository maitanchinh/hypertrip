part of '../view.dart';

class PlacePhoto extends StatefulWidget {
  final List<Photos>? photos;
  final int currentPhotoIndex;

  PlacePhoto({required this.photos, required this.currentPhotoIndex});

  @override
  _PlacePhotoState createState() => _PlacePhotoState();
}

class _PlacePhotoState extends State<PlacePhoto> {
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
                itemCount: widget.photos!.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: Resource.imagesPlaceholder,
                      image:
                          '${widget.photos![index].prefix}original${widget.photos![index].suffix}',
                    ),
                  )).paddingSymmetric(horizontal: 16);
                },
              ),
            ),
            DotIndicator(
              pageController: _pageController,
              pages: widget.photos!,
              indicatorColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
