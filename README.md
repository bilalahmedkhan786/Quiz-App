# QuizApp

QuizApp is a dynamic and interactive quiz application developed using Flutter. It supports both user and admin functionalities, including user registration, quiz management, score tracking, and progress visualization. The app integrates with Firebase for backend support, enabling secure authentication, real-time data storage, and retrieval.

## Features

### User Features
- **User Registration & Login:** Users can register and log in to access the quizzes.
- **Start Quiz:** Users can participate in quizzes from various categories.
- **View Scores:** Users can view their scores for different quiz categories.
- **Track Progress:** Users can track their progress in each category, visualized in graph form.
- **User Profile:** Users can view and edit their profile information.

### Admin Features
- **Admin Login:** The admin can log in using the predefined credentials.
- **Manage Quizzes:** Admins can add, edit, update, and delete quizzes.
- **Manage Users:** Admins can perform all CRUD operations on users (Create, Read, Update, Delete).
- **Dashboard:** The admin dashboard provides an overview of quiz and user management.

## Installation

### Prerequisites

- Flutter SDK
- Firebase project setup with Firestore and Authentication enabled

### Steps

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/quizapp.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd quizapp
    ```

3. **Install dependencies:**

    ```bash
    flutter pub get
    ```

4. **Configure Firebase:**

    - Follow the instructions to integrate Firebase with your Flutter project:
      - [Firebase for Flutter Setup](https://firebase.flutter.dev/docs/overview)

    - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective folders.

5. **Run the application:**

    ```bash
    flutter run
    ```

## Usage

- **User Registration & Login:**
  - Users can sign up using their email and password.
  - Admin can log in using the credentials:  
    - Email: `admin@gmail.com`  
    - Password: `admin123`
  
- **Start Quiz:**
  - Select a quiz category and start answering the questions.
  
- **View Scores:**
  - Navigate to the "My Scores" section to view the scores across different categories.

- **Progress Tracking:**
  - View progress in the "Progress" section with a graph showing quiz attempts over time.

- **Admin Dashboard:**
  - Access admin functionalities like quiz and user management.

## Project Structure

```plaintext
lib/
├── admin/              # Admin related screens and logic
├── models/             # Data models
├── page/               # login and register 
├── shared/             # Shared widgets and utility functions
├── user/               # User related screens and logic
└── main.dart           # Entry point of the application
```

## Dependencies

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [GetX](https://pub.dev/packages/get)
- [fl_chart](https://pub.dev/packages/fl_chart)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter community for the fantastic support.
- Firebase for providing an easy-to-use backend service.
- [GetX](https://pub.dev/packages/get) for state management.
- [fl_chart](https://pub.dev/packages/fl_chart) for the progress chart.

---

This template covers the basic aspects of your quiz app project. You can adjust the content to fit the specifics of your application and include any additional information you think is necessary.
