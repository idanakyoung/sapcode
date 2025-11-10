# 🧾 Lesson 13 - SAPUI5 과제 2 요약 (Notion용)
## 📘 주제 요약

- **목표:** SAPUI5를 이용해 예약연도별 총 예약정보, 상세정보, 좌석등급별 예약금액을
    
    테이블과 도넛 차트로 구현
    
- **핵심 포인트:**
    - `Filter`를 이용한 다중 테이블 연동
    - `Formatter`를 이용한 문자열 → 숫자/통화 변환
    - `Expression Binding`으로 다중 프로퍼티(출발/도착도시) 합치기
    - `VizFrame(donut)` 차트 데이터 필터링 및 퍼센트 라벨 표시
    - 데이터 예시 1
    
    ![image.png](attachment:76cdbe62-10bd-478f-b10b-334f69bdd304:image.png)
    
    - 데이터 예시 2
    
    ![image.png](attachment:f67719c6-a8ad-48cd-98d8-9553a7bca076:image.png)
    
    - 데이터 예시 3
    
    ![image.png](attachment:5c7be8bb-12da-4bec-b0a5-5260a179297c:image.png)
    

---

## 💻 전체 구조

> ① View (XML)
> 
> 
> ② Controller (JS)
> 
> ③ Formatter (JS)
> 
> - 결과창
> 
> ![image.png](attachment:146dd366-815c-494f-9dc2-1522238ef611:image.png)
> 
> ![image.png](attachment:69512fac-db50-46f9-ae38-204f5ea225c3:image.png)
> 

---

### 📄 ① **View (Main.view.xml)**

<details>
<summary>🔽 View 코드 전체 보기</summary>

```xml
<mvc:View controllerName="code.zn0101last.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m"
    xmlns:f="sap.ui.layout.form"
    xmlns:core="sap.ui.core"
    xmlns:l="sap.ui.layout"
    xmlns:viz="sap.viz.ui5.controls"
    xmlns:viz.data="sap.viz.ui5.data"
    xmlns:viz.feeds="sap.viz.ui5.controls.common.feeds"
    core:require="{fmt:'code/zn0101last/model/formatter'}">
    <Page id="page" title="{i18n>title}">

    <VBox id="idVBox">

        <!-- 검색 조건 영역 -->
        <f:SimpleForm id="idSimForm1" width="50%">
            <f:toolbar>
                <Toolbar id="idToolBar1">
                    <Title text="검색 조건"/>
                    <ToolbarSpacer/>
                    <Button id="idBtnSch" text="Search" press=".onSearch" icon="sap-icon://search"/>
                </Toolbar>
            </f:toolbar>

            <f:content>
                <Text text="예약 년도:"/>
                <ComboBox id="idComboBox" width="240px" items="{/esBookYearSet}">
                    <items>
                        <core:Item key="{Byear}" text="{Byeart}"/>
                    </items>
                </ComboBox>
            </f:content>
        </f:SimpleForm>

        <!-- 예약연도별 총 예약 정보 -->
        <Panel headerText="예약연도별 총 예약 정보" expandable="true" expanded="true">
            <f:SimpleForm width="100%">
                <Table id="idTab1" items="{/esBookTotSet}" growing="true"
                    growingThreshold="8" itemPress=".onRowPress">

                    <columns>
                        <Column><header><Text text="예약년도"/></header></Column>
                        <Column><header><Text text="항공사"/></header></Column>
                        <Column><header><Text text="항공사명"/></header></Column>
                        <Column><header><Text text="출발도시"/></header></Column>
                        <Column><header><Text text="도착도시"/></header></Column>
                        <Column><header><Text text="총 예약 건수"/></header></Column>
                        <Column><header><Text text="항공비 총액"/></header></Column>
                        <Column><header><Text text="통화"/></header></Column>
                    </columns>

                    <items>
                        <ColumnListItem type="Navigation">
                            <cells>
                                <Text text="{Byear}"/>
                                <Text text="{Carrid}"/>
                                <Text text="{Carrname}"/>
                                <Text text="{Cityto}"/>
                                <Text text="{Cityfrom}"/>
                                <Text text="{Bkcnt}"/>
                                <Text text="{Toram}"/>
                                <Text text="{Waers}"/>
                            </cells>
                        </ColumnListItem>
                    </items>
                </Table>
            </f:SimpleForm>
        </Panel>

        <!-- 총 예약 상세 정보 -->
        <Panel headerText="총 예약 상세 정보" expandable="true" expanded="true">
            <f:SimpleForm width="100%">
                <HBox width="100%">
                    <Table id="idTab2" items="{/esBookTotSet}" growing="true" growingThreshold="8">
                        <columns>
                            <Column><header><Text text="예약년도"/></header></Column>
                            <Column><header><Text text="항공사"/></header></Column>
                            <Column><header><Text text="항공편"/></header></Column>
                            <Column><header><Text text="출발/도착도시"/></header></Column>
                            <Column><header><Text text="항공비 정가"/></header></Column>
                            <Column><header><Text text="항공비 총액"/></header></Column>
                            <Column><header><Text text="총 예약건수"/></header></Column>
                            <Column><header><Text text="평균 금액"/></header></Column>
                        </columns>

                        <items>
                            <ColumnListItem type="Navigation">
                                <cells>
                                    <Text text="{Byear}"/>
                                    <Text text="{Carrid}"/>
                                    <Text text="{Connid}"/>
                                    <!-- Expression Binding으로 도시 두 개 합치기 -->
                                    <Text text="{= ${Cityfrom} + ' ~ ' + ${Cityto} }"/>
                                    <!-- currency 포매터 -->
                                    <Text text="{parts: [{path:'PriceT'},{path:'Waers'}], formatter: 'fmt.currency'}"/>
                                    <Text text="{path:'Toram', formatter:'fmt.toNumber'}"/>
                                    <Text text="{Bkcnt}"/>
                                    <Text text="{Avram}"/>
                                </cells>
                            </ColumnListItem>
                        </items>
                    </Table>
                </HBox>
            </f:SimpleForm>
        </Panel>

        <!-- 도넛 차트 -->
        <viz:VizFrame id="idVizFrame" height="400px" width="100%" vizType="donut"/>
    </VBox>

    </Page>
</mvc:View>

```

</details>

---

### 🧠 View 핵심 포인트

- `core:require` 로 formatter 연결 (`fmt`)
- `itemPress` 이벤트로 상위/하위 테이블 및 차트 동기화
- `Expression Binding`: `${Cityfrom} + ' ~ ' + ${Cityto}`
- `Formatter`: `fmt.currency`, `fmt.toNumber`
- `VizFrame`: `vizType="donut"`, 퍼센트 라벨 표시

---

### 💡 화면 결과

- 상단 테이블: 예약년도별 요약
- 하단 테이블: 클릭한 항공사 상세
- 하단 차트: 좌석등급별 총 예약금액(도넛형)
    
    → **라벨에 퍼센트(%) 표시**, 범례는 색상 구분
    

---

### 📄 ② **Controller (Main.controller.js)**

<details>
<summary>🔽 Controller 코드 전체 보기</summary>

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

    return Controller.extend("code.zn0101last.controller.Main", {
        onInit() {},

        // ✅ 검색 버튼 클릭 시 필터링
        onSearch() {
            const oComboBox = this.byId("idComboBox");
            const bYear = oComboBox.getSelectedKey();
            if (!bYear) {
                MessageToast.show("연도를 선택하세요");
                return;
            }
            const oTable = this.byId("idTab1");
            const oBinding = oTable.getBinding("items");
            oBinding.filter([new Filter("Byear", FilterOperator.EQ, bYear)]);
        },

        // ✅ 테이블 행 클릭 시 상세 및 차트 갱신
        onRowPress(oEvent) {
            const oItem = oEvent.getParameter("listItem");
            const oCtx  = oItem?.getBindingContext();
            if (!oCtx) {
                MessageToast.show("행 컨텍스트를 찾지 못했습니다");
                return;
            }

            // 클릭 행의 키값 추출
            const bYear   = oCtx.getProperty("Byear");
            const bCarrid = oCtx.getProperty("Carrid");
            const bConnid = oCtx.getProperty("Connid");

            // 하단 테이블 필터 적용
            const oTable = this.byId("idTab2");
            const oBind  = oTable.getBinding("items");
            if (oBind) {
                const aFilter = [
                    new Filter("Byear",  FilterOperator.EQ, bYear),
                    new Filter("Carrid", FilterOperator.EQ, bCarrid),
                    new Filter("Connid", FilterOperator.EQ, bConnid)
                ];
                oBind.filter(aFilter);
            }

            // 도넛 차트 갱신
            const oViz = this.byId("idVizFrame");
            oViz.removeAllFeeds();
            oViz.destroyDataset();

            const oDataset = new FlattenedDataset({
                dimensions: [{
                    name: "좌석등급",
                    value: "{ClassT}"
                }],
                measures: [{
                    name: "총 예약금액",
                    value: "{Toram}"
                }],
                data: {
                    path: "/esClassChartSet",
                    filters: [
                        new Filter("Byear",  FilterOperator.EQ, bYear),
                        new Filter("Carrid", FilterOperator.EQ, bCarrid)
                    ]
                }
            });

            oViz.setDataset(oDataset);
            oViz.setVizProperties({
                title: { text: "좌석등급별 총 예약금액" },
                plotArea: {
                    dataLabel: { visible: true, type: "percentage" },
                    drawingEffect: "glossy"
                },
                legend: { visible: true }
            });

            const feedSize  = new FeedItem({ uid: "size",  type: "Measure",   values: ["총 예약금액"] });
            const feedColor = new FeedItem({ uid: "color", type: "Dimension", values: ["좌석등급"] });
            oViz.addFeed(feedSize);
            oViz.addFeed(feedColor);
        }
    });
});

```

</details>

---

### 🧠 Controller 핵심 포인트

| 기능 | 설명 |
| --- | --- |
| `onSearch()` | 콤보박스 값으로 상단 테이블 필터링 |
| `onRowPress()` | 클릭한 행의 키(`Byear`, `Carrid`, `Connid`)로 상세/차트 갱신 |
| `getBinding("items").filter()` | 리스트 바인딩 필터링 |
| `removeAllFeeds() / destroyDataset()` | 차트 중복 방지 |
| `plotArea.dataLabel.type="percentage"` | 퍼센트 표시 |
| `FeedItem` | 도넛 차트: size(Measure) + color(Dimension) |

---

### 📄 ③ **Formatter (formatter.js)**

<details>
<summary>🔽 Formatter 코드 전체 보기</summary>

```jsx
sap.ui.define([
    "sap/ui/core/format/NumberFormat"
], function (NumberFormat) {
    "use strict";

    return {

        // 숫자형 변환: "  2,320.04" → 2320.04
        toNumber: function (value) {
            if (value === null || value === undefined || value === "") return 0;
            var s = String(value).replace(/\s+/g, "").replace(/,/g, "");
            var n = parseFloat(s);
            return isNaN(n) ? 0 : n;
        },

        // 출발/도착 도시 결합: ROME ~ FRANKFURT
        cityPair: function (from, to) {
            if (!from && !to) return "";
            if (!from) return to;
            if (!to) return from;
            return from + " ~ " + to;
        },

        // 통화 포맷
        currency: function (value, unit) {
            if (value === null || value === undefined || value === "") return "";
            var oCurrencyFormat = NumberFormat.getCurrencyInstance({
                currencyCode: true,
                showMeasure: true,
                groupingEnabled: true,
                maxFractionDigits: 2
            });
            var num = parseFloat(String(value).replace(/[\s,]/g, ""));
            return oCurrencyFormat.format(num, unit || "USD");
        }
    };
});

```

</details>

---

### 🧠 Formatter 핵심 포인트

| 함수명 | 기능 | 예시 출력 |
| --- | --- | --- |
| `toNumber(value)` | 문자열 → 숫자 | `" 2,320.04"` → `2320.04` |
| `cityPair(from,to)` | 도시 두 개 결합 | `"ROME" + " ~ " + "FRANKFURT"` |
| `currency(value,unit)` | 통화 코드 붙여 포맷 | `10216159.31, "SGD"` → `SGD 10,216,159.31` |

---

## ✅ 실행 결과 요약

| 구역 | 설명 |
| --- | --- |
| **검색 조건** | 예약년도 선택(Search 버튼) |
| **예약연도별 총 예약 정보** | 상위 집계 테이블 (`/esBookTotSet`) |
| **총 예약 상세 정보** | 클릭된 항공사의 세부 노선 목록 |
| **좌석등급별 총 예약금액(도넛 차트)** | `esClassChartSet` 기반, 퍼센트 라벨 표시 |

---

## 🧩 체크리스트

- [x]  `core:require`로 포매터 연결
- [x]  `itemPress` 이벤트로 데이터 연동
- [x]  `getBinding("items").filter()` 구조 숙지
- [x]  `Expression Binding`으로 두 필드 합치기
- [x]  `plotArea.dataLabel.type="percentage"` 설정
- [x]  `removeAllFeeds()` + `destroyDataset()` 필수

## 🧩 바인딩 핵심 (이번 레슨 포인트만)

- *리스트 바인딩(items)**은 `bindElement`로 안 바뀜 → **filter**로 좁혀라.
    - 그래서 `idTab2`는 `bindElement(sPath)`가 아니라 `getBinding("items").filter(aFilter)`.
- **단건 상세**를 컨테이너에 띄울 땐 `bindElement(sPath)`가 정답(이번 구조는 리스트라 X).
- **도시 합치기**: Expression Binding
    
    ```xml
    <Text text="{= ${Cityfrom} + ' ~ ' + ${Cityto} }"/>
    
    ```
    
- **통화/숫자 포맷**: 포매터 활용
    - `fmt.toNumber` → `" 2,320.04"` 같은 문자열을 숫자로 변환
    - `fmt.currency` → 금액 + 화폐코드로 현지 포맷 출력
- **VizFrame 타입** 문자열 정확히: `"donut"`(공백 없음).

---

## 🧰 포매터(사용만 정리)

- `toNumber(value)`
    - 공백/콤마 제거 → `parseFloat` → 숫자 반환(실패 시 0)
    - 차트/계산에서 문자열 숫자 깨짐 방지.
- `cityPair(from, to)`
    - `"FROM ~ TO"` 형식으로 합치기(둘 중 하나 null이어도 안전하게 처리).
- `currency(value, unit)`
    - `NumberFormat.getCurrencyInstance()`로 **통화 포맷**.
    - `parts:[PriceT, Waers]` 같이 두 값 묶어 사용.

---

## 🧱 차트 구성 포인트(이 레슨에서 새로 강조)

- **Dataset 경로/필드**: `/esClassChartSet`, `ClassT`(좌석등급), `Toram`(총액)
- **Feed 연결 이름은 Dataset의 name과 일치**
    - Measure name: `"총 예약금액"` → Feed values에도 정확히 동일 문자열
    - Dimension name: `"좌석등급"` → Feed values에도 동일
- **갱신 시 초기화 필수**
    - `oViz.removeAllFeeds(); oViz.destroyDataset();` 후 재세팅.
- **퍼센트 라벨 켜기**
    - `plotArea.dataLabel = { visible: true, type: "percentage" }`
