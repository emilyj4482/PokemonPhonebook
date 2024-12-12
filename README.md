# 포켓몬 연락처 앱
> 네트워크 통신을 이용해서 `https://pokeapi.co/` 서버에서 랜덤 포켓몬 이미지를 불러와서 프로필 사진으로 달고, 연락처를 입력 받아 저장하는 앱을 개발합니다.

| MainListView | PhoneBookView |
| ----- | ----- |
| <img src="https://github.com/user-attachments/assets/ae80f30c-f321-421b-b4f7-bf492225f8d7" width=430> | <img src="https://github.com/user-attachments/assets/8f758319-8afc-4911-97f1-1c4bf84fd3c3" width=430> |

## 개요
- 개인 프로젝트 입니다.
- storyboard 없는 code base `UIKit`으로 구현했습니다.
- `MVVM` 패턴을 적용했습니다.
- `Delegate` 패턴을 활용했습니다.
- `SnapKit`, `Alamofire` 라이브러리를 활용했습니다.
- `CoreData`를 사용하여 디스크 저장 기능을 구현했습니다.
> 개발과정을 담은 포스팅 시리즈 : https://velog.io/@emilyj4482/series/PhonebookApp

## 프로젝트 구조
```
📦 PokemonPhoneBook
├── 📂 App
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   ├── Info.plist
│   ├── LaunchScreen.storyboard
│   └── SceneDelegate.swift
├── 📂 Helper
│   ├── +Notification.swift
│   ├── +UIImage.Swift
│   ├── +UIImageView.swift
│   ├── +UIView.swift
│   ├── CDKey.swift
│   └── Mode.swift
├── 📂 Service
│   └── NetworkService.swift
├── 📂 Manager
│   └── CoreDataManager.swift
├── 📂 Model
│   ├── PhoneBook.swift
│   └── Pokemon.swift
├── 📂 View
│   ├── MainListView.swift
│   ├── ListCell.swift
│   └── PhoneBookView.swift
├── 📂 Controller
│   ├── MainListViewController.swift
│   └── PhoneBookViewController.swift
├── 📂 ViewModel
│   ├── MainListViewModel.swift
│   └── PhoneBookViewModel.swift
├── 💾 PokemonPhonebook.xcdatamodeld 
```

## 기능 소개
