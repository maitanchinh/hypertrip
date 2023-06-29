part of '../view.dart';

Widget _buildHeader(LoadTourDetailSuccessState state, BuildContext context) {
  return Container(
    height: 300,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 18,
          offset: const Offset(0, 18),
        ),
      ],
    ),
    child: Stack(
      children: [
        /// image
        commonCachedNetworkImage(
          state.tour.thumbnailUrl,
          fit: BoxFit.cover,
          height: 300,
          radius: 20,
          width: double.infinity,
        ),

        /// dark overlay
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              // radius bottomleft 20, bottomright 20, gradient black
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // radius: 17,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PText(
                    state.tour.title,
                    color: Colors.white,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      PSmallText(state.tour.departure),
                      const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: AppColors.textGreyColor,
                        size: 14,
                      ),
                      PSmallText(state.tour.destination)
                    ],
                  ),
                  const SizedBox(height: 10),
                  PSmallText(state.tour.duration)
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
