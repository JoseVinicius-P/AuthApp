import 'package:flutter/material.dart';
import 'package:auth/app/shared/services/my_colors.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key, required this.placeholder, this.avatarImageProvider, this.onTapSelectPhoto, this.showButton,
  });

  final AssetImage placeholder;
  final ImageProvider? avatarImageProvider;
  final void Function()? onTapSelectPhoto;
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Image(
            image: placeholder,
            fit: BoxFit.cover,
          ),
        ),
        ClipOval(
          child: Image(
            image: avatarImageProvider ?? placeholder,
            fit: BoxFit.cover,
          ),
        ),
        if(showButton ?? true) Positioned(
          bottom: 5,
          right: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTapSelectPhoto,
            child: Container(
              decoration: BoxDecoration(
                  color: onTapSelectPhoto == null ? MyColors.primaryColdColor : MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.edit_rounded, color: Colors.white,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}