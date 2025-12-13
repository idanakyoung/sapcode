# 🧾 Lesson 12 - SAPUI5 Exam 과제 요구사항 요약 (Notion용)

### 🎯 **학습성과 (Learning Outcome)**

> SAPUI5 Model, View, Controller 및 OData 등을 활용해 SAPUI5 Application을 구현할 수 있다.
> 

---

### 📌 **과제 기본 정보**

| 구분 | 내용 |
| --- | --- |
| **프로젝트명** | `zux_##_exam` (## = 본인 번호) |
| **OData 서비스** | `ZUXEXAM_SRV` |
| **앱 타이틀** | `SAPUI5 Exam` |
| **개발 기간** | 09:00 ~ 18:00 (결과물 제출: 17:30 ~ 18:00) |
| **결과물 제출 위치** | https://naver.me/FINMXvyI |
| **제출 파일** | ① Word 문서 (`SAPUX_본인이름.docx`) ② SAPUI5 프로젝트 파일 (.zip) |
| **Template 문서 다운로드 위치** | https://naver.me/FINMXvyI |
| **주의사항** | 프로그램명, 결과물 문서명 등 **Naming Rule 준수** 필수 |

---

### 🧩 **프로젝트 요구사항 요약 (Level별 구성)**

### **🧱 Level 1 — 프로젝트 생성**

- **프로젝트명:** `zux_##_exam`
- **OData Service:** `ZUXEXAM_SRV`
- **App Title:** SAPUI5 Exam
- **UI 구조:** Layout은 예시와 유사하게 구성
- **사용 레이아웃 컨트롤:**
    - `HorizontalLayout`, `VerticalLayout`, `SimpleForm`, `Panel` 등
    - `Fragment View` 가능
- **목표:** 기본 SAPUI5 앱 구조 및 OData 연결

---

### **🔎 Level 2 — 검색 조건 화면 구성**

- **검색 조건:** ComboBox (선택 년도)
- **데이터 소스:**
    - EntitySet: `ES_SYEARSet`
    - Property:
        - `Syear` (년도)
        - `Syeart` (년도 Text)
- **예시 URI:**
    
    ```
    /sap/opu/odata/sap/ZUXEXAM_SRV/ES_SYEARSet?$format=json
    
    ```
    
- **기능:** ComboBox에서 선택한 연도를 필터 조건으로 사용

---

### **📋 Level 3 — 조회 결과 (List) 표시**

- **UI 컨트롤:** `sap.m.Table`
- **데이터 소스:**
    - EntitySet: `ES_SALESSet`
    - Property:
        - `Syear` (년도)
        - `Carrid` (항공사 코드)
        - `Carrname` (항공사명)
        - `Bkcnt` (예약건수)
        - `Curam` (매출액)
        - `Waers` (통화)
        - `Cacnt` (취소건수)
- **기능:**
    - ComboBox에서 선택한 연도로 Table 필터링
    - `sap.ui.model.Filter` 사용
- **예시 URI:**
    
    ```
    /sap/opu/odata/sap/ZUXEXAM_SRV/ES_SALESSet?$filter=Syear eq '2025'&$format=json
    
    ```
    

---

### **📊 Level 4 — Row 클릭 시 차트 표시**

- **차트 컨트롤:** `sap.viz.ui5.controls.VizFrame`
- **데이터 소스:**
    - EntitySet: `ES_MONTHSet`
    - Property:
        - `Month` (월)
        - `Syear` (년도)
        - `Carrid` (항공사 코드)
        - `Curam` (매출액)
        - `CuramC` (취소매출액)
        - `Waers` (통화)
- **기능:**
    - Table의 행 클릭 시 해당 항공사·연도 데이터를 차트로 시각화
    - (예: 막대, 도넛 등 자유 선택)
- **예시 URI:**
    
    ```
    /sap/opu/odata/sap/ZUXEXAM_SRV/ES_MONTHSet?$filter=Syear eq '2026' and Carrid eq 'AZ'&$format=json
    
    ```
    
- **추가 기능 (확장 구현):**
    - 도넛 조각 클릭 시 해당 연도 월별 차트 생성
    - 선택 해제 시 제거
    - 초기화 버튼으로 전체 차트 삭제

---

### **🪟 Level 5 — 예약 상세 (Popup) 표시**

- **UI 컨트롤:** `sap.m.Dialog` (Fragment View)
- **데이터 소스:**
    - EntitySet: `ES_DETAILSet`
    - Property:
        - `Syear` (년도)
        - `Carrid` (항공사 코드)
        - `Carrname` (항공사명)
        - `Connid` (편명)
        - `Fldate` (출발일)
        - `Seatsmax` (정원좌석)
        - `Seatsocc` (예약좌석)
        - `Seatsfree` (여유좌석)
        - `Bookrate` (예약율)
- **기능:**
    - “예약 상세” 버튼 클릭 시 팝업 오픈
    - 선택 항공사의 해당 연도 출발편 상세 표시
- **예시 URI:**
    
    ```
    /sap/opu/odata/sap/ZUXEXAM_SRV/ES_SALESSet(Syear='2025',Carrid='SQ')/to_Detail?$format=json
    
    ```
    

# 🧭 SAPUI5 Exam 프로젝트 — `zux_01_exam`

> 목표:
> 
> 
> 연도별 항공사 매출 데이터를 OData로 조회하여
> 
> 📋 테이블 + 📊 차트 + 🪟 예약 상세 팝업 형태로 시각화 구현
> 

---

## 🧩 1️⃣ 프로젝트 개요

| 항목 | 내용 |
| --- | --- |
| **프로젝트명** | `zux_01_exam` |
| **OData 서비스** | `ZUXEXAM_SRV` |
| **앱 제목** | SAPUI5 Exam |
| **메인 엔티티** | ES_SYEARSet / ES_SALESSet / ES_MONTHSet / ES_DETAILSet |
| **기술요소** | MVC 구조, OData Model, VizFrame Chart, Fragment Popup |
| **주요 UI 컨트롤** | `ComboBox`, `Table`, `Button`, `Panel`, `SimpleForm`, `VizFrame`, `Dialog` |
| **핵심 기능** | 연도 선택 → 항공사별 매출 조회 → 행 클릭 시 차트 표시 → 도넛 클릭 시 연도별 상세 차트 추가 → 예약 상세 팝업 |

---

## 🧭 2️⃣ 전체 화면 구성 (View 구조 요약)

```
Page (title: SAPUI5 Exam)
 └─ ResponsiveFlowLayout
     ├─ SimpleForm (조회 조건)
     │   ├─ ComboBox (연도 선택)
     │   └─ Button (Search)
     │
     ├─ Panel (항공사별 매출)
     │   └─ Table (ES_SALESSet)
     │       └─ 예약 상세 버튼 (Popup 연결)
     │
     ├─ SimpleForm (월별 매출 차트)
     │   └─ VizFrame (stacked_column)
     │
     ├─ HBox
     │   ├─ VizFrame (donut, select/deselect 이벤트)
     │   └─ VBox (idYearChartsBox, 동적 연도별 차트 표시)
     │
     └─ SimpleForm (차트 초기화 버튼)

```

---

## 💻 3️⃣ 주요 코드 및 기능 흐름

### 🔹 (1) 검색 조건 — `onSearch()`

> ComboBox에서 선택한 연도로 ES_SALESSet을 필터링
> 

```jsx
onSearch() {
  const oComboBox = this.byId("idComboBox");
  const sYear = oComboBox.getSelectedKey();

  if (!sYear) {
    MessageToast.show("연도를 선택하세요");
    return;
  }

  const aFilter = [new Filter("Syear", FilterOperator.EQ, sYear)];
  const oTable = this.byId("idTab1");
  oTable.getBinding("items").filter(aFilter);
}

```

🧠 **핵심 학습 포인트**

- `sap.ui.model.Filter`를 사용한 서버사이드 필터링
- ComboBox의 `selectedKey`를 조건으로 적용

---

### 🔹 (2) 항공사 행 클릭 — `onRowPress()`

> 선택한 행(항공사)의 연도, 항공사ID를 기반으로 차트 두 개 갱신
> 
- **막대 차트 (`idVizFrame`)** : 월별 매출
- **도넛 차트 (`idVizFrame2`)** : 항공사 년도별 매출

```jsx
onRowPress(oEvent) {
  const oCtx = oEvent.getParameter("listItem").getBindingContext();
  const sYear = oCtx.getProperty("Syear");
  const sCarrid = oCtx.getProperty("Carrid");
  const sCarrname = oCtx.getProperty("Carrname");

  this._currentCarrid = sCarrid; // ✅ 도넛 클릭 시 활용

  const oViz = this.byId("idVizFrame");
  const oViz2 = this.byId("idVizFrame2");
  oViz.removeAllFeeds(); oViz.destroyDataset();
  oViz2.removeAllFeeds(); oViz2.destroyDataset();

  // 월별 매출 (막대차트)
  const oDataset = new FlattenedDataset({
    dimensions: [{ name: "월별", value: "{Month}" }],
    measures: [{ name: "취소 매출액", value: "{CuramC}" }, { name: "매출액", value: "{Curam}" }],
    data: { path: "/ES_MONTHSet", filters: [
      new Filter("Syear", FilterOperator.EQ, sYear),
      new Filter("Carrid", FilterOperator.EQ, sCarrid)
    ]}
  });

  // 년도별 매출 (도넛차트)
  const oDataset2 = new FlattenedDataset({
    dimensions: [{ name: "년도별", value: "{Syear}" }],
    measures: [{ name: "매출액", value: "{Curam}" }],
    data: { path: "/ES_CHARTSet", filters: [
      new Filter("Carrid", FilterOperator.EQ, sCarrid)
    ]}
  });

  oViz.setDataset(oDataset);
  oViz2.setDataset(oDataset2);
}

```

🧠 **핵심 학습 포인트**

- `FlattenedDataset`을 이용해 차트별 데이터 구성
- `FeedItem`을 통한 measure/dimension 매핑
- `_currentCarrid`를 전역 컨트롤러 변수로 유지해 이벤트 간 데이터 공유

---

### 🔹 (3) 도넛 클릭 — `onYearSliceSelect()`

> 도넛 조각(연도) 클릭 시 오른쪽 VBox에 해당 연도의 월별 매출 차트 추가
> 

```jsx
onYearSliceSelect(oEvent) {
  const sYear = String(oEvent.getParameter("data")[0].data["년도별"]);
  const sCarrid = this._currentCarrid;
  if (!sCarrid) return;

  const oYearViz = new sap.viz.ui5.controls.VizFrame({
    vizType: "column",
    width: "100%",
    height: "300px"
  });

  const oDataset = new sap.viz.ui5.data.FlattenedDataset({
    dimensions: [{ name: "월", value: "{Month}" }],
    measures: [{ name: "취소 매출액", value: "{CuramC}" }, { name: "매출액", value: "{Curam}" }],
    data: {
      path: "/ES_MONTHSet",
      filters: [
        new sap.ui.model.Filter("Syear", sap.ui.model.FilterOperator.EQ, sYear),
        new sap.ui.model.Filter("Carrid", sap.ui.model.FilterOperator.EQ, sCarrid)
      ]
    }
  });

  oYearViz.setDataset(oDataset);
  oYearViz.setVizProperties({
    title: { text: sYear + "년 월별 매출액" },
    plotArea: { dataLabel: { visible: true } }
  });

  this.byId("idYearChartsBox").addItem(oYearViz);
}

```

🧠 **핵심 학습 포인트**

- 동적으로 VizFrame 생성 (`new sap.viz.ui5.controls.VizFrame`)
- 클릭된 데이터(`oEvent.getParameter("data")`)에서 차원값 추출
- 여러 차트를 `VBox`에 addItem()으로 누적 추가

---

### 🔹 (4) 도넛 해제 — `onYearSliceDeselect()`

> 도넛 조각 클릭 해제 시 해당 연도 차트 제거
> 

```jsx
onYearSliceDeselect(oEvent) {
  const a = oEvent.getParameter("data");
  if (!a || !a.length) return;
  const sYear = String(a[0].data.Syear || a[0].data["년도별"]);
  const sChartId = this.createId("idVizYear_" + sYear);
  const oChart = sap.ui.getCore().byId(sChartId);
  if (oChart) oChart.destroy();
}

```

---

### 🔹 (5) 차트 초기화 — `onClearCharts()`

> 오른쪽 VBox(idYearChartsBox) 내부 차트를 한 번에 제거
> 

```jsx
onClearCharts() {
  this.byId("idYearChartsBox").destroyItems();
}

```

🧠 **핵심 학습 포인트**

- 동적 컴포넌트 초기화 시 `destroyItems()` 활용

---

### 🔹 (6) 예약 상세 팝업 — `onBookingDetail()` & Fragment

```jsx
onBookingDetail(oEvent) {
  if (!this.pDialog) {
    this.pDialog = this.loadFragment({ name: "code.zux01exam.view.PopupFrag" });
  }
  this.pDialog.then((oDialog) => { oDialog.open(); });

  const oBtn = oEvent.getSource();
  const oCtx = oBtn.getBindingContext();
  const sPath = oCtx.getPath();

  if (!sPath) { MessageToast.show("컨텍스트 없음"); return; }

  const oTable = this.byId("idTab2");
  oTable.bindElement(sPath);
}

```

🧠 **핵심 학습 포인트**

- `Fragment`를 통한 팝업(Dialog) 뷰 분리
- `bindElement(sPath)`로 관계형 Entity(`to_Detail`) 데이터 바인딩

---

## 🪟 4️⃣ Popup Fragment 구조 요약

```xml
<Dialog id="idDialog" title="예약 상세정보">
  <Table id="idTab2" items="{to_Detail}">
    <columns>
      <Column><Text text="항공사" /></Column>
      <Column><Text text="항공사명" /></Column>
      <Column><Text text="편명" /></Column>
      <Column><Text text="출발일자" /></Column>
      <Column><Text text="정원좌석" /></Column>
      <Column><Text text="예약좌석" /></Column>
      <Column><Text text="여유좌석" /></Column>
      <Column><Text text="예약율" /></Column>
    </columns>
  </Table>

  <beginButton>
    <Button text="Close" press=".onCloseDialog"/>
  </beginButton>
</Dialog>

```

---

## 📊 5️⃣ 실행 시 동작 흐름

```
1️⃣ ComboBox에서 연도 선택 → Search 클릭
     ↓
2️⃣ ES_SALESSet에서 해당 연도 항공사 리스트 표시
     ↓
3️⃣ 행 클릭 → 상단 월별/년도별 차트 표시
     ↓
4️⃣ 도넛에서 특정 연도 클릭 → 오른쪽 VBox에 월별 차트 추가
     ↓
5️⃣ 도넛 조각 해제 or “차트 초기화” 클릭 → 해당 차트 제거
     ↓
6️⃣ “예약 상세” 버튼 클릭 → Popup Fragment로 상세정보 표시

```

---

## 🧠 6️⃣ 학습 포인트 정리

| 주제 | 핵심 포인트 |
| --- | --- |
| **OData 필터링** | `sap.ui.model.Filter` + `FilterOperator.EQ` |
| **테이블 이벤트 처리** | `itemPress`, `getBindingContext()` |
| **VizFrame 시각화** | `FlattenedDataset` + `FeedItem` 구조 이해 |
| **다중 차트 동적 생성** | `VBox.addItem()` / `destroyItems()` |
| **Fragment 관리** | `loadFragment()` + `bindElement()` |
| **데이터 흐름 제어** | `_currentCarrid`로 항공사 상태 유지 |

---

## 🧾 7️⃣ 최종 결과 요약

| 항목 | 구현 결과 |
| --- | --- |
| **Level 1** | MVC 구조 + 프로젝트 생성 완료 |
| **Level 2** | ComboBox를 통한 연도 선택 및 필터링 |
| **Level 3** | Table로 항공사별 매출 표시 |
| **Level 4** | Row 클릭 시 월별/년도별 매출 차트 표시 |
| **Level 5** | 예약 상세 팝업(Fragment) 구현 |
| **추가 구현** | 도넛 클릭 → 연도별 월차트 추가 / 해제 및 초기화 기능 |

---

> 💬 정리 요약:
> 
> 
> 이 프로젝트는 SAPUI5의 핵심 개념인
> 
> **Model 바인딩 → Controller 이벤트 처리 → View 시각화**
> 
> 전 과정을 모두 포함하는 종합 과제였으며,
> 
> 실무에서 자주 쓰이는 **OData 연동 + VizFrame 차트 + Fragment 팝업 구조**를
> 
> 완전하게 익힐 수 있는 예제다.
> 

# 🧭 전체 코드 정리

## 💡 View (`Main.view.xml`)

```xml
<mvc:View controllerName="code.zux01exam.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core"
    xmlns:l="sap.ui.layout"
    xmlns:viz="sap.viz.ui5.controls"
    xmlns:viz.data="sap.viz.ui5.data"
    xmlns:viz.feeds="sap.viz.ui5.controls.common.feeds">

    <Page id="page" title="{i18n>title}">
        <l:ResponsiveFlowLayout id="idResFlow">

            <!-- ▷ 조회 조건 -->
            <l:VerticalLayout id="idVert" width="100%">
                <l:layoutData>
                    <l:ResponsiveFlowLayoutData margin="true" minWidth="400"/>
                </l:layoutData>

                <f:SimpleForm id="idSimForm1" width="100%">
                    <f:toolbar>
                        <Toolbar>
                            <Title text="조회 조건"/>
                            <ToolbarSpacer/>
                            <Button text="Search" icon="sap-icon://search" press=".onSearch"/>
                        </Toolbar>
                    </f:toolbar>

                    <f:content>
                        <Text text="선택년도:"/>
                        <ComboBox id="idComboBox" width="240px" items="{/ES_SYEARSet}">
                            <items>
                                <core:Item key="{Syear}" text="{Syeart}"/>
                            </items>
                        </ComboBox>
                    </f:content>
                </f:SimpleForm>
            </l:VerticalLayout>

            <!-- ▷ 항공사별 매출 테이블 -->
            <l:VerticalLayout id="idVert2" width="100%">
                <l:layoutData>
                    <l:ResponsiveFlowLayoutData margin="true" weight="2"/>
                </l:layoutData>

                <Panel headerText="항공사별 매출" expandable="true" expanded="true">
                    <f:SimpleForm width="100%">
                        <Table id="idTab1" items="{/ES_SALESSet}" growing="true"
                               growingThreshold="3" itemPress=".onRowPress">
                            <columns>
                                <Column><Text text="년도"/></Column>
                                <Column><Text text="항공사"/></Column>
                                <Column><Text text="항공사명"/></Column>
                                <Column><Text text="매출액"/></Column>
                                <Column><Text text="예약건수"/></Column>
                                <Column><Text text="취소건수"/></Column>
                                <Column><Text text="예약정보"/></Column>
                            </columns>

                            <items>
                                <ColumnListItem type="Navigation" press=".onRowPress">
                                    <cells>
                                        <Text text="{Syear}"/>
                                        <Text text="{Carrid}"/>
                                        <Text text="{Carrname}"/>
                                        <Text text="{Curam}"/>
                                        <Text text="{Bkcnt}"/>
                                        <Text text="{Cacnt}"/>
                                        <Button text="예약 상세" press=".onBookingDetail"/>
                                    </cells>
                                </ColumnListItem>
                            </items>
                        </Table>
                    </f:SimpleForm>
                </Panel>

                <!-- ▷ 월별 매출 차트 -->
                <f:SimpleForm width="100%">
                    <viz:VizFrame id="idVizFrame" height="400px" width="100%" vizType="stacked_column"/>
                </f:SimpleForm>

                <!-- ▷ 도넛 + 연도별 상세 차트 -->
                <HBox width="100%" renderType="Bare">
                    <viz:VizFrame id="idVizFrame2" height="400px" width="50%"
                                  vizType="donut"
                                  selectData=".onYearSliceSelect"
                                  deselectData=".onYearSliceDeselect"/>
                    <VBox id="idYearChartsBox" width="55%" alignItems="Stretch"/>
                </HBox>

                <!-- ▷ 초기화 버튼 -->
                <f:SimpleForm>
                    <Button text="차트 초기화" press=".onClearCharts"/>
                </f:SimpleForm>

            </l:VerticalLayout>
        </l:ResponsiveFlowLayout>
    </Page>
</mvc:View>

```

---

## 💡 Controller (`Main.controller.js`)

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
    "sap/viz/ui5/controls/common/feeds/FeedItem"
], (Controller, JSONModel, Filter, FilterOperator, Sorter, MessageToast, MessageBox, DateFormat, FlattenedDataset, FeedItem) => {
    "use strict";

    return Controller.extend("code.zux01exam.controller.Main", {
        onInit() {},

        // ▷ 1. ComboBox로 연도별 필터링
        onSearch() {
            const oComboBox = this.byId("idComboBox");
            const sYear = oComboBox.getSelectedKey();

            if (!sYear) {
                MessageToast.show("연도를 선택하세요");
                return;
            }

            const aFilter = [new Filter("Syear", FilterOperator.EQ, sYear)];
            const oTable = this.byId("idTab1");
            oTable.getBinding("items").filter(aFilter);
        },

        // ▷ 2. 테이블 행 클릭 시 차트 표시
        onRowPress(oEvent) {
            const oCtx = oEvent.getParameter("listItem").getBindingContext();
            const sYear = oCtx.getProperty("Syear");
            const sCarrid = oCtx.getProperty("Carrid");
            const sCarrname = oCtx.getProperty("Carrname");

            this._currentCarrid = sCarrid; // 도넛 클릭용 저장

            const oViz = this.byId("idVizFrame");
            const oViz2 = this.byId("idVizFrame2");

            oViz.removeAllFeeds(); oViz.destroyDataset();
            oViz2.removeAllFeeds(); oViz2.destroyDataset();

            const oDataset = new FlattenedDataset({
                dimensions: [{ name: "월별", value: "{Month}" }],
                measures: [{ name: "취소 매출액", value: "{CuramC}" }, { name: "매출액", value: "{Curam}" }],
                data: { path: "/ES_MONTHSet", filters: [
                    new Filter("Syear", FilterOperator.EQ, sYear),
                    new Filter("Carrid", FilterOperator.EQ, sCarrid)
                ]}
            });

            const oDataset2 = new FlattenedDataset({
                dimensions: [{ name: "년도별", value: "{Syear}" }],
                measures: [{ name: "매출액", value: "{Curam}" }],
                data: { path: "/ES_CHARTSet", filters: [
                    new Filter("Carrid", FilterOperator.EQ, sCarrid)
                ]}
            });

            oViz.setDataset(oDataset);
            oViz2.setDataset(oDataset2);

            oViz.setVizProperties({
                title: { text: sYear + "년도 " + sCarrid + " 항공사 월별 매출액" },
                plotArea: { drawingEffect: "normal", dataLabel: { visible: true } },
                legend: { visible: true }
            });

            const feedValueAxis = new FeedItem({ uid: "valueAxis", type: "Measure", values: ["취소 매출액", "매출액"] });
            const feedCategoryAxis = new FeedItem({ uid: "categoryAxis", type: "Dimension", values: ["월별"] });
            const feedColor = new FeedItem({ uid: "color", type: "Dimension", values: ["월별"] });
            oViz.addFeed(feedValueAxis); oViz.addFeed(feedCategoryAxis); oViz.addFeed(feedColor);

            oViz2.setVizProperties({
                title: { text: sCarrname + "항공사의 년도별 매출액" },
                plotArea: { drawingEffect: "normal", dataLabel: { visible: true } },
                legend: { visible: true }
            });

            oViz2.addFeed(new FeedItem({ uid: "size", type: "Measure", values: ["매출액"] }));
            oViz2.addFeed(new FeedItem({ uid: "color", type: "Dimension", values: ["년도별"] }));
        },

        // ▷ 3. 도넛 조각 클릭 시 연도별 월 차트 추가
        onYearSliceSelect(oEvent) {
            const sYear = String(oEvent.getParameter("data")[0].data["년도별"]);
            const sCarrid = this._currentCarrid;
            if (!sCarrid) return;

            const oYearViz = new sap.viz.ui5.controls.VizFrame({
                vizType: "column",
                width: "100%",
                height: "300px"
            });

            const oDataset = new sap.viz.ui5.data.FlattenedDataset({
                dimensions: [{ name: "월", value: "{Month}" }],
                measures: [{ name: "취소 매출액", value: "{CuramC}" }, { name: "매출액", value: "{Curam}" }],
                data: { path: "/ES_MONTHSet", filters: [
                    new sap.ui.model.Filter("Syear", sap.ui.model.FilterOperator.EQ, sYear),
                    new sap.ui.model.Filter("Carrid", sap.ui.model.FilterOperator.EQ, sCarrid)
                ]}
            });

            oYearViz.setDataset(oDataset);
            oYearViz.setVizProperties({
                title: { text: sYear + "년 월별 매출액" },
                plotArea: { dataLabel: { visible: true }, drawingEffect: "normal" },
                legend: { visible: true }
            });

            oYearViz.addFeed(new sap.viz.ui5.controls.common.feeds.FeedItem({
                uid: "valueAxis", type: "Measure", values: ["취소 매출액", "매출액"]
            }));
            oYearViz.addFeed(new sap.viz.ui5.controls.common.feeds.FeedItem({
                uid: "categoryAxis", type: "Dimension", values: ["월"]
            }));
            oYearViz.addFeed(new sap.viz.ui5.controls.common.feeds.FeedItem({
                uid: "color", type: "Dimension", values: ["월"]
            }));

            this.byId("idYearChartsBox").addItem(oYearViz);
        },

        // ▷ 4. 도넛 조각 해제 시 차트 제거
        onYearSliceDeselect(oEvent) {
            const a = oEvent.getParameter("data");
            if (!a || !a.length) return;
            const sYear = String(a[0].data.Syear || a[0].data["년도별"]);
            const sChartId = this.createId("idVizYear_" + sYear);
            const oChart = sap.ui.getCore().byId(sChartId);
            if (oChart) oChart.destroy();
        },

        // ▷ 5. 차트 초기화 버튼
        onClearCharts() {
            this.byId("idYearChartsBox").destroyItems();
        },

        // ▷ 6. 예약 상세 팝업
        onBookingDetail(oEvent) {
            if (!this.pDialog) {
                this.pDialog = this.loadFragment({ name: "code.zux01exam.view.PopupFrag" });
            }
            this.pDialog.then((oDialog) => oDialog.open());

            const oBtn = oEvent.getSource();
            const oCtx = oBtn.getBindingContext();
            const sPath = oCtx.getPath();
            if (!sPath) return;

            const oTable = this.byId("idTab2");
            oTable.bindElement(sPath);
        },

        onCloseDialog() {
            this.byId("idDialog").close();
        }
    });
});

```

---

## 💡 Fragment (`PopupFrag.fragment.xml`)

```xml
<core:FragmentDefinitionxmlns:core="sap.ui.core"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form">

    <Dialog id="idDialog" title="예약 상세정보">

        <Table id="idTab2" items="{to_Detail}" growing="true" growingThreshold="10">
            <columns>
                <Column><Text text="항공사"/></Column>
                <Column><Text text="항공사 이름"/></Column>
                <Column><Text text="편명"/></Column>
                <Column><Text text="출발일자"/></Column>
                <Column><Text text="정원 좌석"/></Column>
                <Column><Text text="예약 좌석"/></Column>
                <Column><Text text="여유 좌석"/></Column>
                <Column><Text text="예약율"/></Column>
            </columns>

            <items>
                <ColumnListItem>
                    <cells>
                        <Text text="{Carrid}"/>
                        <Text text="{Carrname}"/>
                        <Text text="{Connid}"/>
                        <Text text="{path:'Fldate', type:'sap.ui.model.odata.type.Date'}"/>
                        <Text text="{Seatsmax}"/>
                        <Text text="{Seatsocc}"/>
                        <Text text="{Seatsfree}"/>
                        <Text text="{Bookrate}"/>
                    </cells>
                </ColumnListItem>
            </items>
        </Table>

        <beginButton>
            <Button text="Close" press=".onCloseDialog"/>
        </beginButton>
    </Dialog>
</core:FragmentDefinition>

```

# 🔧 SAPUI5 그래프 동기화 오류 수정 정리

## 문제 현상

도넛 차트에서 `2025` → `2026` 순으로 클릭 시,

기존에 생성된 `2025년 월별 차트`까지 **모두 2026 데이터로 바뀌는 문제 발생**.

---

## 원인 분석

1. **도넛 차트의 다중 선택(multi-select)** 기능 때문에
    
    여러 조각이 동시에 선택되어 `selectData` 이벤트가 누적 호출됨.
    
2. 동적으로 추가된 연도별 차트들이 **같은 OData 모델 컨텍스트를 공유**해서
    
    나중에 바인딩된 값으로 전부 리렌더링됨.
    
3. 차트에 **고유 ID가 부여되지 않아** 구분 없이 동일 객체처럼 갱신됨.

---

## 수정 내용 요약

### 1️⃣ 도넛 차트의 선택 모드 단일화

`onRowPress` 내부에서 도넛 차트의 VizProperty에

단일 선택 모드(`single`) 추가.

```jsx
// onRowPress 마지막 부분에 추가
oViz2.setVizProperties({
  // ...기존 속성
  interaction: {
    selectability: { mode: "single" } // ✅ 단일 선택 모드
  }
});

```

---

### 2️⃣ 동적으로 생성되는 차트에 View의 모델 명시적으로 주입

자동 상속 대신, 명확하게 부모 모델을 전달하여

각 차트가 독립된 컨텍스트로 데이터 바인딩하도록 수정.

```jsx
// onYearSliceSelect 내부
const oYearViz = new sap.viz.ui5.controls.VizFrame(sChartId, {
  vizType: "column",
  width: "100%",
  height: "300px"
});

// ✅ 모델 명시적으로 지정
oYearViz.setModel(this.getView().getModel());

```

---

### 3️⃣ 도넛 선택 후 선택 상태 즉시 초기화

다음 클릭 시 이전 선택이 남지 않도록

`vizSelection([], { clearSelection: true })` 추가.

```jsx
// onYearSliceSelect 마지막 줄에 추가
this.byId("idVizFrame2").vizSelection([], { clearSelection: true });

```

---

### 4️⃣ 연도별 고유 ID로 차트 구분 (중복 생성 방지)

각 연도별 차트에 ID를 부여하여

기존 차트가 덮어쓰이지 않게 고정.

```jsx
// 고유 ID 부여
const sChartId = this.createId("idVizYear_" + sYear);

// 이미 존재하는 차트면 재생성 방지
if (sap.ui.getCore().byId(sChartId)) return;

```
