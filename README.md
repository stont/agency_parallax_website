# Bubble House Biz 🏠

Welcome to Bubble House Biz! 

## 🎯 What Makes This Project Cool

- 🎬 Smooth sliding animations for your content
- 📱 Works great on phones, tablets, and computers
- 💬 Built-in WhatsApp and Email buttons for easy customer contact
- 🎨 Easy to customize with your own colors and content
- 📖 Story-based design to showcase your business

## 🚀 Getting Started (Step by Step)

### 1. Set Up Your Computer

First, you'll need to install some tools:

1. Install [Flutter](https://flutter.dev/docs/get-started/install)
2. Install [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
3. Install [Git](https://git-scm.com/downloads)

### 2. Get The Project

Open your terminal/command prompt and run:

```bash
# Clone the project
git clone https://github.com/stont/agency_parallax_website.git

# Go into the project folder
cd bubble_house_biz

# Get all the required packages
flutter pub get
```

### 3. Make It Your Own

#### Change Basic Information
Open `lib/core/constants/strings.dart` and change these:
```dart
// Your business information
const String APP_NAME = 'Your Business Name';
const String CONTACT_EMAIL = 'your.email@example.com';
const String WHATSAPP_NUMBER = 'your-whatsapp-number';
```

#### Change Colors
In `lib/app/theme.dart`, customize your colors:
```dart
// Your brand colors
final primaryColor = Color(0xFFYOUR_COLOR);
final secondaryColor = Color(0xFFYOUR_COLOR);
```

#### Change Content
Find and edit these files to add your own content:
- `lib/core/constants/story_content.dart` - Main website text
- `lib/data/story_data/` - Stories and testimonials
- `assets/images/` - Add your own images

### 4. Run The Project

In VS Code or Android Studio:
1. Open the project folder
2. Press F5 or click the Run button
3. Select 'Chrome' as your target device

Or use terminal:
```bash
flutter run -d chrome
```

## 📱 Cool Features You Can Customize

### WhatsApp & Email Buttons
The floating buttons in the corner let visitors contact you easily:
- WhatsApp button opens WhatsApp chat
- Email button opens email client
- Easy to customize in `lib/shared/widgets/floating_buttons.dart`

### Story Sections
Your content is organized in these sections:
1. Welcome slider (Hero section)
2. Core values
3. Services
4. Team stories
5. Customer reviews

Each section is in `lib/features/` - modify them to match your needs!

### Images
Replace the demo images with your own:
1. Go to `assets/images/`
2. Add your images in the right folders:
    - `hero/` - Main slider images
    - `services/` - Service section images
    - `team/` - Team member photos
    - `stories/` - Other story images

## 🎨 Customization Tips

### To Change Colors:
```dart
// In lib/app/theme.dart
class AppTheme {
  static final Color primaryColor = Color(0xFFYOUR_COLOR);
  static final Color accentColor = Color(0xFFYOUR_COLOR);
}
```

### To Change Text:
```dart
// In lib/core/constants/strings.dart
class AppStrings {
  static const String welcome = 'Your Welcome Message';
  static const String about = 'Your About Text';
}
```

### To Add New Features:
1. Create a new folder in `lib/features/`
2. Add your new screens and widgets
3. Update `lib/app/routes.dart` with new pages

## ❓ Need Help?

Got stuck? Here's what to do:
1. Check the Flutter documentation at [flutter.dev](https://flutter.dev/docs)
2. Look for similar code in the project's existing features
3. Try Flutter's Discord community for help
4. Search on Stack Overflow with the [flutter] tag

## 🚦 Project Structure

Here's where to find everything:
```
lib/
├── app/                  # App setup
├── core/                 # Basic stuff
│   ├── constants/        # Text and settings
│   ├── services/        # Main functions
│   └── utils/           # Helper tools
├── features/            # Main sections
│   ├── home/
│   ├── about/
│   ├── services/
│   └── contact/
└── shared/              # Reusable parts
    ├── widgets/
    └── animations/
```

## 📝 Next Steps

1. Replace the demo content with your own
2. Update colors to match your brand
3. Add your own images
4. Test on different devices
5. Deploy to your hosting service

You're ready to go! Feel free to modify anything to make it perfect for your needs. Happy coding! 🎉
