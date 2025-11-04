# ✨ Lesson 10 — UI5 Date Data Type

→ 10 / 2-6 , 10 / 4-1 정리하기 

---

## 🗓️ 참고 : `sap.ui.model.type.Date`의 `style` 옵션 종류

| 스타일 값 | 설명 | 예시 (한국 로케일 기준: `ko_KR`) | 예시 (미국 로케일 기준: `en_US`) |
| --- | --- | --- | --- |
| `"short"` | **짧은 형식** — 숫자 위주로 간단히 표시 | `25. 11. 3.` | `11/3/25` |
| `"medium"` | **중간 형식** — 월 이름 약어 포함 | `2025. 11. 3.` | `Nov 3, 2025` |
| `"long"` | **긴 형식** — 월 이름 전체 포함 | `2025년 11월 3일` | `November 3, 2025` |
| `"full"` | **전체 형식** — 요일까지 포함 | `2025년 11월 3일 월요일` | `Monday, November 3, 2025` |

# 🧠 **Lesson 10-1 — 부서-사원 테이블 데이터 바인딩과 콤보박스 사용**

홍길동, 김철수, 이철수 등의 사원들과 Sales와 Support 등의 부서들의 데이터 바인딩 (선택 후 버튼 클릭 또는 각 테이블 직접 클릭 후 데이터 표시) 10-2 로직과 비슷함, 코드 참고하기

# 🧠 **Lesson 10-2 — Filtering & Sorting with Formatter**

> 목표:
> 
> 
> JSONModel 데이터를 테이블에 바인딩하고,
> 
> - ComboBox 선택으로 **필터링 (Filter)**
> - 버튼 클릭으로 **정렬 (Sorter)**
> - 클릭한 행에 따른 **세부 테이블 표시**
> - formatter를 통해 **코드값 변환 표시**
>     
>     기능을 구현한다.
>     

---

## 🧭 **실제 시퀀스 흐름**

1️⃣ **onInit()**

- `emp`(직원 목록)과 `skill`(보유 기술) 데이터를 JSON 형태로 정의
- `oModel` 생성 → `setData(oData)` → `setModel()`로 **기본 모델 등록**
- 통화 코드용 별도 모델(`oModel2`, name: `cur`) 생성하여 ComboBox에 바인딩

2️⃣ **ComboBox 선택 시 onSelectionChange()**

- 선택된 통화값(`selCurr.key`)을 읽어
- `Filter("currency", EQ, selCurr.key)` 생성
- `idTabEmp` 테이블의 `items` 바인딩에 `filter()` 적용
    
    → 해당 통화 직원만 표시
    

3️⃣ **Remove Filter 버튼 (onRemoveFilter)**

- `oBinding.filter(null)` 로 모든 필터 해제

4️⃣ **Accesending by Gender 버튼 (onSorting)**

- `Sorter("gender", false)` 로 오름차순 정렬기 생성
- `oBinding.sort(aSorter)` 적용 → 성별 순으로 정렬

5️⃣ **Remove Sorting 버튼 (onRemoveStorting)**

- `oBinding.sort(null)` 로 정렬 해제

6️⃣ **직원 행 클릭 (onPress)**

- 클릭한 행의 `pernr` 값을 얻고
- `Filter("pernr", EQ, selPernr)` 적용하여
    
    `idTabSkill` 테이블을 필터링 → 해당 직원의 스킬만 표시
    

---

## 💬 **설계 의도 (Why this way?)**

- Filter와 Sorter를 직접 컨트롤러에서 적용함으로써
    
    **바인딩 데이터를 실시간으로 동적으로 제어**할 수 있도록 함.
    
- Formatter를 분리하여 뷰에서 표시 로직을 깔끔하게 관리.
- 이중 모델(`default` / `cur`) 구조로 데이터 역할을 분리.
    
    (기본 모델 → 직원/스킬, 보조 모델 → 통화 선택)
    

---

## 🎛️ **액티비티 및 주요 속성 요약**

| 구분 | 객체 | 속성 / 메서드 | 설명 |
| --- | --- | --- | --- |
| 모델 | `JSONModel` | `setData(oData)` | JS 객체를 JSON 모델로 등록 |
| 테이블 | `idTabEmp` | `items="{/emp}"` | 직원 리스트 바인딩 |
| 테이블 | `idTabSkill` | `items="{/skill}"` | 스킬 리스트 바인딩 |
| 필터 | `Filter(path, operator, value)` | `"currency"`, `EQ`, `선택값` | ComboBox 선택값 기준 필터 |
| 정렬 | `Sorter(path, descending)` | `"gender"`, false | 성별 오름차순 정렬 |
| 포맷터 | `formatter.genderText` / `jikText` | `{path:'gender', formatter:'formatter.genderText'}` | 코드값 → 표시텍스트 변환 |

---

## 🧩 **Formatter 핵심**

| 함수명 | 역할 | 예시 입력 → 출력 |
| --- | --- | --- |
| `genderText(pGender)` | 성별코드 변환 | `"M"` → `"Male"`, `"F"` → `"Female"` |
| `jikText(pGrade)` | 직급코드 → 한글 직급명 | `"A1"` → `"사원"`, `"C1"` → `"과장"` |

> ✅ 뷰에서는
> 
> 
> `<ObjectIdentifier title="{path:'gender', formatter:'formatter.genderText'}"/>`
> 
> 식으로 호출.
> 

---

## ⚙️ **UI 요소 설명**

| UI 요소 | ID | 역할 |
| --- | --- | --- |
| `ComboBox` | `idComboCurr` | 통화코드 선택 (필터 트리거) |
| `Button` | `idBtn2` | Remove Filter |
| `Button` | `idBtn3` | 성별 오름차순 정렬 |
| `Button` | `idBtn4` | 정렬 해제 |
| `Table` | `idTabEmp` | 직원 리스트 (기본 모델) |
| `Table` | `idTabSkill` | 스킬 리스트 (하단, pernr 기준 필터링) |

---

## ⚠️ **예외 처리 및 주의 사항**

- `oBinding.filter([aFilter])` 는 2차원 배열 형태지만 UI5가 자동으로 1차원 필터로 인식.
    
    ⇒ 정석은 `oBinding.filter(aFilter)` 로 사용.
    
- ComboBox에서 선택값 직접 얻을 때는
    
    `selectedItem.getKey()` 를 사용하면 모델 경로 참조보다 간결.
    
- Formatter는 순수 표시 로직만 담도록 관리하고, 조건 처리 등은 Expression Binding으로 대체 가능.

---

## ✅ **핵심 설계 포인트**

- **Filter / Sorter / Formatter** 3 요소를 통합 활용하여
    
    UI 데이터 표시와 조작을 완전 분리.
    
- **onPress()** → 상세 테이블 연동으로 Master-Detail 구조의 기본 개념 이해.
- 다중 모델(`default`, `cur`)을 활용한 이름 있는 모델 바인딩 연습.
- SAPUI5 데이터 바인딩의 **동적 제어 핵심** 습득.

---

## 🧠 **회고 및 개선 아이디어**

- Expression Binding(`{= }`)을 활용하면 formatter를 단축 가능.
    
    예: `{= ${gender} === 'M' ? 'Male' : 'Female'}`
    
- 통화 기준 필터와 성별 기준 정렬을 조합 필터로 확장 가능.
- 직원 선택 시 Dialog 팝업 으로 스킬 세부정보 표시하는 버전으로 발전 가능.
- ViewModel (`sap.ui.model.json.JSONModel`) 을 활용해 UI 상태 제어 기능 추가 예정.

---

## 📋 **파일 구조 예시**

```
unit10_l0401/
│
├── controller/
│   └── Main.controller.js
├── model/
│   └── formatter.js
├── view/
│   └── Main.view.xml
└── manifest.json

```

# 실습코드

# 1) Controller: `code.unit10l0401.controller.Main`

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",          // MVC 컨트롤러 베이스 클래스
    "sap/ui/model/json/JSONModel",         // JSON 모델 클래스
    "sap/ui/model/Filter",                 // 테이블/리스트 필터 객체
    "sap/ui/model/FilterOperator",         // 필터 연산자(enum)
    "sap/ui/model/Sorter"                  // 정렬기 객체
], (Controller,JSONModel,Filter,FilterOperator,Sorter) => {
    "use strict";

    return Controller.extend("code.unit10l0401.controller.Main", { // 네 컨트롤러 이름 등록

        onInit() {                              // 뷰 생성 시 최초 한 번 실행
            var oData = {                        // 화면에서 쓸 실제 데이터(직원/스킬)
                emp:[                            // 직원 목록
                    {pernr:"p01", eName:"HongGD", birthDt:"20001115", salary:"20000", currency:"KRW", gender:"M", jik:"A1"},
                    {pernr:"p02", eName:"KimSU",  birthDt:"20000915", salary:"30000", currency:"EUR", gender:"M", jik:"A1"},
                    {pernr:"p03", eName:"KimYH",  birthDt:"20000520", salary:"40000", currency:"USD", gender:"F", jik:"C1"},
                    {pernr:"p04", eName:"SimCI",  birthDt:"20000325", salary:"50000", currency:"KRW", gender:"M", jik:"P1"}
                ],

                skill :[                         // 직원별 보유 스킬(실제 화면 하단 테이블)
                    {pernr:"p01", sId:"S1", sName:" ABAP"},
                    {pernr:"p02", sId:"S2", sName:" SAPUI5"},
                    {pernr:"p03", sId:"S3", sName:"Fiori"},

                    {pernr:"p02", sId:"S1", sName:"ABAP"},
                    {pernr:"p02", sId:"S2", sName:"SAPUI5"},
                    {pernr:"p02", sId:"S4", sName:"JAVAScript"},
                    {pernr:"p02", sId:"S5", sName:"SAP Gateway"},

                    {pernr:"p03", sId:"S1", sName:"ABAP"},
                    {pernr:"p03", sId:"S2", sName:"SAPUI5"},
                    {pernr:"p03", sId:"S3", sName:"Fiori"},
                    {pernr:"p03", sId:"S6", sName:"WedynPro ABAP"},

                    {pernr:"p04", sId:"S1", sName:"ABAP"},
                    {pernr:"p04", sId:"S2", sName:"SAPUI5"},
                    {pernr:"p03", sId:"S3", sName:"Fiori"},
                    {pernr:"p04", sId:"S4", sName:"JAVAScript"},
                    {pernr:"p04", sId:"S5", sName:"SAP Gateway"},
                    {pernr:"p03", sId:"S6", sName:"WedynPro ABAP"}
                ]
            }
            var oModel = new JSONModel()         // 기본 모델 인스턴스 생성
            oModel.setData(oData)                // 위의 oData를 모델에 주입
            this.getView().setModel(oModel)      // 뷰의 기본 모델로 등록 (model name 없음)

            var oCurr = {                        // 통화 콤보박스에 쓸 별도 데이터
                currCode: [
                    {key:"EUR", value:"EUR"},
                    {key:"USD", value:"USD"},
                    {key:"JPY", value:"JPY"},
                    {key:"GBP", value:"GBP"},
                    {key:"KRW", value:"KRW"}
                ]
            }
            var oModel2 = new JSONModel()        // 통화 전용 모델
            oModel2.setData(oCurr)               // 통화 데이터 주입
            this.getView().setModel(oModel2, "cur") // 뷰에 "cur"라는 이름으로 등록
        },

        onPress (oEvent) {                       // 직원 테이블 행(네비게이션) 클릭 시 실행
            let selItem = oEvent.getSource().getBindingContext() // 눌린 아이템의 바인딩컨텍스트
            console.log(selItem)
            let oModel = this.getView().getModel()               // 기본 모델 참조

            let selPernr = oModel.getProperty("pernr", selItem)  // 선택 아이템의 pernr 값 읽기
            let oFilter = new Filter("pernr", FilterOperator.EQ, selPernr) // pernr=선택값 조건
            let aFilter = []
            aFilter.push(oFilter)                                // 필터 배열에 추가(지금은 1개)

            let oTable = this.byId("idTabSkill")                 // 하단 스킬 테이블
            let oBinding = oTable.getBinding("items")            // items 집계 바인딩 객체
            oBinding.filter(oFilter)                             // 해당 pernr로 스킬 필터링
        },

        onSorting () {                         // '성별 오름차순' 버튼 클릭 시
            // true 오면 내림차순이지만, 여기서는 false ⇒ 오름차순
            var oSorter = new Sorter("gender", false) // gender 기준 asc
            var aSorter = []
            aSorter.push(oSorter)                        // 정렬기 배열 준비

            var oTable = this.byId("idTabEmp")          // 직원 테이블
            var oBinding = oTable.getBinding("items")   // items 바인딩
            // oBinding.sorter([oSorter])               // (과거 API 스타일 주석)
            oBinding.sort(aSorter)                      // 배열로 정렬 적용
        },

        onRemoveStorting () {                 // 정렬 해제 버튼 클릭 시
            let oTable = this.byId("idTabEmp")
            let oBinding = oTable.getBinding("items")
            oBinding.sort(null)               // sorter 제거(원래 순서로)
            // 주석 세 줄은 같은 의미의 다양한 작성 시도
        },

        onSelectionChange (oEvent) {          // 통화 콤보박스 선택 변경 시
            let selectedItem = oEvent.getParameter("selectedItem")    // 선택된 아이템
            let sPath = selectedItem.getBindingContext("cur").getPath() // "cur" 모델 경로
            let selCurr = this.getView().getModel("cur").getProperty(sPath) // {key,value} 객체

            let oFilter = new Filter("currency", FilterOperator.EQ, selCurr.key) // currency=선택통화
            let aFilter = []
            aFilter.push(oFilter)                                     // 필터 배열 구성

            var oTable = this.byId("idTabEmp")
            var oBinding = oTable.getBinding("items")
            oBinding.filter([aFilter])                                // 직원 테이블 필터(통화)
        },

        onRemoveFilter () {                 // 필터 제거 버튼
            var oTable = this.byId("idTabEmp")
            var oBinding = oTable.getBinding("items")
            oBinding.filter(null)           // 모든 필터 제거
        }
    });
});

```

## 1) Controller — `code.unit10l0401.controller.Main`

## 1-1. onInit()

### 역할

- 기본 모델(무명)로 `emp`, `skill` 데이터를 세팅.
- 이름 있는 모델 `"cur"`로 통화코드 목록을 세팅(ComboBox 소스).

### 체크포인트

- `salary`가 **문자열**로 들어감 (`"20000"`, `"30000"`, …). Currency 타입 포맷팅은 문자열도 잘 처리하지만, **숫자**가 더 안전하고 천단위/로케일 포맷 정확도가 좋아짐.
- `skill.sName` 중 `" ABAP"`처럼 **앞 공백**이 섞여 있고, `"WedynPro ABAP"` 오탈자(아마 “**WebDynpro ABAP**”)가 있음. UI에 그대로 노출될 수 있음 → 정규화 권장.
- `emp.gender`/`emp.jik`는 코드값 → 뷰에서 formatter로 라벨화. 데이터-표시 분리가 잘 됨.

## 1-2. onPress(oEvent)

### 역할

- 직원 테이블 행 클릭 시 해당 행의 `pernr`로 하단 스킬 테이블 필터링.
- `oEvent.getSource().getBindingContext()`로 컨텍스트 확보 → `oModel.getProperty("pernr", selItem)`로 pernr 추출 → `Filter("pernr", EQ, selPernr)` 생성 → `idTabSkill`의 `items` 바인딩에 `filter(oFilter)` 적용.

### 체크포인트

- `filter(oFilter)`처럼 **단일 객체**를 넘겨도 UI5가 내부에서 배열로 감싸 처리하므로 동작함.
    
    하지만 **권장**은 `filter([oFilter], "Application")`로 명시하는 것(아래 개선안에 정리).
    
- 현재는 클릭마다 **필터를 덮어씀**. 복수 조건(예: 스킬명 추가 필터)과 병행하려면 **Application/Control 필터 타입 분리**가 유용함.

## 1-3. onSorting()
<img width="1934" height="593" alt="image" src="https://github.com/user-attachments/assets/64e5aa4c-d50d-4f75-b470-ad281f0e1f3e" />
### 역할

- `Sorter("gender", false)`로 성별 **오름차순** 정렬 적용.

### 체크포인트

- 정상. 다만 여러 컬럼 정렬이 필요하면 `sort([new Sorter("gender", false), new Sorter("eName", false)])`처럼 **다중 Sorter** 전달 가능.

## 1-4. onRemoveStorting() 
<img width="1916" height="597" alt="image" src="https://github.com/user-attachments/assets/1d6adb26-1a66-4b54-b42e-fc7d2fd26188" />

### 역할

- 정렬 제거(`sort(null)`).

### 체크포인트

- 함수명 오탈자: **onRemoveStorting → onRemoveSorting** 권장(뷰도 같이 변경 필요).

## 1-5. onSelectionChange(oEvent)
<img width="1916" height="612" alt="image" src="https://github.com/user-attachments/assets/1a315d5d-08bd-454b-af3e-7d7ec388d56d" />
### 역할

- ComboBox에서 선택한 통화코드를 읽어 `idTabEmp`에 필터 적용.

### 체크포인트(중요)

- 현재 코드:
    
    ```jsx
    let aFilter = [];
    aFilter.push(oFilter);
    oBinding.filter([aFilter]); // 2차원 배열
    
    ```
    
    - UI5가 2차원 배열을 “필터 그룹”으로 유연 처리해서 **돌아가긴 함**.
        
        하지만 **정석**은 `oBinding.filter(aFilter)` 또는 `oBinding.filter([oFilter])`.
        
- ComboBox는 `core:Item key="{cur>key}"` 구조니까,
    
    `selectedItem.getKey()`로 **바로 key**를 읽는 게 더 간결/안전:
    
    ```jsx
    const key = oEvent.getParameter("selectedItem").getKey();
    
    ```
    
- 필터 타입을 구분하면(예: `"Application"`) 테이블 자체 컨트롤 필터와 충돌을 피함.

## 1-6. onRemoveFilter()
<img width="1936" height="702" alt="image" src="https://github.com/user-attachments/assets/80ea4cb7-5a86-4280-8ccb-3ceee1a4b2ac" />

### 역할

- 모든 필터 제거.

### 체크포인트

- `filter(null)`은 **Application/Control** 모두 제거.
    
    “내가 건 필터만” 지우고 싶으면 `filter([], "Application")` 같이 타입 지정.
    

# 2) Formatter: `code/unit10l0401/model/formatter.js`

```jsx
sap.ui.define(
    [],
    function() {
        "use strict";

        return {
            // gender 코드를 화면 표시용 텍스트로 변환
            genderText : function(pGender) {
                switch (pGender) {
                    case "M" :
                        return "Male"    // 남성
                        break;
                    case "F" :
                        return "Female"  // 여성
                        break;
                    default :
                        return pGender;  // 그 외 값은 있는 그대로
                        break;
                }
            },

            // 직급 코드를 한글 직급명으로 변환
            jikText : function(pGrade) {
                 switch (pGrade) {
                    case "A1" :
                        return "사원"
                        break;
                    case "D1" :
                        return "대리"
                        break;
                    case "C1" :
                        return "과장"
                        break;
                    case "P1" :
                        return "부장"
                        break;
                    default :
                        return pGrade; // 매핑 없는 값은 원문 유지
                        break;
                }
            }
        }
    }
)

```

- 이 파일은 별도 네임스페이스의 “포맷 함수 모음집”.
- 뷰에서 `{path:'gender', formatter:'formatter.genderText'}` 처럼 호출해서 표시값 바꿈

## 2) Formatter — `code/unit10l0401/model/formatter.js`

## 2-1. genderText / jikText

### 역할

- 코드 → 라벨 텍스트 변환.

### 체크포인트

- `return` 후 `break`는 **도달 불가 코드**라 불필요. (문제는 없지만 정리 권장)
- `default: return pGender/pGrade`는 미정의 코드 대비에 유용.
- i18n 연계가 필요하면 formatter에서 리소스 번들을 주입받거나, **Expression Binding**으로도 대체 가능(간단 조건일 때).

# 3) View(XML): `Main.view.xml`

```xml
<mvc:View controllerName="code.unit10l0401.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:core="sap.ui.core"
    xmlns:f="sap.ui.layout.form"
    core:require = "{formatter: 'code/unit10l0401/model/formatter'}">
    <!-- 이 뷰는 Main 컨트롤러를 사용.
         sap.m(모바일 컨트롤), core(코어), f(SimpleForm) 네임스페이스 선언.
         core:require로 formatter 모듈을 'formatter'라는 이름으로 뷰에 주입 -->

    <Page id="page" title="{i18n>title}">
        <!-- 상단 폼 영역: 필터/정렬 컨트롤 배치 -->
        <f:SimpleForm  id="idSmpForm">
            <Label id="idLblCurr" text="Currency Code"></Label>
            <ComboBox id="idComboCurr" items="{cur>/currCode}"
                      selectionChange=".onSelectionChange">
                <!-- ComboBox는 이름있는 모델 'cur'의 /currCode 배열을 바인딩 -->
                <items>
                    <core:Item  id="idItem" key="{cur>key}"  text="{cur>value}"></core:Item>
                    <!-- 각 아이템은 key/value를 표시, key는 필터값으로 사용 -->
                </items>
            </ComboBox>

            <Button id="idBtn2" text="Remove Filter" press=".onRemoveFilter"></Button>

            <Label id="idLbl"></Label> <!-- (레이아웃용 빈 라벨) -->
            <Button id="idBtn3" text="Accesending by Gender" press=".onSorting"></Button>
            <Button id="idBtn4" text="Remove Sorting" press= ".onRemoveStorting"></Button>
        </f:SimpleForm>

        <!-- 직원 테이블: 기본 모델(/emp) 목록 표시 -->
        <Table id="idTabEmp" items= "{path:'/emp'}" >
            <columns>
                <Column id="idCol11">
                    <header><Text id="idtxt11" text="Personal Number"/></header>
                </Column>
                <Column id="idCol12">
                    <header><Text id="idtxt12" text="Name"/></header>
                </Column>
                <Column id="idCol13">
                    <header><Text id="idtxt13" text="Birth Date"/></header>
                </Column>
                <Column id="idCol14">
                    <header><Text id="idtxt14" text="Salary"/></header>
                </Column>
                <Column id="idCol15">
                    <header><Text id="idtxt15" text="Currency Code"/></header>
                </Column>
                <Column id="idCol16">
                    <header><Text id="idtxt16" text="Gender"/></header>
                </Column>
                <Column id="idCol17">
                    <header><Text id="idtxt17" text="Grade"/></header>
                </Column>
            </columns>

            <items>
                <!-- 각 직원 한 행 -->
                <ColumnListItem id="idColList11" press =".onPress" type = "Navigation" >
                    <!-- type="Navigation" : 행 오른쪽에 > 표시, press 이벤트 발생 -->
                    <cells>
                        <!-- 사번 -->
                        <ObjectIdentifier id="idObj11" title="{pernr}"/>
                        <!-- 이름 -->
                        <ObjectIdentifier id="idObj12" title="{eName}"/>
                        <!-- 생일: 문자열(yyyyMMdd) → Date 타입으로 표시 형식(stlye: medium) -->
                        <ObjectIdentifier id="idObj13"
                                title="{path: 'birthDt',
                                type : 'sap.ui.model.type.Date',
                                formatOptions:{source:{pattern:'yyyyMMdd'}, style : 'medium'}}"/>
                        <!-- 급여: Currency 타입으로 포맷, showMeasure:false라서 숫자만, 단위는 unit 속성으로 분리 -->
                        <ObjectNumber id="idObj14"
                                number="{parts:[{path:'salary'}, {path : 'currency'}],
                                type : 'sap.ui.model.type.Currency',
                                formatOptions:{showMeasure:false}}"
                                unit="{currency}"/>
                        <!-- 통화코드(문자 그대로) -->
                        <ObjectIdentifier id="idObj15" title="{currency}"/>
                        <!-- 성별: formatter로 M/F → Male/Female -->
                        <ObjectIdentifier id="idObj16"
                                title="{path:'gender', formatter: 'formatter.genderText'}"/>
                        <!-- 직급: formatter로 A1/C1/P1 → 사원/과장/부장 -->
                        <ObjectIdentifier id="idObj17"
                                title="{path:'jik', formatter: 'formatter.jikText'}"/>
                    </cells>
                </ColumnListItem>
            </items>
        </Table>

        <!-- 스킬 테이블: 기본 모델(/skill)에서 pernr 기준 필터링 예정 -->
        <Table id="idTabSkill"
               items="{path:'/skill',
               filters:[{path:'pernr', operator:'EQ', value1:null}]}" >
               <!-- 초기에는 pernr == null 조건이라 화면엔 비어 있게 시작 -->
            <columns>
                <Column id="idCol21">
                    <header><Text id="idHtxt21" text="Personal No."/></header>
                </Column>
                <Column id="idCol22">
                    <header><Text id="idHtxt22" text="Skill ID"/></header>
                </Column>
                <Column id="idCol23">
                    <header><Text id="idHtxt23" text="Skill Name"/></header>
                </Column>
            </columns>

            <items>
                <ColumnListItem id="idListItem21">
                    <cells>
                        <Text id="idCelTxt21" text="{pernr}"/>
                        <Text id="idCelTxt22" text="{sId}"/>
                        <Text id="idCelTxt23" text="{sName}"/>
                    </cells>
                </ColumnListItem>
            </items>
        </Table>

    </Page>
</mvc:View>

```

- 흐름 요약
    1. `onInit`에서 기본 모델(직원/스킬)과 통화 모델(cur)을 뷰에 세팅.
    2. 위쪽 `ComboBox`는 `cur>/currCode`를 바인딩해서 통화 목록 보여줌. 바뀌면 `onSelectionChange`에서 직원 테이블 필터링.
    3. 직원 테이블 행을 클릭하면 `onPress`가 실행되어 `pernr`로 스킬 테이블을 필터링해서 해당 직원의 스킬만 표시.
    4. ‘Accesending by Gender’ 누르면 성별 오름차순 정렬, ‘Remove Sorting’은 정렬 제거.
    5. ‘Remove Filter’는 직원 테이블의 필터 전부 해제.
    6. 성별/직급 칼럼은 formatter를 통해 표시 텍스트로 변환.

## 3) View(XML) — `Main.view.xml`

## 3-1. core:require

```xml
core:require="{formatter: 'code/unit10l0401/model/formatter'}"

```

- 뷰 단에서 `formatter` 네임으로 포매터 모듈을 주입.
- 이후 XML 바인딩에서 `formatter.genderText` 식으로 접근.

## 3-2. 상단 SimpleForm

- `ComboBox id="idComboCurr"`은 `items="{cur>/currCode}"`로 **이름 있는 모델**을 바인딩.
- `core:Item key="{cur>key}" text="{cur>value}"` → **getKey()** 가능.
- “Remove Filter”/“Accesending by Gender”/“Remove Sorting” 버튼은 컨트롤러 이벤트에 연결.

### 체크포인트

- Label `idLbl`은 **빈 라벨**로 레이아웃 간격용. Form 레이아웃 대신 `ToolbarSpacer`나 Grid를 쓰는 게 구조적으로 깔끔할 때가 많음.

## 3-3. 직원 테이블 `idTabEmp`

- `items="{/emp}"`로 기본 모델 바인딩.
- 셀:
    - `ObjectIdentifier`로 `pernr`, `eName`.
    - 생일은 `sap.ui.model.type.Date` + `formatOptions.source.pattern='yyyyMMdd'`로 **문자열 날짜 파싱 → 표시**.
        
        ✔️ 정확한 사용.
        
    - 급여는 `ObjectNumber` + `type: Currency (parts: salary, currency)` + `showMeasure:false` + `unit="{currency}"`.
        
        ✔️ 통화기호/단위 분리 표시. 다만 **salary는 숫자화** 권장.
        
    - 성별/직급은 formatter 적용.

### 체크포인트

- `ColumnListItem type="Navigation"` + `press=".onPress"`로 **행 클릭 이벤트** 활성화. 적절.
- 접근성(ARIA)/정렬 아이콘/No Data Text 등은 추후 UX 개선 포인트.

## 3-4. 스킬 테이블 `idTabSkill`

- 초기 바인딩에 `filters:[{path:'pernr', operator:'EQ', value1:null}]` → **처음에 비워두기** 의도.
    - 일부 경우 `EQ null`은 모든 항목이 빠지지 않을 수도 있음(데이터셋에 `null`이 실제 존재하면 걸릴 수 있음).
        
        → 초기에 `items="{}"`로 비워두고, `onPress`에서 `bindItems()`/`filter()`로 여는 방식도 안정적.
        
- 클릭 후 `onPress`에서 `pernr` EQ 필터로 **해당 직원 스킬만** 표시.

---

# 4) 이벤트/데이터 흐름 요약(시퀀스)

1. **onInit**:
    - 기본 모델: `/emp`, `/skill`
    - 이름 모델 `"cur"`: `/currCode`
2. **사용자 액션 A (ComboBox 변경)**:
    - `onSelectionChange` → 선택된 `key`로 `Filter("currency", EQ, key)` → `idTabEmp.items.filter([...])`
3. **사용자 액션 B (Remove Filter 버튼)**:
    - `onRemoveFilter` → `idTabEmp.items.filter(null)`
4. **사용자 액션 C (성별 정렬)**:
    - `onSorting` → `idTabEmp.items.sort([Sorter("gender", false)])`
5. **사용자 액션 D (정렬 제거)**:
    - `onRemoveSorting` → `idTabEmp.items.sort(null)`
6. **사용자 액션 E (행 클릭)**:
    - `onPress` → 클릭 행 `pernr` 추출 → `idTabSkill.items.filter([Filter("pernr", EQ, pernr)])`

---

# 5) 다중 필터/정렬 확장 시 팁

- **다중 필터**:
    
    ```jsx
    const aFilters = [
      new Filter("currency", FilterOperator.EQ, key),
      new Filter("gender", FilterOperator.EQ, "M")
    ];
    oBinding.filter(aFilters, "Application"); // 타입 지정 권장
    
    ```
    
- **다중 정렬**:
    
    ```jsx
    oBinding.sort([
      new Sorter("gender", false),
      new Sorter("eName", false)
    ]);
    
    ```
    
- **필터 타입**:
    - `"Application"`: 앱 로직에서 건 필터
    - `"Control"`: 컨트롤(서치필드 등) 내부에서 건 필터
        
        → 타입을 나눠두면 특정 그룹만 깔끔히 제거 가능.
        

---

# 6) 성능/안정성 체크리스트

- 데이터가 커질 경우 `growing="true"`(sap.m.Table) 고려.
- 정렬/필터 반복 호출 시 **불필요한 rebind 최소화**(현재 패턴은 OK).
- 날짜/금액은 **타입 기반 포맷** 유지(현재처럼 type 지정 OK).
    
    단, salary는 **숫자형** 변환 권장.
    
- 초기 스킬 테이블 비우기: `EQ null` 대신 **items 비바인딩**/`noDataText` 설정 고려.

---

# 7) 권장 수정 포인트(안전·가독성 위주)

1. **정렬 해제 함수명 통일**

```diff
- onRemoveStorting ()
+ onRemoveSorting ()

```

뷰의 `press=".onRemoveStorting"`도 함께 수정.

1. **ComboBox 선택 키 직접 사용 & 필터 1차원 배열**

```jsx
onSelectionChange(oEvent) {
  const key = oEvent.getParameter("selectedItem").getKey();
  const oBinding = this.byId("idTabEmp").getBinding("items");
  oBinding.filter([ new Filter("currency", FilterOperator.EQ, key) ], "Application");
}

```

1. **onPress 필터도 타입 명시(권장)**

```jsx
oBinding.filter([oFilter], "Application");

```

1. **salary 숫자화**

```jsx
emp: [
  { ..., salary: 20000, currency: "KRW", ... }
]

```

1. **스킬명 정규화(공백/오탈자)**
- `" ABAP"` → `"ABAP"`
- `"WedynPro ABAP"` → `"WebDynpro ABAP"`
1. **초기 스킬 테이블 비우기(대안)**
- XML에서 초기 필터로 `EQ null` 대신:
    - 아예 `items="{/skill}"`로 두고, `visible="false"`로 시작 → onPress에서 `visible="true"` + 필터
    - 또는 초기엔 `items="{}"`(바인딩 없는 상태) → onPress에서 `bindItems`/`filter`로 세팅

---

# 8) 옵션: Expression Binding로 간소화 가능 (뷰만 손봄)

- 성별/직급 formatter 대체(학습용 제안):

```xml
<ObjectIdentifiertitle="{= ${gender} === 'M' ? 'Male' : 'Female' }"/>
<ObjectIdentifiertitle="{= ${jik} === 'A1' ? '사원' : ${jik} === 'C1' ? '과장' : ${jik} === 'P1' ? '부장' : ${jik} }"/>

```

> 포맷터를 유지하면 재사용성/테스트가 좋아서, 현재 구조도 충분히 합리적
>
