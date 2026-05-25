/// Centralized asset management.
/// 
/// Helps avoid hardcoded strings and makes asset path updates easier.
/// This file is the single source of truth for all assets in the application.
class AppAssets {
  AppAssets._();

  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';

  // Icons (SVG)
  static const String menuIcon = '$_imagesPath/hamburger.svg';
  static const String coinIcon = '$_imagesPath/coin.svg';
  static const String submitIcon = '$_imagesPath/poestisticLogo.svg';
  
  // Action Icons (SVG)
  static const String iconLike = '$_iconsPath/like-outline.svg';
  static const String iconShare = '$_iconsPath/share.svg';
  static const String iconSend = '$_iconsPath/send.svg';
  static const String iconDownload = '$_iconsPath/download.svg';
  static const String iconSave = '$_iconsPath/save.svg';
  static const String iconArrowMood = '$_iconsPath/arrow-mood.svg';

  // Images (SVG)
  static const String poetisticLogo = '$_imagesPath/Poetistic.svg';

  // Images (Raster)
  static const String appLogo = '$_imagesPath/Applogo.png';
  static const String logoFinal = '$_imagesPath/LogoFinal.png';

  // Poet Images
  static const String poet1 = '$_imagesPath/poet1.webp';
  static const String poet2 = '$_imagesPath/poet2.webp';
  static const String poet3 = '$_imagesPath/poet3.webp';
  static const String poet4 = '$_imagesPath/poet4.webp';
  static const String poet5 = '$_imagesPath/poet5.webp';

  // Quote Card Backgrounds
  static const String quoteBg1 = '$_imagesPath/TopSyari.jpg';
  static const String quoteBg2 = '$_imagesPath/TopSyari2.jpg';
  static const String quoteBg3 = '$_imagesPath/TopSyari3.jpg';

  // Category Images
  static const String categorySher = '$_imagesPath/sher.jpg';
  static const String categoryGhazal = '$_imagesPath/ghajal.jpeg';
  static const String categoryNazm = '$_imagesPath/nazam.jpeg';
}


