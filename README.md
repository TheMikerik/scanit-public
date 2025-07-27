# Scanit – iOS 3D Scanning App (Bachelor Thesis Showcase)

**Scanit** is a mobile 3D scanning application developed as part of a bachelor thesis for **[Invent Medical Group](https://www.inventmedical.com)**. The app leverages the TrueDepth camera available on modern iOS devices to capture high-resolution RGBD (color + depth) data and reconstructs it into 3D mesh models.

> ⚠️ **Note:** This is a **showcase-only** public repository. Most parts of the implementation (especially processing logic and proprietary components) are confidential and not included here.

---

## ✨ Features

- **iOS App** built using Flutter (UI) and Swift (native modules)
- **TrueDepth Camera** for depth + RGB capture
- **Real-time RGBD Streaming** to a Python backend via WebSocket
- **3D Mesh Reconstruction** and export in `.obj` format
- **Noise Filtering**, **PointCloud**, **ICP Alignment**, **TSDF** and **Segmentation** support

---

## 📱 Tech Stack

### Frontend
- **Flutter & Riverpod** for cross-platform UI
- **Swift** for native iOS integrations (camera, WebSocket, depth data access)

### Backend
- **Python WebSocket Server** to handle image and depth data
- Custom processing pipeline (not open sourced)

---

## 📸 Showcase

### App Screenshots
![Scanit Screenshot 1](assets/1.jpeg) ![Scanit Screenshot 2](assets/2.jpeg) ![Scanit Screenshot 3](assets/3.jpeg) ![Scanit Screenshot 4](assets/4.jpeg)

![Scanit Screenshot 5](assets/5.jpeg) ![Scanit Screenshot 6](assets/6.jpeg) ![Scanit Screenshot 7](assets/7.jpeg) ![Scanit Screenshot 8](assets/8.jpeg)

![Scanit Screenshot 9](assets/9.jpeg) ![Scanit Screenshot 10](assets/10.jpeg) ![Scanit Screenshot 11](assets/11.jpeg) ![Scanit Screenshot 12](assets/12.jpeg)

### Exported 3D Model
![Scanit Result 4](assets/16.png)

*Click on any image to view it in full size.*

---

## 📂 Flutter Folder Structure (Showcase)
```
lib/
├── src/
│   ├── core/
│   │   ├── common/              # Shared widgets & components
│   │   ├── error/               # Error handling
│   │   ├── extensions/          # Extension methods
│   │   ├── resources/           # Assets, strings, colors
│   │   ├── routing/             # GoRouter setup
│   │   ├── theme/               # App theming
│   │   └── utils/               # Helper methods
│   ├── features/                # Feature-based structure
│   │   └── [feature]/           # Name of desired feature
│   │       ├── service/         # Handles external services (APIs, Firebase, storage, etc.)
│   │       ├── data/            # Implements repositories, maps data between DTOs and domain models
│   │       ├── domain/          # Contains core business logic: entities, use cases, and repository contracts
│   │       └── presentation/    # UI layer: screens, widgets, controllers and state management
│   └── app.dart                 # App widget
└── main.dart                    # Entry point
```

---

## 🔒 Confidentiality Notice

All parts of the project are proprietary to the company that commissioned this work and **are not included** in this repository.

For academic or technical inquiries, please reach out to the author.

---

## 📧 Author

**Michal Ručka**  
Bachelor's Thesis – VŠB-TUO, Faculty of Electrical Engineering and Computer Science  
Email: ruc0066@vsb.cz