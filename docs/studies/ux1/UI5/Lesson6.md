# 📘 Lesson 6-1. Fragment 기본 실습

---

## 🎯 학습 목표

- **Fragment(XML 조각)** 를 View 안에서 불러와 사용하는 방법 이해
- **Fragment와 View 간 이벤트 연결 구조** 익히기
- `MessageToast`로 View와 Fragment 각각의 Input 값을 출력

<img width="1694" height="752" alt="image" src="https://github.com/user-attachments/assets/be82a5fc-f81e-4bf2-9c90-bbe19a7ddaa9" />


---

## 🧩 실습 구성

| 구성 요소 | 파일명 | 설명 |
| --- | --- | --- |
| **Controller** | `Main.controller.js` | 메인과 프래그먼트 버튼 이벤트 처리 |
| **View** | `Main.view.xml` | 메인 Input + Fragment 포함 |
| **Fragment** | `XMLFrag.fragment.xml` | 독립된 Input & Button 조각 |

---

## 💻 Controller (`Main.controller.js`)

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageToast"
], (Controller, MessageToast) => {
    "use strict";

    return Controller.extend("code.unit9l0101.controller.Main", {
        onInit() {
        },

        // 메인 뷰 버튼 클릭 이벤트
        onMainClick() {
            var mainValue = this.byId("idInpMain").getValue();
            MessageToast.show(mainValue);
        },

        // 프래그먼트 버튼 클릭 이벤트
        onFragClick() {
            var fragValue = this.byId("idFrgInp").getValue();
            MessageToast.show(fragValue);
        }
    });
});

```

### ✅ 핵심 포인트

- `this.byId("...")`는 View + Fragment 포함 전체 범위에서 ID 검색 가능
- `MessageToast.show()`는 화면 오른쪽 하단에 잠시 메시지를 띄움
- `onFragClick()`도 같은 컨트롤러에 있기 때문에 Fragment에서도 접근 가능

---

## 💻 Main View (`Main.view.xml`)

```xml
<mvc:View controllerName="code.unit9l0101.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns:core="sap.ui.core"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
        <!-- Main View Input -->
        <Input id="idInpMain" value="Main View" />

        <!-- Main View Button -->
        <Button id="idBtnMain" text="Main View Button" press=".onMainClick" />

        <!-- Fragment 불러오기 -->
        <core:Fragment fragmentName="code.unit9l0101.view.XMLFrag" type="XML" />
    </Page>
</mvc:View>

```

### ✅ 핵심 포인트

- `<core:Fragment fragmentName="패스" type="XML" />` 로 Fragment 삽입
- `fragmentName` 은 실제 파일 경로 (`view` 폴더 + 파일명)와 동일해야 함
- Fragment 내부 컨트롤들도 같은 컨트롤러에서 이벤트 접근 가능

---

## 💻 Fragment (`XMLFrag.fragment.xml`)

```xml
<core:FragmentDefinitionxmlns:core="sap.ui.core"
    xmlns="sap.m">
    <Input id="idFrgInp" value="Fragment Input" />
    <Button id="idFrgBtn" text="Fragment Button" press=".onFragClick" />
</core:FragmentDefinition>

```

### ✅ 핵심 포인트

- Fragment는 `<core:FragmentDefinition>`으로 시작해야 함
- View처럼 독립된 XML 조각이지만 Controller는 따로 갖지 않음
- 이벤트(`press=".onFragClick"`)는 Main Controller로 연결됨

---

## 🧠 동작 흐름 요약

1️⃣ **Main View** 로딩 시 → Fragment(XMLFrag) 자동 삽입

2️⃣ `Main View Button` 클릭 → Main Input 값 출력

3️⃣ `Fragment Button` 클릭 → Fragment Input 값 출력

---

## 🧩 실행 결과

| 구분 | 컨트롤 ID | 초기 값 | 버튼 클릭 시 결과 |
| --- | --- | --- | --- |
| 메인 뷰 | `idInpMain` | `Main View` | 메시지: “Main View” |
| 프래그먼트 | `idFrgInp` | `Fragment Input` | 메시지: “Fragment Input” |

---

## 💬 정리 요약

| 항목 | 설명 |
| --- | --- |
| **Fragment 역할** | View 안에 삽입되는 재사용 가능한 화면 조각 |
| **Controller 연결** | Fragment는 View의 Controller를 공유함 |
| **호출 방식** | `<core:Fragment fragmentName="..." type="XML" />` |
| **이벤트 처리** | `press=".함수명"`으로 Controller 이벤트 호출 가능 |
| **사용 목적** | Dialog, Popup, Form 조각 등 재사용 화면 구성 |

---

## 🧠 추가 팁

> Fragment는 보통 두 가지 방법으로 사용돼 👇
> 
> 
> 1️⃣ View 안에서 직접 `<core:Fragment>` 로 삽입 (지금 방식)
> 
> 2️⃣ Controller에서 `this.loadFragment({ name: "..." })` 로 **동적 로드(Dialog 등)**
> 

# 📘 Lesson 6-2. 동적 Fragment(Dialog) 실습

---

## 🎯 학습 목표

- **Controller에서 Fragment(Dialog)** 를 동적으로 로드하고 열기
- **Promise(`.then`) 구조** 이해 (Fragment 비동기 로드)
- **Dialog → View 간 데이터 전달 및 닫기(onClose)** 구조 익히기

<img width="1719" height="741" alt="image" src="https://github.com/user-attachments/assets/bc9d9a48-e817-4c2c-8818-c3c46bcd7c0c" />


---

## 🧩 실습 구성

| 구성 요소 | 파일명 | 설명 |
| --- | --- | --- |
| **Controller** | `Main.controller.js` | Dialog Fragment 로드 및 이벤트 처리 |
| **Main View** | `Main.view.xml` | 버튼 + 메인 Input |
| **Fragment** | `PopupFrag.fragment.xml` | Dialog 정의 (Text + Input + Close 버튼) |

---

## 💻 Controller (`Main.controller.js`)

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("code.unit9l0102.controller.Main", {
        onInit() {
        },

        // 🔹 다이얼로그 열기
        onDialog: function() {
            // 1️⃣ pDialog가 없으면 Fragment를 최초 로드
            if (!this.pDialog) {
                this.pDialog = this.loadFragment({
                    name: "code.unit9l0102.view.PopupFrag"
                });
            }

            // 2️⃣ Promise 완료 후 Dialog 열기
            this.pDialog.then(function(oDialog) {
                oDialog.open();
            });
        },

        // 🔹 다이얼로그 닫기 + 데이터 전달
        onClose: function() {
            // 1️⃣ Dialog 닫기
            this.byId("idDialog").close();

            // 2️⃣ Popup Input 값 읽기
            var oInput = this.byId("idInpPopup").getValue();

            // 3️⃣ Main Input에 전달 (⚠️ 괄호 위치 주의!)
            this.byId("idInpMain").setValue(oInput);
        }
    });
});

```

---

## 💻 Main View (`Main.view.xml`)

```xml
<mvc:View controllerName="code.unit9l0102.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
        <!-- Dialog 띄우기 버튼 -->
        <Button id="idBtnPopup" text="Display Dialog View" press=".onDialog" />

        <!-- Fragment의 Input 값이 전달될 메인 인풋 -->
        <Input id="idInpMain" editable="false" />
    </Page>
</mvc:View>

```

### ✅ 포인트

- 버튼 클릭 → `onDialog()` 실행
- `loadFragment()` 로 `PopupFrag.fragment.xml` 비동기 로드
- Dialog 오픈 시, `this.pDialog` 에 캐시 저장되어 다음 호출 시 재사용

---

## 💻 Fragment (`PopupFrag.fragment.xml`)

```xml
<core:FragmentDefinitionxmlns:core="sap.ui.core"
    xmlns="sap.m">

    <!-- Dialog Fragment -->
    <Dialog id="idDialog" title="Dialog Fragment View">
        <!-- 상단 텍스트 + 입력창 -->
        <Text id="idTxtPopup" text="Dialog View Text" />
        <Input id="idInpPopup" value="" />

        <!-- 닫기 버튼 -->
        <beginButton>
            <Button id="idBtnClose" text="Close" press=".onClose" />
        </beginButton>
    </Dialog>

</core:FragmentDefinition>

```

---

## 🔍 실행 흐름

1️⃣ **버튼 클릭 (Display Dialog View)**

→ `onDialog()` 실행

→ Fragment 파일(`PopupFrag.fragment.xml`)이 처음 한 번만 로드됨

2️⃣ **Dialog 열림**

→ 사용자 입력 가능 (`idInpPopup`)

3️⃣ **Close 버튼 클릭**

→ `onClose()` 실행

→ Dialog 닫힘 + 입력값을 메인 View의 `idInpMain` 에 전달

---

## ⚙️ 수정 포인트 (중요 ❗)

네 코드 중

```jsx
this.byId("idInpMain".setValue(oInput.getvalue()))

```

이 부분은 괄호 구조가 잘못돼서 동작 안 해 😅

정확히는 이렇게 써야 해 👇

```jsx
var oInput = this.byId("idInpPopup").getValue();
this.byId("idInpMain").setValue(oInput);

```

---

## 🧠 핵심 요약

| 항목 | 설명 |
| --- | --- |
| **Fragment 호출 방식** | `this.loadFragment({ name: "..." })` |
| **반환 타입** | Promise (→ `.then()`으로 Dialog 접근) |
| **Dialog 닫기** | `this.byId("idDialog").close()` |
| **데이터 전달** | `getValue()` → `setValue()` |
| **최초 1회 로드 후 재사용** | `this.pDialog` 로 캐싱 (성능 최적화) |

---

## 💬 추가 팁

- Fragment를 매번 새로 열지 않도록 `if (!this.pDialog)` 구조를 꼭 사용
- `loadFragment()`는 **비동기**로 작동하므로 `.then()` 필요
- Dialog 닫을 때 `destroy()` 하지 않으면 다음에 그대로 재사용 가능
- 이 방식은 **Popup, Confirm, Setting Dialog** 등 거의 모든 실무 Dialog의 기본 구조야!
