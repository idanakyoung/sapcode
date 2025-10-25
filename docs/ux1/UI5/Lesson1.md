# ✨ Lesson 1  – SAPUI5 기초 UI Control 정리

---

## 📦 공통 전제

- 두 파일은 **각각 독립 HTML 페이지**입니다(동일 문서에 연속 삽입하면 DOCTYPE/HEAD 중복으로 충돌).
- 공통 부트스트랩:
    - `src="resources/sap-ui-core.js"` (로컬 SDK 경로)
    - `data-sap-ui-theme="sap_horizon"` (Horizon 테마)
    - `data-sap-ui-libs="sap.m"` (모바일 컨트롤)
    - `data-sap-ui-compat-version="edge"` (최신 호환 모드)

> ✅ 참고: 속성명은 하이픈(compat-version) 표기도 동작하지만, 공식 표기는 data-sap-ui-compatVersion(카멜 케이스)입니다. 일관성을 위해 개선 코드에서 카멜 케이스를 사용합니다.
> 

---

# Lesson 1-1 –  Text + Label + Button

### 1) 원본 코드

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>exercise_04</title>
    <style>
        html, body, body > div, #container, #container-uiarea {
            height: 100%;
        }
    </style>
    <script
        id="sap-ui-bootstrap"
        src="resources/sap-ui-core.js"
        data-sap-ui-theme="sap_horizon"
        data-sap-ui-libs="sap.m"
        data-sap-ui-compat-version="edge"
    ></script>

    <script>
        var oText = new sap.m.Text({text: "Hello World"})
        oText.placeAt("content")

        var oLabel = new sap.m.Label({text: "Name"})
        oLabel.placeAt("content")

        var oButton = new sap.m.Button({text: "Submit"})
        oButton.placeAt("content")
    </script>

</head>
<body class="sapUiBody sapUiSizeCompact" id="content">

</body>
</html>

```

### 2) 화면 모형(미리보기)

```
Hello World
Name
[ Submit ]

```

- 위에서 아래로 **순차 렌더링**됩니다(개별 `placeAt`).
- 간격/정렬은 기본값이라 **컴팩트하게 붙어** 보일 수 있어요.

### 3) 핵심 포인트 & 주의사항

- `placeAt("content")`로 `<body id="content">`에 직접 렌더링.
- 컨트롤 간 여백/정렬 컨트롤이 없어 UI가 조밀.
- 코어 초기화 타이밍 이슈를 피하려면 `sap.ui.getCore().attachInit(...)` 권장.

### 4) 개선 코드 (안전한 초기화 + 레이아웃 + 상호작용)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>exercise_04 – improved</title>
  <script id="sap-ui-bootstrap"
          src="resources/sap-ui-core.js"
          data-sap-ui-theme="sap_horizon"
          data-sap-ui-libs="sap.m"
          data-sap-ui-compatVersion="edge"></script>
</head>
<body class="sapUiBody sapUiSizeCompact">
  <div id="content"></div>
  <script>
    sap.ui.getCore().attachInit(function () {
      var oInput = new sap.m.Input({ id: "nameInput", placeholder: "Enter your name" });
      var oLabel = new sap.m.Label({ text: "Name", labelFor: oInput });
      var oText  = new sap.m.Text({ text: "Hello World" });
      var oButton = new sap.m.Button({
        text: "Submit",
        type: "Emphasized",
        press: function () {
          var name = oInput.getValue().trim();
          sap.m.MessageToast.show("Hello, " + (name || "World") + "!");
        }
      });
      var oVBox = new sap.m.VBox({ items: [oText, oLabel, oInput, oButton] })
                    .addStyleClass("sapUiSmallMargin");
      oVBox.placeAt("content");
    });
  </script>
</body>
</html>

```

### 5) 개선 화면 모형

```
Lesson 1 – exercise_04 (개선)
------------------------------
Hello World
Name   [                ]  ← Input

            [ Submit ]
(클릭 시) ─▶ "Hello, <name>!"  토스트 메시지

```

---

# Lesson 1-2  – 단일 Button(Render & Event)

### 1) 원본 코드

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SAPUI5 UI Control</title>
    <style>
        html, body, body > div, #container, #container-uiarea {
            height: 100%;
        }
    </style>
    <script
        id="sap-ui-bootstrap"
        src="resources/sap-ui-core.js"
        data-sap-ui-theme="sap_horizon"
        data-sap-ui-libs="sap.m"
        data-sap-ui-compat-version="edge"
    ></script>
   <script>
        var oButton = sap.m.Button(
            {
                text: "Search"
            }
        );

        oButton.placeAt("content");
    </script>
</head>
<body class="sapUiBody sapUiSizeCompact" id="content">
    <!-- <div
        data-sap-ui-component
        data-name="code.unit4l0201"
        data-id="container"
        data-settings='{"id" : "code.unit4l0201"}'
        data-handle-validation="true"
    ></div> -->
</body>
</html>

```

### 2) 화면 모형(미리보기)

```
[ Search ]

```

- 단일 버튼만 표시됩니다. 기본 타입은 `Default`.
- 이벤트 핸들러(`press`)가 없어 **클릭 시 동작 없음**.

### 3) 핵심 포인트 & 주의사항

- 초기화 타이밍 안정화를 위해 `attachInit` 권장.
- 컴포넌트 부트스트랩 주석 블록은 별도 **Component 기반 앱**으로 확장 가능.

### 4) 개선 코드 (아이콘 + 이벤트 + 정렬)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>Lesson 2 – Button Improved</title>
  <script id="sap-ui-bootstrap"
          src="resources/sap-ui-core.js"
          data-sap-ui-theme="sap_horizon"
          data-sap-ui-libs="sap.m"
          data-sap-ui-compatVersion="edge"></script>
</head>
<body class="sapUiBody sapUiSizeCompact">
  <div id="content"></div>
  <script>
    sap.ui.getCore().attachInit(function(){
      var oButton = new sap.m.Button({
        text: "Search",
        icon: "sap-icon://search",
        type: "Emphasized",
        press: function(){
          sap.m.MessageToast.show("Search button clicked 🔍");
        }
      });
      var oVBox = new sap.m.VBox({
        items: [ new sap.m.Text({text: "Search Demo"}), oButton ],
        alignItems: "Center",
        justifyContent: "Center"
      }).addStyleClass("sapUiSmallMargin");
      oVBox.placeAt("content");
    });
  </script>
</body>
</html>

```

### 5) 개선 화면 모형

```
Search Demo

[ 🔍  Search ]  ← Emphasized 스타일, 중앙 정렬
(클릭 시) ─▶ "Search button clicked 🔍"  토스트

```

---

## ✅ 두 예제 비교 한눈에 보기

| 항목 | Lesson 1 (exercise_04) | Lesson 2 (Button) |
| --- | --- | --- |
| 컨트롤 | Text, Label, Button (+Input 권장) | Button 단일 |
| 렌더링 | 각각 `placeAt` → 세로 나열 | 단일 `placeAt` |
| 초기화 | 즉시 실행(개선: `attachInit`) | 즉시 실행(개선: `attachInit`) |
| 상호작용 | 기본 없음(개선: Toast) | 기본 없음(개선: Toast) |
| 레이아웃 | 없음(개선: `VBox`) | 없음(개선: `VBox`) |

---

## 🛠 실무 체크리스트

- [ ]  `sap-ui-core.js` 경로/CDN 확인 (`https://sdk.openui5.org/resources/sap-ui-core.js`)
- [ ]  `data-sap-ui-compatVersion` 표기 사용(일관성)
- [ ]  `sap.ui.getCore().attachInit`로 안전 초기화
- [ ]  레이아웃 컨트롤(`VBox/HBox/Page`) 적극 활용
- [ ]  버튼 `type/icon`으로 의미와 접근성 향상
- [ ]  `MessageToast`/`Dialog`로 사용자 피드백 제공
