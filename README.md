# 영화 리뷰 앱
TMDB(The Movie Database) API를 활용한 SwiftUI 기반의 iOS 영화 리뷰 애플리케이션입니다.
# 주요 기능
- 다양한 카테고리별 영화 탐색
  - 현재 상영작
  - 인기 영화
  - 평점 높은 영화
- 영화 상세 정보 조회
- 개인 영화 리뷰 작성 및 관리
- 평점별 리뷰 영화 필터링
- 작성한 리뷰 오프라인 지원
- 부드러운 애니메이션이 적용된 반응형 UI

# 아키텍처
MVVM(Model-View-ViewModel) 아키텍처 패턴과 클린 아키텍처 원칙을 따릅니다:
- View 계층: SwiftUI 뷰
- ViewModel 계층: UI 상태 및 비즈니스 로직 관리
- Repository 계층: 데이터 작업 조정
- Data Sources:
    - Remote: TMDB API
    - Local: Core Data

# 기술 스택
- 프레임워크: SwiftUI
- 데이터 저장소: Core Data
- 네트워킹: URLSession
- 이미지 로딩: Kingfisher
- 아키텍처 패턴: MVVM

# 프로젝트 구조
```
MovieReviewApp/
├── App/
│   └── PrographyTaskApp.swift
├── Presentation/
│   ├── Home/
│   ├── Detail/
│   └── MyPage/
├── Domain/
│   ├── Models/
│   └── Repositories/
├── Data/
│   ├── Network/
│   ├── Local/
│   └── DTOs/
└── Common/
    ├── Extensions/
    └── Utils/
```

#상세 기능
## 홈 화면
- 인기 영화 수평 스크롤 배너
- 카테고리별 탭 네비게이션
- 무한 스크롤 영화 목록
- 일관된 디자인의 커스텀 UI 컴포넌트

## 상세 화면
- 영화 정보 표시
- 리뷰 작성 기능
- 리뷰 수정 및 삭제
- 평점 표시

## 마이페이지
- 리뷰한 영화 그리드 뷰
- 평점 기반 필터링
- 리뷰 관리

## 사용된 라이브러리
- Kingfisher: 효율적인 이미지 로딩 및 캐싱
- TMDB API: 영화 데이터 제공
