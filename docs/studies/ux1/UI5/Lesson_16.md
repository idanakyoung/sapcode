
# 🧾 Lesson 16 - **SAPUI5 과제 5 요약 (Notion용)**

# 🧾 ZPOU03 - 학생/반 조회 앱 정리 (Notion용)

<img width="2492" height="884" alt="image" src="https://github.com/user-attachments/assets/17495801-0cd0-4449-a8e9-cb89a304da68" />

---

## 1. 💻 Controller 전체 흐름 (주석 버전)

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
    "sap/ui/model/Sorter",
    "sap/m/MessageToast",
    "sap/m/MessageBox",
    "sap/ui/core/format/DateFormat",
    "sap/viz/ui5/data/FlattenedDataset",
    "sap/viz/ui5/controls/common/feeds/FeedItem",
    "sap/viz/ui5/data/DimensionDefinition",
    "sap/viz/ui5/data/MeasureDefinition"
], (Controller, JSONModel, Filter, FilterOperator, Sorter, MessageToast, MessageBox, DateFormat, FlattenedDataset, FeedItem, DimensionDefinition, MeasureDefinition) => {
    "use strict";

    return Controller.extend("code.zpou03.controller.Main", {

        /* =========================================================
           onInit
           - 화면 처음 뜰 때 실행
           - 성별 콤보박스용 JSONModel 생성해서 "gData" 이름으로 뷰에 등록
           ========================================================= */
        onInit() {
            const oData = {
                sex: [
                    { gCode : "1", gName : "남자" },
                    { gCode : "2", gName : "여자" }
                ]
            };

            // JSON 모델 생성
            const oModel = new JSONModel(oData);

            // 뷰에 "gData"라는 이름으로 등록 → 뷰에서 gData>/sex 로 바인딩
            this.getView().setModel(oModel, "gData");
        },

        /* =========================================================
           onSearch
           - [검색 버튼] 클릭 시 실행
           - 1) 반 ComboBox 선택값
             2) 성별 ComboBox 선택값
             로 Filter 배열 생성
           - 학생 리스트 테이블(/esStdListSet)에 필터 적용
           ========================================================= */
        onSearch () {
            // 1) 반 ComboBox
            const o1ComboBox = this.byId("idComboBox1");
            const g1Select   = o1ComboBox.getSelectedKey();  // 선택된 반번호 (Teano)

            if (!g1Select) {
                MessageToast.show("반을 선택하세요");
                return;
            }

            // 2) 성별 ComboBox
            const o2ComboBox = this.byId("idComboBox2");
            const g2Select   = o2ComboBox.getSelectedKey();  // 선택된 성별 코드 (1/2)

            if (!g2Select) {
                MessageToast.show("성별을 선택하세요");
                return;
            }

            // 3) Filter 배열 생성
            //    - Teano(반번호) = g1Select
            //    - Gesch(성별)   = g2Select
            const a1Filter = [
                new Filter("Teano",  FilterOperator.EQ, g1Select),
                new Filter("Gesch", FilterOperator.EQ, g2Select)
            ];

            // 4) 학생 리스트 테이블 바인딩 가져오기
            const o1Table   = this.byId("idTab1");
            const o1Binding = o1Table.getBinding("items");

            // 5) 필터 적용
            if (o1Binding) {
                o1Binding.filter(a1Filter);
            }
        },

        /* =========================================================
           onSelectionChange
           - 학생 리스트 테이블에서 행 선택 시 실행
           - 1) /esStdListSet 한 행의 컨텍스트에서 Stdno, Teano 키 꺼냄
           - 2) ODataModel.createKey()로
               /esStdInfoSet(Stdno='...'),
               /esClassInfoSet(Teano='...') 경로 생성
           - 3) oModel.read()로 각각 조회 후 상세 Input 채우기
           ========================================================= */
        onSelectionChange: function (oEvent) {
            // (방법1 주석처리된 간단 바인딩 방식)
            // let selItem = oEvent.getSource().getBindingContext();
            // let sStdno = selItem.getProperty("Stdno");
            // let sPath = "/esStdInfoSet('"+sStdno+"')"
            // let oPanel = this.byId("idPanelStuInfo")
            // oPanel.bindElement(sPath)

            // let sTeano = selItem.getProperty("Teano");
            // let sPath2 = "/esClassInfoSet('"+sTeano+"')"
            // let oPanel2 = this.byId("idPanelClassInfo")
            // oPanel2.bindElement(sPath2)

            // 1) 테이블에서 선택된 행의 컨텍스트(/esStdListSet)
            var oItem = oEvent.getParameter("listItem") || oEvent.getSource();
            var oCtx  = oItem.getBindingContext();

            if (!oCtx) {
                MessageToast.show("선택된 학생 정보를 찾을 수 없습니다.");
                return;
            }

            // 2) 키 값 가져오기
            var sStdno = oCtx.getProperty("Stdno"); // 학생번호 키
            var sTeano = oCtx.getProperty("Teano"); // 반번호 키

            // 3) OData 모델
            var oModel = this.getView().getModel();

            /* -----------------------------------------------------
               [A] 학생 상세 정보 조회
               - 엔티티셋: /esStdInfoSet
               - 키: Stdno
               - createKey 사용 예:
                 oModel.createKey("/esStdInfoSet", { Stdno: sStdno });
               - 결과: "/esStdInfoSet(Stdno='25010001')" 형태의 경로 생성
               ----------------------------------------------------- */
            var sStdPath = oModel.createKey("/esStdInfoSet", {
                Stdno: sStdno
            });

            oModel.read(sStdPath, {
                success: function (oStd) {

                    // [학생 정보 Panel]에 값 채우기
                    this.byId("idInpStuInfo1").setValue(oStd.Stdno + " / " + oStd.Sname); // 학생번호 / 이름
                    this.byId("idInpStuInfo2").setValue(oStd.Begda);                       // 지원일자

                    // 조장 여부
                    var sLflag  = this._formatN(oStd.Lflag);   // Y/N 또는 빈값 → N
                    var sLflagT = this._formatN(oStd.LflagT);  // 조장 텍스트
                    this.byId("idInpStuInfo3").setValue(sLflag + " / " + sLflagT);

                    // 전공 여부
                    var sMajor = this._formatN(oStd.Major);
                    this.byId("idInpStuInfo4").setValue(sMajor);

                    // 지원 금액
                    this.byId("idInpStuInfo5").setValue(oStd.Price);

                }.bind(this),
                error: function () {
                    MessageToast.show("학생 상세 정보 조회 중 오류가 발생했습니다.");
                }
            });

            /* -----------------------------------------------------
               [B] 반(클래스) 상세 정보 조회
               - 엔티티셋: /esClassInfoSet
               - 키: Teano
               - createKey 사용 예:
                 oModel.createKey("/esClassInfoSet", { Teano: sTeano });
               ----------------------------------------------------- */
            var sClassPath = oModel.createKey("/esClassInfoSet", {
                Teano: sTeano
            });

            oModel.read(sClassPath, {
                success: function (oClass) {

                    // [소속반 정보 Panel]에 값 채우기
                    this.byId("idInpGrpInfo1").setValue(oClass.Teano + " / " + oClass.Tname); // 소속반
                    this.byId("idInpGrpInfo2").setValue(oClass.Croom);                        // 강의실
                    this.byId("idInpGrpInfo3").setValue(oClass.Mtnam);                        // 강사
                    this.byId("idInpGrpInfo4").setValue(oClass.Itnam);                        // 사내강사

                }.bind(this),
                error: function () {
                    MessageToast.show("반 상세 정보 조회 중 오류가 발생했습니다.");
                }
            });
        },

        /* =========================================================
           _formatN
           - 조장/전공 여부 같은 플래그 값이
             null, undefined, "" 이면 "N"으로 치환
           - 그냥 값이 있으면 그대로 리턴
           ========================================================= */
        _formatN: function (v) {
            return (v === null || v === undefined || v === "") ? "N" : v;
        }

    });
});

```

---

## 2. 🖼 Main View 전체 흐름 (주석 버전)

```xml
<mvc:View controllerName="code.zpou03.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core"
    xmlns:l="sap.ui.layout"
    xmlns:viz="sap.viz.ui5.controls"
    xmlns:viz.data="sap.viz.ui5.data"
    xmlns:viz.feeds="sap.viz.ui5.controls.common.feeds">

    <!-- 메인 페이지 -->
    <Page id="page" title="{i18n>title}">

        <!-- =====================================================
             [1] 상단 HBox
             - 왼쪽: 검색 조건 Panel
             - 오른쪽: 학생 리스트 Panel
           ===================================================== -->
        <HBox id="idHBox0">

            <!-- -----------------------------------------------
                 [1-1] 검색 조건 Panel
                 - 반 ComboBox: /esDeepSet
                 - 성별 ComboBox: gData>/sex
               ----------------------------------------------- -->
            <Panel id="IdPane1" headerText="검색 조건"
                expandable="true" expanded="true" expandAnimation="true">

                <!-- 헤더 툴바 (검색 버튼 포함) -->
                <headerToolbar>
                    <Toolbar id="idToolbarCond">
                        <content>
                            <Title id="idToolBarContTxt" text="검색 조건"></Title>
                            <ToolbarSpacer id="idToolBarSpaece"></ToolbarSpacer>
                            <Button id="idBtnSch" text="Search" press=".onSearch" icon="sap-icon://search"></Button>
                        </content>
                    </Toolbar>
                </headerToolbar>

                <!-- 반 ComboBox -->
                <HBox id="idHboxSearch" alignItems="Center"
                    justifyContent="Start" class="sapUiTinyMarginBegin">
                    <Label id="idLblBookYearCombBox1" text="반" width="5rem"></Label>

                    <!-- items="{/esDeepSet}" : OData 기본 모델의 /esDeepSet 엔티티셋 -->
                    <ComboBox id="idComboBox1"
                        width="10rem"
                        items="{/esDeepSet}">
                        <!-- core:Item key → Teano, text → Tname -->
                        <core:Item id="idItem1" key="{Teano}" text="{Tname}"></core:Item>
                    </ComboBox>
                </HBox>

                <!-- 성별 ComboBox -->
                <HBox id="idHboxSearch2" alignItems="Center"
                    justifyContent="Start" class="sapUiTinyMarginBegin">
                    <Label id="idLblBookYearCombBox2" text="성별" width="5rem"></Label>

                    <!-- items="{gData>/sex}" : onInit에서 등록한 JSONModel("gData") -->
                    <ComboBox id="idComboBox2"
                        width="10rem"
                        items="{gData>/sex}">
                        <core:Item id="idItem2" key="{gData>gCode}" text="{gData>gName}"></core:Item>
                    </ComboBox>
                </HBox>

            </Panel>

            <!-- -----------------------------------------------
                 [1-2] 학생 리스트 Panel
                 - Table items="{/esStdListSet}"
                 - mode="SingleSelectMaster" → 한 행 선택 시 onSelectionChange
               ----------------------------------------------- -->
            <Panel id="IdPane2" headerText="학생 리스트"
                expandable="true" expanded="true" expandAnimation="true">

                <f:SimpleForm id="idSimForm1" width="100%">
                    <f:content>

                        <!-- 학생 리스트 테이블 -->
                        <Table id="idTab1"
                            items="{/esStdListSet}"
                            growing="true"
                            growingThreshold="3"
                            mode="SingleSelectMaster"
                            selectionChange=".onSelectionChange">

                            <!-- 컬럼 정의 -->
                            <columns>
                                <Column id="idCol1">
                                    <header><Text id="idHtxt1" text="반번호"></Text></header>
                                </Column>
                                <Column id="idCol2">
                                    <header><Text id="idHtxt2" text="반명"></Text></header>
                                </Column>
                                <Column id="idCol3">
                                    <header><Text id="idHtxt3" text="학생번호"></Text></header>
                                </Column>
                                <Column id="idCol4">
                                    <header><Text id="idHtxt4" text="학생명"></Text></header>
                                </Column>
                                <Column id="idCol5">
                                    <header><Text id="idHtxt5" text="지원금"></Text></header>
                                </Column>
                                <Column id="idCol6">
                                    <header><Text id="idHtxt6" text="성별"></Text></header>
                                </Column>
                                <Column id="idCol7">
                                    <header><Text id="idHtxt7" text="지원일자"></Text></header>
                                </Column>
                            </columns>

                            <!-- 각 행 템플릿 -->
                            <items>
                                <!-- type="Navigation" : 선택 시 오른쪽 화살표 스타일 -->
                                <ColumnListItem id="idColListItem1" type="Navigation">
                                    <cells>
                                        <!-- 테이블 컨텍스트 기준 상대 경로 바인딩 -->
                                        <Text id="idCelTxt1" text="{Teano}"></Text>
                                        <Text id="idCelTxt2" text="{Tname}"></Text>
                                        <Text id="idCelTxt3" text="{Stdno}"></Text>
                                        <Text id="idCelTxt4" text="{Sname}"></Text>
                                        <Text id="idCelTxt5" text="{Price}"></Text>
                                        <Text id="idCelTxt6" text="{Gesch}"></Text>

                                        <!-- OData Date 타입 바인딩 예시 -->
                                        <Text id="idCelTxt7"
                                            text="{ path:'Begda', type : 'sap.ui.model.odata.type.Date'}"></Text>
                                    </cells>
                                </ColumnListItem>
                            </items>

                        </Table>

                    </f:content>
                </f:SimpleForm>

            </Panel>

        </HBox>

        <!-- =====================================================
             [3] 학생 정보 Panel
             - onSelectionChange에서 oModel.read("/esStdInfoSet(...)")
               결과를 Input에 setValue 해주는 영역
           ===================================================== -->
        <Panel id="IdPane3" headerText="학생 정보"
            expandable="true" expanded="true" expandAnimation="true">

            <HBox id="idHboxStuInfo1"
                justifyContent="Start" class="sapUiTinyMarginBegin">
                <VBox id="idVBox1">

                    <HBox id="idHBox1">
                        <Label id="idTLblStuInfo1" text="학생번호" width="100px"></Label>
                        <Input id="idInpStuInfo1" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox2">
                        <Label id="idTLblStuInfo2" text="지원일자" width="100px" textAlign="Center"></Label>
                        <Input id="idInpStuInfo2" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox3">
                        <Label id="idTLblStuInfo3" text="조장" width="100px" textAlign="Center"></Label>
                        <Input id="idInpStuInfo3" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox4">
                        <Label id="idTLblStuInfo4" text="전공여부" width="100px" textAlign="Center"></Label>
                        <Input id="idInpStuInfo4" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox5">
                        <Label id="idTLblStuInfo5" text="지원금액" width="100px" textAlign="Center"></Label>
                        <Input id="idInpStuInfo5" editable="false" width="30rem"></Input>
                    </HBox>

                </VBox>
            </HBox>
        </Panel>

        <!-- =====================================================
             [4] 소속반 정보 Panel
             - onSelectionChange에서 oModel.read("/esClassInfoSet(...)")
               결과를 Input에 setValue 해주는 영역
           ===================================================== -->
        <Panel id="IdPane4" headerText="소속반 정보"
            expandable="true" expanded="true" expandAnimation="true">

            <HBox id="idHboxStuInfo2" alignItems="Center"
                justifyContent="Start" class="sapUiTinyMarginBegin">
                <VBox id="idVBox2">

                    <HBox id="idHBox6">
                        <Label id="idTLblGrpInfo1" text="소속반" width="100px"></Label>
                        <Input id="idInpGrpInfo1" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox7">
                        <Label id="idTLblGrpInfo2" text="강의실" width="100px" textAlign="Center"></Label>
                        <Input id="idInpGrpInfo2" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox8">
                        <Label id="idTLblGrpInfo3" text="강사" width="100px" textAlign="Center"></Label>
                        <Input id="idInpGrpInfo3" editable="false" width="30rem"></Input>
                    </HBox>

                    <HBox id="idHBox9">
                        <Label id="idTLblGrpInfo4" text="사내강사" width="100px" textAlign="Center"></Label>
                        <Input id="idInpGrpInfo4" editable="false" width="30rem"></Input>
                    </HBox>

                </VBox>
            </HBox>
        </Panel>

    </Page>
</mvc:View>

```

---

## 3. 🔑 “경로 설정 + 바인딩” 핵심 정리 (OData + JSON)

이 앱의 핵심 포인트만 딱 모아서 정리하면:

### 3-1. 리스트 바인딩 (컬렉션 바인딩)

1. **학생 리스트 테이블**

```xml
<Table id="idTab1" items="{/esStdListSet}">
    <!-- 셀에서는 상대경로로 속성 접근 -->
    <Text text="{Teano}" />
    <Text text="{Stdno}" />
    <Text text="{Sname}" />
</Table>

```

- `items="{/esStdListSet}"`
    
    → **기본 ODataModel** 의 엔티티셋 `/esStdListSet` 전체를 바인딩
    
- 각 행 컨텍스트는 `/esStdListSet('키')` 라고 보면 되고,
    
    셀에서는 `{Teano}`, `{Stdno}` 같이 **상대경로**로 접근.
    
1. **반 ComboBox (OData)**

```xml
<ComboBox id="idComboBox1"
    items="{/esDeepSet}">
    <core:Item key="{Teano}" text="{Tname}" />
</ComboBox>

```

- `items="{/esDeepSet}"`
    
    → `/esDeepSet` 엔티티셋에서 반 목록을 가져옴
    
- `key="{Teano}"` → `getSelectedKey()` 하면 Teano 값(예: "001")이 들어옴
- `text="{Tname}"` → 콤보박스에 표시되는 이름 (예: "1반")
1. **성별 ComboBox (JSONModel)**

```xml
<ComboBox id="idComboBox2"
    items="{gData>/sex}">
    <core:Item key="{gData>gCode}" text="{gData>gName}" />
</ComboBox>

```

- onInit에서:
    
    ```jsx
    const oModel = new JSONModel({
        sex: [
            { gCode : "1", gName : "남자" },
            { gCode : "2", gName : "여자" }
        ]
    });
    this.getView().setModel(oModel, "gData");
    
    ```
    
- `gData>/sex` → `gData` 모델의 `sex` 배열
- `key="{gData>gCode}"` → "1" 또는 "2"
- `text="{gData>gName}"` → "남자", "여자"

---

### 3-2. 필터 바인딩 (경로 + Filter)

검색 버튼 클릭 시:

```jsx
const g1Select = this.byId("idComboBox1").getSelectedKey(); // Teano
const g2Select = this.byId("idComboBox2").getSelectedKey(); // Gesch 코드

const a1Filter = [
    new Filter("Teano",  FilterOperator.EQ, g1Select),
    new Filter("Gesch", FilterOperator.EQ, g2Select)
];

const o1Table   = this.byId("idTab1");
const o1Binding = o1Table.getBinding("items");

o1Binding.filter(a1Filter);

```

- `Filter("필드명", FilterOperator.EQ, 값)`
- 여기서 **필드명은 테이블 엔티티의 속성명** (`Teano`, `Gesch`)
- `o1Binding.filter(a1Filter)` 하면
    
    `/esStdListSet`에 `$filter=Teano eq '...' and Gesch eq '...'` 같은 OData 쿼리로 호출됨.
    

---

### 3-3. 단일 엔티티 경로 생성 (createKey 사용)

선택된 학생 한 명에 대해 **상세 정보**를 가져올 때:

```jsx
// 1) 선택된 행 컨텍스트
var oCtx  = oItem.getBindingContext();
var sStdno = oCtx.getProperty("Stdno");
var sTeano = oCtx.getProperty("Teano");

// 2) OData 모델
var oModel = this.getView().getModel();

// 3) 경로 생성 (createKey)
var sStdPath = oModel.createKey("/esStdInfoSet", { Stdno: sStdno });
// 결과 예시: "/esStdInfoSet(Stdno='25010001')"

var sClassPath = oModel.createKey("/esClassInfoSet", { Teano: sTeano });
// 결과 예시: "/esClassInfoSet(Teano='001')"

```

`createKey("/엔티티셋명", { 키필드명: 값 })` 패턴 기억하기:

- 단일 키:
    
    `/esStdInfoSet(Stdno='25010001')`
    
- 복합 키라면:
    
    `createKey("/SomethingSet", { Key1: v1, Key2: v2 });`
    
    → `/SomethingSet(Key1='v1',Key2='v2')`
    

그리고 이 경로로 `read`:

```jsx
oModel.read(sStdPath, {
    success: function (oStd) { ... }.bind(this),
    error:   function () { ... }
});

```

---

### 3-4. 값 없는 플래그를 “N”으로 바꾸기 (_formatN)

```jsx
_formatN: function (v) {
    return (v === null || v === undefined || v === "") ? "N" : v;
}

```

사용 예:

```jsx
var sLflag  = this._formatN(oStd.Lflag);
var sLflagT = this._formatN(oStd.LflagT);
this.byId("idInpStuInfo3").setValue(sLflag + " / " + sLflagT);

var sMajor = this._formatN(oStd.Major);
this.byId("idInpStuInfo4").setValue(sMajor);

```

→ 조장/전공 여부가 **null/빈값이어도 항상 “N”**으로 표시됨.

---

## 4. 🧩 Fragment View로 나누기 (검색 / 리스트 / 학생정보 / 소속반)

지금 Main.view.xml 하나에 다 들어있는데,

이걸 **4개 Fragment**로 나눠본다고 생각해보자.

- `SearchCondition.fragment.xml` : 검색 조건 Panel
- `StudentList.fragment.xml` : 학생 리스트 Panel
- `StudentInfo.fragment.xml` : 학생 정보 Panel
- `ClassInfo.fragment.xml` : 소속반 정보 Panel

> 파일 위치 예시:
> 
> 
> `webapp/view/SearchCondition.fragment.xml`
> 
> `webapp/view/StudentList.fragment.xml`
> 
> `webapp/view/StudentInfo.fragment.xml`
> 
> `webapp/view/ClassInfo.fragment.xml`
> 

### 4-1. Main.view.xml (Fragment 포함 버전)

```xml
<mvc:View controllerName="code.zpou03.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core"
    xmlns:l="sap.ui.layout">

    <Page id="page" title="{i18n>title}">

        <!-- 상단 HBox: 검색 조건 + 학생 리스트 -->
        <HBox id="idHBox0">
            <!-- 검색 조건 Fragment -->
            <core:Fragment fragmentName="code.zpou03.view.SearchCondition" type="XML" />
            <!-- 학생 리스트 Fragment -->
            <core:Fragment fragmentName="code.zpou03.view.StudentList" type="XML" />
        </HBox>

        <!-- 학생 정보 Fragment -->
        <core:Fragment fragmentName="code.zpou03.view.StudentInfo" type="XML" />

        <!-- 소속반 정보 Fragment -->
        <core:Fragment fragmentName="code.zpou03.view.ClassInfo" type="XML" />

    </Page>
</mvc:View>

```

---

### 4-2. 🔍 SearchCondition.fragment.xml

```xml
<core:FragmentDefinitionxmlns="sap.m"
    xmlns:core="sap.ui.core">

    <Panel id="IdPane1" headerText="검색 조건"
        expandable="true" expanded="true" expandAnimation="true">

        <headerToolbar>
            <Toolbar id="idToolbarCond">
                <content>
                    <Title id="idToolBarContTxt" text="검색 조건"></Title>
                    <ToolbarSpacer id="idToolBarSpaece"></ToolbarSpacer>
                    <Button id="idBtnSch" text="Search" press=".onSearch" icon="sap-icon://search"></Button>
                </content>
            </Toolbar>
        </headerToolbar>

        <HBox id="idHboxSearch" alignItems="Center"
            justifyContent="Start" class="sapUiTinyMarginBegin">
            <Label id="idLblBookYearCombBox1" text="반" width="5rem"></Label>

            <ComboBox id="idComboBox1"
                width="10rem"
                items="{/esDeepSet}">
                <core:Item id="idItem1" key="{Teano}" text="{Tname}" />
            </ComboBox>
        </HBox>

        <HBox id="idHboxSearch2" alignItems="Center"
            justifyContent="Start" class="sapUiTinyMarginBegin">
            <Label id="idLblBookYearCombBox2" text="성별" width="5rem"></Label>

            <ComboBox id="idComboBox2"
                width="10rem"
                items="{gData>/sex}">
                <core:Item id="idItem2" key="{gData>gCode}" text="{gData>gName}" />
            </ComboBox>
        </HBox>

    </Panel>
</core:FragmentDefinition>

```

---

### 4-3. 📋 StudentList.fragment.xml

```xml
<core:FragmentDefinitionxmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core">

    <Panel id="IdPane2" headerText="학생 리스트"
        expandable="true" expanded="true" expandAnimation="true">

        <f:SimpleForm id="idSimForm1" width="100%">
            <f:content>

                <Table id="idTab1"
                    items="{/esStdListSet}"
                    growing="true"
                    growingThreshold="3"
                    mode="SingleSelectMaster"
                    selectionChange=".onSelectionChange">

                    <columns>
                        <Column><header><Text text="반번호" /></header></Column>
                        <Column><header><Text text="반명" /></header></Column>
                        <Column><header><Text text="학생번호" /></header></Column>
                        <Column><header><Text text="학생명" /></header></Column>
                        <Column><header><Text text="지원금" /></header></Column>
                        <Column><header><Text text="성별" /></header></Column>
                        <Column><header><Text text="지원일자" /></header></Column>
                    </columns>

                    <items>
                        <ColumnListItem type="Navigation">
                            <cells>
                                <Text text="{Teano}" />
                                <Text text="{Tname}" />
                                <Text text="{Stdno}" />
                                <Text text="{Sname}" />
                                <Text text="{Price}" />
                                <Text text="{Gesch}" />
                                <Text text="{ path:'Begda', type : 'sap.ui.model.odata.type.Date'}" />
                            </cells>
                        </ColumnListItem>
                    </items>

                </Table>

            </f:content>
        </f:SimpleForm>

    </Panel>
</core:FragmentDefinition>

```

---

### 4-4. 👩‍🎓 StudentInfo.fragment.xml

```xml
<core:FragmentDefinitionxmlns="sap.m"
    xmlns:core="sap.ui.core">

    <Panel id="IdPane3" headerText="학생 정보"
        expandable="true" expanded="true" expandAnimation="true">

        <HBox id="idHboxStuInfo1"
            justifyContent="Start" class="sapUiTinyMarginBegin">
            <VBox id="idVBox1">

                <HBox>
                    <Label text="학생번호" width="100px" />
                    <Input id="idInpStuInfo1" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="지원일자" width="100px" textAlign="Center" />
                    <Input id="idInpStuInfo2" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="조장" width="100px" textAlign="Center" />
                    <Input id="idInpStuInfo3" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="전공여부" width="100px" textAlign="Center" />
                    <Input id="idInpStuInfo4" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="지원금액" width="100px" textAlign="Center" />
                    <Input id="idInpStuInfo5" editable="false" width="30rem" />
                </HBox>

            </VBox>
        </HBox>

    </Panel>
</core:FragmentDefinition>

```

---

### 4-5. 🏫 ClassInfo.fragment.xml

```xml
<core:FragmentDefinitionxmlns="sap.m"
    xmlns:core="sap.ui.core">

    <Panel id="IdPane4" headerText="소속반 정보"
        expandable="true" expanded="true" expandAnimation="true">

        <HBox id="idHboxStuInfo2" alignItems="Center"
            justifyContent="Start" class="sapUiTinyMarginBegin">
            <VBox id="idVBox2">

                <HBox>
                    <Label text="소속반" width="100px" />
                    <Input id="idInpGrpInfo1" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="강의실" width="100px" textAlign="Center" />
                    <Input id="idInpGrpInfo2" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="강사" width="100px" textAlign="Center" />
                    <Input id="idInpGrpInfo3" editable="false" width="30rem" />
                </HBox>

                <HBox>
                    <Label text="사내강사" width="100px" textAlign="Center" />
                    <Input id="idInpGrpInfo4" editable="false" width="30rem" />
                </HBox>

            </VBox>
        </HBox>

    </Panel>
</core:FragmentDefinition>

```

---

## 5. 🧠 마지막 핵심 한 줄 요약 (경로 & 바인딩)

- **리스트 바인딩**: `items="{/EntitySet}"` + 셀에서 `{필드명}` → 상대경로
- **Filter**: `new Filter("필드명", FilterOperator.EQ, 값)` → `binding.filter([필터])`
- **단일 엔티티 조회**:
    
    `createKey("/EntitySet", { KeyField: key })` → `read(경로, {...})`
    
- **Fragment**: 메인뷰는 골격만, Panel/섹션은 각각 Fragment로 쪼개서 `core:Fragment`로 삽입
