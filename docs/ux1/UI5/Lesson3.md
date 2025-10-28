# ✨ Lesson 3 – XMLView 기반 앱 부트스트랩

---

> Lesson 3는 XMLView + 모듈 부트스트랩 흐름을 중심으로 챕터를 나눠서 정리합니다. 3-1에서는 XMLView.create로 View를 로드하고, HTML에서는 data-sap-ui-on-init로 진입점을 연결하는 전체 플로우를 다룹니다.
> 

## 📁 폴더 구조 예시 (Lesson 3)

```
project-root/
├─ index.html                          ← (3-1) HTML 부트스트랩
├─ resources/sap-ui-core.js
└─ code/
   └─ exercise06/
      ├─ index.js                      ← (3-1) 진입 모듈
      └─ view/
         └─ App.view.xml               ← (3-1) XMLView
      └─ controller/
         └─ App.controller.js          ← (선택) 컨트롤러

```

---

# Lesson 3-1 – XMLView(App) + HTML + JS 진입 모듈

## 1) 원본 XMLView (code/exercise06/view/App.view.xml)

```xml
<mvc:View controllerName="code.exercise06.controller.App"
    displayBlock="true"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
        <Text text="Hello world"></Text>
</mvc:View>

```

## 2) 원본 HTML (index.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Exercise 6</title>
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
        data-sap-ui-resource-roots='{
            "code.exercise06": "./"
        }'
        data-sap-ui-on-init="module:code/exercise06/index"
        data-sap-ui-compat-version="edge"
        data-sap-ui-async="true"
        data-sap-ui-frame-options="trusted"
    ></script>
</head>
<body class="sapUiBody sapUiSizeCompact">
  <div id="content"></div>
</body>
</html>

```

## 3) 원본 자바스크립트 (code/exercise06/index.js)

```jsx
sap.ui.define(
    ["sap/ui/core/mvc/XMLView"],
    function (XMLView) {
        "use strict";

        XMLView.create({
            id : "App",
            viewName : "code.exercise06.view.App"
        }).then(function (oView) {
            oView.placeAt("content");
        });
    }
);

```

## 4) 화면 모형(미리보기)

```
Hello world

```

- XMLView 안의 `<Text>`가 렌더링됩니다.
- `displayBlock="true"`로 View가 **전체 폭(block)**을 차지합니다.

## 5) 핵심 포인트 & 주의사항

- **리소스 루트 매핑**: `data-sap-ui-resource-roots`에서 `"code.exercise06": "./"` → `code/exercise06/...` 모듈 경로로 해석.
- **진입점(on-init)**: HTML의 `data-sap-ui-on-init="module:code/exercise06/index"`가 `index.js`를 최초 실행.
- **XMLView 로딩**: `XMLView.create({ viewName: ... })`는 **Promise** 반환 → `then()`에서 `placeAt` 수행.
- **컨트롤러 연결**: `controllerName="code.exercise06.controller.App"`로 지정되어 있어 **컨트롤러 파일이 없으면 경고**가 발생할 수 있습니다(필수는 아님). 빈 컨트롤러라도 두면 깔끔해요.
- **성능 플래그**: `data-sap-ui-async="true"`로 비동기 부트스트랩. 로딩 체감 개선.

## 6) 개선 코드 (권장 구조: App → Page 컨테이너, 빈 컨트롤러 포함)

### 6-1) App.view.xml (컨테이너화 + 타이틀)

```xml
<mvc:View controllerName="code.exercise06.controller.App"
    displayBlock="true"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
  <App>
    <pages>
      <Page title="Exercise 6">
        <content>
          <Text text="Hello world" />
        </content>
      </Page>
    </pages>
  </App>
</mvc:View>

```

### 6-2) App.controller.js (선택)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/m/MessageToast"
], function (Controller, MessageToast) {
  "use strict";
  return Controller.extend("code.exercise06.controller.App", {
    onInit: function () {
      // 초기화 로직 (필요 시)
      MessageToast.show("App initialized");
    }
  });
});

```

### 6-3) index.js (변경 없음, 엄격 모드/리턴 추가)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/XMLView"
], function (XMLView) {
  "use strict";

  return XMLView.create({
    id: "App",
    viewName: "code.exercise06.view.App"
  }).then(function (oView) {
    oView.placeAt("content");
    return oView; // 테스트/주입 용
  });
});

```

## 7) 개선 화면 모형

```
┌─────────────────────────────┐
│        Exercise 6           │  ← Page title
├─────────────────────────────┤
│ Hello world                 │  ← content(Text)
└─────────────────────────────┘

```

## 8) 디버깅 & 실무 팁

- **경로 확인**: XML 경로는 `code/exercise06/view/App.view.xml` ↔ `viewName: "code.exercise06.view.App"`가 반드시 일치.
- **네임스페이스 유효성**: XML 상단의 `xmlns:mvc`/`xmlns`가 정확해야 파싱 오류가 없음.
- **컨트롤러 경고 방지**: 컨트롤러 파일이 없다면 `controllerName`을 빼거나, 빈 컨트롤러 파일을 생성.
- **레이아웃 권장**: 단순 `<Text>`만 있을 때도 `App/Page` 컨테이너로 추후 확장 여지 확보.
- **CSS Density**: `<body class="sapUiBody sapUiSizeCompact">`로 데스크톱 밀도 적용.

---

## ✅ Lesson 3-1 요약

| 항목 | 내용 |
| --- | --- |
| View 로딩 | `XMLView.create` → Promise → `placeAt` |
| 진입점 | `data-sap-ui-on-init`에서 모듈 실행 |
| 경로/루트 | `resource-roots`로 네임스페이스 매핑 |
| 컨트롤러 | 선택 사항이지만 연결 시 파일 준비 권장 |
| 레이아웃 | `App > Page > content` 구조 권장 |

> 다음 3-2에서는 **Model 바인딩(JSONModel)**을 추가해서 XMLView와 데이터 연결을 실습합니다. 😉
> 

---

# Lesson 3-2 – XMLView(Main/App) + 모델 바인딩 기초

> 두 개의 XMLView 스니펫(App, Main)과 HTML/JS 부트스트랩을 기반으로, i18n + JSONModel을 연결하는 실무 패턴을 정리합니다.
> 
> 
> 입력 필드(First/Last name)를 **데이터 바인딩**하고, **라벨 연결/레이아웃(App>Page)**까지 반영합니다.
> 

## 📁 폴더 구조 예시

```
project-root/
├─ index.html
├─ resources/sap-ui-core.js
└─ code/
   └─ unit6l0101/
      ├─ index.js
      ├─ view/
      │  ├─ App.view.xml   ← (사용자 제공: 라벨/인풋만)
      │  └─ Main.view.xml  ← (사용자 제공: Page + i18n title)
      ├─ controller/
      │  ├─ App.controller.js   (선택)
      │  └─ Main.controller.js  (선택)
      └─ i18n/
         └─ i18n.properties

```

---

## 1) 원본 XML – App.view.xml

```xml
<mvc:View controllerName="code.unit6l0101.controller.App"
    displayBlock="true"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Label id="idlblFname" text="First name"></Label>
    <Input id="idInpFname" value="길동"></Input>
    <Label id="idlblLname" text="Last name"></Label>
    <Input id="idInpLname"></Input>
    <!-- <App id="app">
    </App> -->
</mvc:View>

```

## 2) 원본 XML – Main.view.xml

```xml
<mvc:View controllerName="code.unit6l0101.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
    </Page>
</mvc:View>

```

## 3) 원본 HTML

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Unit 6 XML View</title>
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
        data-sap-ui-resource-roots='{
            "code.unit6l0101": "./"
        }'
        data-sap-ui-on-init="module:code/unit6l0101/index"
        data-sap-ui-compat-version="edge"
        data-sap-ui-async="true"
        data-sap-ui-frame-options="trusted"
    ></script>
</head>
<body class="sapUiBody sapUiSizeCompact" id="content">
</body>
</html>

```

## 4) 원본 JS – index.js

```jsx
sap.ui.define(
    ["sap/ui/core/mvc/XMLView"],

    function (XMLView) {
        XMLView.create({
            id: "App",
            viewName: "code.unit6l0101.view.App"
        }).then(function(oView) {
            oView.placeAt("content");
        });
    }
);

```

## 5) 화면 모형(미리보기)

```
First name  [ 길동        ]
Last name   [             ]
(타이틀 없음 / Page 미사용)

```

---

## 6) 핵심 포인트 & 주의사항

- **두 View의 관계**: HTML 진입점은 `App.view.xml`을 로드하지만, `Main.view.xml`은 별도 Page 컨테이너와 i18n 타이틀을 가집니다. 실제 앱에서는 **App > Page > content** 구조로 통합하는 것이 자연스럽습니다.
- **i18n 미설정**: `Main.view.xml`에서 `{i18n>title}` 바인딩을 사용하지만, **i18n 모델이 등록되지 않음** → 제목이 비어 보일 수 있음.
- **바인딩 부재**: `App.view.xml`은 **정적 텍스트/값**으로만 구성되어 있고 JSONModel이 없습니다.
- **접근성/연결**: `Label`은 관련 `Input`과 `labelFor`로 연결하는 것이 좋습니다.

---

## 7) 개선안 A – 단일 View(App)로 정리 + i18n/JSONModel 연결 (권장)

> App 하나에 Page를 두고, 입력 폼을 데이터 바인딩합니다.
> 

### 7-1) i18n (code/unit6l0101/i18n/i18n.properties)

```
title=Unit 6 XML View
txtFirst=First name
txtLast=Last name
placeholderFirst=Enter first name
placeholderLast=Enter last name

```

### 7-2) App.view.xml (컨테이너/바인딩/라벨 연결)

```xml
<mvc:View controllerName="code.unit6l0101.controller.App"
    displayBlock="true"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
  <App>
    <pages>
      <Page id="page" title="{i18n>title}">
        <content>
          <VBox class="sapUiSmallMargin">
            <Label text="{i18n>txtFirst}" labelFor="idInpFname" />
            <Input id="idInpFname" value="{/person/firstName}" placeholder="{i18n>placeholderFirst}" />

            <Label text="{i18n>txtLast}" labelFor="idInpLname" />
            <Input id="idInpLname" value="{/person/lastName}" placeholder="{i18n>placeholderLast}" />
          </VBox>
        </content>
      </Page>
    </pages>
  </App>
</mvc:View>

```

### 7-3) index.js (i18n + JSONModel 세팅)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/XMLView",
  "sap/ui/model/resource/ResourceModel",
  "sap/ui/model/json/JSONModel"
], function (XMLView, ResourceModel, JSONModel) {
  "use strict";

  // i18n 모델 등록
  const oI18n = new ResourceModel({ bundleName: "code.unit6l0101.i18n.i18n" });
  sap.ui.getCore().setModel(oI18n, "i18n");

  // JSON 데이터 모델 등록
  const oData = { person: { firstName: "길동", lastName: "" } };
  const oModel = new JSONModel(oData);
  sap.ui.getCore().setModel(oModel); // default model

  // XMLView 로드
  return XMLView.create({ id: "App", viewName: "code.unit6l0101.view.App" })
    .then(function (oView) {
      oView.placeAt("content");
      return oView;
    });
});

```

### 7-4) 개선 화면 모형

```
┌───────────────────────────────┐
│       Unit 6 XML View         │
├───────────────────────────────┤
│ First name  [ 길동          ] │
│ Last name   [               ] │
└───────────────────────────────┘

```

---

## 8) 개선안 B – Main.view.xml을 쉘로 사용 (대안)

> Main.view.xml을 로드하고, 그 내부에 App 또는 폼을 포함시키는 방식입니다.
> 

### 8-1) Main.view.xml (Page 안에 폼 포함)

```xml
<mvc:View controllerName="code.unit6l0101.controller.Main"
    displayBlock="true"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
  <Page id="page" title="{i18n>title}">
    <content>
      <VBox class="sapUiSmallMargin">
        <Label text="{i18n>txtFirst}" labelFor="idInpFname" />
        <Input id="idInpFname" value="{/person/firstName}" />
        <Label text="{i18n>txtLast}" labelFor="idInpLname" />
        <Input id="idInpLname" value="{/person/lastName}" />
      </VBox>
    </content>
  </Page>
</mvc:View>

```

### 8-2) index.js (Main 로드로 변경)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/XMLView",
  "sap/ui/model/resource/ResourceModel",
  "sap/ui/model/json/JSONModel"
], function (XMLView, ResourceModel, JSONModel) {
  "use strict";

  sap.ui.getCore().setModel(new ResourceModel({ bundleName: "code.unit6l0101.i18n.i18n" }), "i18n");
  sap.ui.getCore().setModel(new JSONModel({ person: { firstName: "길동", lastName: "" } }));

  return XMLView.create({ id: "Main", viewName: "code.unit6l0101.view.Main" })
    .then(function (oView) { oView.placeAt("content"); return oView; });
});

```

---

## 9) 디버깅 & 실무 체크리스트

- [ ]  `resource-roots` ↔ 모듈 경로 일치 (`code.unit6l0101` → `./code/unit6l0101/...`).
- [ ]  i18n 모델 등록 여부 확인 (바인딩 `{i18n>...}`가 문자열로 보이면 OK).
- [ ]  JSONModel 기본 모델 등록 후 `{/path}` 바인딩 확인.
- [ ]  `labelFor`로 `Label` ↔ `Input` 연결 (접근성/포커스).
- [ ]  `App > Page > content` 레이아웃 권장 (확장 용이).

## ✅ Lesson 3-2 요약

| 항목 | 내용 |
| --- | --- |
| 모델 구성 | `ResourceModel`(i18n), `JSONModel`(데이터) 등록 |
| 바인딩 | XML에서 `{i18n>key}`, `{/person/firstName}` 형식 사용 |
| 레이아웃 | `App > Page > VBox > Label/Input` 구조 권장 |
| 대안 | Main를 쉘로 사용해 동일 폼 포함 가능 |
| 팁 | 컨트롤러는 선택, 초기화/검증 로직은 Controller `onInit`에 배치 |

---

# Lesson 3-3 – Controller 이벤트 바인딩(Checkbox) + Component 부트스트랩

> ComponentSupport로 앱을 올리고, XMLView → Controller에서 CheckBox의 select 이벤트를 처리하는 예제입니다. i18n 타이틀과 컴포넌트 구조(필수 파일)를 함께 정리했어요.
> 

## 📁 폴더 구조 예시

```
project-root/
├─ index.html
├─ resources/sap-ui-core.js
└─ unit6l0201/
   ├─ Component.js
   ├─ manifest.json
   ├─ view/
   │  └─ Main.view.xml
   ├─ controller/
   │  └─ Main.controller.js
   └─ i18n/
      └─ i18n.properties

```

---

## 1) 원본 XML (unit6l0201/view/Main.view.xml)

```xml
<mvc:View controllerName="unit6l0201.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
         <CheckBox id="idChkBox" text="No" select=".onSelect" />
    </Page>
</mvc:View>

```

## 2) 원본 HTML (index.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Unit 6 controller</title>
    <style>
        html, body, body > div, #container, #container-uiarea { height: 100%; }
    </style>
    <script id="sap-ui-bootstrap"
        src="resources/sap-ui-core.js"
        data-sap-ui-theme="sap_horizon"
        data-sap-ui-resource-roots='{"unit6l0201": "./"}'
        data-sap-ui-on-init="module:sap/ui/core/ComponentSupport"
        data-sap-ui-compat-version="edge"
        data-sap-ui-async="true"
        data-sap-ui-frame-options="trusted"></script>
</head>
<body class="sapUiBody sapUiSizeCompact" id="content">
    <div
        data-sap-ui-component
        data-name="unit6l0201"
        data-id="container"
        data-settings='{"id" : "unit6l0201"}'
        data-handle-validation="true"></div>
</body>
</html>

```

## 3) 원본 Controller (unit6l0201/controller/Main.controller.js)

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("unit6l0201.controller.Main", {
        onInit() {
        },
        onSelect: function () {
            var oChkBox = this.byId("idChkBox");
            if (oChkBox.getSelected()) {
                oChkBox.setText("Yes");
            } else {
                oChkBox.setText("No");
            }
        }
    });
});

```

## 4) 화면 모형(미리보기)

```
┌────────────────────────────┐
│      {i18n>title}          │  ← i18n에서 치환되면 실제 제목 표기
├────────────────────────────┤
│ [ ] No                     │  ← 체크 시 → [x] Yes
└────────────────────────────┘

```

---

## 5) 핵심 포인트 & 주의사항

- **ComponentSupport 사용**: `data-sap-ui-on-init="module:sap/ui/core/ComponentSupport"` + `<div data-sap-ui-component ...>` 조합은
    
    **`unit6l0201` 컴포넌트**(manifest.json/Component.js) 존재를 전제로 합니다. 해당 파일이 없으면 로딩 실패합니다.
    
- **i18n 타이틀**: `{i18n>title}`이 정상 표시되려면 **i18n 모델 등록**(보통 manifest.json에서 설정)이 필요합니다.
- **이벤트 바인딩**: XML의 `select=".onSelect"`는 **동일 컨트롤러 인스턴스**의 `onSelect` 메서드를 호출합니다.
- **byId 탐색 스코프**: `this.byId()`는 현재 View 스코프에서만 ID를 찾습니다(적절한 사용).

---

## 6) 개선 코드 – 컴포넌트 기반 실행에 필요한 파일 추가

> 아래 두 파일만 추가하면, HTML의 ComponentSupport로 앱이 구동되고 i18n 타이틀도 표시됩니다.
> 

### 6-1) manifest.json (unit6l0201/manifest.json)

```json
{
  "_version": "1.49.0",
  "sap.app": {
    "id": "unit6l0201",
    "type": "application",
    "title": "Unit 6 controller",
    "i18n": "i18n/i18n.properties"
  },
  "sap.ui5": {
    "dependencies": {
      "libs": { "sap.m": {} }
    },
    "rootView": {
      "viewName": "unit6l0201.view.Main",
      "type": "XML",
      "id": "Main",
      "async": true
    },
    "models": {
      "i18n": {
        "type": "sap.ui.model.resource.ResourceModel",
        "settings": { "bundleName": "unit6l0201.i18n.i18n" }
      }
    },
    "contentDensities": { "compact": true, "cozy": false }
  }
}

```

### 6-2) Component.js (unit6l0201/Component.js)

```jsx
sap.ui.define([
  "sap/ui/core/UIComponent"
], function (UIComponent) {
  "use strict";

  return UIComponent.extend("unit6l0201.Component", {
    metadata: { manifest: "json" },
    init: function () {
      UIComponent.prototype.init.apply(this, arguments);
      // 라우팅 사용 시 this.getRouter().initialize(); 등 추가 가능
    }
  });
});

```

### 6-3) i18n (unit6l0201/i18n/i18n.properties)

```
title=Unit 6 controller

```

> 위 3개 파일을 추가하면, HTML에서 지정한 컴포넌트가 자동으로 로드되고 Main.view.xml의 {i18n>title} 바인딩이 정상 표시됩니다.
> 

---

## 7) 보너스 – 바인딩 기반 토글(옵션)

> 텍스트를 코드에서 세팅하는 대신, 모델 바인딩으로 토글하는 패턴도 있습니다.
> 

### 7-1) View (텍스트 바인딩)

```xml
<CheckBox id="idChkBox"
  selected="{/ui/checked}"
  text="{= ${/ui/checked} ? 'Yes' : 'No' }"
  select=".onSelect" />

```

### 7-2) Controller (모델 업데이트)

```jsx
onInit: function(){
  const oModel = new sap.ui.model.json.JSONModel({ ui: { checked: false } });
  this.getView().setModel(oModel);
},
onSelect: function(){
  const oModel = this.getView().getModel();
  const b = !!oModel.getProperty("/ui/checked");
  oModel.setProperty("/ui/checked", !b);
}

```

> 장점: 표시 로직을 XML로 분리하여 테스트/유지보수 용이.
> 

---

## ✅ Lesson 3-3 체크리스트

- [ ]  `manifest.json`/`Component.js` 존재(필수) – ComponentSupport 사용 시
- [ ]  i18n 모델 등록 여부 확인(타이틀 바인딩)
- [ ]  `controllerName` ↔ 파일 경로 일치
- [ ]  이벤트 핸들러 네이밍/시그니처 일치 (`select`.onSelect)
- [ ]  필요 시 바인딩 기반 토글로 UI/로직 분리

---

# ✨ Lesson 3-4 – Controller 이벤트 처리 (Input → MessageBox)

> 이번 레슨은 Controller의 이벤트 핸들링(버튼 press)과 sap.m.MessageBox 사용을 중심으로 다룹니다.
> 
> 
> 사용자가 Input 필드에 이름을 입력하고 `Submit` 버튼을 누르면 MessageBox로 인사 문구를 표시하는 예제예요 👋
> 

---

## 📁 폴더 구조 예시

```
project-root/
├─ index.html
└─ code/
   └─ unit6l0202/
      ├─ view/
      │  └─ Main.view.xml
      ├─ controller/
      │  └─ Main.controller.js
      ├─ i18n/
      │  └─ i18n.properties
      ├─ Component.js
      └─ manifest.json

```

---

## 🧩 1) View (main.view.xml)

```xml
<mvc:View controllerName="code.unit6l0202.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
  <Page id="page" title="{i18n>title}">
    <Label id="idLblFname" text="Name" />
    <Input id="idInpName" />
    <Button id="idBtnSubmit" text="Submit" press="onSubmit" />
  </Page>
</mvc:View>

```

---

## 💻 2) Controller (main.controller.js)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/m/MessageBox"
], (Controller, MessageBox) => {
  "use strict";

  return Controller.extend("code.unit6l0202.controller.Main", {
    onInit() {},

    onSubmit: function () {
      var sName = this.getView().byId("idInpName").getValue();
      sName = "Hello, " + sName;

      MessageBox.show(sName, {
        title: "Name Display Message Box"
      });
    }
  });
});

```

---

## 🌐 3) HTML (index.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>Unit 6 controller</title>
  <style>
    html, body, body > div, #container, #container-uiarea { height: 100%; }
  </style>
  <script id="sap-ui-bootstrap"
    src="resources/sap-ui-core.js"
    data-sap-ui-theme="sap_horizon"
    data-sap-ui-resource-roots='{"code.unit6l0202": "./"}'
    data-sap-ui-on-init="module:sap/ui/core/ComponentSupport"
    data-sap-ui-compat-version="edge"
    data-sap-ui-async="true"
    data-sap-ui-frame-options="trusted"></script>
</head>
<body class="sapUiBody sapUiSizeCompact" id="content">
  <divdata-sap-ui-component
    data-name="code.unit6l0202"
    data-id="container"
    data-settings='{"id" : "code.unit6l0202"}'
    data-handle-validation="true"></div>
</body>
</html>

```

---

## 🖼 4) 화면 모형 (미리보기)

```
┌──────────────────────────────┐
│        {i18n>title}          │
├──────────────────────────────┤
│ Name   [ Hong Gildong   ]    │
│ [ Submit ]                   │
└──────────────────────────────┘

(버튼 클릭 시) ▶ MessageBox:
┌──────────────────────────────┐
│ Hello, Hong Gildong         │
│ [ OK ]                       │
└──────────────────────────────┘

```

---

## ⚙️ 5) 핵심 포인트 & 주의사항

| 항목 | 설명 |
| --- | --- |
| **이벤트 핸들링** | XML의 `press=\"onSubmit\"` → Controller의 `onSubmit()` 실행 |
| **입력 값 읽기** | `this.getView().byId(\"idInpName\").getValue()` 사용 |
| **MessageBox** | `sap.m.MessageBox.show(message, options)` 로 팝업 표시 |
| **i18n** | `{i18n>title}` 사용 → manifest 또는 Component 내 모델 등록 필요 |
| **전달 경로** | View ↔ Controller 연결은 `controllerName` 속성으로 지정 |

---

## ✨ 6) 개선 버전 (표현식 바인딩 + 검증)

```xml
<Input id="idInpName"
       value="{/user/name}"
       placeholder="{i18n>phEnterName}" />
<Button text="Submit" press="onSubmit" enabled="{= ${/user/name} !== '' }" />

```

```jsx
onInit: function() {
  const oModel = new sap.ui.model.json.JSONModel({ user: { name: "" } });
  this.getView().setModel(oModel);
},
onSubmit: function() {
  const sName = this.getView().getModel().getProperty("/user/name");
  sap.m.MessageBox.success(`Hello, ${sName}!`);
}

```

> ✅ 장점: 입력값과 버튼 활성화 상태를 모델로 관리해 더 깔끔한 패턴을 구성할 수 있습니다.
> 

---

## 💬 **MessageBox 속성 및 옵션 정리**

SAPUI5의 `sap.m.MessageBox.show()`는

사용자에게 **정보, 경고, 오류, 질문** 등을 표시할 수 있는 **모달 대화 상자(Message Dialog)**를 생성합니다.

아래는 일반적인 호출 예시와 함께 각 속성 설명입니다 👇

```jsx
sap.ui.define(["sap/m/MessageBox"], function (MessageBox) {
  MessageBox.show(
    "This message should appear in the message box.", {
      icon: MessageBox.Icon.INFORMATION,
      title: "My message box title",
      actions: [MessageBox.Action.YES, MessageBox.Action.NO],
      emphasizedAction: MessageBox.Action.YES,
      onClose: function (oAction) {
        // 사용자가 YES/NO 중 무엇을 눌렀는지에 따라 처리
        console.log("User selected:", oAction);
      }
    }
  );
});

```

---

### 🧩 **주요 속성(property) 설명**

| 속성명 | 설명 | 예시 값 |
| --- | --- | --- |
| **`icon`** | 메시지 박스의 왼쪽 상단에 표시할 아이콘 지정 | `MessageBox.Icon.INFORMATION`, `WARNING`, `ERROR`, `SUCCESS`, `QUESTION` |
| **`title`** | 대화 상자 제목 (상단 바에 표시) | `"My message box title"` |
| **`actions`** | 사용자 선택 버튼 리스트 | `[MessageBox.Action.YES, MessageBox.Action.NO]`, `[\"OK\", \"Cancel\"]` |
| **`emphasizedAction`** | 시각적으로 강조(파란색 버튼)할 액션 지정 | `MessageBox.Action.YES` |
| **`onClose`** | 사용자가 버튼 클릭 후 닫을 때 실행되는 콜백 | `function(oAction) { ... }` |
| **`details`** | (선택) 추가 설명 또는 디버그용 상세 텍스트 표시 | `"Additional details..."` |
| **`styleClass`** | 커스텀 CSS 적용 클래스 | `"myCustomDialogStyle"` |
| **`actionsOrientation`** | 버튼 정렬 방향 (`Horizontal` or `Vertical`) | `"Vertical"` |

---

### 🧱 **MessageBox 단축 메서드**

`MessageBox.show()` 외에도 상황에 맞는 **단축 메서드**가 있습니다.

코드 가독성을 높이고, `icon`과 `title`이 자동으로 설정됩니다.

| 메서드 | 기본 아이콘 | 설명 |
| --- | --- | --- |
| `MessageBox.success()` | ✅ Success | 성공 메시지 |
| `MessageBox.error()` | ❌ Error | 오류 메시지 |
| `MessageBox.warning()` | ⚠️ Warning | 경고 메시지 |
| `MessageBox.information()` | ℹ️ Info | 정보 메시지 |
| `MessageBox.confirm()` | ❓ Question | 확인/취소 형태의 질문 메시지 |

예시 👇

```jsx
MessageBox.confirm("Are you sure you want to delete?", {
  title: "Confirm Deletion",
  onClose: (oAction) => {
    if (oAction === MessageBox.Action.OK) {
      console.log("Confirmed!");
    }
  }
});
```

---

## 🔍 byId의 **기본 개념**

SAPUI5는 MVC(Model–View–Controller) 구조로 동작해요.

XMLView에서 만든 컨트롤들은 Controller와 자동 연결되는데,

이때 Controller가 해당 View 안의 컨트롤을 접근할 때 사용하는 함수가 바로 `byId()`예요.

---

## 🧩 **기본 문법**

```jsx
// Controller 내부에서 사용
this.byId("<XML에 지정한 id>");

```

예시 👇

```xml
<Input id="idInpName" placeholder="Enter your name" />
<Button id="idBtnSubmit" text="Submit" press="onSubmit" />

```

```jsx
onSubmit: function() {
  const oInput = this.byId("idInpName");     // ID로 Input 컨트롤 찾기
  const sValue = oInput.getValue();          // 입력값 읽기
  console.log("입력된 이름:", sValue);
}

```

---

## 🧠 **왜 그냥 document.getElementById() 안 쓰고 byId()?**

SAPUI5는 **가상 DOM(View 구조)** 위에서 렌더링되기 때문에

브라우저의 HTML `id`와 SAPUI5의 컨트롤 ID가 다릅니다.

SAPUI5 내부에서는 다음과 같이 **ID가 자동 변환**돼요 👇

```
XMLView: id="App"
Input: id="idInpName"
→ 실제 DOM ID: App--idInpName

```

즉, 브라우저 입장에서 보면 `idInpName`이라는 HTML 요소는 존재하지 않습니다.

그래서 일반 `document.getElementById()`로는 찾을 수 없어요.

`byId()`는 SAPUI5가 자동으로 View ID 네임스페이스를 계산해서 정확히 찾아주는 함수예요 ✅

---

## 🧰 **관련 메서드 요약**

| 메서드 | 설명 | 사용 위치 |
| --- | --- | --- |
| `this.byId("id")` | 현재 View 내부의 컨트롤 탐색 | Controller 내부 |
| `sap.ui.getCore().byId("fullId")` | 전역 스코프에서 전체 ID로 탐색 | 전역 코드, 여러 View 간 접근 |
| `this.getView().byId("id")` | 명시적으로 View 객체 통해 탐색 (동일 기능) | Controller 내부 |
| `this.getOwnerComponent().byId("id")` | Component 단위에서 탐색 | Component 기반 앱 |

---

## 🧩 **예시 (비교)**

```jsx
// SAPUI5 방식 (정상)
var oButton = this.byId("idBtnSubmit");
oButton.setText("Clicked!");

// 브라우저 방식 (실패 가능)
var oBtn = document.getElementById("idBtnSubmit"); // undefined

```

## 정리 — `:` 붙이는 경우 vs 안 붙이는 경우

| 구분 | 예시 | 의미 | 용도 |
| --- | --- | --- | --- |
| `:` 붙임 | `xmlns:mvc="sap.ui.core.mvc"` | 별칭(namespace prefix)을 지정함 | 여러 라이브러리를 동시에 쓸 때 |
| `:` 없음 | `xmlns="sap.m"` | 기본(default) 네임스페이스 | 가장 자주 쓰는 라이브러리를 기본으로 설정 |

---

## 🧠 Lesson 3-4 요약

| 항목 | 내용 |
| --- | --- |
| 이벤트 | 버튼 `press` → `onSubmit` 호출 |
| 동작 | Input 값을 가져와 MessageBox에 출력 |
| 컨트롤러 | MVC 패턴에서 View 로직 분리 |
| 개선 아이디어 | 모델 바인딩 및 입력 검증 추가 |
| 실무 팁 | `MessageBox.show` 외에도 `success` / `error` / `warning` 단축 메서드 지원 |
