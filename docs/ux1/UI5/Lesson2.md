# ✨ Lesson 2 – 모듈(파일 분리) 기반 SAPUI5 UI 구성

> 이번 레슨에서는 JS와 HTML을 분리하여 모듈형 구조(sap.ui.define)로 UI를 구성하는 방법을 배웁니다.
> 여기서 모듈, 모듈화는 소스코드를 작은 단위로 나눠서 재사용 가능하게끔 세분화된 단위 또는 단위화를 말합니다.
> 
> 모듈 로딩, `resource-roots` 매핑, `data-sap-ui-on-init` 초기화, 그리고 구조화된 컨트롤 렌더링이 핵심
> 

---

## 📁 폴더 구조 예시

```
project-root/
├─ index.html                      ← (Lesson 2-1 또는 2-2)
├─ resources/sap-ui-core.js        ← SAPUI5 Core SDK 파일
└─ code/
   ├─ unit5l0101/
   │  └─ index.js                  ← Lesson 2-1 자바스크립트
   └─ exercise05/
      └─ index.js                  ← Lesson 2-2 자바스크립트

```

---

# Lesson 2-1 – `sap.ui.define` 기본 모듈 구성

### 🧩 1) 자바스크립트 (code/unit5l0101/index.js)

```jsx
sap.ui.define(
  ["sap/m/Button", "sap/m/Text", "sap/m/Label"],
  function (Button, Text, Label) {
      firstName = "gildong";
      lastname = "Hong";

      console.log(firstName);
      console.log(lastname);

      new Button({ text: "SAPUI5" }).placeAt("content");
  }
);

```

### 🌐 2) HTML (index.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Unit 5 Module</title>
  <style>
    html, body, body > div, #container, #container-uiarea { height: 100%; }
  </style>
  <script id="sap-ui-bootstrap"
          src="resources/sap-ui-core.js"
          data-sap-ui-theme="sap_horizon"
          data-sap-ui-resource-roots='{"code.unit5l0101": "./"}'
          data-sap-ui-on-init="module:code/unit5l0101/index"
          data-sap-ui-compat-version="edge"
          data-sap-ui-async="true"
          data-sap-ui-frame-options="trusted"></script>
</head>
<body class="sapUiBody sapUiSizeCompact" id="content"></body>
</html>

```

### 💻 3) 실행 결과 (미리보기)

```
[ SAPUI5 ]

```

단일 버튼이 중앙에 렌더링됩니다.

### ⚙️ 4) 포인트 & 개선사항

| 구분 | 설명 |
| --- | --- |
| 전역 변수 | `firstName`, `lastname`가 전역으로 선언되어 위험 ⚠️ |
| 모듈 구조 | `sap.ui.define`을 사용하여 종속 모듈을 명시적으로 로드 |
| 초기화 | `data-sap-ui-on-init`으로 진입점 지정 |
| 비동기 | `data-sap-ui-async="true"`로 성능 향상 |

### ✅ 개선 코드

```jsx
// file: code/unit5l0101/index.js
sap.ui.define([
  "sap/m/Button",
  "sap/m/Text",
  "sap/m/Label",
  "sap/m/VBox"
], function (Button, Text, Label, VBox) {
  "use strict";

  const firstName = "gildong";
  const lastName = "Hong";
  console.log(firstName, lastName);

  const oVBox = new VBox({
    items: [
      new Text({ text: `Hello, ${firstName} ${lastName}` }),
      new Label({ text: "Click the button" }),
      new Button({ text: "SAPUI5", type: "Emphasized" })
    ]
  }).addStyleClass("sapUiSmallMargin");

  oVBox.placeAt("content");
});

```

### 🎨 개선 후 화면 모형

```
Hello, gildong Hong
Click the button
[ SAPUI5 ]

```

---

# Lesson 2-2 – VBox를 이용한 버튼 그룹 배치

### 🧩 1) 자바스크립트 (code/exercise05/index.js)

```jsx
sap.ui.define(
  ["sap/m/Text", "sap/m/Button", "sap/m/HBox", "sap/m/VBox"],
  function (Text, Button, HBox, VBox) {
      new Text({ text: "Hello SAPUI5" }).placeAt("content");

      new VBox({
          items: [
              new Button({ text: "Save" }),
              new Button({ text: "Update" }),
              new Button({ text: "Delete" })
          ]
      }).placeAt("content");
  }
);

```

### 🌐 2) HTML (index.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Exercise 05</title>
  <style>
    html, body, body > div, #container, #container-uiarea { height: 100%; }
  </style>
  <script id="sap-ui-bootstrap"
          src="resources/sap-ui-core.js"
          data-sap-ui-theme="sap_horizon"
          data-sap-ui-libs="sap.m"
          data-sap-ui-resource-roots='{"code.exercise05": "./"}'
          data-sap-ui-on-init="module:code/exercise05/index"
          data-sap-ui-compat-version="edge"
          data-sap-ui-async="true"
          data-sap-ui-frame-options="trusted"></script>
</head>
<body class="sapUiBody sapUiSizeCompact" id="content"></body>
</html>

```

### 💻 3) 실행 결과 (미리보기)

```
Hello SAPUI5
[ Save ]
[ Update ]
[ Delete ]

```

버튼이 세로로 배치됩니다.

### ⚙️ 4) 포인트 & 개선사항

| 구분 | 설명 |
| --- | --- |
| 다중 placeAt | `Text`, `VBox` 각각 placeAt → 비효율적 |
| 의존성 관리 | `HBox`는 사용되지 않음 (삭제 권장) |
| 정렬 개선 | 중앙 정렬, 타입 지정으로 시각적 일관성 향상 |

### ✅ 개선 코드

```jsx
// file: code/exercise05/index.js
sap.ui.define([
  "sap/m/Text",
  "sap/m/Button",
  "sap/m/VBox"
], function (Text, Button, VBox) {
  "use strict";

  const oVBox = new VBox({
    items: [
      new Text({ text: "Hello SAPUI5" }),
      new Button({ text: "Save", type: "Accept" }),
      new Button({ text: "Update", type: "Emphasized" }),
      new Button({ text: "Delete", type: "Reject" })
    ],
    alignItems: "Center",
    justifyContent: "Center"
  }).addStyleClass("sapUiSmallMargin");

  oVBox.placeAt("content");
});

```

### 🎨 개선 후 화면 모형

```
Hello SAPUI5

[ Save   ]  (Accept)
[ Update ]  (Emphasized)
[ Delete ]  (Reject)

```

---

## ✅ Lesson 2 핵심 요약

| 항목 | 내용 |
| --- | --- |
| **모듈 로딩** | `sap.ui.define`으로 의존성 선언 + 비동기 초기화 |
| **리소스 루트 매핑** | `data-sap-ui-resource-roots`로 네임스페이스 연결 |
| **on-init** | HTML 부트스트랩에서 모듈 초기 실행 지정 |
| **전역 변수 방지** | `"use strict"` + `const/let` 사용 |
| **UI 구조** | 단일 루트 컨테이너(`VBox`)로 정돈 |
| **디자인 일관성** | 버튼 타입(`Accept/Reject/Emphasized`) 적용 |

---


### 🧩 레이아웃(Layout) 컨트롤 비교

| 컨트롤 | 설명 | 주요 속성 | 사용 예시 |
| --- | --- | --- | --- |
| **VBox** | 수직(Vertical) 방향으로 컨트롤 배치 | `alignItems`, `justifyContent`, `items` | 폼, 입력창, 버튼 그룹 등 |
| **HBox** | 수평(Horizontal) 방향으로 컨트롤 배치 | `alignItems`, `justifyContent`, `wrap` | 버튼 나열, 툴바 구조 등 |
| **FlexBox** | H/VBox 상위 개념, CSS Flex 기반 | `direction`, `fitContainer`, `renderType` | 반응형 레이아웃 구현 |
| **Panel** | 제목과 함께 컨텐츠 그룹화 | `headerText`, `expandable` | 섹션 구분 UI |
| **Page / App** | 모바일 구조 컨테이너 | `title`, `content`, `footer` | 전체 페이지 구성 |

예시 (HBox)

```jsx
new sap.m.HBox({
  items: [
    new sap.m.Button({ text: "Left" }),
    new sap.m.Button({ text: "Center" }),
    new sap.m.Button({ text: "Right" })
  ],
  alignItems: "Center",
  justifyContent: "SpaceBetween"
}).placeAt("content");

```

결과 미리보기 👇

```
[Left]      [Center]      [Right]

```

### 🎛 UI5 컨트롤 그룹 학습 순서 추천

1. **sap.m (모바일 컨트롤)**: Button, Label, Text, Input, Select, MessageToast 등.
2. **Layout 컨트롤**: VBox, HBox, FlexBox, Panel.
3. **Container 컨트롤**: Page, App, Dialog, SplitContainer.
4. **MVC 구조**: View(XML/JS/JSON) + Controller.
5. **Model & Binding**: JSONModel → i18n → ODataModel 순서.
6. **Component 구조화**: 재사용 가능한 앱 단위 구성.

### ⚙️ 개발자에게 유용한 팁

- `sap.ui.define` 사용 시 **의존성 이름 순서**와 **콜백 인자 순서** 반드시 일치해야 함.
- `sap.ui.require`는 **런타임 동적 로딩** 용도로 사용 (예: 이벤트 시점에 모듈 로드).
- `sap.m.MessageBox`, `sap.m.Dialog` 등 사용자 피드백 컨트롤 익혀두기.
- `data-sap-ui-async="true"`는 비동기 로딩을 활성화해 성능 개선.
- `sap.ui.getCore().attachInit()`은 수동 초기화 시 가장 안전한 타이밍.

### 🔍 디버깅/실행 팁

| 도구 | 설명 |
| --- | --- |
| **F12 콘솔** | UI5 로그(`sap-ui-debug=true` URL 파라미터 추가) |
| **sap.ui.version** | UI5 버전 확인 (`console.log(sap.ui.version)`) |
| **sap.ui.getCore().byId()** | 생성된 컨트롤 탐색 |
| **UI5 Inspector (Chrome 확장)** | 렌더된 UI5 트리 시각화 |

### 📘 학습 확장 아이디어

- **HBox + VBox 조합**으로 반응형 그리드 연습하기
- **sap.m.Panel**로 그룹화된 섹션 UI 구성
- **sap.m.Page + sap.m.App**으로 네비게이션 UI 구성
- **Dialog**/`MessageBox`로 사용자 피드백 UX 강화
- JSONModel을 연결해 `Text`/`Input` 데이터 바인딩 실습
