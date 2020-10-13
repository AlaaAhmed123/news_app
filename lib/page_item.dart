import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'NewsTabs.dart';
import 'dart.dart';
import 'page_transformer.dart';

class IntroPageItem extends StatelessWidget {
  IntroPageItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final IntroItem item;
  final PageVisibility pageVisibility;


  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    var categoryText = _applyTextEffects(
        translationFactor: 500.0,
        child: new InkWell(
          onTap: () => navigationTab(context),
          child: Text(
            item.category,
            style: textTheme.caption.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
              fontSize: 30.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
    );

    var titleText = _applyTextEffects(
      translationFactor: 500.0,
      child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new InkWell(
            onTap: () => navigationTab(context),

            child: Text(
              item.title,
              style: textTheme.title
                  .copyWith(color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'DancingScriptOt',
                  fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
          )
      ),
    );

    return Positioned(
      bottom: 150.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      item.imageUrl,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            imageOverlayGradient,
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }

  void navigationTab(context) {
    switch (item.navigationTab) {
      case 'NewsTabs':
        Navigator.of(context, rootNavigator: true).push(
            new CupertinoPageRoute<bool>(
                fullscreenDialog: false,
                builder: (BuildContext context) =>
                new NewsTabs(country: 'us')));
        break;
     /* case 'EventsTabs' :
        Navigator.of(context, rootNavigator: true).push(
            new CupertinoPageRoute<bool>(
                fullscreenDialog: false,
                builder: (BuildContext context) => new EventsTabs()));
        break;
      case 'PodcastsTabs' :
        Navigator.of(context, rootNavigator: true).push(
            new CupertinoPageRoute<bool>(
                fullscreenDialog: false,
                builder: (BuildContext context) => new PodcastTabs()));
        break;*/
    }
  }
}