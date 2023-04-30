import 'package:flutter/cupertino.dart';

//global keys

const String jsonPath = "assets/json";

class JsonAssets {
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
}

//images pathes used allover the application
class ImagesPathes {
  static const imagePath = "https://live.staticflickr.com/65535/";
  // static const String tmicoLogoPath = "assets";
  // static const String slitLampMicroscopesPath = "assets/slitLampMicroscopes";
  // static const String operatingMicroscopes = "assets/operatingMicroscopes";
  // static const String imagingSystems = "assets/imagingSystems";
  // static const String diagnosticsAndSpecialist =
  //     "assets/diagnosticsAndSpecialist";
  // static const String opthalmicFurnitures = "assets/opthalmicFurnitures";
  // static const String contactUsPath = "assets";
}
//---------------------------------------------------------------------------------------------------

class SlitLampMicroscopes {
  String name = "Slit Lamp Microscopes";
  String inProductImageUrl = SlitLampMicroscopesImages.slitLampMicroscopes;
  String pathName = "slit-lamp-microscopes";
  String toShowProducts = SlitLampMicroscopesImages.show;
}

class SGL700 {
  String inProductImageUrl = SlitLampMicroscopesImages.gl700Product;
  String pathName = "700gl";
  String name = "700GL";
  String productViewingData =
      "5x step Galilean type, converging optics, upper LED illumination, and built-in background illumination";
}

class SGL700NSW {
  String inProductImageUrl = SlitLampMicroscopesImages.gl700Product;
  String pathName = "700gl-nsw";
  String name = "700GL NSW";
  String productViewingData =
      " 5x step Galilean type, converging optics, upper LED illumination, built in background illumination and wide angle fundus observation";
}

class SGL30 {
  String inProductImageUrl = SlitLampMicroscopesImages.gl30Product;
  String pathName = "30gl";
  String name = "30GL";
  String productViewingData =
      "2x step Greenough type with converging optics and upper LED illumination";
}

class SAT1 {
  String inProductImageUrl = SlitLampMicroscopesImages.at1Product;
  String pathName = "at1";
  String name = "AT-1 Applanation Tonometer";
  String productViewingData =
      "R-Type Compact Applanation Tonometer with option to be permanently fixed to slit lamp with observation from the left eye";
}

class SMS1 {
  String inProductImageUrl = SlitLampMicroscopesImages.ms1Product;
  String pathName = "ms1";
  String name = "MS1 Mobile Slit Lamp Microscope";
  String productViewingData =
      "Portable, LED lighting, anterior segment observation, excellent operability ";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
class OperatingMicroscopes {
  String name = "Operating Microscopes";

  String inProductImageUrl = OperatingMicroscopesImages.operatingMicroscopes;
  String pathName = "operating-microscopes";
  String toShowProducts = OperatingMicroscopesImages.show;
}

class OOM6 {
  String inProductImageUrl = OperatingMicroscopesImages.oom6;
  String pathName = "om6";
  String name = "OM-6";
  String productViewingData =
      "Entry-level operating microscope suitable for anterior and periphery procedures.  LED light source without changing a light bulb. Compact size microscope but high optical performance.";
}

class OOM9 {
  String inProductImageUrl = OperatingMicroscopesImages.oom9;
  String pathName = "om9";
  String name = "OM-9";
  String productViewingData =
      "LED optimised system for outstanding clarity, can be configured in various specifications. Suitable for anterior and posterior surgical procedures.";
}

class OOM19 {
  String inProductImageUrl = OperatingMicroscopesImages.oom19;
  String pathName = "om19";
  String name = "OM-19";
  String productViewingData =
      "The world’s first operating microscope with independent light intensity adjustment for coaxial and red-reflex illumination. With X-Y coupling, zoom magnification, tiltable eyepieces and rotating coaxial stereoscopic assistant microscope. Suitable for anterior and posterior surgical procedures.";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
class ImagingSystems {
  String name = "Imaging Systems";

  String inProductImageUrl = ImagingSystemsImages.imagingSystems;
  String pathName = "imaging-systems";
  String toShowProducts = ImagingSystemsImages.show;
}

class IDIS1 {
  String inProductImageUrl = ImagingSystemsImages.dis1;
  String pathName = "dis1";
  String name = "DIS1 Digital Imaging System";

  String productViewingData =
      "All-in-One CMOS Full HD Microscope Imaging System providing a Sharp, High-Definition Live View";
}

class ITD10 {
  String inProductImageUrl = ImagingSystemsImages.td10;
  String pathName = "td10";
  String name = "TD-10 / EyeCAM Digital Camera & Image Filing Software";
  String productViewingData =
      "Ultra high resolution USB 3.0 with 28 frames per second, DICOM compatible EyeCam software, and integrated yellow filter";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
class DiagnosticsAndSpecialist {
  String name = "Diagnostics & Specialist";

  String inProductImageUrl = DiagnosticsAndSpecialistImages.diagnostics;
  String pathName = "diagnostics&specialist";
  String toShowProducts = DiagnosticsAndSpecialistImages.show;
}

class DARKM150 {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.arkmThumb;
  String pathName = "arkm-150";
  String name = "ARKM-150  Auto-Refkeratometer";
  String productViewingData =
      "Semi-automatic auto refractometer with keratometry";
}

class DCP40 {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.cp40Thumb;
  String pathName = "cp-40";
  String name = "CP-40 LED Chart Projector";
  String productViewingData = "LED chart projector";
}

class DSNT700 {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.snt700Thumb;
  String pathName = "snt-700";
  String name = "SNT-700 Soft Non-contact Tonometer";
  String productViewingData = "Soft non-contact tonometer";
}

class DVT5 {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.vt5Thumb;
  String pathName = "vt-5";
  String name = "VT-5 View Tester";
  String productViewingData = "Manual phoropter";
}

class DSMTUBE {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.smTubeThumb;
  String pathName = "smtube";
  String name = "SMT11EU SMTube";
  String productViewingData = "SMTube for dry eye testing ";
}

class DTF600 {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.tf600;
  String pathName = "tf-600";
  String name = "TF-600 Trial Frame";
  String productViewingData =
      "The Magnon TF-600 is a high quality metal trial frame which is durably constructed, yet light weight comfort for the patient. The fingertip control allows a full range of adjustments for the practitioner.The trial frame can hold any 38 mm trial lens rings. Proper holder spacing ensures accurate additive power results when MAGNON corrected curve additive design lenses are used";
}

class DMT266 {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.mt266;
  String pathName = "mt-266";
  String name = "MT-266-Trial Lens Set";
  String productViewingData =
      "The Magnon MT-266 is full apreture trial lens set which offers a luxurious selection of lens powers to meet practitioner's need";
}

class DACCUON {
  String inProductImageUrl = DiagnosticsAndSpecialistImages.accuon;
  String pathName = "accuon";
  String name = "ACCUON Auto Ref-Keratometer";
  String productViewingData =
      "Easy mode change for adults and childs, capacitive touch operational panel, electrical stage lock by one touch, wide range movement of lcd monitor, simple software update, various ports, wirless communication, slot type main board";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
class OpthalmicFurnitures {
  String name = "Opthalmic Furnitures";

  String inProductImageUrl = OpthalmicFurnituresImages.drone4;
  String pathName = "opthalmic-furnitures";
  String toShowProducts = OpthalmicFurnituresImages.drone41;
}

class FDrone4 {
  String inProductImageUrl = OpthalmicFurnituresImages.drone4;
  String pathName = "drone-4";
  String name = "Drone-4-Refraction Unit";
  String productViewingData =
      "Refraction unit Drone 4 with motorized rotating and sliding tabletop for 4 instruments,electormechanical lock of the table also the vertical movement of the chair is adjustable from the integrated touch table on the tabletop and many other features ";
}

class FDeltaQ {
  String inProductImageUrl = OpthalmicFurnituresImages.deltaQ;
  String pathName = "deltaq";
  String name = "Refraction Unit DeltaQ";
  String productViewingData =
      "Refraction unit DeltaQ with tabletop for 2 instruments,column with overhead led lamp with adjustable illumnation also the vertical movement of the chair is adjustable from the integrated touch table on the tabletop and many other features";
}

class FMDS14 {
  String inProductImageUrl = OpthalmicFurnituresImages.mds14;
  String pathName = "mds-14";
  String name = "MDS14 Refraction Unit";
  String productViewingData =
      "Refraction unit MDS14 with tabletop for 1 instruments";
}

class FMDS14S {
  String inProductImageUrl = OpthalmicFurnituresImages.mds14;
  String pathName = "mds-14s";
  String name = "MDS14s Refraction Unit";
  String productViewingData =
      "Refraction unit MDS14S with sliding tabletop for 1 or 2 instruments";
}

class FZULU1 {
  String inProductImageUrl = OpthalmicFurnituresImages.zulu1;
  String pathName = "zulu1";
  String name = "Zulu1 Refraction Unit";
  String productViewingData =
      "Refraction unit Zulu1 with tabletop for 1 instrument";
}

class FZULU2 {
  String inProductImageUrl = OpthalmicFurnituresImages.zulu2;
  String pathName = "zulu2";
  String name = "Zulu2 Refraction Unit";
  String productViewingData =
      "Refraction unit Zulu1 with tabletop for 2 instruments";
}

class FZULU3 {
  String inProductImageUrl = OpthalmicFurnituresImages.zulu3;
  String pathName = "zulu3";
  String name = "Zulu3 Refraction Unit";
  String productViewingData =
      "Refraction unit Zulu1 with tabletop for 3 instruments";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
//prodcuts images classes
class SlitLampMicroscopesImages {
  static const String slitLampMicroscopes =
      "${ImagesPathes.imagePath}/52421311982_47d01865a2_o.jpg";
  static const String show =
      "${ImagesPathes.imagePath}/52421312007_be2a306ab6_o.jpg";
  static const String slitLamp =
      "${ImagesPathes.imagePath}/52422106064_f52a5f1b83_o.jpg";
  static const String slitLamp700GL =
      "${ImagesPathes.imagePath}/52422270910_a8ece1dfc2_o.jpg";
  static const String slitLamp700GLBlur =
      "${ImagesPathes.imagePath}/52421312102_3e27136877_o.jpg";
  static const String slitLamp30GLFront =
      "${ImagesPathes.imagePath}/52421312242_040651f40b_o.jpg";
  static const String slitLamp30GLSide =
      "${ImagesPathes.imagePath}/52422106309_6629920f31_o.jpg";
  static const String at1 =
      "${ImagesPathes.imagePath}/52421312042_4119882f0e_o.jpg";
  static const String ms1 =
      "${ImagesPathes.imagePath}/52421312027_3015c6b2bb_o.jpg";

  static const String gl700Product =
      "${ImagesPathes.imagePath}/52422335598_69bd5ee135_o.jpg";
  static const String nswgl700Product =
      "${ImagesPathes.imagePath}/52422335598_69bd5ee135_o.jpg";
  static const String gl30Product =
      "${ImagesPathes.imagePath}/52421312162_b7428c6b91_o.jpg";
  static const String ms1Product =
      "${ImagesPathes.imagePath}/52421821306_f9c62f1b0a_o.jpg";
  static const String at1Product =
      "${ImagesPathes.imagePath}/52422270775_ae776ed01d_o.jpg";
}

class OperatingMicroscopesImages {
  static const String operatingMicroscopes =
      "${ImagesPathes.imagePath}/52422106614_018a0d1192_o.jpg";
  static const String show =
      "${ImagesPathes.imagePath}/52421312547_bffa188f5d_o.jpg";

  static const String om6 =
      "${ImagesPathes.imagePath}/52422271425_d7a0cd34d3_o.jpg";
  static const String om6Blur =
      "${ImagesPathes.imagePath}/52421821921_8623bee244_o.jpg";
  static const String om9 =
      "${ImagesPathes.imagePath}/52422271390_6c4dcf74b3_o.jpg";
  static const String om9Blur =
      "${ImagesPathes.imagePath}/52422106634_2c16575bcd_o.jpg";
  static const String om19 =
      "${ImagesPathes.imagePath}/52421821876_fb2d3f8929_o.jpg";

  static const String oom6 =
      "${ImagesPathes.imagePath}/52422106669_7d0a021b4a_o.jpg";
  static const String oom9 =
      "${ImagesPathes.imagePath}/52422336058_218f8bb370_o.jpg";
  static const String oom19 =
      "${ImagesPathes.imagePath}/52422271360_47c820f1ce_o.jpg";
}

class ImagingSystemsImages {
  static const String imagingSystems =
      "${ImagesPathes.imagePath}/52421822286_e49c92e33b_o.jpg";
  static const String dis1 =
      "${ImagesPathes.imagePath}/52422336628_ed34a4b151_o.jpg";
  static const String td10 =
      "${ImagesPathes.imagePath}/52422336528_c415b48f60_o.jpg";
  static const String show =
      "${ImagesPathes.imagePath}/52422336523_f69915708d_o.jpg";
}

class DiagnosticsAndSpecialistImages {
  static const String diagnostics =
      "${ImagesPathes.imagePath}/52422272180_d143c3b618_o.jpg";
  static const String show =
      "${ImagesPathes.imagePath}/52421822556_08eab6da8d_o.jpg";

  static const String arkmThumb =
      "${ImagesPathes.imagePath}/52422273120_758464357f_o.jpg";
  static const String arkmBack =
      "${ImagesPathes.imagePath}/52422107334_07f706a56d_o.jpg";
  static const String cp40Thumb =
      "${ImagesPathes.imagePath}/52421313262_03ebf9b815_o.jpg";
  static const String accuon =
      "${ImagesPathes.imagePath}/52421822701_8ea3c10f43_o.jpg";
  static const String cp40Front =
      "${ImagesPathes.imagePath}/52421822611_6d59d49066_o.jpg";
  static const String cp40Side =
      "${ImagesPathes.imagePath}/52421822656_08626a275a_o.jpg";
  static const String smTubeThumb =
      "${ImagesPathes.imagePath}/52422336993_cba7e071ce_o.jpg";
  static const String smTube =
      "${ImagesPathes.imagePath}/52422272145_5ae8fbbcc4_o.jpg";
  static const String vt5Thumb =
      "${ImagesPathes.imagePath}/52421313127_beee12795d_o.jpg";
  static const String vt5 =
      "${ImagesPathes.imagePath}/52422107189_38558541a0_o.jpg";
  static const String vt5Blury =
      "${ImagesPathes.imagePath}/52422107214_a208e6d087_o.jpg";
  static const String mt266 =
      "${ImagesPathes.imagePath}/52421313242_ff341a8c5b_o.jpg";
  static const String snt700Thumb =
      "${ImagesPathes.imagePath}/52422107224_55aae38e5b_o.jpg";
  static const String snt700CloseView =
      "${ImagesPathes.imagePath}/52422336858_88fd6156fc_o.jpg";
  static const String snt700FrontView =
      "${ImagesPathes.imagePath}/52421822511_4cb648face_o.jpg";
  static const String snt700BlurView =
      "${ImagesPathes.imagePath}/52422272110_de0528e6df_o.jpg";
  static const String snt700lensView =
      "${ImagesPathes.imagePath}/52422272125_6b09d6c33b_o.jpg";
  static const String tf600 =
      "${ImagesPathes.imagePath}/52422336783_78878281fd_o.jpg";
}

class OpthalmicFurnituresImages {
  static const String furnitures =
      "${ImagesPathes.imagePath}/52422109429_0794e0b456_o.jpg";
  static const String drone4 =
      "${ImagesPathes.imagePath}/52422338563_aeef65fdee_o.jpg";
  static const String drone41 =
      "${ImagesPathes.imagePath}/52421314732_2955c9c6f9_o.jpg";
  static const String show =
      "${ImagesPathes.imagePath}/52422108874_e0bfa008b0_o.jpg";

  static const String deltaQ =
      "${ImagesPathes.imagePath}/52422108954_d816c4abe4_o.jpg";
  static const String mds14 =
      "${ImagesPathes.imagePath}/52422273745_bc8615b752_o.jpg";
  static const String zulu1 =
      "${ImagesPathes.imagePath}/52422338503_a1efb721b2_o.jpg";
  static const String zulu2 =
      "${ImagesPathes.imagePath}/52421314682_a76173314d_o.jpg";
  static const String zulu3 =
      "${ImagesPathes.imagePath}/52422338463_b5939bc0f2_o.jpg";
}

class TmicoImages {
  static const String tmicoLogo =
      "${ImagesPathes.imagePath}/52422274640_93bd3a6c05_o.jpg";
}

class OtherImages {
  static const String contactUsImage =
      "${ImagesPathes.imagePath}/52422339443_c9d5ae143b_o.jpg";
  static const String aboutImage =
      "${ImagesPathes.imagePath}/52422109739_8b6e3985ac_o.jpg";
  static const String about1Image =
      "${ImagesPathes.imagePath}/52422109794_fbc0725a6a_o.jpg";
  static const String about2Image =
      "${ImagesPathes.imagePath}/52422109774_a5d0af9690_o.jpg";
  static const String about3Image =
      "${ImagesPathes.imagePath}/52422274675_0a014ce019_o.jpg";
  static const String team =
      "${ImagesPathes.imagePath}/52421315587_3ce64294bc_o.jpg";
}

//----------------------------------------------------------------------------------------------------
class CustomizedText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const CustomizedText(
      {super.key, required this.text, required this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: textStyle,
      softWrap: true,
      textAlign: TextAlign.center,
    ));
  }
}

class CustomizedTextNotCentered extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const CustomizedTextNotCentered(
      {super.key, required this.text, required this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      softWrap: true,
    );
  }
}
