class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "แปลภาษามือ",
    image: "assets/images/11.png",
    desc: "แปลภาษามือเป็นภาษาไทย จากกล้องแบบทันที \nเมื่อเปิดกล้องจะสามารถตรวจจับภาษามือและแปลงเป็นภาษาไทยได้ทันที",
  ),
  OnboardingContents(
    title: "พจนานุกรมภาษามือ",
    image: "assets/images/12.png",
    desc:
    "รวบรวมคำศัพท์พื้นฐานที่ใช้ในชีวิตประจำวันมาไว้ในแอปพลิเคชั่น สามารถเข้าถึงได้ง่าย สะดวกและรวดเร็ว",
  ),
  OnboardingContents(
    title: "PHASA MUE",
    image: "assets/images/13.png",
    desc: "มาเริ่มใช้งานกันเถอะ",
  ),
];