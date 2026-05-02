class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({required this.image, required this.title, required this.description});

  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: "assets/images/onboarding.png",
      title: "Find Your Perfect Home, Anywhere",
      description: "Start your journey with a comfortable and reliable home search",
    ),
    OnboardingModel(
      image: "assets/images/onboarding.png",
      title: "Find Your Perfect Home, Anywhere",
      description: "Start your journey with a comfortable and reliable home search",
    ),
    OnboardingModel(
      image: "assets/images/onboarding.png",
      title: "Find Your Perfect Home, Anywhere",
      description: "Start your journey with a comfortable and reliable home search",
    ),
  ];
}
