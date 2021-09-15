### 요약

- Airbnb iOS App 클로닝
- 기간 : 2021.06

### 주요 기능

- 장소 검색 시 자동 완성
- 달력에서 날짜 선택

### 고민한 내용

뷰와 뷰 모델의 바인딩

- Box 개념 사용해서 Box의 value 값이 업데이트 될 때마다 listener(closure)가 실행되도록 한다.

```swift
final class Box<T> {
  
  typealias Listener = (T) -> Void
  
  var listener: Listener?
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
```

- `Box`를 활용하여 Calendar의 날짜를 선택하면 선택된 값이 표시되도록 구현한다.

```swift
class CalendarViewModel {
  
  let dates = Box<[Date]>([])
  
  func selectDate(date: Date) {
    if dates.value.count > 1 {
      dates.value = [date]
    } else {
      dates.value.append(date)
    }
    dates.value.sort()
  }
  
  func deselectDate(date: Date) {
    if dates.value.contains(date) {
      let index = dates.value.firstIndex(of: date)!
      dates.value.remove(at: index)
    }
  }
}
```

화면 전환을 위해 View Controller 간의 강한 coupling이 발생하는 문제

- 화면 전환을 담당하는 delegate 역할의 Coordinator 객체를 정의하고 화면 전환 역할을 위임

```swift
protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get }
  func start()
}

class MainCoordinator: Coordinator {
  let window: UIWindow
  let navigationController: UINavigationController
  var searchCoordinator: SearchCoordinator
  var calendarCoordinator: CalendarCoordinator
  
  init(window: UIWindow) {
    self.window = window
    let navigationController = UINavigationController()
    navigationController.navigationBar.tintColor = .systemPink
    self.navigationController = navigationController
    self.window.rootViewController = navigationController
    
    searchCoordinator = SearchCoordinator(navigationController: navigationController)
    calendarCoordinator = CalendarCoordinator(navigationController: navigationController)
  }
  
  func start() {
    let vc = MainViewController.instantiate()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
  }
}
```

메인 화면을 nested collection view로 구현 → 코드의 복잡함

- Compositional Layout API를 학습해보고 적용

```swift
func generateLayout() -> UICollectionViewLayout {
  let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
    let sectionLayoutKind = Section.allCases[sectionIndex]
    switch sectionLayoutKind {
    case .nearbyDestinations: return self.nearbyDestinationLayout()
    case .travelStyles: return self.travelStylesLayout()
    }
  }
  return layout
}

private func nearbyDestinationLayout() -> NSCollectionLayoutSection {
  let itemSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(1),
    heightDimension: .fractionalHeight(1))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  item.contentInsets = .init(top: 0, leading: 0, bottom: padding, trailing: padding)
  
  let groupSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(0.6),
    heightDimension: .fractionalWidth(0.4))
  let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
  
  let headerSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(1),
    heightDimension: .estimated(44))
  let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
    layoutSize: headerSize,
    elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
  
  let section = NSCollectionLayoutSection(group: group)
  section.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
  section.boundarySupplementaryItems = [headerItem]
  section.orthogonalScrollingBehavior = .groupPaging
  
  return section
}
```

### 개선하고 싶은 부분

- 뷰(Cell)의 사이즈를 지정하는 데 매직 넘버(고정 값)를 사용한 것

### 학습거리

- [DiffableDataSource](https://velog.io/@lena_/iOS13-UITableViewDiffableDataSource)
- Compositonal Layout
- Custom Calendar
- Coordinator Pattern
- SearchController
- MapKit (auto complete)

### Screenshots
<img src="https://user-images.githubusercontent.com/75113784/133397222-9ea0f6a9-ce5c-420e-abc8-82cb4a37932a.gif" width="30%"> <img src="https://user-images.githubusercontent.com/75113784/133397239-6015927d-9236-4677-880d-eb7cae6bebd6.gif" width="30%"> <img src="https://user-images.githubusercontent.com/75113784/133397211-37a7b071-db97-495f-bb0a-ccf98c9e8726.png" width="30%">
