# ✨ Lesson 8 — UI5 Aggregation 바인딩 실습 기록

## 🧭 **Lesson 8-1. ComboBox Aggregation 바인딩 실습**

---

## 🧩 **1. 개념 정리: Aggregation 바인딩이란?**

> Aggregation 바인딩(Aggregation Binding)
> 
> 
> 컨트롤이 여러 개의 하위 항목(집합, aggregation)을 가질 때,
> 
> 모델(Model) 안의 **배열(Array) 데이터를 자동으로 연결하여 UI를 반복 생성**하는 바인딩 방식이다.
> 
> 즉, 배열 데이터의 개수만큼 아이템을 자동으로 만들어주는 **"반복 바인딩"**이라고 이해하면 된다.
> 

---

### 🧠 **핵심 속성**

| 속성 | 설명 |
| --- | --- |
| **path** | 모델 안에서 바인딩할 배열의 경로 (예: `data>/codes`) |
| **template** | 배열의 각 요소를 화면에 표시하는 UI 구조 (`core:Item`, `StandardListItem` 등) |
| **model name** | 연결된 모델 이름 (`data` 등) |
| **binding mode** | 단방향(One-way) / 양방향(Two-way) 바인딩 지원 |
| **sorter / filter** | Aggregation 항목에 정렬 또는 필터 기능 적용 가능 |

---

### 💡 **예시 구조**

```xml
<Listitems="{
    path: 'data>/products'
  }">
  <StandardListItemtitle="{data>name}"
    description="{data>price}" />
</List>

```

- `/products` 배열 안의 데이터 개수만큼 `StandardListItem`이 자동 생성됨
- 각 항목의 `name`, `price` 속성이 화면에 표시됨

---

### 🎯 **2. 실습 목표**

- `ComboBox`의 `items` 집합(aggregation)에 배열 데이터를 바인딩한다.
- 사용자가 항목을 선택하면 **선택된 key**를 `Text` 컨트롤에 표시한다.
- 정렬(Sorter)과 양방향 바인딩(selectedKey ↔ model)을 적용한다.

---

### 💻 **3. 실습 코드**

![image.png](attachment:aa614854-940a-487e-a225-b581f3f401ff:image.png)

### 🪶 **View (Main.view.xml)**

```xml
<mvc:View controllerName="code.unit10l0201.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:core="sap.ui.core">

  <Page id="page" title="8-1 ComboBox (Aggregation Binding)">
    <VBox class="sapUiSmallMargin">

      <!-- ComboBox: Aggregation 바인딩 -->
      <ComboBox id="idComboBox"
        selectedKey="{data>/selCode}"
        selectionChange=".onSelectionChange"
        items="{
          path: 'data>/codes',
          sorter: { path: 'sName' }
        }">

        <!-- 템플릿: 배열의 각 요소를 표시할 Item -->
        <core:Item key="{data>sCode}" text="{data>sName}" />
      </ComboBox>

      <!-- 선택 결과 출력 -->
      <HBox class="sapUiSmallMarginTop" alignItems="Center">
        <Text text="선택된 코드:"/>
        <Text id="idTxtKey" class="sapUiSmallMarginBegin" text="{data>/selCode}"/>
      </HBox>
    </VBox>
  </Page>
</mvc:View>

```

---

### ⚙️ **Controller (Main.controller.js)**

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/m/MessageToast"
], function(Controller, JSONModel, MessageToast){
  "use strict";
  return Controller.extend("code.unit10l0201.controller.Main", {

    onInit: function () {
      // JSONModel 데이터 구성
      var oData = {
        selCode: "",
        codes: [
          { sCode: "S01", sName: "ABAP" },
          { sCode: "S02", sName: "SAPUI5" },
          { sCode: "S03", sName: "SAP Fiori" }
        ]
      };
      this.getView().setModel(new JSONModel(oData), "data");
    },

    onSelectionChange: function (oEvent) {
      var oItem = oEvent.getParameter("selectedItem");
      var sKey = oItem?.getKey();
      this.getView().getModel("data").setProperty("/selCode", sKey || "");
      if (sKey) MessageToast.show("선택한 코드: " + sKey);
    }
  });
});

```

---

### 💬 **4. 실행 흐름 설명**

| 단계 | 내용 |
| --- | --- |
| ① | `onInit()`에서 JSONModel(`data`) 생성 후 View에 설정 |
| ② | ComboBox의 `items` 속성이 `data>/codes` 배열과 연결됨 |
| ③ | 배열의 각 요소(`sCode`, `sName`)를 기반으로 `<core:Item>` 자동 생성 |
| ④ | 항목 선택 시 `onSelectionChange()`가 실행되어 `/selCode` 업데이트 |
| ⑤ | `Text` 컨트롤이 `/selCode`와 바인딩되어 선택값이 즉시 반영됨 |

---

### 🧩 **5. 주요 포인트**

- **Aggregation 바인딩 핵심 구조**
    
    → `items="{ path: '모델명>/배열경로' }"` + `<core:Item key="{...}" text="{...}" />`
    
- **selectedKey**로 선택 항목을 모델 속성(`/selCode`)과 양방향 바인딩
- **MessageToast**를 사용해 선택 즉시 피드백 제공
- 데이터만 바꾸면 ComboBox 항목이 자동 갱신됨 → **유지보수 용이**

---

### 🧠 **6. 실습 정리**

| 항목 | 설명 |
| --- | --- |
| **사용 컨트롤** | `sap.m.ComboBox`, `sap.m.Text` |
| **사용 모델** | `sap.ui.model.json.JSONModel` |
| **바인딩 유형** | Aggregation Binding (배열 데이터 반복 생성) |
| **핵심 속성** | `path`, `template`, `selectedKey`, `selectionChange` |
| **응용 가능** | List, Table, Select 등 반복 구조를 가진 컨트롤 전반 |

---

## 🧭 **Lesson 8-2. ComboBox + List Aggregation 실습 (코드 중심 정리)**

---

### 💻 **1. 주요 코드 요약**

| 구분 | 사용 구문 | 역할 |
| --- | --- | --- |
| **모델 생성** | `new JSONModel(oData)` | JSON 데이터를 UI에 연결할 모델 객체 생성 |
| **모델 설정** | `this.getView().setModel(oModel)` | View에 모델 등록 (이후 전체 컨트롤에서 `/속성` 접근 가능) |
| **Aggregation 바인딩** | `items="{/sList}"` | 모델의 배열 데이터를 기반으로 ComboBox / List 항목 자동 생성 |
| **속성 바인딩** | `key="{sCode}"`, `text="{sName}"`, `title="{sCode}"`, `description="{sName}"` | 데이터 속성을 각 컨트롤의 속성과 연결 |
| **초기값 설정** | `selectedKey="S03"` | ComboBox 기본 선택 항목 지정 |
| **양방향 바인딩** | `text="{/selCode}"` | 모델 값(`/selCode`)이 변경되면 Text 자동 갱신 |
| **이벤트 연결** | `selectionChange=".onSelectionChange"` / `itemPress=".onItemPress"` | 사용자 동작 발생 시 컨트롤러의 함수 호출 |
| **모델 데이터 접근** | `getBindingContext().getObject()` | 클릭된 아이템의 실제 데이터 객체 획득 |
| **모델 값 변경** | `setProperty("/selCode", sValue)` | 모델의 특정 경로 값 업데이트 (UI 자동 반영) |
| **피드백 메시지** | `MessageToast.show()` | 선택된 항목 정보 간단히 표시 |

---

### ⚙️ **2. Controller 핵심 로직 흐름**

![image.png](attachment:a2eab6bd-25dc-4ed5-a046-a64e1152925e:image.png)

```jsx
// ① 초기 데이터 구성 및 모델 등록
var oData = {
  selCode: "S01",
  sList: [
    { sCode: "S01", sName: "ABAP" },
    { sCode: "S02", sName: "JAVASCRIPT" },
    { sCode: "S03", sName: "SAPUI5" },
    { sCode: "S04", sName: "SAP Fiori" },
    { sCode: "S05", sName: "ABAP Object" }
  ]
};
this.getView().setModel(new JSONModel(oData));

// ② ComboBox 선택 시
onSelectionChange(oEvent) {
  const sPath = oEvent.getParameter("selectedItem").getBindingContext().getPath();
  const sCodeInfo = this.getView().getModel().getProperty(sPath);
  this.getView().getModel().setProperty("/selCode", sCodeInfo.sCode);
}

// ③ Search 버튼 클릭 시
onSerch() {
  const sKey = this.byId("idComboBox").getSelectedKey();
  this.byId("idTxtKey").setText(sKey);
}

// ④ List 아이템 클릭 시
onItemPress(oEvent) {
  const oData = oEvent.getParameter("listItem").getBindingContext().getObject();
  MessageToast.show(`선택한 Item : ${oData.sCode} (${oData.sName})`);
}

```

---

### 🧩 **3. View 핵심 속성 정리**

| 컨트롤 | 속성/이벤트 | 역할 |
| --- | --- | --- |
| **ComboBox** | `items="{/sList}"` | 배열 데이터를 바인딩해 항목 자동 생성 |
| 〃 | `selectedKey="S03"` | 초기 선택 항목 지정 |
| 〃 | `selectionChange` | 선택 변경 시 컨트롤러 함수 실행 |
| **Button** | `press=".onSerch"` | 클릭 이벤트 트리거 |
| **Text** | `text="{/selCode}"` | 모델 값(`/selCode`)을 실시간 표시 |
| **List** | `items="{/sList}"` | 배열 데이터를 기반으로 리스트 아이템 자동 생성 |
| 〃 | `itemPress=".onItemPress"` | 리스트 항목 클릭 시 이벤트 발생 |
| **StandardListItem** | `title="{sCode}"`, `description="{sName}"` | 각 아이템의 코드·이름 표시 |
| 〃 | `type="Navigation"` | 네비게이션 스타일 표시 아이콘 추가 |

---

### 💡 **4. 포인트 정리**

- **모델 공유**: ComboBox와 List가 동일한 `/sList` 데이터를 참조
- **양방향 데이터 반영**: `/selCode` 값이 변경되면 Text 자동 업데이트
- **이벤트 기반 동작**: ComboBox 선택 → 모델 업데이트 → Text 반영
- **데이터 접근**: `getBindingContext()`를 통해 선택된 객체 직접 조회 가능
- **UI 일관성**: 한 모델만 수정해도 모든 바인딩된 컨트롤이 자동 갱신

---

### 🧠 **5. 한줄 요약**

> Lesson 8-2에서는 하나의 JSONModel을 공유하는 ComboBox와 List를 Aggregation 바인딩으로 연결하고,
> 
> 
> **이벤트(선택·클릭)와 데이터 갱신(setProperty)** 흐름을 통해 **UI-Model 간 상호 작용 구조**를 익혔다.
> 

---

## 🧭 Lesson 8-3. 사칙연산 + ComboBox (코드 중심 정리)

---

### 🎯 목표

- `ComboBox`의 `selectedKey`로 연산자 선택
- `Input` 두 값 + 선택 연산자로 계산
- 결과를 `Input`(읽기 전용)에 표시하고 `MessageBox`로 피드백

![image.png](attachment:5c3d2325-c605-4ebf-8569-14574ade0e19:image.png)

---

### 💻 사용한 주요 코드 요소

### 1) View (핵심 바인딩/속성)

- `items="{/sList}"` : 배열 기반 Aggregation 바인딩
- `<core:Item key="{sCode}" text="{sName}" />` : 드롭다운 항목 정의
- `selectedKey="{/selCode}"` : 기본/현재 선택 연동 (양방향)
- `enabled="false"` : 결과 `Input`은 수정 불가(표시 전용)

```xml
<ComboBox id="idComboOp"
  items="{path: '/sList'}"
  selectedKey="{/selCode}">
  <core:Item key="{sCode}" text="{sName}" />
</ComboBox>

```

### 2) Controller (핵심 로직/유효성 검사)

- 모델 구성: `/selCode`(기본 “+”), `/sList`(연산자 목록)
- 값 읽기: `byId("...").getValue()` / 연산자: `getSelectedKey()`
- 숫자 변환: `parseFloat(...)` → `isNaN` 검사
- 분기: `switch(operation)` + 0 나누기 방지
- 결과 표시: `this.byId("idInpres").setValue(result)`
- 사용자 피드백: `MessageBox.show(total, { ... })`

```jsx
onSubmit: function () {
  const first  = parseFloat(this.byId("idInpFInt").getValue());
  const op     = this.byId("idComboOp").getSelectedKey();
  const second = parseFloat(this.byId("idInpSInt").getValue());

  if (isNaN(first) || isNaN(second)) {
    MessageBox.error("숫자1과 숫자2에 유효한 숫자 값을 입력하세요.");
    return;
  }
  if (!['+','-','*','/'].includes(op)) {
    MessageBox.error("연산자 기호(+, -, *, /)를 올바르게 입력하세요.");
    return;
  }

  let result;
  switch (op) {
    case '+': result = first + second; break;
    case '-': result = first - second; break;
    case '*': result = first * second; break;
    case '/':
      if (second === 0) { MessageBox.error("0으로 나눌 수 없습니다."); return; }
      result = first / second;
      break;
  }

  this.byId("idInpres").setValue(result);
  MessageBox.show(`최종 값은 ${result} 입니다.`, {
    title: "Total Display Message Box",
    icon: MessageBox.Icon.INFORMATION,
    actions: [MessageBox.Action.OK],
    emphasizedAction: MessageBox.Action.OK
  });
}

```

---

### 🧩 이번 코드에서 중요한 포인트만 콕

| 구분 | 코드/속성 | 왜 중요한가 |
| --- | --- | --- |
| 연산자 선택 | `ComboBox.selectedKey` | 화면 선택 ↔ 모델(`/selCode`) 싱크, 초기값 지정 용이 |
| 항목 템플릿 | `<core:Item key text>` | 키(실제 연산자)와 표시 텍스트(설명) 분리 |
| 값 읽기 | `getValue()` / `getSelectedKey()` | `ComboBox`는 **value가 아닌 key**로 로직 처리해야 안전 |
| 숫자 변환 | `parseFloat` + `isNaN` | 문자열/공백 등 엣지 케이스 방지 |
| 예외처리 | 0 나누기, 잘못된 연산자 | 런타임 에러/Infinity 방지, 사용자 메시지 명확 |
| 결과 출력 | `setValue(result)` | 즉시 UI 반영, 읽기 전용으로 실수 수정 방지 |
| 피드백 | `MessageBox.show(...)` | 계산 성공/실패 흐름을 사용자에게 명확히 전달 |

---

### 🔎 실행 흐름 (요약)

1. `onInit()`에서 `/selCode` 기본값 “+”, `/sList`(연산자 목록) 세팅 → View 바인딩
2. 사용자 입력 → `onSubmit()` 호출
3. `Input` 값 → `parseFloat`, 연산자 → `getSelectedKey`
4. 유효성 검사(NaN/연산자/0나눗셈) → 실패 시 `MessageBox.error`
5. `switch`로 계산 → 결과 `setValue` + `MessageBox.show`

---

### ⚠️ 흔한 실수 & 빠른 개선 팁

- **네임스페이스 불일치**
    - View: `controllerName="code.quiz0202.controller.Main"`
    - Controller: `Controller.extend("quiz02.controller.Main", { ... })`
        
        👉 둘 중 하나로 통일해야 이벤트/바인딩 정상 동작 (예: `code.quiz0202.controller.Main`로 통일)
        
- **공백/빈문자 입력**
    - `parseFloat('')` → `NaN`
        
        👉 `trim()`으로 앞뒤 공백 제거 후 검사 추가하면 안전
        
- **값 상태 피드백**(선택)
    - 잘못된 입력 시 `Input.setValueState("Error")` + `setValueStateText(...)`로 UX 향상 가능
- **소수점 자리수**(선택)
    - `result.toFixed(2)` 등으로 표시 포맷 제어 가능(모델/뷰포맷터로 분리 추천)

---

### ✅ 테스트 케이스 (빠른 검증용)

| 입력 | 연산자 | 기대 결과 |
| --- | --- | --- |
| 10 / 2 | `/` | 5 |
| 5 / 0 | `/` | “0으로 나눌 수 없습니다.” 에러 |
| 2.5 + 3.1 | `+` | 5.6 |
| 7 * 3 | `*` | 21 |
| (빈칸) + 3 | `+` | “유효한 숫자 값을 입력” 에러 |

---

# 8-4. Aggregation Binding (Table + Carousel)

## 🎯 학습목표

- JSONModel을 뷰에 주입하고 **집계 바인딩(aggregation binding)** 으로 `Table`/`Carousel` 항목을 자동 생성한다.
- `HBox` 플렉스 레이아웃으로 **캐러셀 페이지를 한 줄(일렬) 레이아웃**으로 정렬한다.

## 🧱 예제 데이터 & 구조

- 경로: `/Company`
- 스키마: `{ name, city, land, postcode }`
- 사용 컨트롤: `sap.m.Table`, `sap.m.Carousel`, `sap.m.HBox`, `sap.m.ObjectIdentifier`, `sap.m.ObjectNumber`, `sap.m.Text`

## 🧩 컨트롤러 핵심 (code.unit10l0203.controller.Main)

![image.png](attachment:752ca886-be0b-4245-8545-a86a1b896054:image.png)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel"
], function (Controller, JSONModel) {
  "use strict";

  return Controller.extend("code.unit10l0203.controller.Main", {
    onInit() {
      var oData = {
        Company: [
          { name: "SAP AG",  city: "walldorf", land: "DE", postcode: "12345" },
          { name: "Beam HG", city: "Hancock",  land: "US", postcode: "45636" },
          { name: "Carot Ltd", city: "Cheshire", land: "US", postcode: "98525" },
          { name: "Acme",    city: "Belmont",  land: "DE", postcode: "34567" },
          { name: "BMW",     city: "Munchen",  land: "DE", postcode: "92599" }
        ]
      };

      // 1) 모델 생성 & 데이터 설정
      var oModel = new JSONModel();
      oModel.setData(oData);

      // 2) 뷰에 모델 주입(이름 없는 default 모델)
      this.getView().setModel(oModel);
    },

    // 선택/탭 이벤트(옵션)
    onSelectionChange(oEvent) {
      const aContexts = oEvent.getSource().getSelectedContexts();
      // 필요 시 aContexts[0].getObject() 로 레코드 접근
    },
    onItemPress(oEvent) {
      const oObj = oEvent.getSource().getBindingContext().getObject();
      // 필요 시 상세 팝업/네비게이션
    }
  });
});

```

## 🖼️ 뷰 핵심(XML)

```xml
<mvc:View controllerName="code.unit10l0203.controller.Main"
  xmlns:mvc="sap.ui.core.mvc"
  xmlns="sap.m">

  <Page id="page" title="{i18n>title}">
    <VBox id="idVBox1" class="sapUiSmallMargin">

      <!-- 1) Table: aggregation items="{/Company}" -->
      <Table id="idTab"
             items="{/Company}"
             mode="MultiSelect"
             alternateRowColors="true"
             growing="true"
             growingThreshold="10"
             itemPress=".onItemPress"
             selectionChange=".onSelectionChange">
        <columns>
          <Column><header><Text text="Name" /></header></Column>
          <Column><header><Text text="City" /></header></Column>
          <Column><header><Text text="Country" /></header></Column>
          <Column><header><Text text="PostCode" /></header></Column>
        </columns>

        <items>
          <ColumnListItem type="Navigation">
            <cells>
              <Text text="{name}" />
              <Text text="{city}" />
              <Text text="{land}" />
              <Text text="{postcode}" />
            </cells>
          </ColumnListItem>
        </items>
      </Table>

      <!-- 2) Carousel: pages="{/Company}" (각 항목을 한 줄 레이아웃으로) -->
      <Carousel id="idCar" pages="{/Company}" loop="true" height="240px">
        <pages>
          <HBox class="sapUiSmallMargin"
                justifyContent="SpaceBetween"
                alignItems="Center"
                width="100%">
            <!-- 이름(넓게) -->
            <ObjectIdentifier title="{name}">
              <layoutData>
                <FlexItemData growFactor="2" />
              </layoutData>
            </ObjectIdentifier>

            <!-- City -->
            <Text text="City: {city}" wrapping="false">
              <layoutData><FlexItemData growFactor="1" /></layoutData>
            </Text>

            <!-- Country -->
            <Text text="Country: {land}" wrapping="false">
              <layoutData><FlexItemData growFactor="1" /></layoutData>
            </Text>

            <!-- PostCode -->
            <ObjectNumber number="{postcode}" unit="PostCode" emphasized="true">
              <layoutData><FlexItemData growFactor="1" /></layoutData>
            </ObjectNumber>
          </HBox>
        </pages>
      </Carousel>

    </VBox>
  </Page>
</mvc:View>

```

## ✅ 집계 바인딩 체크리스트

- [ ]  `JSONModel` 생성 → `setData(oData)` 호출했는가
- [ ]  `this.getView().setModel(oModel)` 로 **뷰에 모델 주입**했는가
- [ ]  `Table.items="{/Company}"`, `Carousel.pages="{/Company}"` 처럼 **루트 경로**로 묶었는가
- [ ]  셀/페이지 내부 바인딩은 **상대 경로**(`{name}`, `{city}`)로 썼는가
- [ ]  캐러셀 레이아웃이 한 줄로 보이도록 `HBox` + `wrapping="false"` 사용했는가
- [ ]  이벤트 속성(`itemPress`, `selectionChange`)를 XML에 달았으면 컨트롤러에 핸들러가 있는가

## 🧰 레이아웃 팁(캐러셀 한 줄 정렬)

- `HBox`에 `justifyContent="SpaceBetween"`, `alignItems="Center"`로 정렬
- 텍스트 줄바꿈 방지: `wrapping="false"`
- 항목 간 너비 배분: `FlexItemData.growFactor` (이름만 `2`, 나머지 `1`)
- 필요 시 `width="100%"` 지정으로 캐러셀 페이지 폭 고정

## 🐞 자주 나는 오류 & 해결

- **(증상)** 캐러셀에서 줄바꿈으로 두 줄/세 줄로 깨짐
    
    **→ (해결)** 각 `Text`에 `wrapping="false"` 추가, `HBox` 사용, 필요하면 너무 긴 값은 `maxLines="1"` + `textAlign` 조정
    
- **(증상)** Table/Carousel에 데이터가 안 뜸
    
    **→ (해결)** 모델 주입 누락, 경로 오타(`/Company`), 데이터 키 오타(`postcode` ↔ `postCode` 구분) 확인
    
- **(증상)** 이벤트 바인딩 했는데 에러
    
    **→ (해결)** 컨트롤러에 동일한 함수명 존재하는지 확인(`onItemPress`, `onSelectionChange`)
    

## 🧪 미션(확장 과제)

1. `Table` 헤더에 검색 `SearchField` 추가하고 `city` 포함 필터링 구현
2. 캐러셀 페이지에 `ObjectStatus` 추가해서 `DE`는 Positive, `US`는 Information 색상 표시
3. `MultiSelect`로 선택한 회사들을 **하단 리스트**에 요약 표시(이름/국가)

## 📝 스니펫 모음

- **선택한 첫 레코드 가져오기**

```jsx
const aCtx = this.byId("idTab").getSelectedContexts();
if (aCtx.length) {
  const o = aCtx[0].getObject(); // {name, city, land, postcode}
}

```

- **간단 필터링(도시)**

```jsx
const sQuery = "Munchen";
const oBinding = this.byId("idTab").getBinding("items");
oBinding.filter([ new sap.ui.model.Filter("city", "Contains", sQuery) ]);

```

## 🧭 오늘 배운 포인트(요약)

- 집계 바인딩은 **컨테이너의 aggregation 속성**에 경로만 걸어주면 아이템들이 자동 생성됨
- 캐러셀 한 줄 정렬은 `HBox + FlexItemData + wrapping="false"` 조합이 깔끔함

# 8-5. Aggregation Binding (sap.ui.table.Table)

## 🎯 학습목표

- `sap.ui.table.Table`에서 `rows="{/Company}"` 방식으로 **집계 바인딩** 적용
- 컬럼별 **정렬/필터** 속성 세팅하고, **자동 폭 맞춤**(auto resize)까지 구현

![image.png](attachment:56f0791d-a84b-41f8-9a1a-98d404261fb6:image.png)

## 🧱 데이터/모델 구조

- 경로: `/Company`
- 스키마: `{ name, city, land, postcode }`
- 컨트롤: `sap.ui.table.Table` + `t:Column` + `m:Text`

## ❗️이름 맞추기 체크

- 지금 네 코드에서 컨트롤러는 `code.unit10l0203.controller.Main`, 뷰는 `code.unit10l0204.controller.Main`로 달라.
    
    → 둘 중 하나로 **통일**해야 이벤트/바인딩 정상 동작해.
    
    - 옵션 A: 컨트롤러 네임스페이스를 `code.unit10l0204.controller.Main`로 변경
    - 옵션 B: 뷰의 `controllerName`을 `code.unit10l0203.controller.Main`로 변경

> 아래 스니펫은 컨트롤러/뷰 모두 unit10l0204로 통일한 버전이야. 필요하면 네 프로젝트에 맞춰 숫자만 바꿔.
> 

## 🧩 컨트롤러 (code.unit10l0204.controller.Main)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel"
], function (Controller, JSONModel) {
  "use strict";

  return Controller.extend("code.unit10l0204.controller.Main", {
    onInit() {
      var oData = {
        Company : [
          {name:"SAP AG",   city:"walldorf", land:"DE", postcode:"12345"},
          {name:"Beam HG",  city:"Hancock",  land:"US", postcode:"45636"},
          {name:"Carot Ltd",city:"Cheshire", land:"US", postcode:"98525"},
          {name:"Acme",     city:"Belmont",  land:"DE", postcode:"34567"},
          {name:"BMW",      city:"Munchen",  land:"DE", postcode:"92599"}
        ]
      };

      var oModel = new JSONModel();
      oModel.setData(oData);
      this.getView().setModel(oModel);

      // (선택) 렌더링 후 컬럼 자동폭 맞춤
      this.getView().addEventDelegate({
        onAfterShow: this._autoResize.bind(this)
      }, this);
    },

    _autoResize() {
      var oTable = this.byId("idTab1");
      if (!oTable) return;
      // 각 컬럼 폭 자동조정
      var aCols = oTable.getColumns();
      aCols.forEach(function(col, i){
        oTable.autoResizeColumn(i);
      });
    }
  });
});

```

## 🖼️ 뷰 (XML)

> 부트스트랩(standalone)이라면 sap.ui.table 라이브러리 포함 필요:
> 
> 
> `data-sap-ui-libs="sap.m,sap.ui.table"`
> 

```xml
<mvc:View controllerName="code.unit10l0204.controller.Main"
  xmlns:mvc="sap.ui.core.mvc"
  xmlns="sap.m"
  xmlns:t="sap.ui.table">

  <Page id="page" title="{i18n>title}">
    <t:Table id="idTab1"
             rows="{/Company}"
             alternateRowColors="true"
             selectionMode="MultiToggle"
             visibleRowCountMode="Auto"
             enableColumnReordering="true"
             showNoData="true"
             rowHeight="32">

      <t:columns>

        <t:Column id="idCol1" width="14rem" sortProperty="name" filterProperty="name">
          <t:label><Label text="Name" /></t:label>
          <t:template><Text text="{name}" /></t:template>
        </t:Column>

        <t:Column id="idCol2" width="12rem" sortProperty="city" filterProperty="city">
          <t:label><Label text="City" /></t:label>
          <t:template><Text text="{city}" /></t:template>
        </t:Column>

        <t:Column id="idCol3" width="10rem" sortProperty="land" filterProperty="land">
          <t:label><Label text="Country" /></t:label>
          <t:template><Text text="{land}" /></t:template>
        </t:Column>

        <t:Column id="idCol4" width="10rem" sortProperty="postcode" filterProperty="postcode">
          <t:label><Label text="Post Code" /></t:label>
          <t:template><Text text="{postcode}" /></t:template>
        </t:Column>

      </t:columns>
    </t:Table>
  </Page>
</mvc:View>

```

## ✅ 체크리스트

- [ ]  컨트롤러/뷰 **네임스페이스 일치**
- [ ]  부트스트랩에 `sap.ui.table` 로드(`data-sap-ui-libs`)
- [ ]  `rows="{/Company}"`로 루트 경로 바인딩
- [ ]  각 컬럼에 `sortProperty`, `filterProperty` 지정
- [ ]  (옵션) `visibleRowCountMode="Auto"` + `autoResizeColumn(i)`로 보기 좋게 정렬

## 🐞 흔한 이슈 & 해결

- **데이터 안 뜸**: 모델 미주입, 경로 오타(`/Company`) 확인
- **정렬/필터 메뉴 안 보임**: `sortProperty`/`filterProperty` 누락
- **스크롤만 생기고 줄 수 고정**: `visibleRowCountMode="Auto"` 쓰거나 `visibleRowCount` 적절히 설정
- **컨트롤러 이벤트/함수 안 먹음**: `controllerName` 불일치, 네임스페이스 오탈자 확인

## 🧪 미션(확장)

1. `selectionMode="Single"`로 바꾸고 선택 행 데이터를 상태바에 표시
2. `land === 'DE'`만 필터링하는 버튼 추가(프로그램 필터)
3. `postcode`를 숫자 정렬되게 커스텀 컴페어러 적용(고급)

## 📝 스니펫 모음

- **프로그램 정렬/필터**

- ```jsx
var oTable = this.byId("idTab1");
var oBinding = oTable.getBinding("rows");

// 필터: land === 'DE'
oBinding.filter([ new sap.ui.model.Filter("land", sap.ui.model.FilterOperator.EQ, "DE") ]);

// 정렬: name 오름차순
oBinding.sort([ new sap.ui.model.Sorter("name", false) ]);

```
