# 📘 Lesson 7. 모델과 데이터 바인딩 (Model & Data Binding)

---

## 🎯 학습 목표

- SAP UI5에서 **모델(Model)** 과 **뷰(View)** 간의 데이터 연결 구조 이해
- **데이터 바인딩(Data Binding)** 의 종류 및 동작 방식 숙지
- **바인딩 모드(OneTime / OneWay / TwoWay)** 구분 및 실습

---

## 🧩 1️⃣  Property와 각종 정의

SAPUI5의 바인딩 구문은 `{}` 안에 모델 경로를 지정하는 형태야.

기본 문법은 다음과 같아 👇

```
{modelName>path}

```

| 구성 요소 | 설명 | 예시 |
| --- | --- | --- |
| `{}` | 바인딩 표시 | `{}` |
| `modelName>` | 모델 이름 (Optional) | `{myModel>/data/name}` |
| `path` | 모델 내부 데이터 경로 | `/data/name` |
| `formatter` | 출력 시 형식 변환 함수 지정 | `{path:'/price', formatter:'.formatCurrency'}` |

📌 **프로퍼티 바인딩의 속성 예시**

```xml
<Text text="{/CustomerName}" />
<Input value="{myModel>/UserName}" />

```

📌 **복합 바인딩 (여러 속성 합쳐서 표현)**

```xml
<Text text="{parts:[{path:'/FirstName'}, {path:'/LastName'}], formatter:'.fullName'}" />

```

---

## 🔗 2️⃣ 데이터 바인딩의 종류 (3가지)

| 종류 | 설명 | 예시 | 사용 대상 |
| --- | --- | --- | --- |
| **Property Binding** | 컨트롤의 속성(Property)에 데이터 연결 | `<Input value="{/name}" />` | 단일 값 |
| **Aggregation Binding** | 여러 데이터(리스트, 테이블 등)에 연결 | `<List items="{/employees}">...</List>` | 복수 데이터 |
| **Element Binding** | 특정 객체(하나의 Row/Record)에 바인딩 | `this.getView().bindElement("/employees/0")` | 디테일 페이지 등 |

💬 **핵심 포인트**

Property → 단일 값

Aggregation → 여러 개

Element → 특정 객체 전체

---

## 🔄 3️⃣ 데이터 바인딩의 **모드(Mode)** (3가지)

| 바인딩 모드 | 데이터 흐름 | Model → View 반영 | View → Model 반영 | 특징 / 사용 예 |
| --- | --- | --- | --- | --- |
| **OneTime (원타임)** | 없음 (초기 1회만) | ❌ | ❌ | 고정 텍스트, 제목 등 |
| **OneWay (원웨이)** | 단방향 | ✅ | ❌ | 표시용(Label, Text 등) |
| **TwoWay (투웨이)** | 양방향 | ✅ | ✅ | 사용자 입력(Input, Checkbox 등) |

🧠 **정리**

- OneTime → 최초 한 번만
- OneWay → Model이 바뀌면 View 자동 갱신
- TwoWay → 양방향 동기화 (입력 시 Model도 변경됨)

---

## 4️⃣ *실습 코드*

# 📘 Lesson 7-1. JSONModel 기본 바인딩 실습

---

## 🎯 학습 목표

- **JSONModel** 을 생성하고 View에 연결하는 방법 이해
- **Property Binding** 을 통해 View에서 모델 데이터 표시
- **CheckBox selected** 속성처럼 Boolean 값 바인딩 익히기

<img width="1812" height="784" alt="image" src="https://github.com/user-attachments/assets/7ea88efe-d3d9-4a34-911b-8860c82ab2e2" />


---

## 🧩 실습 구성

| 구성 요소 | 파일명 | 설명 |
| --- | --- | --- |
| **View** | `Main.view.xml` | 입력창 + 체크박스 표시 (UI) |
| **Controller** | `Main.controller.js` | JSON 데이터 생성 및 Model 연결 |

---

## 💻 View (XML)

```xml
<mvc:View controllerName="code.unit10l0101.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
        <!-- Property Binding : Model 데이터와 UI 연결 -->
        <Input id="idInpFname" value="{/firstName}" />
        <Input id="idInpLname" value="{/lastName}" />
        <!-- 복합 바인딩 형태로 Full Name 표시 -->
        <Input id="idInpName" value="{/lastName} {/firstName}" />
        <!-- Boolean 값 바인딩 -->
        <CheckBox id="idChkBox" text="ALL" selected="{/enable}" />
    </Page>
</mvc:View>

```

🧠 **설명**

- `value="{/firstName}"` → 모델의 `firstName` 값 표시
- `value="{/lastName} {/firstName}"` → 두 속성을 합쳐 한 Input에 표시
- `selected="{/enable}"` → 모델의 Boolean 값으로 체크박스 상태 제어

---

## 💻 Controller (JS)

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
], (Controller, JSONModel) => {
    "use strict";

    return Controller.extend("code.unit10l0101.controller.Main", {
        onInit() {
            // (1) Data 정의 – JavaScript 객체로 값 준비
            var oData = {
                lastName : "Hong",
                firstName : "gil dong",
                enable : true
            };

            // (2) JSONModel 생성
            var oModel = new JSONModel();

            // (3) Model에 데이터 할당
            oModel.setData(oData);

            // (4) View에 Model 연결
            this.getView().setModel(oModel);
        }
    });
});

```

---

## 🔍 실행 결과

| UI 컨트롤 | 표시 내용 / 상태 | 설명 |
| --- | --- | --- |
| Input 1 | `gil dong` | firstName 값 |
| Input 2 | `Hong` | lastName 값 |
| Input 3 | `Hong gil dong` | 복합 바인딩 |
| CheckBox | 체크 상태 ON | enable =true 값 반영 |

---

## 💬 요약 포인트

| 항목 | 설명 |
| --- | --- |
| **모델 생성** | `new JSONModel()` |
| **데이터 주입** | `oModel.setData(oData)` |
| **View 연결** | `this.getView().setModel(oModel)` |
| **XML 바인딩 구문** | `{path}` 형태로 속성 연결 |

---

## 🧠 기억하기

> Controller에서 JSON 데이터를 정의하고
> 
> 
> → JSONModel에 담아
> 
> → View에 setModel() 하면
> 
> → XML View의 `{}` 구문으로 즉시 데이터 표시된다 💡
> 

# 📘 Lesson 7-2. 외부 JSON 파일 로드 & 절대경로 바인딩 실습

---

## 🎯 학습 목표

- **외부 JSON 파일(data.json)** 을 불러와 Model로 연결
- XML View에서 **모델 이름(name)** 을 지정하여 바인딩
- **버튼 이벤트(onPress)** 로 모델 속성 변경 (양방향 확인)
- **절대경로 방식(`name>/속성`)** 을 이용한 데이터 접근

<img width="1760" height="885" alt="image" src="https://github.com/user-attachments/assets/d9c62f58-c203-463c-be77-e694306256fe" />


---

## 🧩 실습 구성

| 구성 요소 | 파일명 | 설명 |
| --- | --- | --- |
| **View** | `Main.view.xml` | Input + CheckBox + Button UI |
| **Controller** | `Main.controller.js` | JSON 파일 로드 및 데이터 변경 처리 |
| **Model File** | `/model/data.json` | 외부 JSON 데이터 소스 |

---

## 💻 Model File (`/model/data.json`)

```json
{
    "firstName": "길동",
    "lastName": "홍",
    "enable": true,
    "disable": true}

```

🧠 **설명**

- `enable` 값은 CheckBox의 선택 여부와 연결
- 나중에 버튼 클릭 시 `enable` 값을 `true ↔ false` 로 전환

---

## 💻 View (XML)

```xml
<mvc:View controllerName="code.unit10l0102.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
        <!-- 절대경로 바인딩 : 모델명>경로 -->
        <Input id="idInpFname" value="{name>/firstName}" />
        <Input id="idInpLname" value="{name>/lastName}" />

        <!-- CheckBox selected 속성을 Boolean 데이터와 연결 -->
        <CheckBox id="idChkBox" text="Check Box" selected="{name>/enable}" />

        <!-- 버튼 클릭 시 enable 값 반전 -->
        <Button id="idBtn" text="Display/Change" press=".onPress" />
    </Page>
</mvc:View>

```

📌 **핵심 포인트**

- `name>`: 모델 이름이 `"name"`인 JSONModel에 접근
- `/firstName`, `/lastName`: 절대경로 접근
- `/enable`: CheckBox의 선택 여부와 연결

---

## 💻 Controller (JS)

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
], (Controller, JSONModel) => {
    "use strict";

    return Controller.extend("code.unit10l0102.controller.Main", {
        onInit() {
            // (1) JSON Model 생성
            var oModel = new JSONModel();

            // (2) 외부 JSON 파일 로드
            oModel.loadData("/model/data.json");

            // (3) View에 모델 연결 (모델명: name)
            this.getView().setModel(oModel, "name");
        },

        // (4) 버튼 클릭 시 enable 속성 반전
        onPress : function() {
            var sBool;

            // 현재 enable 값 읽기
            if (this.getView().getModel("name").getProperty("/enable")) {
                sBool = false;
            } else {
                sBool = true;
            }

            // enable 값 갱신 (Two-Way 바인딩)
            this.getView().getModel("name").setProperty("/enable", sBool);
        }
    });
});

```

---

## 🔍 실행 결과

| UI 컨트롤 | 표시 내용 / 상태 | 설명 |
| --- | --- | --- |
| Input 1 | `길동` | firstName 값 표시 |
| Input 2 | `홍` | lastName 값 표시 |
| CheckBox | 체크됨 (true) | enable 값 반영 |
| Button | 클릭 시 체크박스 ON/OFF 전환 | enable 값이 반전되어 View 자동 갱신 |

---

## 🧠 정리 포인트

| 항목 | 설명 |
| --- | --- |
| **모델 로드** | `oModel.loadData("/model/data.json")` 로 외부 JSON 불러옴 |
| **모델 이름 지정** | `this.getView().setModel(oModel, "name")` |
| **절대경로 바인딩** | `{name>/속성}` 형태로 데이터 연결 |
| **속성 값 변경** | `setProperty("/enable", sBool)` 로 Model → View 즉시 반영 |
| **CheckBox 동작 원리** | Model의 Boolean 값에 따라 자동 선택/해제 |

---

## 💬 핵심 요약

> 외부 JSON 파일을 불러와 모델에 연결하고,
> 
> 
> 모델 이름을 지정해 `{name>/경로}` 형태로 절대경로 바인딩한다.
> 
> Controller에서 `setProperty()` 로 데이터를 바꾸면
> 
> View(UI)가 자동으로 갱신된다. (OneWay or TwoWay 바인딩 효과)
> 

# 📘 Lesson 7-3. RadioButton · Two-Way 바인딩 · Expression 바인딩

## 🎯 학습 목표

- `JSONModel` 기본(기본 모드: TwoWay)로 **양방향 바인딩** 체감하기
- `RadioButton`의 `groupName`으로 **상호 배타 선택** + 모델 값 반영 이해
- 텍스트에 고정 문구 + 값 섞을 때 **표현식 바인딩(Expression Binding)** 쓰기

<img width="1812" height="784" alt="image" src="https://github.com/user-attachments/assets/fb50e29c-01ee-4bce-a746-d434e9f6e5a0" />


---

## 💻 Controller (그대로 OK)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel"
], (Controller, JSONModel) => {
  "use strict";

  return Controller.extend("code.unit10l0103.controller.Main", {
    onInit() {
      var oData = { name: "홍길동", enable: true };

      var oModel = new JSONModel();
      oModel.setData(oData);                 // 기본 바인딩 모드 = TwoWay
      this.getView().setModel(oModel);
    }
  });
});

```

- `JSONModel`의 기본 바인딩 모드가 **TwoWay**라서
    
    View에서 바뀐 값이 **자동으로 모델**에 반영돼.
    

---

## 💻 View (XML) — ✅ 권장 수정 포함

```xml
<mvc:View controllerName="code.unit10l0103.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
  <Page id="page" title="{i18n>title}">

    <!-- 같은 groupName → 둘 중 하나만 선택됨 -->
    <!-- 1번 라디오: selected를 /enable과 바인딩 -->
    <RadioButton id="idRb1" groupName="groupA"
                 selected="{/enable}" text="Display" />

    <!-- 2번 라디오: 바인딩 없이 표시만 (idRb1이 false가 되며 모델도 false로 반영됨) -->
    <RadioButton id="idRb2" groupName="groupA" text="Display" />

    <!-- enable 값(true/false)에 따라 입력 가능/불가 -->
    <!-- valueLiveUpdate="true" → 타이핑 중에도 모델에 즉시 반영 -->
    <Input id="idInpName" value="{/name}" valueLiveUpdate="true"
           enabled="{/enable}" />

    <!-- [수정 포인트] 정적 문구 + 값 혼합은 표현식 바인딩으로! -->
    <Text id="idTxtName" text="{= 'My name is ' + ${/name} }" />
  </Page>
</mvc:View>

```

### 🔧 왜 `Text`를 고쳤나?

- `text="My name is {/name}"` 처럼 **문자 + 바인딩**을 그대로 섞으면 동작 X
- 해결: **표현식 바인딩** `{= ... }` 또는 **복합 바인딩(parts/formatter)** 사용
    - 위 예시는 `{= 'My name is ' + ${/name} }`

---

## 🔍 동작 흐름 이해

1. 초기 데이터: `{ name: "홍길동", enable: true }`
    
    → 1번 라디오 체크 ON, Input 활성화
    
2. 2번 라디오를 클릭
    - `groupA` 특성상 1번이 자동으로 `selected=false`
    - 1번 라디오의 `selected="{/enable}"`가 **TwoWay**라서
        
        `/enable` 값이 **false로 갱신**됨
        
    - Input의 `enabled="{/enable}"`가 false가 되어 **비활성화**
3. Input에 타이핑
    - `valueLiveUpdate="true"` 덕분에 **입력 즉시 모델 `/name` 갱신**
    - 아래 `Text`(표현식 바인딩)도 즉시 렌더링 반영

---

## 🧠 핵심 포인트 요약

| 포인트 | 한 줄 설명 |
| --- | --- |
| RadioButton + `groupName` | 같은 그룹은 **상호 배타**. 하나 선택되면 다른 하나 해제 |
| TwoWay 바인딩 | 컨트롤 값 변경 → **모델로 즉시 반영** |
| selected 바인딩 | `selected="{/enable}"` 하나만 바인딩해도, 그룹 상호작용으로 모델 토글됨 |
| enabled 바인딩 | `/enable` 값에 따라 Input 활성/비활성 제어 |
| 표현식 바인딩 | 문구 + 값 섞을 때 `{= '문구' + ${path} }` |

---

## ✅ 미니 체크리스트

- [x]  모델은 `JSONModel` 기본 TwoWay?
- [x]  라디오는 같은 `groupName`?
- [x]  상태 토글 기준 속성은 하나만 바인딩해도 되는지 이해됨?
- [x]  문구+값은 표현식 바인딩으로 작성했는지?

# 📘 Lesson 7-4. 고객 정보 폼 바인딩

## 🎯 포인트

- **named model**(`"name"`)을 View에 붙이고
- `SimpleForm` 안에서 **절대경로 바인딩**으로 각 Input과 연결
- 버튼은 UI만 있고 이벤트는 아직 없음(원하면 `onCreate` 만들어줄게)

<img width="1657" height="713" alt="image" src="https://github.com/user-attachments/assets/f8300278-edb6-4146-900c-6bbad67d9ee1" />


---

## ✅ 동작 설명

- `oModel.loadData("/model/data.json")` 로 외부 JSON 로드
- View에서 `{name>/필드명}` 으로 바인딩 (모델명 `name` + 절대경로)
- JSON에 있는 값들이 폼에 그대로 표시·수정됨 (기본 Two-Way)

---

## 💾 data.json (네가 보낸 구조 사용)

```json
{
  "CustomerNumber": "1",
  "Form": "Firma",
  "Customer Name": "구나경",
  "Street": "부산광역시 부산진구 서전로38번길 65 (전포동)",
  "Post Code": "47294",
  "City": "Busan",
  "Country": "KOREA",
  "Email": "2215486@donga.ac.kr",
  "Telephone": "010-9923-0905",
  "Discount": "06"
}

```

> ⚠️ Tip: 키에 공백(예: "Customer Name") 있어도 {name>/Customer Name} 처럼 그대로 쓰면 동작하긴 해.
> 
> 
> 다만 실무에선 나중 관리 편하게 `CustomerName`, `PostCode` 식으로 파스칼/카멜케이스 권장.
> 

---

## 🧩 View 바인딩 체크

- `Form` → `{name>/Form}`
- `Customer Name` → `{name>/Customer Name}`
- `Discount` → `{name>/Discount}`
- `Street` → `{name>/Street}`
- `Post Code` → `{name>/Post Code}`
- `City` → `{name>/City}`
- `Country` → `{name>/Country}`
- `Email` → `{name>/Email}`
- `Telephone` → `{name>/Telephone}`

모두 **모델명 `name` + 절대경로**로 잘 연결되어 있음 👌

---

## 🧩 View 탭에서의 오버뷰 실습코드

```xml
<mvc:View controllerName="code.exercise10.controller.Overview"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core">
    <Page id="idPage" title="Flight Customers">
        <content>
            <Panel id="idPan" headerText="New Customer" expandable="true" expanded="true">
                <content>
                    <f:SimpleForm id="idSim" layout="ColumnLayout" editable="true">
                        <f:toolbar>
                            <Toolbar id="idTool2">
                                <content>
                                    <ToolbarSpacer id="idTlSpace"></ToolbarSpacer>
                                    <Button id="idBtn2" icon="sap-icon://create" text="Create Customer"></Button>
                                </content>
                            </Toolbar>
                        </f:toolbar>
                        <f:content>
                            <core:Title id="idTit1" text="General Data"></core:Title>
                            <Label id="idName1" text="Form"></Label>
                            <Input id="idInpName1" value="{name>/Form}"></Input> 
                            <Label id="idName2" text="Customer Name"></Label>
                            <Input id="idInpName2" value="{name>/Customer Name}"></Input>
                            <Label id="idName3" text="Discount"></Label>
                            <Input id="idInpName3" value="{name>/Discount}"></Input>

                            <core:Title id="idTit2" text="Address Data"></core:Title>
                            <Label id="idName4" text="Street"></Label>
                            <Input id="idInpName4" value="{name>/Street}"></Input>
                            <Label id="idName5" text="Post Code"></Label>
                            <Input id="idInpName5" value="{name>/Post Code}"></Input>
                            <Label id="idName6" text="City"></Label>
                            <Input id="idInpName6" value="{name>/City}"></Input>
                            <Label id="idName7" text="Country"></Label>
                            <Input id="idInpName7" value="{name>/Country}"></Input>

                            <core:Title id="idTit3" text="Contact Data"></core:Title>
                            <Label id="idName8" text="Email"></Label>
                            <Input id="idInpName8" value="{name>/Email}"></Input>
                            <Label id="idName9" text="Telephone"></Label>
                            <Input id="idInpName9" value="{name>/Telephone}"></Input>
                        </f:content>
                    </f:SimpleForm>
                </content>
            </Panel>
        </content>
    </Page>
</mvc:View> 
```

---

## ✨ 추천 개선(선택)

아래처럼 타입/밸리데이션만 살짝 추가하면 폼 퀄리티가 확 올라가.

```xml
<Input value="{name>/Email}" type="Email" />
<Input value="{name>/Telephone}" type="Tel" />
<Input value="{name>/Discount}" type="Number" maxLength="2" />

```

그리고 생성 버튼에 이벤트 연결:

```xml
<Button id="idBtn2" icon="sap-icon://create" text="Create Customer" press=".onCreate" />

```

```jsx
onCreate: function () {
  const oModel = this.getView().getModel("name");
  const oData  = oModel.getData();

  // 예: 간단 검증
  if (!oData["Customer Name"] || !oData.Email) {
    sap.m.MessageToast.show("고객명과 이메일은 필수야!");
    return;
  }
  // TODO: 백엔드 호출 또는 로컬 저장 로직
  console.log("Created:", oData);
  sap.m.MessageToast.show("고객 생성 완료(샘플)");
}

```

---

## 🔍 헷갈릴 수 있는 포인트 정리

- **절대경로**: `{name>/City}` 처럼 `/`로 시작(루트부터) + **모델명 지정**
- **Two-Way 기본**: `JSONModel`은 기본 바인딩 모드가 Two-Way라서, 인풋 수정하면 모델도 같이 바뀜
- **loadData 경로**: `/model/data.json` 은 앱 루트 기준. 경로 틀리면 404 → 값 안 뜸
- **공백 키**: UI5 경로에 공백 포함 가능. 그래도 유지보수는 `CustomerName` 같은 키가 유리
