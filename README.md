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
### 01) 연락처 목록 조회하기 : UITableView
| blackView | listTableView |
| ----- | ----- |
| <img src ="https://github.com/user-attachments/assets/02f92b91-75ac-4a37-84ef-927980216b71" width=350> | <img src="https://github.com/user-attachments/assets/ae80f30c-f321-421b-b4f7-bf492225f8d7" width=350> |

```swift
// 연락처가 0개일 때 보여주는 뷰
private lazy var blankView: UILabel = {
    let label = UILabel()
        
    label.backgroundColor = .systemBackground
    label.text = "연락처 없음 😕"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 25, weight: .light)
        
    return label
}()

// 연락처 목록 뷰
private lazy var listTableView: UITableView = {
    let tableView = UITableView()
        
    tableView.backgroundColor = .systemBackground
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        
    return tableView
}()
```
- 컨테이너 뷰에 2개의 컴포넌트를 선언하고 Bool 타입의 `테이터 개수 == 0` 값을 파라미터로 받아 두 컴포넌트의 `isHidden` 값에 적절한 값이 할당되도록 구현했습니다.
```swift
// MainListView.swift
func reloadView(_ isBlank: Bool) {
    listTableView.reloadData()
    blankView.isHidden = !isBlank
    listTableView.isHidden = isBlank
}

// MainListViewController.swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
     // 연락처 개수가 0이면 blank view가 뜨도록 bool 값 전달
    containerView.reloadView(vm.phoneBooks.count == 0)
}
```
- `MainListViewDelegate`를 통해 `MainListViewController`와의 소통
> - `ViewModel` → `Controller` → `View` 흐름으로 데이터소스를 전달 받아 테이블 뷰와 연결
> - `cell`의 탭 동작을 전달하여 `PhoneBookViewController`로 이동을 `Controller`가 수행
```swift
protocol MainListViewDelegate: AnyObject {
    func pushPhoneBookView(with index: Int)
    func getPhoneBookCount() -> Int
    func getPhoneBook(with index: Int) -> PhoneBook
}
```
### 02) 연락처 추가하기 : Navigation Bar Button
![Screen Recording 2024-12-12 at 15 40 33](https://github.com/user-attachments/assets/c8d87066-d485-4199-9bd8-271dd8588997)
<br>우측 상단 바 버튼 `추가`를 탭하면 `PhoneBookViewController`로 이동합니다.
<br>이 때, `PhoneBookViewController`는 테이블 뷰 셀을 탭했을 때도 재사용되므로 `조회 모드`와 `추가 모드`를 구분하여 이동하도록 했습니다.
<br>`PhoneBookViewController`의 `viewDidLoad` 시점에 랜덤 포켓몬 이미지가 네트워크 통신을 통해 불러오도록 했습니다.
```swift
class MainListViewController: UIViewController {
    private func setNavigationBar() {
        navigationItem.title = "연락처 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
    }

    @objc func addButtonTapped() {
        let vc = PhoneBookViewController()
        vc.mode = .create
        navigationController?.pushViewController(vc, animated: true)
    }
}

class PhoneBookViewController: UIViewController {
    // view did load에 호출되는 함수 : view model에게 이미지 로드 명령
    // "랜덤 이미지 생성" 버튼을 탭했을 때도 이 함수가 호출된다
    func fetchPokemonImage() {
        vm.fetchPokemon()
    }
}
```
### 03) 연락처 조회하기 : UITableViewDelegate
![Screen Recording 2024-12-12 at 15 52 58](https://github.com/user-attachments/assets/22d13cec-96dd-4337-8f28-001df64762f3)
<br>`didSelectRowAt`에서 `delegate`를 통해 `Controller`에게 상호작용을 알리면 `Controller`는 `조회 모드`로 `PhoneBookController`로 이동합니다.
<br>이 때, 파라미터로 cell의 `indexPath.row` 값을 전달하여 데이터소스에서 `index`번째 자료를 `PhoneBookController`에게 전달한 뒤 이동하도록 구현했습니다.
```swift
extension MainListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pushPhoneBookView(with: indexPath.row)
    }
}

class MainListViewController: UIViewController {
    func pushPhoneBookView(with index: Int) {
        let vc = PhoneBookViewController()
        vc.mode = .read
        vc.phoneBook = vm.phoneBooks[index]
        navigationController?.pushViewController(vc, animated: true)
    }
}
```
- `PhoneBookView`의 재사용
> `enum`으로 모드 값을 관리하여 `.read` 모드일 때는 이름과 연락처가 `UILabel`로 표시되도록 구현
```swift
class PhoneBookView: UIView {
    var mode: Mode {
        didSet {
            setupView()
        }
    }

    private func setupView() {
        switch mode {
        case .read:
            hideTextField(true)
        default:
            hideTextField(false)
        }
        hideDeleteButton()
    }
}
```
### 04) 연락처 수정하기
![Screen Recording 2024-12-12 at 16 16 09](https://github.com/user-attachments/assets/fb4c919b-6a21-4605-a2eb-8da224fafa7c)
<br>연락처 조회 모드 상태에서 우측 상단 바 버튼 `수정`을 탭하면 수정 모드가 되어 `UILabel`이 `hidden`되고 데이터가 입력된 상태의 `UITextField`가 `!hidden` 됩니다.
<br>수정 모드일 때만 `연락처 삭제` 버튼이 보이도록 구현했습니다.
<br>수정사항을 입력하고 `저장` 버튼을 탭하면 변경사항이 적용된 조회 모드 화면이 됩니다.
```swift
// 우측 상단 bar button이 모드에 따라 다르게 동작하도록 분기하는 함수
@objc func barButtonTapped() {
    switch mode {
    case .read:
        // 조회 모드에서 수정 모드로 전환
        mode = .edit
        containerView.mode = mode
        navigationItem.rightBarButtonItem?.title = mode.buttonTitle
        // 조회 중인 연락처 정보가 입력된 상태의 textfield가 뜨도록 컨테이너 뷰 바인딩
        guard let phoneBook = phoneBook else { return }
        containerView.bindTextFields(phoneBook)
    case .create:
        // 추가 버튼이 눌리면 입력된 내용으로 연락처 정보를 생성하고 메인 목록 화면으로 돌아간다
        createPhoneBook()
        navigationController?.popViewController(animated: true)
    case .edit:
        // 수정 모드에서 저장 버튼이 눌리면 입력된 내용을 바탕으로 연락처 정보를 업데이트하고, 업데이트 내용이 반영된 상태로 조회모드로 전환
        updatePhoneBook()
        mode = .read
        containerView.mode = mode
        configureViewByMode()
        navigationItem.rightBarButtonItem?.title = mode.buttonTitle
    }
}
```
### 05) 연락처 삭제하기
![Screen Recording 2024-12-12 at 16 24 55](https://github.com/user-attachments/assets/d812f065-3aa5-4853-bcf4-d4ac98df55e6)
<br>연락처 수정 모드에서만 나타나는 `연락처 삭제` 버튼을 누르면 연락처가 삭제됩니다.
<br>`Controller`는 삭제해야 할 연락처의 `id` 값을 `view model`에게 전달하고 이전 화면인 `MainListViewController`로 이동합니다.
```swift
func deletePhoneBook() {
    guard let id = phoneBook?.id else { return }
    vm.deletePhoneBook(of: id)
    navigationController?.popViewController(animated: true)
}
```
