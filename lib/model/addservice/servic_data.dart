import 'package:beautybazzle/utiils/static_data.dart';
import 'package:flutter/material.dart';

class UserModel {
  IconData? icon; // IconData type for Flutter icons
  String? name;

  UserModel({this.icon, this.name});

  static List<UserModel> mylist = [
    UserModel(
      icon: Icons.cut, // Icon for Hair Services
      name: "Hair  ",
    ),
    UserModel(
      icon: Icons.face, // Icon for Skin Services
      name: "Skin  ",
    ),
    UserModel(
      icon: Icons.brush, // Icon for Makeup Services
      name: "Makeup",
    ),
    UserModel(
      icon: Icons.handshake, // Icon for Nail Services (for illustration)
      name: "Nail   ",
    ),
    UserModel(
      icon: Icons.spa, // Icon for Body Services
      name: "Body  ",
    ),
    UserModel(
      icon: Icons.celebration, // Icon for Bridal Services
      name: "Bridal",
    ),
  ];
}

class UserModel1 {
  String? name;
  String? Description;
  String? image;
  UserModel1({this.name, this.Description, this.image});
  static List<UserModel1> mylist = [
    UserModel1(
        Description:
            "Transform your look with professional hair services tailored to perfection and treatments for every hair type!",
        name: "Hair Services ",
        image: "images/salon.jpeg"),
    UserModel1(
        Description:
            "Reveal your natural radiance with our complete range of expert skin care services for all skin types!",
        name: "Skin Services ",
        image: "images/salon.jpeg"),
    UserModel1(
        Description:
            "Transform your nails with exquisite designs and expert care – book your perfect manicure today!",
        name: "Nails Services ",
        image: "images/salon.jpeg"),
    UserModel1(
        Description:
            "Enhance your beauty with flawless, professional makeup services for every occasion – book your perfect look today!",
        name: "Makeup Services ",
        image: "images/salon.jpeg"),
    UserModel1(
        Description:
            "Transform and rejuvenate with premium body services tailored to bring out your natural beauty!",
        name: "Body Services ",
        image: "images/salon.jpeg"),
    UserModel1(
        Description:
            "Transform your special day with stunning, all-inclusive bridal beauty services tailored just for you!",
        name: "Bridal Services ",
        image: "images/salon.jpeg"),
  ];
}

////////////////////////////////////////////////////
class UserModel2 {
  String? name;
  String? Description;
  String? image;
  UserModel2({this.name, this.Description, this.image});
  static List<UserModel2> mylist = [
    UserModel2(
        Description:
            "Transform your look with professional hair services tailored to perfection and treatments for every hair type!",
        name: "Hair Services ",
        image: StaticData.myDp),
    UserModel2(
        Description:
            "Reveal your natural radiance with our complete range of expert skin care services for all skin types!",
        name: "Skin Services ",
        image: StaticData.myDp),
  ];
}

/////////////////////////////////////////////////
class UserModel3 {
  String? name;
  String? Description;
  String? image;
  UserModel3({this.name, this.Description, this.image});
  static List<UserModel3> mylist = [
    UserModel3(
        Description:
            "Transform your look with professional hair services tailored to perfection and treatments for every hair type!",
        name: "Hair Services ",
        image: "images/offer.jpeg"),
    UserModel3(
        Description:
            "Reveal your natural radiance with our complete range of expert skin care services for all skin types!",
        name: "Skin Services ",
        image: "images/offer.jpeg"),
    UserModel3(
        Description:
            "Transform your nails with exquisite designs and expert care – book your perfect manicure today!",
        name: "Nails Services ",
        image: "images/offer.jpeg"),
  ];
}

//////////////////////////////////////////////
class UserModel4 {
  String? notification;

  UserModel4({
    this.notification,
  });
  static List<UserModel4> mylist = [
    UserModel4(
      notification:
          "🌸 Pamper yourself today! Book an appointment and shine! 💅✨",
    ),
    UserModel4(
      notification:
          "💖 Special discount on bridal packages this week only! Don’t miss out! 👰",
    ),
    UserModel4(
      notification:
          "✨ Ready for a makeover? Visit us for exclusive hair and skin treatments! 💇‍♀️💆‍♀️!",
    ),
    UserModel4(
      notification:
          "🎉 Limited-time offer: 20% off on manicure & pedicure combos! 💅👣",
    ),
    UserModel4(
      notification:
          "💄 Be party-ready! Book your makeup session now and sparkle all night! ✨",
    )
  ];
}

/////////////////////////////////////////
class UserModel5 {
  String? name;
  String? Description1;
  String? image;
  UserModel5({this.name, this.Description1, this.image});
  static List<UserModel5> mylist = [
    UserModel5(
        Description1:
            "Transform your look with a precise and stylish haircut tailored just for you!",
        name: "Hair Cut",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Transform your look with a vibrant, long-lasting hair color tailored to your style and personality.",
        name: "Hair Color ",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Enhance your hair's natural beauty with stunning highlights that add dimension and style.",
        name: "Highlights",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Enhance your hair with subtle lowlights for added depth and natural dimension.",
        name: "Lowlights",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Transform your look with sleek, smooth, and long-lasting hair straightening for ultimate style and confidence.",
        name: "Hair Straightening",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Achieve silky, frizz-free, and perfectly smooth hair with our professional Hair Smoothing service.",
        name: "Hair Smoothing",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Hair Rebonding",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service",
        name: "Hair Extension",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Hair Styling",
        image: "images/offer.jpeg"),
    UserModel5(
        Description1:
            "Enhance your look with expert hair texturing for added depth, volume, and style",
        name: "Hair Texturing",
        image: "images/offer.jpeg"),
  ];
}

///////////////////////////////////////////////////////////////////////////////
class UserModel6 {
  String? name;
  String? Description1;
  String? image;
  UserModel6({this.name, this.Description1, this.image});
  static List<UserModel6> mylist = [
    UserModel6(
        Description1:
            "Relax and rejuvenate with our luxurious facial treatments, designed to hydrate, brighten, and refresh your skin",
        name: "Facial",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Thorough and professional clean-up to ensure your space is spotless and refreshed, leaving it tidy and inviting.",
        name: "Clean-up",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Brighten and refresh your skin with our nourishing bleach treatment, leaving you with a glowing and even complexion.",
        name: "Bleach",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Experience smooth, flawless skin with our professional waxing service, ensuring comfort and long-lasting results.",
        name: "Waxing",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Threading is a precise and gentle method of hair removal, ideal for shaping eyebrows and removing facial hair.",
        name: "Threading",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Microdermabrasion is a non-invasive exfoliating treatment that removes dead skin cells to reveal a smoother.",
        name: "Microdermabrasion",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Chemical Peels are a skincare treatment that exfoliates the skin, improving texture, tone.",
        name: "Chemical Peels",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Revitalize your skin with our Skin Polishing treatment, designed to remove dead cells, leaving your skin smooth.",
        name: "Skin Polishing",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Achieve a radiant glow with our Skin Brightening treatment, designed to even out skin tone and enhance your natural luminosity",
        name: "Skin Brightenting",
        image: "images/offer.jpeg"),
    UserModel6(
        Description1:
            "Revitalize and firm your skin with our advanced skin tightening treatment, reducing sagging and promoting a youthful.",
        name: "Skin Tightening",
        image: "images/offer.jpeg"),
  ];
}

////////////////////////////////////////////////////////////////////////
class UserModel7 {
  String? name;
  String? Description1;
  String? image;
  UserModel7({this.name, this.Description1, this.image});
  static List<UserModel7> mylist = [
    UserModel7(
        Description1:
            "Transform your look with a precise and stylish haircut tailored just for you!",
        name: "Bridal Makeup",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Transform your look with a vibrant, long-lasting hair color tailored to your style and personality.",
        name: "Party Makeup ",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Enhance your hair's natural beauty with stunning highlights that add dimension and style.",
        name: "Everyday Makeup",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Enhance your hair with subtle lowlights for added depth and natural dimension.",
        name: "Special Occasion Makeup",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Transform your look with sleek, smooth, and long-lasting hair straightening for ultimate style and confidence.",
        name: "HD Makeup",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Achieve silky, frizz-free, and perfectly smooth hair with our professional Hair Smoothing service.",
        name: "Airbrush Makeup",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Makeup Lessons",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service",
        name: "Makeup Trials",
        image: "images/offer.jpeg"),
    UserModel7(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Lash Application",
        image: "images/offer.jpeg"),
  ];
}

//////////////////////////////////////////////////////////
class UserModel8 {
  String? name;
  String? Description1;
  String? image;
  UserModel8({this.name, this.Description1, this.image});
  static List<UserModel8> mylist = [
    UserModel8(
        Description1:
            "Transform your look with a precise and stylish haircut tailored just for you!",
        name: "Manicure",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Transform your look with a vibrant, long-lasting hair color tailored to your style and personality.",
        name: "Pedicure",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Enhance your hair's natural beauty with stunning highlights that add dimension and style.",
        name: "Gel Nail",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Enhance your hair with subtle lowlights for added depth and natural dimension.",
        name: "Acryline Nail",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Transform your look with sleek, smooth, and long-lasting hair straightening for ultimate style and confidence.",
        name: "Nail Art",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Achieve silky, frizz-free, and perfectly smooth hair with our professional Hair Smoothing service.",
        name: "Nail Extension",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Nail Repair",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service",
        name: "Nail Polish",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Nail Shaping",
        image: "images/offer.jpeg"),
    UserModel8(
        Description1:
            "Enhance your look with expert hair texturing for added depth, volume, and style",
        name: "Nail Care",
        image: "images/offer.jpeg"),
  ];
}

/////////////////////////////////////////////////////////////////////////////
class UserModel9 {
  String? name;
  String? Description1;
  String? image;
  UserModel9({this.name, this.Description1, this.image});
  static List<UserModel9> mylist = [
    UserModel9(
        Description1:
            "Transform your look with a precise and stylish haircut tailored just for you!",
        name: "Body Massage",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Transform your look with a vibrant, long-lasting hair color tailored to your style and personality.",
        name: "Body Wrap",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Enhance your hair's natural beauty with stunning highlights that add dimension and style.",
        name: "Body Scrub",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Enhance your hair with subtle lowlights for added depth and natural dimension.",
        name: "Reflexology",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Transform your look with sleek, smooth, and long-lasting hair straightening for ultimate style and confidence.",
        name: "Hot Stone Therapy",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Achieve silky, frizz-free, and perfectly smooth hair with our professional Hair Smoothing service.",
        name: "Swedish Massage",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Deep Tissue Massage",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service",
        name: "Aromatatherapy",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Body Polishing",
        image: "images/offer.jpeg"),
    UserModel9(
        Description1:
            "Enhance your look with expert hair texturing for added depth, volume, and style",
        name: "Body Contouring",
        image: "images/offer.jpeg"),
  ];
}

/////////////////////////////////////////////////////
class UserModel10 {
  String? name;
  String? Description1;
  String? image;
  UserModel10({this.name, this.Description1, this.image});
  static List<UserModel10> mylist = [
    UserModel10(
        Description1:
            "Transform your look with a precise and stylish haircut tailored just for you!",
        name: "Bridal Makeup",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Transform your look with a vibrant, long-lasting hair color tailored to your style and personality.",
        name: "Bridal Hairdo",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Enhance your hair's natural beauty with stunning highlights that add dimension and style.",
        name: "Bridal Nail Art",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Enhance your hair with subtle lowlights for added depth and natural dimension.",
        name: "Bridal Mehendi",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Transform your look with sleek, smooth, and long-lasting hair straightening for ultimate style and confidence.",
        name: "Bridal Package",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Achieve silky, frizz-free, and perfectly smooth hair with our professional Hair Smoothing service.",
        name: "Pre-Bridal Services",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Post-Bridal Services",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service",
        name: "Wedding Day Services",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Engagment Services",
        image: "images/offer.jpeg"),
    UserModel10(
        Description1:
            "Enhance your look with expert hair texturing for added depth, volume, and style",
        name: "Sangeet Services",
        image: "images/offer.jpeg"),
  ];
}

//////////////////////////////////////////////////////////
class UserModel11 {
  String? name;
  String? Description1;
  String? image;
  UserModel11({this.name, this.Description1, this.image});
  static List<UserModel11> mylist = [
    UserModel11(
        Description1:
            "Transform your look with a precise and stylish haircut tailored just for you!",
        name: "Eyebrow Shaping",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Transform your look with a vibrant, long-lasting hair color tailored to your style and personality.",
        name: "Eyelash Extension",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Enhance your hair's natural beauty with stunning highlights that add dimension and style.",
        name: "Hair Removal",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Enhance your hair with subtle lowlights for added depth and natural dimension.",
        name: "Tattoo Removel",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Transform your look with sleek, smooth, and long-lasting hair straightening for ultimate style and confidence.",
        name: "Permanent Makeup",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Achieve silky, frizz-free, and perfectly smooth hair with our professional Hair Smoothing service.",
        name: "Microblading",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Hair Treatment",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service",
        name: "Scalp Treatment",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Transform your hair with sleek, smooth, and frizz-free perfection through our expert Hair Rebonding service.",
        name: "Skin Tag Removal",
        image: "images/offer.jpeg"),
    UserModel11(
        Description1:
            "Enhance your look with expert hair texturing for added depth, volume, and style",
        name: "Mole Removal",
        image: "images/offer.jpeg"),
  ];
}
