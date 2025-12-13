# ✨ Lesson 9 — UI5 Element Binding + 응용 퀴즈

# 🧩 Lesson 9-1 — JSONModel 로드 및 마스터/디테일 기본 구조

(따로 각 셀을 선택해서 (선택 안하면 오류 메세지 박스)어떤 버튼을 누르면 선택한 값에 대한 각 정보를 버튼을 누르면 나오는 창에 연결시켜서 해당 정보를 메세지 토스트나 메시지 박스로 출력 하기)

## 🎯 학습 목표

- `JSONModel`을 활용해 외부 JSON 데이터를 앱에 로드한다.
- View에서 데이터를 `Aggregation Binding`으로 표시한다.
- `data.json` 구조를 이해한다.

---

## 📂 파일 구성

```
/controller/Main.controller.js
/view/Main.view.xml
/model/data.json

```

---

## 🧠 주요 개념 요약

| 개념 | 설명 |
| --- | --- |
| **JSONModel** | JSON 파일 또는 객체를 데이터 소스로 사용하는 모델 |
| **Aggregation Binding** | 리스트나 테이블에 배열 데이터 바인딩 (ex. `/data`) |
| **절대 경로 바인딩** | 루트(`/`) 기준으로 시작하는 경로 |
| **상대 경로 바인딩** | 현재 컨텍스트를 기준으로 하위 속성을 참조하는 경로 |

---

## 🧩 1️⃣ Controller — JSONModel 로드

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
], (Controller, JSONModel) => {
    "use strict";

    return Controller.extend("code.unit10l0205.controller.Main", {
        onInit() {
            var oModel = new JSONModel();
            oModel.loadData("/model/data.json");
            this.getView().setModel(oModel);
        },

        onSelectionChange (oEvent) {
            var oListItem = oEvent.getParameter("listItem");
            var sPath = oListItem.getBindingContext().getPath();

            var oTabConect = this.byId("idTabConnect");
            oTabConect.bindElement(sPath);
        }
    });
});

```

### 🔍 코드 해설

- `new JSONModel()` → JSON 모델 인스턴스 생성
- `loadData("/model/data.json")` → 외부 JSON 로드
- `setModel(oModel)` → View에 기본(Default) 모델로 설정
- `onSelectionChange()` → 마스터 테이블 항목 클릭 시 선택된 항목 경로(`sPath`)를 얻고, 디테일 테이블에 바인딩

---

## 🧩 2️⃣ View — XML View 구조

```xml
<mvc:View controllerName="code.unit10l0205.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">

    <Page id="page" title="{i18n>title}">
        <!-- 마스터 테이블 -->
        <Table id="idTabCarrier" items="{/data}" mode="SingleSelectMaster"
               selectionChange=".onSelectionChange">
            <columns>
                <Column><header><Text text="Airline Code" /></header></Column>
                <Column><header><Text text="Airline Name" /></header></Column>
                <Column><header><Text text="Currency Code" /></header></Column>
                <Column><header><Text text="Web Site(URL)" /></header></Column>
            </columns>
            <items>
                <ColumnListItem>
                    <cells>
                        <Text text="{carrier/carrId}" />
                        <Text text="{carrier/carrName}" />
                        <Text text="{carrier/currCode}" />
                        <Text text="{carrier/url}" />
                    </cells>
                </ColumnListItem>
            </items>
        </Table>

        <!-- 디테일 테이블 -->
        <Table id="idTabConnect" items="{connections}">
            <columns>
                <Column><header><Text text="Connection No." /></header></Column>
                <Column><header><Text text="Departure City" /></header></Column>
                <Column><header><Text text="Arrival City" /></header></Column>
            </columns>
            <items>
                <ColumnListItem>
                    <cells>
                        <Text text="{connId}" />
                        <Text text="{cityFrom}" />
                        <Text text="{cityTo}" />
                    </cells>
                </ColumnListItem>
            </items>
        </Table>
    </Page>
</mvc:View>

```

### 📘 핵심 포인트

- `items="{/data}"`: Aggregation 바인딩으로 JSON 배열 연결
- `{carrier/carrId}`: 각 항목의 상대경로 바인딩
- `items="{connections}"`: Element 바인딩 시 상대경로로 연결편 목록 표시

---

## 🧩 3️⃣ 모델 데이터 — `model/data.json`

```json
{
  "data": [
    {
      "carrier": {
        "carrId": "LH",
        "carrName": "Lufthansa",
        "currCode": "EUR",
        "url": "http://www.lufthansa.com"
      },
      "connections": [
        { "connId": "400", "cityFrom": "Frankfurt", "cityTo": "New York" },
        { "connId": "401", "cityFrom": "New York", "cityTo": "Frankfurt" },
        { "connId": "0455", "cityFrom": "San Francisco", "cityTo": "Frankfurt" },
        { "connId": "2402", "cityFrom": "Frankfurt", "cityTo": "Berlin" }
      ]
    },
    {
      "carrier": {
        "carrId": "JL",
        "carrName": "Japan Airlines",
        "currCode": "JPY",
        "url": "http://www.jal.co.jp"
      },
      "connections": [
        { "connId": "0407", "cityFrom": "Tokyo", "cityTo": "Frankfurt" },
        { "connId": "0408", "cityFrom": "Frankfurt", "cityTo": "Tokyo" }
      ]
    },
    ...
  ]
}

```

---

## 💡 정리 포인트

| 구분 | 설명 |
| --- | --- |
| 모델 로딩 | `JSONModel().loadData()` 사용 |
| 데이터 구조 | `data` 배열 내부에 `carrier`와 `connections` 존재 |
| 마스터 테이블 | `/data`를 aggregation binding |
| 디테일 테이블 | `connections`를 element binding 기반으로 표시 |
| 이벤트 처리 | `selectionChange` → `bindElement(sPath)` 실행 |

---

## ✅ 실행 결과

1. 상단 테이블에 항공사 목록 표시
2. 항공사를 클릭하면 하단 테이블에 해당 항공사 연결편 목록 표시

---

# 🧩 Lesson 9-2 — FLP 안전 경로 + Fragment Dialog (단독 정리)

> 이번 레슨 목표
> 
> - `sap.ui.require.toUrl`로 FLP/프리뷰 환경에서 깨지지 않는 JSON 경로 사용
> - 마스터 선택 시 **Dialog(Fragment)**를 지연 로드하여 상세 표시
> - 선택 컨텍스트를 Fragment에 전달하고 상대경로 바인딩으로 표시

---

## 1) Controller (code.unit10l0205detaildialog.controller.Main)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel"
], (Controller,JSONModel) => {
  "use strict";

  return Controller.extend("code.unit10l0205detaildialog.controller.Main", {
    onInit() {
      var oModel = new sap.ui.model.json.JSONModel();
      // FLP(앱 프리뷰) 환경에서도 안전하게 model/data.json을 찾게 해줌
      var sUrl = sap.ui.require.toUrl("code/unit10l0205detaildialog/model/data.json");
      oModel.loadData(sUrl);

      this.getView().setModel(oModel);

      oModel.attachRequestCompleted(() => {
        console.log("✅ Data loaded:", oModel.getData());
      });
    },

    onSelectionChange (oEvent) {
      // oListItem은 바로 그 Lufthansa 행(ColumnListItem 컨트롤)
      var oListItem = oEvent.getParameter("listItem");
      // oListItem(행)의 데이터 위치(Context)
      var oCtx  = oListItem.getBindingContext();
      // 경로(/data/0)를 문자열 형태로 꺼내기
      var sPath = oCtx.getPath();
      // XML 안 상대경로를 이용해 현재 경로 테이블 전체에 상대 경로 데이터를 바인딩(연결)
      var oTabConect = this.byId("idTabConnect");
      oTabConect.bindElement(sPath);

      // 1️⃣ Promise 생성 (Dialog를 나중에 만들어 줄 약속)
      if (!this.pDialog) {
        this.pDialog = this.loadFragment({
          name: "code.unit10l0205detaildialog.view.PopupFrag"
        });
      }

      // 2️⃣ Promise가 끝나면 진짜 Dialog(oDialog)를 전달받음
      this.pDialog.then(function(oDialog){
        // 3️⃣ Dialog가 준비됐으니까 setBindingContext도 가능
        oDialog.setBindingContext(oCtx);
        oDialog.open(); // 팝업 표시
      }.bind(this));
    },

    onClose: function () {
      this.byId("idDialog").close();
    }
  });
});

```

### ✅ 핵심 포인트

- **FLP 안전 경로**: `sap.ui.require.toUrl("<컴포넌트 네임스페이스>/model/data.json")` → 런치패드/로컬 프리뷰 어디서든 동작
- **지연 로드 + 캐시**: `this.pDialog`에 Fragment Promise를 저장하여 **한 번만 로드**하고 계속 재사용
- **컨텍스트 전달**: `oDialog.setBindingContext(oCtx)`로 Fragment 내부 바인딩을 **상대경로**로 깔끔하게 유지
- **Element 바인딩 전환**: `oTabConect.bindElement(sPath)`로 하단 연결편 테이블은 선택 항목 기준으로 표시

---

## 2) Main View (XML)

```xml
<mvc:View controllerName="code.unit10l0205detaildialog.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core">
  <Page id="page" title="{i18n>title}">

    <!-- 마스터 테이블: 항공사 목록 -->
    <Table id="idTabCarrier" items="{/data}" mode="SingleSelectMaster"
           selectionChange=".onSelectionChange">
      <columns>
        <Column><header><Text text="Airline Code"/></header></Column>
        <Column><header><Text text="Airline Name"/></header></Column>
        <Column><header><Text text="Currency Code"/></header></Column>
        <Column><header><Text text="Web Site(URL)"/></header></Column>
      </columns>
      <items>
        <ColumnListItem>
          <cells>
            <Text text="{carrier/carrId}"/>
            <Text text="{carrier/carrName}"/>
            <Text text="{carrier/currCode}"/>
            <Text text="{carrier/url}"/>
          </cells>
        </ColumnListItem>
      </items>
    </Table>

    <!-- 디테일 테이블: 선택 항공사의 connections 배열을 상대경로로 표시 -->
    <Table id="idTabConnect" items="{connections}">
      <columns>
        <Column><header><Text text="Connection No."/></header></Column>
        <Column><header><Text text="Departure City"/></header></Column>
        <Column><header><Text text="Arrival City"/></header></Column>
      </columns>
      <items>
        <ColumnListItem>
          <cells>
            <Text text="{connId}"/>
            <Text text="{cityFrom}"/>
            <Text text="{cityTo}"/>
          </cells>
        </ColumnListItem>
      </items>
    </Table>
  </Page>
</mvc:View>

```

### ✅ 핵심 포인트

- 마스터(상단)와 디테일(하단) 테이블 구조는 9-1과 동일
- `selectionChange` → 컨트롤러의 `onSelectionChange`에서 **Dialog 오픈 + 디테일 갱신** 처리

---

## 3) Fragment View (PopupFrag.fragment.xml)

```xml
<core:FragmentDefinition
  xmlns:core="sap.ui.core"
  xmlns="sap.m"
  xmlns:f="sap.ui.layout.form">

  <Dialog id="idDialog" title="Dialog Fragment View">
    <beginButton>
      <Button id="idBtnClose" text="Close" press=".onClose"/>
    </beginButton>

    <f:SimpleForm id="idSimp1" editable="false" layout="ResponsiveGridLayout" width="100%">
      <f:content>
        <Label text="Airline Code"/>
        <Text text="{carrier/carrId}"/>

        <Label text="Airline Name"/>
        <Text text="{carrier/carrName}"/>

        <Label text="Currency Code"/>
        <Text text="{carrier/currCode}"/>

        <Label text="Web Site(URL)"/>
        <Text text="{carrier/url}"/>
      </f:content>
    </f:SimpleForm>
  </Dialog>
</core:FragmentDefinition>

```

### ✅ 핵심 포인트

- Fragment 내부 바인딩은 모두 **상대경로** → 컨트롤러에서 전달한 컨텍스트 기준으로 표시됨
- `press=".onClose"`는 호스트 컨트롤러의 `onClose`를 호출

---

## 4) 실행 흐름 (마스터 → 디테일 + 팝업)

1. 앱 시작 시 `data.json`을 FLP 안전 경로로 로드하고 View에 기본 모델로 설정
2. 사용자가 **항공사 Row를 선택** → `onSelectionChange` 실행
3. 디테일 테이블에 `bindElement(sPath)` 적용 → 하단에 연결편 목록 자동 갱신
4. 동시에 Fragment Dialog를 **지연 로드/재사용**하며, 선택 컨텍스트를 전달 후 `open()`

---

## 5) 베스트 프랙티스

- **경로 안전화**: 정적 파일은 항상 `sap.ui.require.toUrl` 사용
- **Fragment 재사용**: `this.pDialog` 캐시로 인스턴스 중복 생성 방지
- **상대경로 바인딩**: Dialog/Form 내용은 절대경로 대신 상대경로로 작성
- **리소스 정리(옵션)**: 화면 종료 시 필요하면 `oDialog.destroy()`로 메모리 회수
- **UX**: Dialog에 `ariaLabelledBy`를 지정해 접근성 강화

---

## 6) 트러블슈팅 체크리스트

- [ ]  `code.unit10l0205detaildialog` 네임스페이스와 실제 폴더 구조가 **일치**하는가?
- [ ]  Fragment `name`과 파일 경로가 정확히 매칭되는가? (오탈자 주의)
- [ ]  첫 클릭에서 Dialog가 안 뜨면 `this.pDialog` Promise 체인/에러 로그 확인
- [ ]  디테일 테이블이 비면 `bindElement(sPath)`가 불렸는지, `items="{connections}"`가 상대경로인지 확인
- [ ]  `press=".onClose"`가 컨트롤러에 구현되어 있는지 확인

---

## 7) 확장 아이디어 (다음 단계 미리보기)

- i18n: Dialog 제목/레이블을 `i18n` 키로 분리
- 링크 UX: `carrier/url`은 `Link` 컨트롤로 클릭 가능하게 변경
- 초기 선택: 첫 Row 자동 선택 후 Dialog 자동 오픈(옵션)

---

# 🧩 Lesson 9-3 — 마스터 테이블 + Dialog 내부 디테일 테이블

## 🎯 목표

- 메인 화면에는 **마스터 테이블만** 유지
- 행 선택 또는 버튼 클릭 시 **Dialog(Fragment)** 를 **지연 로드 + 재사용**
- **선택 행의 바인딩 컨텍스트**를 Dialog에 넘겨 **Dialog 내부 테이블**을 상대경로(`{connections}`)로 표시

---

## 📂 구성 파일

- `controller/Main.controller.js` (컨트롤러)
- `view/Main.view.xml` (마스터 테이블만)
- `view/PopupFrag.fragment.xml` (Dialog + 디테일 테이블)
- `model/data.json` (9-1과 동일)

---

## 🔧 동작 흐름

1. 앱 시작: `data.json`을 **FLP 안전 경로**(`sap.ui.require.toUrl`)로 로드 → View의 **기본 모델**로 설정
2. 마스터(항공사) 테이블에서 행 선택(`selectionChange`)
3. 선택된 행의 **바인딩 컨텍스트(oCtx)** 를 얻고, **Dialog를 지연 로드**
4. `oDialog.setBindingContext(oCtx)` → Fragment 내부 테이블의 `items="{connections}"`가 **선택 항목 기준**으로 렌더
5. `oDialog.open()`으로 팝업 표시
6. 닫기 버튼 `press=".onCloseDialog"`로 종료

---

## ✅ 코드 리뷰 & 핵심 포인트

### 컨트롤러 (제공 코드 기반 설명)

```jsx
onInit() {
  var oModel = new sap.ui.model.json.JSONModel();
  var sUrl = sap.ui.require.toUrl("code/unit10l0205dialogpopup/model/data.json");
  oModel.loadData(sUrl);
  this.getView().setModel(oModel);

  oModel.attachRequestCompleted(() => {
    console.log("✅ Data loaded:", oModel.getData());
  });
},

// ① '버튼으로 여는' 일반 오픈 핸들러
onDialog: function() {
  if (!this.pDialog) {
    this.pDialog = this.loadFragment({
      name: "code.unit10l0205dialogpopup.view.PopupFrag"
    });
  }
  this.pDialog.then(function(oDialog) {   // ← 매개변수명 oDialog 권장
    // ⚠️ 여기서는 컨텍스트를 안 넘기면 상대경로 바인딩이 비어 보일 수 있음
    oDialog.open();
  });
},

// ② '행 선택으로 여는' 핸들러 (권장)
onSelectionChange (oEvent) {
  var oItem = oEvent.getParameter("listItem");
  var oCtx  = oItem.getBindingContext();

  if (!this.pDialog) {
    this.pDialog = this.loadFragment({
      name: "code.unit10l0205dialogpopup.view.PopupFrag"
    });
  }

  this.pDialog.then(function(oDialog){
    // 선택 항목 컨텍스트를 Dialog에 전달 → Fragment 내부 {connections}가 활성화됨
    oDialog.setBindingContext(oCtx);
    // (권장) View에 종속시켜 수명주기/국소 i18n/모델 상속 안정화
    this.getView().addDependent(oDialog);
    oDialog.open();
  }.bind(this));
},

onCloseDialog: function () {
  this.byId("idDialog").close();
}

```

**포인트 정리**

- **지연 로드 + 캐시**: `this.pDialog`에 Fragment Promise 저장 → 한 번만 로드, 계속 재사용.
- **컨텍스트 전달 필수**: Dialog 내부는 **상대경로 바인딩**(`{connections}`, `{connId}`, …)이므로 `setBindingContext(oCtx)`가 있어야 **선택 항목 기준** 데이터가 뜹니다.
    - `onDialog`(버튼 오픈)에서도 최근 선택 항목의 컨텍스트를 기억해 넘기거나, 기본(첫 행) 컨텍스트를 선택해 넘기는 로직이 필요합니다.
- **addDependent 권장**: `this.getView().addDependent(oDialog)`로 View와 수명주기 연결 → i18n/모델 상속/정리 용이.
- **네이밍**: `.then(function(onDialog){ ... })`의 매개변수명을 `oDialog`처럼 의미있게 바꾸는 것을 추천.
- **일관성**: 상단 `sap/ui/model/json/JSONModel`를 이미 의존성으로 주입했으니 인스턴스 생성은 `new JSONModel()`로 통일 가능.

---

## 🖼️ Main View (마스터만 표시)

- 특징: 9-1, 9-2와 달리 **하단 디테일 테이블이 없음**. 디테일은 **Dialog로 이동**.
- `selectionChange` 이벤트로 컨트롤러 `onSelectionChange` 호출 → Dialog 오픈 & 컨텍스트 전달.

```xml
<mvc:View controllerName="code.unit10l0205dialogpopup.controller.Main"
  xmlns:mvc="sap.ui.core.mvc"
  xmlns="sap.m"
  xmlns:f="sap.ui.layout.form"
  xmlns:core="sap.ui.core">

  <Page id="page" title="{i18n>title}">
    <Table id="idTabCarrier" items="{/data}" mode="SingleSelectMaster"
           selectionChange=".onSelectionChange">
      <columns>
        <Column><header><Text text="Airline Code"/></header></Column>
        <Column><header><Text text="Airline Name"/></header></Column>
        <Column><header><Text text="Currency Code"/></header></Column>
        <Column><header><Text text="Web Site(URL)"/></header></Column>
      </columns>
      <items>
        <ColumnListItem>
          <cells>
            <Text text="{carrier/carrId}"/>
            <Text text="{carrier/carrName}"/>
            <Text text="{carrier/currCode}"/>
            <Text text="{carrier/url}"/>
          </cells>
        </ColumnListItem>
      </items>
    </Table>
  </Page>
</mvc:View>

```

---

## 🧩 Fragment (Dialog 내부에 디테일 테이블)

- Dialog가 **선택 항목의 컨텍스트**를 받으면, 내부 테이블의 `items="{connections}"`가 자연스럽게 해당 항목의 연결편 목록으로 렌더됩니다.

```xml
<core:FragmentDefinitionxmlns:core="sap.ui.core"
  xmlns="sap.m"
  xmlns:f="sap.ui.layout.form">

  <Dialog id="idDialog" title="Dialog Fragment View">
    <Table id="idTabConnect" items="{connections}">
      <columns>
        <Column><header><Text text="Connection No."/></header></Column>
        <Column><header><Text text="Departure City"/></header></Column>
        <Column><header><Text text="Arrival City"/></header></Column>
      </columns>
      <items>
        <ColumnListItem>
          <cells>
            <Text text="{connId}"/>
            <Text text="{cityFrom}"/>
            <Text text="{cityTo}"/>
          </cells>
        </ColumnListItem>
      </items>
    </Table>

    <beginButton>
      <Button id="idBtnclose" text="Close" press=".onCloseDialog"/>
    </beginButton>
  </Dialog>
</core:FragmentDefinition>

```

---

## 🧪 트러블슈팅 체크리스트

- [ ]  Fragment `name="code.unit10l0205dialogpopup.view.PopupFrag"` 와 실제 파일 경로/네임스페이스가 정확히 일치하는가?
- [ ]  **반드시** `oDialog.setBindingContext(oCtx)`가 호출되는가? (안 하면 `{connections}` 비어 보임)
- [ ]  `this.getView().addDependent(oDialog)`로 View 종속 추가했는가?
- [ ]  `onDialog`(버튼)로도 열려야 한다면, **최근 선택 컨텍스트**를 저장해 두었다가 세팅하거나, 기본 컨텍스트(`/data/0`)를 세팅하는 로직을 추가했는가?
- [ ]  JSON 경로는 `sap.ui.require.toUrl("code/unit10l0205dialogpopup/model/data.json")`로 안전하게 처리했는가?

---

## ✨ 권장 보완(선택)

- **컨텍스트 저장**: `this._lastCtx = oCtx;` 형태로 최근 선택을 저장 → `onDialog`에서도 `oDialog.setBindingContext(this._lastCtx || this.getView().getModel().createBindingContext("/data/0"));`
- **접근성**: `<Dialog ariaLabelledBy="...">`로 제목 텍스트를 연결
- **ESC 닫기**: `escapeHandler`를 지정해 키보드 닫기 제어(필요 시)
- **정리**: 더 이상 필요 없을 때 `oDialog.destroy()` 호출 (일반적으로 재사용 권장)
