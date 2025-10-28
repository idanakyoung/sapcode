# ✨ Lesson 5 — UI5 실습 기록 템플릿

---

# 🧩 **Lesson 5-1: VerticalLayout과 MVC 기본 구조**

> SAPUI5에서 VerticalLayout을 사용해 여러 UI 컨트롤을 세로로 배치하고, Controller를 통해 이벤트를 처리하는 기본 구조를 익힌다.
> 

---

## 🎯 **학습 목표**

- SAPUI5 MVC 구조(View + Controller) 이해하기
- `VerticalLayout`을 사용한 기본 화면 구성 학습
- 버튼 클릭 시 `MessageBox` 표시 기능 구현

---

## 📖 **핵심 개념**

| 개념 | 설명 |
| --- | --- |
| **MVC(Model-View-Controller)** | UI5의 핵심 구조. View는 화면(UI), Controller는 동작(Logic)을 담당 |
| **VerticalLayout** | 여러 컨트롤을 **세로 방향**으로 배치하는 레이아웃 |
| **MessageBox** | 사용자에게 알림창을 표시하는 컨트롤 |
| **`this.byId()`** | View 내의 특정 컨트롤(ID로 지정)을 접근할 때 사용하는 메서드 |

---

## 💻 **XML View 코드**

```xml
<mvc:View controllerName="code.unit8l0101.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:layout="sap.ui.layout">

    <Page id="page" title="{i18n>title}">
        <!-- VerticalLayout: 여러 UI 컨트롤을 세로로 배치 -->
        <layout:VerticalLayout id="idVert">

            <Label id="idLblName" text="Name" />
            <Input id="idInpName" value="john" />
            <Button id="idBtnSubmit" text="Submit" press=".onSubmit" />

        </layout:VerticalLayout>
    </Page>
</mvc:View>

```

---

## ⚙️ **Controller 코드**

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], function (Controller, MessageBox) {
    "use strict";

    return Controller.extend("code.unit8l0101.controller.Main", {
        onInit() {},

        onSubmit: function() {
            var name = this.byId("idInpName").getValue();

            MessageBox.information(name, {
                title: "Name Message Box",
                icon: MessageBox.Icon.INFORMATION,
                actions: [MessageBox.Action.OK],
                emphasizedAction: MessageBox.Action.OK
            });
        }
    });
});

```

---

## 🧠 **핵심 포인트**

✅ `VerticalLayout`

- 내부 컨트롤을 세로로 배치
- 컨트롤 수가 많을 경우 자동으로 스크롤 표시됨

✅ `press` 이벤트

- 버튼 클릭 시 `press` 속성에 연결된 함수(`.onSubmit`) 실행

✅ `MessageBox`

- 사용자에게 메시지를 알림창으로 표시
- `MessageBox.information()` → 정보 메시지 창

✅ `this.byId("...")`

- View의 ID를 통해 특정 컨트롤에 접근

---

## 🧩 **화면 시각화**

```
┌──────────────────────────────┐
│           Title              │
│------------------------------│
│ Name                         │
│ [ john                ]      │  ← Input 필드
│ [ Submit 버튼 ]              │  ← 버튼 클릭 시 MessageBox 표시
└──────────────────────────────┘

```

📱 세로로 정렬된 기본 화면 구성

버튼 클릭 시 입력값(예: "john")을 MessageBox로 출력

---

## 🧾 **정리 요약**

| 구분 | 내용 |
| --- | --- |
| **View** | XML 기반 화면 구성 (`Label`, `Input`, `Button`) |
| **Layout** | `sap.ui.layout.VerticalLayout` – 세로 정렬 |
| **Controller** | `sap.ui.core.mvc.Controller` |
| **이벤트** | `press=".onSubmit"` → 버튼 클릭 시 함수 실행 |
| **결과 동작** | 입력값을 MessageBox로 표시 |

---

# 🧩 **Lesson 5-2: HorizontalLayout과 가로 배치 구조**

> SAPUI5의 HorizontalLayout을 사용하여 여러 UI 컨트롤을 한 줄에 수평 배치하고, Controller를 통해 입력값을 조합하는 방법을 학습한다.
> 

---

## 🎯 **학습 목표**

- `HorizontalLayout`을 사용한 **가로 배치 UI 구성** 이해
- 여러 `Input` 값을 가져와 하나로 합치는 로직 구현
- `MessageBox`로 사용자 입력값 확인

---

## 📖 **핵심 개념**

| 개념 | 설명 |
| --- | --- |
| **HorizontalLayout** | UI 컨트롤을 **수평으로 한 줄에 나란히** 배치 |
| **byId()** | 특정 컨트롤에 접근하여 값(`getValue`, `setValue`) 제어 |
| **MessageBox** | 입력값을 사용자에게 알림창으로 표시 |
| **enabled="false"** | 사용자가 수정할 수 없는 읽기 전용 Input 생성 |

---

## 💻 **XML View 코드**

```xml
<mvc:View controllerName="code.unit8l0102.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:layout="sap.ui.layout">

    <Page id="page" title="{i18n>title}">
        <!-- Row(행)에 수평으로 UI Control을 차례대로 배치 -->
        <layout:HorizontalLayout>
            <Label id="idLblFname" text="First Name" />
            <Input id="idInpFname" value="gildong" />
            <Label id="idLblLname" text="Last Name" />
            <Input id="idInpLname" value="Hong" />
            <Button id="idBtnSubmit" text="Submit" press=".onSubmit" />
            <Input id="idInpname" enabled="false" />
        </layout:HorizontalLayout>
    </Page>
</mvc:View>

```

---

## ⚙️ **Controller 코드**

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], function (Controller, MessageBox) {
    "use strict";

    return Controller.extend("code.unit8l0102.controller.Main", {
        onInit() {},

        onSubmit: function() {
            var FirstName = this.byId("idInpFname").getValue();
            var LastName = this.byId("idInpLname").getValue();
            var FullName = FirstName + LastName;

            MessageBox.information(
                "FirstName은 " + FirstName + ", LastName은 " + LastName + "입니다.",
                {
                    title: "Name Message Box",
                    icon: MessageBox.Icon.INFORMATION,
                    actions: [MessageBox.Action.OK],
                    emphasizedAction: MessageBox.Action.OK
                }
            );

            this.byId("idInpname").setValue(FullName);
        }
    });
});

```

---

## 🧠 **핵심 포인트**

✅ `HorizontalLayout`

- 모든 컨트롤을 **한 줄(Row)** 에 나란히 배치
- 줄바꿈 없이 좌→우 순서대로 표시

✅ `MessageBox.information()`

- 입력한 이름 정보를 팝업창으로 출력

✅ `enabled="false"`

- 결과 출력용 Input (읽기 전용)

✅ `this.byId("...").setValue()`

- 컨트롤에 동적으로 값 설정

---

## 🧩 **화면 시각화**

```
┌──────────────────────────────────────────────────────────┐
│ First Name [ gildong ]  Last Name [ Hong ]  [Submit]     │
│ [ gildongHong ]                                           │ ← 결과 표시 (읽기 전용 Input)
└──────────────────────────────────────────────────────────┘

```

- 한 줄에 Label, Input, Button 모두 나란히 배치
- `Submit` 클릭 시 → MessageBox 표시
- 아래의 `enabled="false"` Input에 FullName 자동 출력

---

## 🧾 **정리 요약**

| 구분 | 내용 |
| --- | --- |
| **View** | XML 기반 UI (수평 배치) |
| **Layout** | `sap.ui.layout.HorizontalLayout` |
| **Controller** | 이벤트 처리 (`onSubmit`) |
| **핵심 로직** | Input 값 가져와 문자열 결합 후 MessageBox 출력 |
| **결과 표시** | `idInpname` Input에 FullName 출력 |

---

## 💡 **Tip**

- HorizontalLayout은 단순 가로 배치에 좋지만,
    
    반응형(Responsive) 지원은 부족하므로 **GridLayout**이나 **ResponsiveFlowLayout**을 나중에 사용하는 것이 일반적입니다.
    

---

# 🧩 **Lesson 5-3: Grid Layout(12컬럼)과 반응형 배치**

> sap.ui.layout.Grid를 사용해 12컬럼 기반으로 컨트롤을 배치하고, 화면 크기(L/M/S)에 따라 자동 줄바꿈·폭 조절을 구현한다.
> 

---

## 🎯 학습 목표

- `Grid` 레이아웃의 12컬럼 개념과 `span` 사용법 이해
- 데스크탑/태블릿/모바일별 반응형 배치 설계
- `indent`로 들여쓰기 적용하기

---

## 📖 핵심 개념

| 개념 | 설명 |
| --- | --- |
| **12컬럼 그리드** | 한 행(Row)은 12칸. 각 컨트롤은 `span="Lx My Sz"`로 화면 크기별 칸 수를 가짐 |
| **브레이크포인트** | `XL/L/M/S` (추가로 XL도 사용 가능) |
| **자동 줄바꿈** | 한 행에 배치 합이 12를 넘으면 다음 줄로 감 |
| **indent** | 특정 화면 크기에서 **들여쓰기(오프셋)** 를 주어 좌우 여백 확보 |

---

## 💻 XML View

```xml
<mvc:View controllerName="code.unit8l0103.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:l="sap.ui.layout">
    <Page id="page" title="{i18n>title}">
        <!-- 반응형 12컬럼 Grid -->
        <l:Grid id="idGrid">

            <!-- First Name -->
            <Label id="idLblFname" text="First Name">
                <layoutData>
                    <l:GridData id="idGridDat1" span="L2 M4 S12" />
                </layoutData>
            </Label>

            <Input id="idInpFname">
                <layoutData>
                    <l:GridData id="idGridDat2" span="L10 M8 S12" />
                </layoutData>
            </Input>

            <!-- Last Name -->
            <Label id="idLblLname" text="Last Name">
                <layoutData>
                    <l:GridData id="idGridDat3" span="L2 M4 S12" />
                </layoutData>
            </Label>

            <Input id="idInpLname">
                <layoutData>
                    <!-- 모바일은 각각 12칸 → 세로로 줄바꿈 -->
                    <l:GridData id="idGridDat4" span="L10 M8 S12" />
                </layoutData>
            </Input>

            <!-- Action Button -->
            <Button id="idBtnSubmit" text="Click Me" press=".onClick"
                    icon="sap-icon://action-settings" width="100%">
                <layoutData>
                    <!-- indent: M에서 4칸 들여쓰기 -->
                    <l:GridData id="idGridDat5" span="L2 M8 S12" indent="M4" />
                </layoutData>
            </Button>

        </l:Grid>
    </Page>
</mvc:View>

```

> ✅ text="Cleck Me"는 오타라 Click Me로 표기 권장
> 

---

## ⚙️ Controller

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("code.unit8l0103.controller.Main", {
        onInit() {
            // 초기화 로직 (필요 시)
        },
        onClick() {
            // 버튼 클릭 핸들러 (필요 시 구현)
        }
    });
});

```

> ✅ View에서 press=".onClick"을 사용하므로, Controller에 onClick() 추가해 완결성을 높이는 것이 좋아요.
> 

---

## 🧠 배치 결과 (시각화)

### 💻 데스크탑(L)

- Label(2) + Input(10) 한 줄
- 다음 줄도 같은 패턴
- 버튼은 `span="L2"`라 좁게, `width="100%"`로 자신의 칸 안에서는 가득

```
[First Name][__________ Fname __________]   ← 2 + 10 = 12
[Last  Name][__________ Lname __________]   ← 2 + 10 = 12
[  Btn  ]                                   ← 2 (나머지는 빈칸)

```

### 📟 태블릿(M)

- Label(4) + Input(8) 한 줄
- 버튼은 `span="M8"` + `indent="M4"` → **왼쪽 4칸 들여쓰기** 후 8칸 폭

```
[First Name    ][______ Fname ________]     ← 4 + 8
[Last  Name    ][______ Lname ________]     ← 4 + 8
[    (indent 4칸)    ][   Button (8칸)  ]   ← 4 + 8

```

### 📱 모바일(S)

- 모든 컨트롤이 `S12` → **한 줄 전체**
- Label과 Input이 **세로로 줄바꿈**

```
[First Name]
[________ Fname __________]

[Last Name]
[________ Lname __________]

[             Button              ]

```

---

## 💻 **1️⃣ 데스크탑 화면 (Large: L)**

> L2, L10 → 한 줄에 Label 2칸 + Input 10칸
> 

```
┌──────────────────────────────────────────────┐
│ Title (예: i18n>title 값)                   │
├──────────────────────────────────────────────┤
│ [First Name]  [__________________________]   │  ← Label(2) + Input(10)
│ [Last Name ]  [__________________________]   │
│            [⚙️ Click Me 버튼]               │  ← indent(M4) 고려 시 가운데 정렬 느낌
└──────────────────────────────────────────────┘

```

🟢 **특징**

- 한 줄에 `Label` + `Input` 같이 나열됨
- 버튼은 전체 폭(`width=100%`)으로 표시
- 여백(`indent`) 적용으로 중앙에 위치 가능

---

## 📟 **2️⃣ 태블릿 화면 (Medium: M)**

> M4, M8 → Label 4칸 + Input 8칸
> 

```
┌──────────────────────────────────────────────┐
│ Title                                        │
├──────────────────────────────────────────────┤
│ [First Name]    [____________________]       │
│ [Last Name ]    [____________________]       │
│        [⚙️ Click Me 버튼 (M4 indent)]       │
└──────────────────────────────────────────────┘

```

🟡 **특징**

- Label이 조금 더 넓어지고, Input이 좁아짐
- Button은 8칸 차지하고 왼쪽 4칸 들여쓰기 (indent="M4")
    
    → 가운데 쯤에 위치
    

---

## 📱 **3️⃣ 모바일 화면 (Small: S)**

> S12 → 모든 컨트롤이 한 줄 전체(12칸)를 차지
> 

```
┌──────────────────────────────────────────────┐
│ Title                                        │
├──────────────────────────────────────────────┤
│ [First Name]                                │
│ [__________________________]                │
│ [Last Name ]                                │
│ [__________________________]                │
│ [⚙️ Click Me 버튼]                          │
└──────────────────────────────────────────────┘

```

🔵 **특징**

- 한 줄에 하나씩 세로 배치
- 모바일에서 보기 편하게 줄바꿈 자동 처리

---

## 📊 **정리 — span 속성의 의미 시각화**

| 속성 | L (데스크탑) | M (태블릿) | S (모바일) |
| --- | --- | --- | --- |
| Label | 🟥 2칸 | 🟧 4칸 | 🟩 12칸 |
| Input | 🟦 10칸 | 🟨 8칸 | 🟪 12칸 |
| Button | 🟦 8칸 (중앙 정렬) | 🟦 8칸 (들여쓰기) | 🟩 12칸 (전체) |

🧩 합치면 항상 **12칸(=한 줄)** 을 기준으로 화면이 자동 재배치됩니다.

→ 그게 `<l:Grid>`의 핵심이에요.

---

## 🧩 속성 훑어보기 (Cheat Sheet)

| 속성 | 예시 | 의미 |
| --- | --- | --- |
| `span` | `span="L2 M4 S12"` | 화면 크기별 칸 수(1~12) |
| `indent` | `indent="M4"` | 해당 화면 크기에서 좌측 들여쓰기(오프셋) |
| `width` | `width="100%"` | 자체 칸 영역 내 가로폭 100% |
| `icon` | `sap-icon://action-settings` | 버튼 아이콘 |

---

## 🧾 정리 요약

- **Grid = 12컬럼**: 합이 12를 넘으면 자동 줄바꿈
- **반응형 배치**: L/M/S에 따라 `span`으로 폭을 다르게
- **모바일 최적화**: `S12`로 각 컨트롤이 한 줄 전체 차지
- **들여쓰기**: `indent="M4"`로 태블릿에서 버튼 정렬 조정

---

# 🧩 **Lesson 5-4: ResponsiveFlowLayout으로 유연한 줄바꿈/확장 배치**

> sap.ui.layout.ResponsiveFlowLayout을 사용해 가로폭에 맞춰 컨트롤을 자동 확장하고, 최소 너비(minWidth) 및 가중치(weight) 로 줄바꿈·비율을 제어한다.
> 

---

## 🎯 학습 목표

- `ResponsiveFlowLayout`의 자동 줄바꿈/확장 동작 이해
- `minWidth`, `weight`, `margin` 속성의 역할 파악
- 레이아웃 블록(VerticalLayout)과의 조합 패턴 익히기

---

## 💻 XML View

```xml
<mvc:View controllerName="code.unit8l0104.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:l="sap.ui.layout">
    <Page id="page" title="{i18n>title}">

        <!-- 화면 폭에 맞춰 확장/축소 + 필요 시 자동 줄바꿈 -->
        <l:ResponsiveFlowLayout id="idResFlow">

            <!-- 블록 #1 -->
            <l:VerticalLayout id="idVert" width="100%">
                <l:layoutData>
                    <!-- minWidth: 400px보다 좁아지면 다음 줄로 감 / margin: 블록 간 여백 -->
                    <l:ResponsiveFlowLayoutData id="idResDat" margin="true" minWidth="400" />
                </l:layoutData>

                <Label id="idLblFname" text="First Name" />
                <Input id="idInpFname" value="길동" />
            </l:VerticalLayout>

            <!-- 블록 #2 -->
            <l:VerticalLayout id="idVert2" width="100%">
                <l:layoutData>
                    <!-- weight: 같은 줄에 있을 때 가로폭 비율(이 블록이 2배 넓게) -->
                    <l:ResponsiveFlowLayoutData id="idResDat2" margin="true" weight="2" />
                </l:layoutData>

                <Label id="idLblLname" text="Last Name" />
                <Input id="idInpLname" value="홍" />
            </l:VerticalLayout>

        </l:ResponsiveFlowLayout>
    </Page>
</mvc:View>

```

---

## 📖 핵심 개념

| 개념 | 설명 |
| --- | --- |
| **ResponsiveFlowLayout** | 행(Row) 안에서 **가능하면 한 줄에 나란히**, 공간이 부족하면 **자동 줄바꿈** |
| **minWidth** | 블록이 **유지하려는 최소 너비(px)**. 이보다 작아지면 **다음 줄로 이동** |
| **weight** | 같은 줄일 때 **가로폭 비율**. 예: `1 : 2`라면 두 번째 블록이 2배 넓게 |
| **margin** | 블록 주위 **바깥 여백** 부여 |
| **width="100%"** | 블록 내부 컨트롤이 **블록 폭을 꽉 채우도록** 설정(권장 패턴) |

---

## 🧠 동작 시각화

### 1) 화면 넓음 (둘 다 한 줄)

```
[ First Name ] [__________________________]   |   [ Last Name ] [_______________________________]
   (블록 #1, weight=1, minWidth=400)          |     (블록 #2, weight=2, 더 넓게)

```

### 2) 화면 중간 (여전히 한 줄 유지 가능)

```
[ First Name ][______________] | [ Last Name ][_________________________]

```

### 3) 화면 좁음 (minWidth 충족 못함 → 자동 줄바꿈)

```
[ First Name ]
[__________________________]

[ Last Name ]
[__________________________]

```

> idVert(minWidth=400) 또는 idVert2가 자신의 최소 너비를 보장할 수 없을 때 해당 블록이 줄바꿈되어 세로 스택으로 전환됩니다.
> 

---

## 🧩 사용 팁

- **두 블록 모두 `minWidth`를 주면** 더 이른 시점에 줄바꿈되어 **모바일 가독성**이 좋아짐
- **가로 비율 제어**는 `weight`로, **줄바꿈 임계값**은 `minWidth`로 생각하면 기억 쉬움
- **여백(margin)** 을 켜서 블록 간 공간을 확보하면 답답함이 줄어듭니다
- 내부에 `Form`이나 `Grid`를 중첩해 **필드 정렬**을 정교하게 다듬어도 좋음

---

## 🧾 정리 요약

| 항목 | 값/예시 | 요점 |
| --- | --- | --- |
| 컨테이너 | `ResponsiveFlowLayout` | 자동 줄바꿈/확장 핵심 |
| 블록 | `VerticalLayout` × 2 | 각 블록에 라벨+인풋 세트 |
| 최소 너비 | `minWidth="400"` | 400px 미만이면 줄바꿈 |
| 비율 | `weight="2"` | 같은 줄에서 1:2로 넓이 배분 |
| 여백 | `margin="true"` | 블록 간 바깥 여백 적용 |

---

# 🧩 **Lesson 5-5: SimpleForm – 빠른 폼 구성(섹션/행 자동 생성)**

> sap.ui.layout.form.SimpleForm으로 폼(양식) 섹션과 행을 자동 생성하고, Toolbar, Title, Label만으로 컨테이너/엘리먼트 구조를 손쉽게 만드는 방법을 익힌다.
> 

---

## 🎯 학습 목표

- `SimpleForm`의 **자동 구조화 규칙**(FormContainer/FormElement) 이해
- `Toolbar`/`Title`/`Label` 역할과 배치 규칙 숙지
- 여러 필드를 **한 행(Row)에 나열**하는 방법
- 날짜/이미지 등 다양한 필드 조합 실습

---

## 📖 핵심 개념

| 개념 | 설명 |
| --- | --- |
| **SimpleForm** | 최소한의 태그로 **FormContainer / FormElement**를 자동 생성하는 폼 컨트롤 |
| **섹션(컨테이너)** | `core:Title` 또는 `sap.m.Title`이 나오면 **새 FormContainer** 시작 |
| **행(엘리먼트)** | `Label`이 나오면 **새 FormElement(=새 Row)** 시작, 뒤에 오는 컨트롤들이 **같은 행**에 배치 |
| **Toolbar** | 폼 상단에 도구 모음(버튼, 타이틀 등) 배치. `ToolbarSpacer`로 오른쪽 정렬 |
| **여러 필드 한 줄** | 같은 `Label` 뒤에 `Input`, `DatePicker` 등을 **연속해서 두면 같은 Row**에 나란히 배치 |
| **width** | `SimpleForm`에 `width="50%"` 등으로 폼 전체 너비 제어 |

---

## 💻 XML View (제공 코드 정리본)

```xml
<mvc:ViewcontrollerName="code.unit8l0105.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core">

    <Page id="page" title="{i18n>title}">

        <!-- SimpleForm #1 : 조건 영역 -->
        <f:SimpleForm id="idSimForm" width="50%">
            <f:toolbar>
                <Toolbar id="idToolBar">
                    <Title id="idTlt" text="Condition" />
                    <ToolbarSpacer id="idToolSpace" />
                    <Button id="idBtnCnc" text="Cancel" press=".onCancel" icon="sap-icon://cancel" />
                    <Button id="idBtnSch" text="Search" press=".onSearch" icon="sap-icon://search" />
                </Toolbar>
            </f:toolbar>

            <f:content>
                <!-- Label이 나오면 새 Row 시작, 이어지는 컨트롤은 같은 Row에 배치 -->
                <Label id="idLblName" text="Name" />
                <!-- <Input id="idInpTle" value="Mr" />  예시로 추가 가능 -->
                <Input id="idInpName" placeholder="Input name" />
            </f:content>
        </f:SimpleForm>

        <!-- SimpleForm #2 : 기본 정보 / 회사 / 주소 / 이미지 -->
        <f:SimpleForm id="idSimForm2">
            <!-- 새 섹션(컨테이너) 시작 -->
            <core:Title id="idTltPreson" text="Personal Info" />
            <Label id="idLblName1" text="Name" />
            <Input id="idInpFname1" value="철수" />
            <Input id="idInpLname1" value="김" />

            <Label id="idLblEntDt" text="Birth of Date" />
            <DateTimePicker id="idDatPick" value="20251010" editable="false" />
            <DatePicker id="idDatRet" />

            <!-- 새 섹션(컨테이너) 시작 -->
            <core:Title id="idTltOrg" text="Company Info" />
            <Label id="idLblComName" text="Company Name" />
            <Input id="idInpComName" value="Code Academy" />
            <Label id="idLblEntDate" text="Entered Date" />
            <DatePicker id="idDatPickEnt" value="20200101" />

            <!-- 새 섹션(컨테이너) 시작 -->
            <core:Title id="idTltAddr" text="Address Info" />
            <Label id="idLblAddr" text="Street/City" />
            <Input id="idInpStre" value="진구 전포동 텐스 5층" />
            <Input id="idInpCity" value="부산시" />

            <!-- 새 섹션(컨테이너) 시작 -->
            <core:Title id="idTltPoht" text="Image" />
            <Image id="idImgPoto1"
                   src="../image/1dd84af98e14901b7a7de1cbf451861e.jpg"
                   width="380px" height="220px" />
        </f:SimpleForm>

    </Page>
</mvc:View>

```

---

## 🧠 동작/배치 포인트

- **폼 구조 자동 생성 규칙**
    - `Toolbar` → 폼 상단 툴 영역
    - `Title/core:Title` → **새 섹션(컨테이너)** 시작
    - `Label` → **새 행(Row)** 시작
        
        그 뒤에 연속으로 오는 컨트롤들은 같은 행에 **가로로 나란히** 배치
        
- **예시 해석**
    - **Personal Info 섹션**
        - `Label(Name)` → 새 행 시작 → `Input(철수)`, `Input(김)`이 **같은 행**에 나란히
        - `Label(Birth of Date)` → 새 행 → `DateTimePicker`, `DatePicker`가 같은 행
    - **Address Info 섹션**
        - `Label(Street/City)` → 새 행 → `Input(Street)`, `Input(City)` 나란히
- **Toolbar 정렬**
    - `Title` + `ToolbarSpacer` + 버튼들 → 버튼이 오른쪽 끝으로 붙음

---

## 🧩 시각화 (텍스트 다이어그램)

```
SimpleForm #1   [ Condition ]
---------------------------------------------------- (Toolbar: Title | Spacer | Cancel | Search)
Row1:  Name  | [ Input: name ]

SimpleForm #2
== Personal Info ===================================
Row1:  Name  | [ 철수 ] [ 김 ]
Row2:  Birth of Date | [ DateTimePicker ] [ DatePicker ]

== Company Info ====================================
Row1:  Company Name | [ Code Academy ]
Row2:  Entered Date | [ DatePicker(20200101) ]

== Address Info ====================================
Row1:  Street/City  | [ 진구 전포동 텐스 5층 ] [ 부산시 ]

== Image ===========================================
Row1:  Image        | [ 380×220 이미지 ]

```

---

## 🧰 실전 팁 & 권장 설정

- **Date/DateTime 값 형식**
    - `DatePicker/DateTimePicker`는 보통 `valueFormat`/`displayFormat`을 함께 설정해주는 게 안전합니다.
    - 예)
        
        ```xml
        <DateTimePickervalue="{path: 'birth', type: 'sap.ui.model.type.Date', formatOptions: { pattern: 'yyyyMMddHHmmss' }}"
          displayFormat="yyyy-MM-dd HH:mm:ss" />
        <DatePickervalue="{path: 'entered', type: 'sap.ui.model.type.Date', formatOptions: { pattern: 'yyyyMMdd' }}"
          displayFormat="yyyy-MM-dd" />
        
        ```
        
    - 하드코딩 `value="20251010"` 보다는 **모델 바인딩 + 타입** 권장.
- **반응형 레이아웃**
    - `SimpleForm`은 기본적으로 반응형 레이아웃을 사용합니다(버전에 따라 `ResponsiveGridLayout`/`ResponsiveLayout`).
    - 열 수나 라벨 위치 등을 세밀히 바꾸려면 `layout`, `editable`, `labelSpan*`, `columnsL/M/S` 속성 활용.
- **이미지 경로**
    - `src`는 앱의 리소스 경로 기준. 빌드/배포 구조에 맞게 `webapp` 내부 경로 확인 필요.
- **접근성**
    - 라벨과 필드의 **연결**은 SimpleForm이 자동 처리하지만, aria-label이 필요한 컨트롤은 추가 설정 고려.

---

## 🧾 정리 요약

| 항목 | 요점 |
| --- | --- |
| 구조 규칙 | Title → 새 섹션, Label → 새 행, 라벨 뒤 컨트롤은 같은 행 |
| 배치 | 한 행에 여러 필드 나란히 배치 가능 |
| Toolbar | Spacer로 버튼 우측 정렬 |
| 날짜 필드 | `valueFormat/displayFormat` 또는 타입 바인딩 권장 |
| 활용 | 개인정보/회사/주소/이미지 등 섹션형 폼에 최적 |

---

# 🧩 **Lesson 5-6: Panel + Toolbar + SimpleForm 구성**

> sap.m.Panel로 섹션을 접고/펼치며, headerToolbar로 액션 버튼(저장/삭제) 을 배치하고, 내부에 개별 필드 또는 SimpleForm을 넣어 정보를 그룹화한다.
> 

---

## 🎯 학습 목표

- `Panel`의 `expandable/expanded/expandAnimation` 이해
- `headerToolbar`와 `ToolbarSpacer`로 액션 정렬
- Panel 내부에 **단일 필드 배치** vs **SimpleForm로 폼 구성** 비교

---

## 💻 XML View

```xml
<mvc:View controllerName="code.unit8l0106.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core"
    xmlns:l="sap.ui.layout">
    <Page id="page" title="{i18n>title}">

        <!-- Panel #1: 개별 필드 + 헤더 툴바 -->
        <Panel id="IdPanel" headerText="Panel with simple form"
               expandable="true" expanded="true" expandAnimation="true">

            <headerToolbar>
                <Toolbar id="idToolBar">
                    <Text id="idTxtTlt1" text="Information Data" />
                    <ToolbarSpacer id="idBarSpace" />
                    <Button id="idBtnSave" text="Save" press=".onSave" icon="sap-icon://save" />
                    <Button id="idBtnDelete" text="Delete" press=".onDelete" icon="sap-icon://delete" />
                </Toolbar>
            </headerToolbar>

            <Label id="idLblFname" text="First Name" />
            <Input id="idInpFname" />
            <Label id="idLblLname" text="Last Name" />
            <Input id="idInpLname" />

        </Panel>

        <!-- Panel #2: SimpleForm로 주소 섹션 구성 -->
        <Panel id="idPanel2" headerText="Address" expandable="true">
            <f:SimpleForm id="idSimForm">
                <core:Title id="idTlt1" text="Post" />
                <Label id="idLbl" text="Post Code" />
                <Input id="idInp" />

                <core:Title id="idTlt2" text="Address" />
                <Label id="idLb2" text="City/Street" />
                <Input id="idInp2" />
                <Input id="idInp3" />
            </f:SimpleForm>
        </Panel>

    </Page>
</mvc:View>

```

---

## 📖 핵심 개념

| 개념 | 설명 |
| --- | --- |
| **Panel** | 접고/펼칠 수 있는 **섹션 컨테이너**. `headerText`로 제목 표시 |
| **expandable / expanded** | 접기 가능 여부 / 초기 펼침 상태 |
| **expandAnimation** | 펼침/접힘 시 애니메이션 |
| **headerToolbar** | Panel 헤더 영역에 `Toolbar` 배치 (텍스트 + 버튼 등) |
| **ToolbarSpacer** | 좌측/중앙 요소와 우측 버튼 사이에 공간을 넣어 **버튼을 우측 정렬** |
| **SimpleForm** | `Title`이 나오면 **새 섹션**, `Label`이 나오면 **새 행** 시작 (자동 배치) |

---

## 🧠 동작/배치 포인트

- **Panel #1**
    - 헤더에 `"Information Data"` 텍스트와 `Save/Delete` 버튼 → 버튼은 `ToolbarSpacer` 때문에 오른쪽 정렬
    - 콘텐츠에는 **개별 필드**(Label+Input) 2세트 배치 (단순 폼)
- **Panel #2**
    - 내부에 `SimpleForm` 사용 → `Title`로 섹션 분리, `Label` 뒤 컨트롤이 같은 행에 나란히 배치
    - `City/Street` 행에 `Input` 2개를 이어서 넣어 한 줄에 두 필드 구성

---

## 🧩 화면 시각화

```
[ Panel: Panel with simple form ]  (▼)  [            Information Data           ][ Save ][ Delete ]
  First Name  [                 ]
  Last  Name  [                 ]

[ Panel: Address ]  (▶/▼)
  -- Post ------------------------------------------------
  Post Code   [                 ]

  -- Address ---------------------------------------------
  City/Street [                 ]  [                 ]

```

- (▼) 펼침 / (▶) 접힘 아이콘 느낌
- 우측에 Save/Delete 버튼이 정렬됨

---

## 🧰 실전 팁

- **접힘 상태 기억**: 사용자 경험을 위해 저장/로드 시 `expanded` 상태를 모델에 바인딩해도 좋음
- **폼 일관성**: 여러 필드가 많아지면 Panel #1도 `SimpleForm`로 전환하여 **레이블 정렬/간격**을 자동화
- **유효성 검사**: `onSave`에서 `valueState`, `valueStateText`로 입력 검증 피드백 제공
- **아이콘 버튼**: `text` 없이 `icon`만 사용하면 헤더가 더 깔끔해짐(툴팁 제공 권장)

---

## 🧾 정리 요약

| 항목 | 요점 |
| --- | --- |
| `Panel` | 섹션 컨테이너, 접고/펼침 가능 |
| `headerToolbar` | 헤더 툴바/버튼 구성, `ToolbarSpacer`로 우측 정렬 |
| 개별 필드 vs SimpleForm | 간단 필드는 개별 배치, 폼은 SimpleForm로 자동 행/섹션 생성 |
| 확장 UX | `expandable / expanded / expandAnimation` 설정으로 자연스러운 UI |

---

# 🧩 **Lesson 5-7: SimpleForm + Panel(툴바) 종합 실습**

> 조건 영역(SimpleForm)과 상세 영역(Panel + Toolbar + SimpleForm)을 합쳐 검색·저장·삭제 흐름을 구현한다.
> 

---

## 🎯 학습 목표

- 조건폼 + 결과패널 2단 구성 패턴 이해
- `ToolbarSpacer`로 헤더 버튼 정렬하기
- 날짜/이메일/텍스트 필드 검증 포인트 익히기
- 이벤트 핸들러(`onSearch`, `onSave`, `onDelete`) 설계

---

## 💻 XML View (제공 코드 정리)

```xml
<mvc:View controllerName="code.quiz04.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core">

    <Page id="page" title="{i18n>title}">

        <!-- 조건 영역 -->
        <f:SimpleForm id="idSimForm" width="50%">
            <f:toolbar>
                <Toolbar id="idToolBar">
                    <Title id="idTlt" text="Condition" />
                    <ToolbarSpacer id="idToolSpace" />
                    <Button id="idBtnSch" text="Search" press=".onSearch" icon="sap-icon://search" />
                </Toolbar>
            </f:toolbar>

            <f:content>
                <Label id="idLblTeamName" text="Team Name" />
                <Input id="idInpTeamName" value="SAP CRM" />
                <Label id="idLblEmpNo" text="Employee Number" />
                <Input id="idInpEmpNo" placeholder="Input Employee Number" />
            </f:content>
        </f:SimpleForm>

        <!-- 결과/상세 영역 -->
        <Panel id="IdPanel" headerText="Panel with simple form"
               expandable="true" expanded="true" expandAnimation="true">

            <headerToolbar>
                <Toolbar id="idToolBar2">
                    <Text id="idTxtTlt1" text="Employee Information" />
                    <ToolbarSpacer id="idBarSpace" />
                    <Button id="idBtnSave" text="Save" press=".onSave" icon="sap-icon://save" />
                    <Button id="idBtnDelete" text="Delete" press=".onDelete" icon="sap-icon://delete" />
                </Toolbar>
            </headerToolbar>

            <f:SimpleForm id="idSimForm2">

                <core:Title id="idTltPerson" text="Personal Information" />
                <Label id="idLblName1" text="Name" />
                <Input id="idInpFname1" value="Gil Dong" />
                <Input id="idInpLname1" value="Hong" />

                <Label id="idLblEntDt" text="Entered Date" />
                <DateTimePicker id="idDatPick" value="Dec 5, 2020" editable="true" />

                <Label id="idLblPosition" text="Position" />
                <Input id="idInpPosition" value="Manager" />

                <Label id="idLblEmail" text="E-MAIL" />
                <Input id="idInpEmail" value="2215486@donga.ac.kr" />

                <core:Title id="idTltOrg" text="Organization Information" />
                <Label id="idLblOrgName" text="Organization Name" />
                <Input id="idInpOrgName" value="SAP ERP TEAM" />

                <Label id="idLblChiefName" text="Chief Name" />
                <Input id="idInpChiefName" value="Kim Chel Soo" />

                <Label id="idLblEntDate" text="Entered Date" />
                <DatePicker id="idDatPickEnt" value="20201225" />

                <Label id="idLblImage" text="Image" />
                <Image id="idImgPoto1"
                       src="../image/1dd84af98e14901b7a7de1cbf451861e.jpg"
                       width="380px" height="220px" />
            </f:SimpleForm>
        </Panel>

    </Page>
</mvc:View>

```

> ✏️ 표기 추천: Infomation → Information, Cheif → Chief
> 

---

## 🧠 핵심 포인트

- **조건 → 상세** 2단 구성
    - 상단 SimpleForm에서 **검색 조건 입력**
    - 하단 Panel에서 **결과/상세 편집** (저장/삭제 버튼)
- **SimpleForm 규칙**
    - `core:Title` → 새 섹션
    - `Label` → 새 행(Row), 이어지는 컨트롤은 같은 행에 나란히
- **Toolbar 정렬**
    - `ToolbarSpacer`로 텍스트/제목 좌측, 버튼 우측 정렬
- **날짜 입력**
    - `DateTimePicker`, `DatePicker`는 보통 `valueFormat`/`displayFormat` 또는 타입 바인딩 사용 권장

---

## 🧩 화면 시각화

```
[ Condition ]                                  [ Search ]
Row1: Team Name         [ SAP CRM ]
Row2: Employee Number   [                ]

[ Employee Information ]                               [ Save ] [ Delete ]
== Personal Information ================================================
Row1: Name              [ Gil Dong ] [ Hong ]
Row2: Entered Date      [ DateTimePicker(Dec 5, 2020) ]
Row3: Position          [ Manager ]
Row4: E-MAIL            [ 2215486@donga.ac.kr ]

== Organization Information ============================================
Row1: Organization Name [ SAP ERP TEAM ]
Row2: Chief Name        [ Kim Chel Soo ]
Row3: Entered Date      [ DatePicker(20201225) ]

RowX: Image             [ (380×220 이미지) ]

```

---

## ✅ 입력 검증 & UX 팁

- **사번(`Employee Number`)**: 숫자 전용 검증 → 숫자 외 입력 시 `valueState="Error"` + 안내
- **이메일**: 정규식으로 형식 체크 → 잘못된 형식 시 Error
- **날짜 필드**:
    - `DateTimePicker`
        
        ```xml
        <DateTimePickervalue="{path: 'enteredAt', type: 'sap.ui.model.type.Date', formatOptions: { pattern: 'yyyy-MM-dd HH:mm' }}"
          displayFormat="yyyy-MM-dd HH:mm" />
        
        ```
        
    - `DatePicker`
        
        ```xml
        <DatePickervalue="{path: 'entered', type: 'sap.ui.model.type.Date', formatOptions: { pattern: 'yyyyMMdd' }}"
          displayFormat="yyyy-MM-dd" />
        
        ```
        
- **이미지 경로**: 배포 경로 기준으로 확인(캐시 이슈 시 쿼리스트링 활용 가능)

---

## ⚙️ Controller 스켈레톤(권장)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/m/MessageBox"
], (Controller, MessageBox) => {
  "use strict";

  return Controller.extend("code.quiz04.controller.Main", {
    onInit() {},

    onSearch() {
      const team = this.byId("idInpTeamName").getValue();
      const empNo = this.byId("idInpEmpNo").getValue();

      if (!empNo || !/^\d+$/.test(empNo)) {
        this.byId("idInpEmpNo").setValueState("Error");
        this.byId("idInpEmpNo").setValueStateText("숫자만 입력하세요.");
        MessageBox.warning("Employee Number를 확인하세요.");
        return;
      }
      this.byId("idInpEmpNo").setValueState("None");
      // TODO: 조회 로직 (OData/REST 호출 후 폼에 바인딩)
      MessageBox.information(`검색: Team=${team}, EmpNo=${empNo}`);
    },

    onSave() {
      const email = this.byId("idInpEmail").getValue();
      if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        this.byId("idInpEmail").setValueState("Error");
        this.byId("idInpEmail").setValueStateText("올바른 이메일 형식이 아닙니다.");
        MessageBox.error("E-MAIL 형식을 확인하세요.");
        return;
      }
      this.byId("idInpEmail").setValueState("None");
      // TODO: 저장 로직
      MessageBox.success("저장되었습니다.");
    },

    onDelete() {
      MessageBox.confirm("정말 삭제하시겠습니까?", {
        actions: [MessageBox.Action.OK, MessageBox.Action.CANCEL],
        emphasizedAction: MessageBox.Action.OK,
        onClose: (act) => {
          if (act === MessageBox.Action.OK) {
            // TODO: 삭제 로직
            MessageBox.success("삭제되었습니다.");
          }
        }
      });
    }
  });
});

```


## 🧾 정리 요약

| 항목 | 요점 |
| --- | --- |
| 구조 | **조건(SimpleForm) + 상세(Panel+Toolbar+SimpleForm)** |
| 핵심 컨셉 | Title=섹션, Label=행 시작(동일 행에 여러 필드 나란히) |
| 툴바 | `ToolbarSpacer`로 버튼 우측 정렬 |
| 검증 | 사번(숫자만), 이메일(정규식), 날짜는 포맷/타입 바인딩 권장 |
| 이벤트 | `onSearch`, `onSave`, `onDelete` 기본 흐름 |
