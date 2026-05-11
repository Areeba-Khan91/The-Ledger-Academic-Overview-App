📘 The Ledger — Professional Academic Overview App
<p align="center"> <img src="https://img.shields.io/badge/Flutter-3.x-blue.svg" /> <img src="https://img.shields.io/badge/Dart-3.x-blue.svg" /> <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-green.svg" /> </p>
📱 Overview

The Ledger is a complete multi-screen Flutter application designed with a focus on high-end professional UI/UX, secure authentication, and architectural cleanliness.

It serves as a comprehensive dashboard for students to manage their:

Academic progress
Schedules
Subject details
📱 Features
🔐 Advanced Authentication Flow
Stateful Registration

Users must register before gaining access. Data is persisted across the session using a centralized Controller layer.

Secure Password Validation

Minimum 6 characters
Mandatory one uppercase letter
Mandatory one special character (!@#$)

Real-time Validation

Interactive UI feedback with a dynamic Security Requirements checklist that updates as you type.

📊 Professional Dashboard
Academic Overview

Displays GPA, Credits, and Rank using custom-designed stat cards.

Dynamic Subject Tracking

Interactive cards for subjects:

Mobile App Development
Software Re-engineering
MIS

Featuring:

Custom Material icons
Individual progress bars (75%, 32%, etc.)
Schedule snapshots
Session Management

Logout functionality that securely returns the user to the Login screen.

📄 Subject Detail Interface
Contextual Data

Unique descriptions, learning objectives, and instructor details for every subject.

Floating UI Elements

Features a Next Session floating card and unique banner images per course.

Interactive Schedule

Detailed breakdown of:

Lab rooms
Timings
Instructor profiles
🏗️ Technical Implementation
Clean Architecture

The project follows a strict Controller-View-Model (CVM) pattern:

Controllers

Separates business logic (Authentication, User State) from the UI.

Models

Strong typing for Subject data and User accounts.

Utils

Centralized reusable AppValidators and Enums.

🎨 UI / UX Standards
Mobile-Justified Layout

Implemented ConstrainedBox and Center widgets to ensure a perfect mobile aspect ratio even when running on Web or Desktop browsers.

Branding

Strictly follows The Ledger design language with a lavender / navy blue color palette.

Material 3

Utilizes modern Material 3 design components for a fluid user experience.

📂 Project Structure
lib/

├── controllers/    # Business logic & Auth management

├── models/         # Data structures (Subject, User)

├── utils/          # Custom validators & Enums

├── views/          # Registration, Login, Dashboard, & Detail screens

└── main.dart       # App entry point & Theme configuration

🚀 Getting Started
Clone the repository
git clone https://github.com/your-username/the-ledger-flutter.git
Navigate to the project directory
cd the-ledger-flutter
Install dependencies
flutter pub get
Run the application
flutter run
🛠️ Security & Validation Logic
Email Format

Regex-based validation for institutional emails.

Credential Matching

Login only permits access if credentials match the registration data exactly.

Interactive Feedback

Uses:

autovalidateMode: AutovalidateMode.onUserInteraction

for a professional feel.

<p align="center">
❤️ Developed with Flutter
</p>


<img width="289" height="626" alt="WhatsApp Image 2026-05-11 at 19 16 29" src="https://github.com/user-attachments/assets/ea934ea1-c063-4918-a4f0-bbf22d26be11" />
<br>
<br>
<img width="331" height="599" alt="WhatsApp Image 2026-05-11 at 19 16 29 (1)" src="https://github.com/user-attachments/assets/0d915c5b-af0a-4369-b72f-731fe550207d" />
<br>
<br>
<img width="409" height="632" alt="WhatsApp Image 2026-05-11 at 22 46 01" src="https://github.com/user-attachments/assets/22a35e69-6340-4c12-984a-6451da5c113d" />
<br>
<br>
<img width="312" height="565" alt="WhatsApp Image 2026-05-11 at 22 55 17" src="https://github.com/user-attachments/assets/1c187d11-8441-4435-886c-0f4c1d378e92" />
<img width="316" height="216" alt="WhatsApp Image 2026-05-11 at 22 55 36" src="https://github.com/user-attachments/assets/21afb098-689e-425b-b879-3f9a0f708b3b" />
<br>
<br>
<img width="341" height="591" alt="WhatsApp Image 2026-05-11 at 22 55 59" src="https://github.com/user-attachments/assets/f2024c1a-13d6-4fa5-a63d-62f85f941784" />
<img width="308" height="171" alt="WhatsApp Image 2026-05-11 at 22 56 11" src="https://github.com/user-attachments/assets/60498485-9afc-47d7-b9ee-7c763927528d" />
<br>
<br>
<img width="334" height="588" alt="WhatsApp Image 2026-05-11 at 22 56 37" src="https://github.com/user-attachments/assets/db08b0ed-079e-4d7e-acb0-bc7ad4f1ba8d" />
<img width="313" height="185" alt="WhatsApp Image 2026-05-11 at 22 56 49" src="https://github.com/user-attachments/assets/b38a1d89-7a54-47ca-8126-bf655f70164b" />


















