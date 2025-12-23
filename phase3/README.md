
# **MatchMate – Relationship Tracker for Men**
### *CS310 – Mobile Application Development*

---

## **Team Members**
|        Name       |   ID  |
|------------------ |-------|
| Toprak Aras       | 32150 |
| Fikret Dara Aktaş | 32511 |
| Kaan Kaplan       | 31946 |
| Onur Deniz Öğüncü | 30744 |
| Sezgin Berk Özer  | 32163 |
| Deniz Barçatayin  | 32405 |

---

## **Project Title**
### **MatchMate – Relationship Tracker for Men**

---

## **Problem Definition**

Many men struggle to keep track of important dates, gifts, partner details, or emotional patterns due to busy routines. MatchMate solves this by disguising itself as a *sports-tracking* app (similar to Maçkolik), providing relationship-focused reminders and insights in a subtle, familiar, privacy-friendly interface.

Users can track anniversaries, gifts, partner preferences, and emotional insights—all presented through a football-style UI that blends naturally into their daily phone usage.

---

## **Target Audience**

The app is designed for **male partners** who want to manage relationship-related information discreetly.  
It is especially beneficial for:

- Men who forget dates or important details  
- Users who want privacy (e.g., disguised notifications)  
- Customers who prefer a playful, sports-themed interface over traditional relationship apps  

---

## **Platform & Technologies**

### **Platform**
- **Flutter & Dart** (cross-platform mobile development)

### **Backend / Storage**
- **Firebase Authentication**
- **Cloud Firestore** (partner data, events, reminders, gifts, cycle data)

---

## **Core Features**

### **1. Onboarding & Partner Setup**
- Users enter partner details (name, birthday, preferences, favorite team, etc.)
- Used for personalized reminders and theming.

### **2. Partner & Event Management**
- Add/edit/delete anniversaries, birthdays, and custom events
- Events sync with Firebase
- Clean sports-themed interface

### **3. Gift History**
- Save past gifts with type, date, and custom notes
- Helps avoid repeated gifts and track relationship effort

### **4. Smart Notifications (Sports-Style Privacy Mode)**
- Notifications look like football updates  
  - *“A tough week is coming for Galatasaray”* → cycle approaching  
  - *“Big match in 2 days!”* → anniversary approaching  
- Users can toggle:
  - **Open Mode**
  - **Hidden/Disguised Mode**

### **5. Menstrual Cycle & Mood Insight (Optional-Core)**
- Shows cycle data on the calendar (with explicit consent)
- Gentle mood predictions:
  - “More sensitive week”
  - “High energy — great time for plans”

### **6. Team Mode (Theme Selection)**
- App colors adapt to user’s favorite football team
- Examples: Galatasaray, Fenerbahçe, Beşiktaş
- Enhances disguise and personalization

---

## **Optional / Nice-to-Have Features**

### **Smart Chat Assistant (Relationship Coach)**
- Rule-based helper suggesting gifts or gestures
- e.g. “It’s been a while since you bought flowers.”

### **Custom Reminder Types**
- Create tasks like “Buy coffee” or “Plan a surprise date.”

### **Stealth / Privacy Mode**
- PIN-locked sections for sensitive data
- Hide/blur cycle or gift history

### **Stats Page (Relationship Analytics)**
- Visualized charts:
  - Number of gifts per year
  - Recent event activity
  - Monthly relationship engagement score

---

## **Unique Selling Point (USP)**
MatchMate is **a relationship assistant disguised as a football app**.  
This blend of:

- **emotional intelligence**,  
- **sports aesthetics**, and  
- **privacy-oriented design**  

makes it a standout experience for users seeking subtle, relationship-friendly support.

---

## **Challenges & Considerations**

1. Designing realistic football-style notifications that still convey relationship-specific meaning  
2. Handling sensitive data securely (cycle & partner details)  
3. Managing state & Firebase synchronization efficiently in Flutter  
4. Achieving seamless balance between sports UI and emotional/relationship content

---

## **Repository Info**

This GitHub repository contains:

- Flutter project files  
- Dart source code  
- UI screens & widget structure  
- Firebase integration modules  
- Assets, theme files, and navigation routes  

---

## **Setup Instructions**

1. Clone the repository  
   ```bash
   git clone https://github.com/onuroguncu/CS310-Project-MatchMate-App.git
   ```

2. Install dependencies  
   ```bash
   flutter pub get
   ```

3. Connect a simulator or Android/iOS device  
   ```bash
   flutter devices
   ```

4. Run the app  
   ```bash
   flutter run
   ```

---

## **License**
No license selected as per project requirements.
