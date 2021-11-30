class OnBoardingModel {
  OnBoardingModel._({required this.title, required this.text, required this.imagePath});

  final String title;
  final String text;
  final String imagePath;

  static final recognition = OnBoardingModel._(
    title: 'Brand Recognition',
    text: 'Boost your brand recognition \n with each click. Generic links don’t mean a thing. Branded links help instil confidence in your content.',
    imagePath: 'assets/images/diagram.svg'
  );

  static final detailedRecords = OnBoardingModel._(
    title: 'Detailed Records',
    text: 'Gain insights into who is clicking your links. Knowing when and where people engage with your content helps inform better decisions. ',
    imagePath: 'assets/images/Gauge.svg'
  );

  static final customizable = OnBoardingModel._(
    title: 'Fully Customizable ',
    text: 'Improve brand awareness and content discoverability through customizable links,\n supercharging audience engagement ',
    imagePath: 'assets/images/tools.svg'
  );

  static final list = <OnBoardingModel>[recognition, detailedRecords, customizable];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OnBoardingModel &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              text == other.text &&
              imagePath == other.imagePath;

  @override
  int get hashCode => title.hashCode ^ text.hashCode ^ imagePath.hashCode;
}