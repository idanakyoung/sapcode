# 🧾 Lesson 14 - **SAPUI5 과제  3 요약 (Notion용)**

**주제:** 예약 연도별 항공사 총 예약 정보 및 좌석등급별 시각화

**구성:**

① 검색 조건 →

② 예약연도별 요약 테이블 →

③ 상세 테이블 →

④ 도넛 & 바 차트 (좌석등급별/월별 비교)

<img width="1080" height="1249" alt="image" src="https://github.com/user-attachments/assets/9f6c17f8-a8cb-4328-98e0-03201af3afae" />

---

## 🧩 1. Formatter (code/zn0101last/model/formatter.js)

데이터 포매팅 전용 헬퍼 파일.

숫자, 통화, 도시명 조합 처리 담당.

```jsx
sap.ui.define([
    "sap/ui/core/format/NumberFormat"
], function (NumberFormat) {
    "use strict";

    return {
        // 🔹 숫자 포매터: 문자열/공백/콤마 제거 후 숫자 변환
        toNumber: function (value) {
            if (value === null || value === undefined || value === "") return 0;
            var s = String(value).replace(/\s+/g, "").replace(/,/g, "");
            var n = parseFloat(s);
            return isNaN(n) ? 0 : n;
        },

        // 🔹 출발지~도착지 포맷 (from/to 조합)
        cityPair: function (from, to) {
            if (!from && !to) return "";
            if (!from) return to;
            if (!to) return from;
            return from + " ~ " + to;
        },

        // 🔹 통화 포매터: NumberFormat으로 통화 표시
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

---

## 🖥️ 2. View (Main.view.xml)

**핵심 UI 구조:**

검색 영역 → 요약 테이블 → 상세 테이블 → 도넛(좌석등급별) & 바 차트(월별 비교)

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

    <!-- [1] 검색 조건 -->
    <VBox id="idVBox1">
        <f:SimpleForm id="idSimForm1" width="50%">
            <f:toolbar>
                <Toolbar id="idToolBar1">
                    <Title id="idTlt1" text="검색 조건"></Title>
                    <ToolbarSpacer id="idToolSpace"></ToolbarSpacer>
                    <Button id="idBtnSch" text="Search" press=".onSearch" icon="sap-icon://search"></Button>
                </Toolbar>
            </f:toolbar>

            <f:content>
                <!-- 예약년도 선택 -->
                <HBox id="idHboxSearch">
                    <Text text="예약 년도"></Text>
                    <ComboBox id="idComboBox" width="240px" items="{/esBookYearSet}">
                        <items>
                            <core:Item key="{Byear}" text="{Byeart}" />
                        </items>
                    </ComboBox>
                </HBox>

                <!-- 항공사 From ~ To -->
                <HBox alignItems="Center" class="sapUiTinyMarginTop">
                    <Label text="항공사" width="5rem"/>
                    <Input id="idInpCarrid1" width="6rem" maxLength="2"/>
                    <Label text=" ~ " width="1.5rem" textAlign="Center"/>
                    <Input id="idInpCarrid2" width="6rem" maxLength="2"/>
                </HBox>
            </f:content>
        </f:SimpleForm>

        <!-- [2] 상단 요약 테이블 -->
        <Panel headerText="예약연도별 총 예약 정보" expandable="true" expanded="true">
            <f:SimpleForm width="100%">
                <Table id="idTab1" items="{/esBookTotSet}" itemPress=".onRowPress" growing="true" growingThreshold="8">
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
    </VBox>

    <!-- [3] 상세 테이블 -->
    <HBox width="100%" alignItems="Stretch" class="sapUiSmallMarginTop">
        <Panel headerText="총 예약 상세 정보" expandable="true" expanded="true">
            <f:SimpleForm width="100%">
                <Table id="idTab2" items="{/esBookTotSet}" itemPress=".onRowPress" growing="true" growingThreshold="8">
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
                                <Text text="{= ${Cityfrom} + ' ~ ' + ${Cityto} }"/>
                                <Text text="{parts:[{path:'PriceT'},{path:'Waers'}], formatter:'fmt.currency'}"/>
                                <Text text="{path:'Toram', formatter:'fmt.toNumber'}"/>
                                <Text text="{Bkcnt}"/>
                                <Text text="{Avram}"/>
                            </cells>
                        </ColumnListItem>
                    </items>
                </Table>
            </f:SimpleForm>
        </Panel>

        <!-- [4] 차트 영역 -->
        <Panel headerText="좌석 등급별 총 예약 금액" expandable="true" expanded="true">
            <f:SimpleForm width="100%">
                <!-- 차트 #1 (도넛) -->
                <viz:VizFrame id="idVizFrame" height="400px" width="100%" vizType="donut" selectData=".onClassTSliceSelect" />
            </f:SimpleForm>

            <!-- 차트 #2 (바) -->
            <HBox width="100%">
                <viz:VizFrame id="idVizFrame2" height="400px" width="100%" vizType="bar"/>
            </HBox>
        </Panel>
    </HBox>

    </Page>
</mvc:View>

```

---

## 🧠 3. Controller (Main.controller.js)

**핵심 로직 요약**

- onInit → 입력 제한 & 기본값
- onSearch → 연도·항공사 조건 필터
- onRowPress → 선택행 기준 도넛차트 생성
- onClassTSliceSelect → 도넛 클릭 시 바차트 생성

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

        // [1] 초기 설정
        onInit() {
            // 항공사 입력값 제한 + 기본값
            this.byId("idInpCarrid1")?.setMaxLength(2);
            this.byId("idInpCarrid2")?.setMaxLength(2);
            this.byId("idInpCarrid1")?.setValue("AA");
            this.byId("idInpCarrid2")?.setValue("UA");

            // 예약년도 콤보박스 기본 선택
            const oCb = this.byId("idComboBox");
            const sYear = String(new Date().getFullYear());
            const oBind = oCb.getBinding("items");
            if (oBind) {
                oBind.attachDataReceived(() => oCb.setSelectedKey(sYear));
            } else {
                oCb?.setSelectedKey(sYear);
            }
        },

        // [2] 검색 이벤트
        onSearch() {
            const oComboBox = this.byId("idComboBox");
            const bYear = oComboBox.getSelectedKey();

            if (!bYear) {
                MessageToast.show("연도를 선택하세요");
                return;
            }
            if (!this._validateAirline()) return;

            const sFrom = this.byId("idInpCarrid1").getValue().toUpperCase();
            const sTo   = this.byId("idInpCarrid2").getValue().toUpperCase();

            const aFilter = [
                new Filter("Byear", FilterOperator.EQ, bYear),
                new Filter("Carrid", FilterOperator.BT, sFrom, sTo)
            ];

            ["idTab1", "idTab2"].forEach((sId) => {
                const oTable = this.byId(sId);
                const oBinding = oTable.getBinding("items");
                if (oBinding) oBinding.filter(aFilter);
            });
        },

        // [2-1] 항공사 입력 검증
        _validateAirline() {
            const oFrom = this.byId("idInpCarrid1");
            const oTo   = this.byId("idInpCarrid2");
            const sFrom = (oFrom.getValue() || "").trim().toUpperCase();
            const sTo   = (oTo.getValue() || "").trim().toUpperCase();

            oFrom.setValue(sFrom);
            oTo.setValue(sTo);

            const bOk = !!sFrom && !!sTo;
            oFrom.setValueState(sFrom ? "None" : "Error");
            oTo.setValueState(sTo ? "None" : "Error");

            if (!bOk) MessageBox.warning("항공사 조건을 모두 입력하세요. (From, To 필수)");
            return bOk;
        },

        // [3] 행 클릭 시 도넛 차트 (#1)
        onRowPress(oEvent) {
            const oItem = oEvent.getParameter("listItem");
            const oCtx = oItem.getBindingContext();
            if (!oCtx) {
                MessageToast.show("행 컨텍스트를 찾지 못했습니다");
                return;
            }

            // 키 저장
            const bYear   = oCtx.getProperty("Byear");
            const bCarrid = oCtx.getProperty("Carrid");
            const bConnid = oCtx.getProperty("Connid");
            const bClass  = oCtx.getProperty("Class");
            this._currentKeys = { Byear: bYear, Carrid: bCarrid, Connid: bConnid, Class: bClass };

            const aFilters = [
                new Filter("Byear", FilterOperator.EQ, bYear),
                new Filter("Carrid", FilterOperator.EQ, bCarrid),
                new Filter("Connid", FilterOperator.EQ, bConnid)
            ];

            // 도넛 차트 초기화 & 데이터셋 적용
            const oViz = this.byId("idVizFrame");
            oViz.setModel(this.getView().getModel());
            oViz.removeAllFeeds();
            oViz.destroyDataset();

            const oDataset = new FlattenedDataset({
                dimensions: [{ name: "좌석등급", value: "{Class}", displayValue: "{ClassT}" }],
                measures: [{ name: "총 예약금액", value: "{Toram}" }],
                data: { path: "/esClassChartSet", filters: aFilters }
            });

            oViz.setDataset(oDataset);
            oViz.setVizProperties({
                title: { text: "좌석등급별 총 예약금액" },
                plotArea: { dataLabel: { visible: true, type: "percentage" }, drawingEffect: "glossy" },
                legend: { visible: true }
            });
            oViz.addFeed(new FeedItem({ uid: "size", type: "Measure", values: ["총 예약금액"] }));
            oViz.addFeed(new FeedItem({ uid: "color", type: "Dimension", values: ["좌석등급"] }));
        },

        // [4] 도넛 클릭 시 바 차트 (#2)
        onClassTSliceSelect(oEvent) {
            const aData = oEvent.getParameter("data") || [];
            const p0 = aData[0];
            if (!p0 || !p0.data) {
                MessageToast.show("도넛 선택 데이터를 찾지 못했습니다");
                return;
            }

            const bClass = p0.data["좌석등급"] || p0.data.Class || null;
            if (!bClass) {
                MessageToast.show("좌석등급(Class) 정보를 찾지 못했습니다");
                return;
            }

            const k = this._currentKeys || {};
            const bYear   = k.Byear;
            const bCarrid = k.Carrid;
            const bConnid = k.Connid;
            if (!bYear || !bCarrid || !bConnid) {
                MessageToast.show("먼저 상단 테이블에서 행을 선택해줘");
                return;
            }

            const aFilters = [
                new Filter("Byear", FilterOperator.EQ, bYear),
                new Filter("Carrid", FilterOperator.EQ, bCarrid),
                new Filter("Connid", FilterOperator.EQ, bConnid),
                new Filter("Class", FilterOperator.EQ, bClass)
            ];

            const oViz2 = this.byId("idVizFrame2");
            oViz2.setModel(this.getView().getModel());
            oViz2.removeAllFeeds();
            oViz2.destroyDataset();

            const oDataset2 = new FlattenedDataset({
                dimensions: [{ name: "월", value: "{MonthT}" }],
                measures: [
                    { name: "선택 좌석등급 총액", value: "{Monto}" },
                    { name: "전체 좌석등급 총합", value: "{Toram}" }
                ],
                data: { path: "/esMonthChartSet", filters: aFilters }
            });

            oViz2.setDataset(oDataset2);
            oViz2.setVizProperties({
                title: { text: "월별 금액 비교" },
                plotArea: { dataLabel: { visible: true } },
                legend: { visible: true },
                categoryAxis: { title: { visible: true, text: "월" } },
                valueAxis: { title: { visible: true, text: "금액" } }
            });
            oViz2.addFeed(new FeedItem({ uid: "categoryAxis", type: "Dimension", values: ["월"] }));
            oViz2.addFeed(new FeedItem({ uid: "valueAxis", type: "Measure", values: ["선택 좌석등급 총액", "전체 좌석등급 총합"] }));
        }
    });
});

```

---

## 🔄 전체 실행 흐름 요약

| 단계 | 동작 | 주요 요소 |
| --- | --- | --- |
| **1️⃣ onInit** | 항공사 입력 기본값/자리수 설정, 콤보박스 기본년도 세팅 | Input, ComboBox |
| **2️⃣ onSearch** | 연도 + 항공사 필터로 `/esBookTotSet` 테이블 필터링 | idTab1, idTab2 |
| **3️⃣ onRowPress** | 선택된 행의 Byear/Carrid/Connid 저장 → `/esClassChartSet` 필터링 → 도넛차트 구성 | idVizFrame |
| **4️⃣ onClassTSliceSelect** | 도넛 조각 클릭 → Class 추출 → `/esMonthChartSet` 필터링 → 바차트 구성 | idVizFrame2 |

---

## 🧠 핵심 포인트

✅ Formatter는 **뷰 단 바인딩용 가벼운 데이터 처리 전용**

✅ Controller는 **이벤트-기반 데이터 흐름 제어(필터/차트 연결)**

✅ View는 시각화 요소와 데이터 경로

---

# ⚙️ SAPUI5 차트 이벤트 오류 비교 정리

## 🧩 비교 개요

| 구분 | **실행 안 된 버전** | **실행된 버전 (최종 수정본)** |
| --- | --- | --- |
| **파일명** | `Main.controller.js` (초기버전) | `Main.controller.js` (최종버전) |
| **이벤트 함수** | `onClassTSliceSelect(oEvent)` | `onClassTSliceSelect(oEvent)` |
| **목표 동작** | 도넛차트 조각 클릭 시 해당 좌석등급(Class)의 월별 예약금액을 바차트로 표시 | 동일 |
| **결과** | ❌ “차트 포인트 컨텍스트를 찾지 못했습니다” 오류 발생 | ✅ 정상 실행 (바 차트 표시) |

---

## 🧠 코드 비교 상세

| 구분 | **실행 안 된 버전** | **실행된 버전** |
| --- | --- | --- |
| **도넛 클릭 데이터 접근 방식** | `js const aPath = oEvent.getParameter("data"); const oCtx = aPath[0].data._context; const bClass = oCtx.getProperty("Class");` | ```js const aData = oEvent.getParameter("data") |
| **데이터 접근 구조** | `_context` 객체 내부에서 Class 속성 접근 | `data` 속성의 dimension name("좌석등급") 직접 접근 |
| **의존 구조** | VizFrame 내부 비공식 속성 `_context`에 의존 | 공식 이벤트 payload(`data`)를 통해 안전하게 접근 |
| **필터 조건 구성** | `_context`에서 가져온 Byear, Carrid, Connid, Class | 상단에서 저장한 `_currentKeys` (행 클릭 시 저장) + `좌석등급` |
| **오류 원인** | `aPath[0].data._context`가 존재하지 않는 환경(OData 환경/버전)에선 undefined → `getProperty` 실행 시 오류 | `data["좌석등급"]`에서 직접 dimension value를 읽어옴 → 모든 환경에서 안정적 |
| **결과** | 이벤트 실행 시 `undefined` → `MessageToast: 차트 포인트 컨텍스트를 찾지 못했습니다` | 정상 실행, 월별 금액 비교 바 차트 표시 |

---

## 🧩 흐름 요약 (Before vs After)

| 단계 | **Before (오류 발생)** | **After (정상 실행)** |
| --- | --- | --- |
| ① 도넛차트 클릭 | `_context` 사용 → 내부 바인딩 구조 의존 | `data["좌석등급"]` 값 직접 추출 |
| ② Byear/Carrid/Connid/Class | 행 클릭 시 저장되지 않음 → Context로 재참조 | 행 클릭 시 `_currentKeys`에 저장해 재사용 |
| ③ 필터 생성 | 불완전한 필터 (undefined Class) | 완전한 필터 (Byear, Carrid, Connid, Class) |
| ④ 결과 | 바 차트 생성 실패 | 바 차트 정상 표시 |

---

## ⚠️ 오류 원인 정리

| 유형 | 원인 설명 |
| --- | --- |
| **1️⃣ 내부 비공식 속성 의존** | `data._context`는 SAPUI5 버전에 따라 제공되지 않음 (ODataModel에서는 undefined) |
| **2️⃣ 클릭 순서 미정의** | 행 클릭 전에 도넛을 누르면 `_currentKeys`가 없어 필터를 구성할 수 없음 |
| **3️⃣ dimension name 미일치** | dimension 이름이 `"Class"`가 아니라 `"좌석등급"`이므로 `p0.data.Class`로는 접근 불가 |

---

## ✅ 수정 포인트 요약

| 변경 항목 | 수정 내용 | 이유 |
| --- | --- | --- |
| **Context 접근 방식** | `_context.getProperty()` → `data["좌석등급"]` | 안정적 데이터 접근 (VizFrame 이벤트 표준 구조) |
| **행 클릭 정보 저장** | `_currentKeys` = { Byear, Carrid, Connid } | 도넛 클릭 시 필터 재사용 가능 |
| **차트 데이터 필터링 로직** | `/esMonthChartSet`에 필터 4개 적용 | 월별 데이터 정확히 조회 |
| **오류 메시지 개선** | “행 선택 필요” 명확화 | 사용자 피드백 향상 |

---

## 📘 최종 이해 요약

> 핵심 개념 한줄 요약
> 
> 
> ```
> ❌ "_context"는 내부참조라 환경마다 undefined
> ✅ "data['좌석등급']"은 dimension에 매핑된 공식 값
> 
> ```
> 
> → 즉, **차트 조각 클릭 시에는 `_context` 대신 `data`에서 dimension 이름으로 직접 접근해야 한다.**
> 

---

## 📊 정리 다이어그램

```
[행 클릭]
↓ (Byear, Carrid, Connid 저장)
[도넛차트 클릭]
↓
selectData → data["좌석등급"] 값 추출
↓
Filter (Byear, Carrid, Connid, Class)
↓
[바차트 생성]

```
