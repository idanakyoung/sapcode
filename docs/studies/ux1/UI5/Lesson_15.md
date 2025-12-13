# 🧾 Lesson 15 - **SAPUI5 과제 4 요약 (Notion용)**

## 📏 CSS 단위 간 관계표 (기준: 브라우저 기본 설정 1rem = 16px)

---

| 단위 | 기준 | 픽셀(px)로 환산 | 비고 |
| --- | --- | --- | --- |
| **1px** | 화면의 1픽셀 | `1px` | 절대 단위 |
| **1rem** | 루트(html)의 font-size (기본 16px) | `16px` | 전체 앱의 기준 단위 |
| **1em** | 현재 요소의 font-size | `보통 16px` (부모가 16px일 때) | 부모 폰트 크기 따라 변함 |
| **1%** | 부모 요소의 크기 | 부모 width의 1% | 반응형 단위 |

## 🧩 Margin 관련 클래스 목록

---

가끔 심플 폼이나 HBox와 VBox가 같이 사용되거나 여러 레이아웃이 겹칠 때 클래스를 지정하더라도 무시될 수 있음 

| 클래스 이름 | 설명 | 적용 방향 |
| --- | --- | --- |
| `sapUiTinyMargin` | 매우 작은 여백 (4px) | 모든 방향 |
| `sapUiTinyMarginBegin` | 왼쪽(시작) 여백 4px | LTR 언어에선 왼쪽 |
| `sapUiTinyMarginEnd` | 오른쪽(끝) 여백 4px | LTR 언어에선 오른쪽 |
| `sapUiTinyMarginTop` | 위쪽 여백 4px |  |
| `sapUiTinyMarginBottom` | 아래쪽 여백 4px |  |

## 🧾 과제 요구사항

---

![image.png](attachment:d9a29b7d-bfd5-46d5-acbf-2304d34063e1:image.png)

## 🧾 과제 결과창

---

![image.png](attachment:f613a648-2703-4cc4-a9b1-855c9bae7487:image.png)

## 🧾 과제 요약 : 라디오 선택으로 상세 자동 채움

### 목표

- 조원 테이블 한 컬럼을 **라디오버튼**으로 만들고 단일 선택.
- 선택 시 하단 **조 / 학번·이름 / 과정명·점수** 자동 표시.
- 라디오 체크 상태가 **다시 그려져도 유지**.

---

### 데이터/모델 구성

- **기본(OData) 모델**
    - `/esTeamDetailSet` : 조원 목록 (TEAMNO, STDNO, STDNM …)
    - `/esTeamScoreSet` : 점수 목록 (STDNO, UNIT, SCORE …)
- **로컬(JSON) 모델**
    - `"gData"` : 콤보박스용 (조 선택)
    - `"ui"` : 화면 상태 유지
        
        ```json
        {
          "selected": {},        // 선택된 조원 객체(TEAMNO, STDNO, STDNM…)
          "selectedSTDNO": null  // 라디오 selected와 동기화할 키
        }
        
        ```
        

> 주의
> 
> - `gData`는 한 번만 setModel 하세요(중복 제거).
> - “6조” 코드 중복은 `"006"`으로 수정.

---

### 핵심 Tip ①: 라디오버튼 **선택 상태 동기화**

```xml
<RadioButtongroupName="memberPick"
  select=".onMemberPicked"
  selected="{= ${ui>/selectedSTDNO} === ${STDNO} }"/>

```

- `selected`를 **식(Expression) 바인딩**으로 설정.
- `ui>/selectedSTDNO`(상태)와 현재 행의 `STDNO`가 같으면 체크됨.
- 컨트롤러에서 `ui>/selectedSTDNO`만 바꿔주면, 라디오가 **자동으로 체크/해제**.

---

### 핵심 Tip ②: 라벨/인풋 **경로 바인딩**

- 하단 표시 영역은 **행 컨텍스트에 의존 X**.
- 항상 화면 상태 모델 `ui`의 값을 바인딩.

```xml
<!-- 조 -->
<Input value="{ui>/selected/TEAMNO}" editable="false"/>

<!-- 학번 / 이름 -->
<Input value="{
  parts: [{path:'ui>/selected/STDNO'}, {path:'ui>/selected/STDNM'}],
  formatter: '.fmtStudent'
}" editable="false"/>

```

---

### 전체 동작 흐름

1. 사용자가 콤보박스로 조 선택 → **Search 클릭**
    - `/esTeamDetailSet`을 `TEAMNO = 선택조`로 필터.
    - 하단 점수 테이블 필터/선택 상태 초기화.
2. 조원 테이블에서 **라디오 선택**
    - 선택된 행 컨텍스트에서 `TEAMNO, STDNO, STDNM` 읽음.
    - `ui>/selected`와 `ui>/selectedSTDNO` 갱신 → 하단 인풋 + 라디오 selected 즉시 반영.
    - `/esTeamScoreSet`을 `STDNO = 선택학번`으로 필터 → 점수 테이블 갱신.

---

### XML View (발췌: 핵심 부분만)

```xml
<!-- 조원 테이블 -->
<Table id="idTab1" items="{/esTeamDetailSet}" growing="true" growingThreshold="3">
  <columns>
    <Column hAlign="Center" width="7rem"><Text text="선택"/></Column>
    <Column><header><Text text="조"/></header></Column>
    <Column><header><Text text="학번"/></header></Column>
    <Column><header><Text text="이름"/></header></Column>
  </columns>

  <items>
    <ColumnListItem type="Inactive">
      <cells>
        <RadioButtongroupName="memberPick"
          select=".onMemberPicked"
          selected="{= ${ui>/selectedSTDNO} === ${STDNO} }"/>
        <Text text="{TEAMNO}"/>
        <Text text="{STDNO}"/>
        <Text text="{STDNM}"/>
      </cells>
    </ColumnListItem>
  </items>
</Table>

<!-- 하단 상세 표시 -->
<Input value="{ui>/selected/TEAMNO}" editable="false"/>

<Input value="{
  parts: [{path:'ui>/selected/STDNO'}, {path:'ui>/selected/STDNM'}],
  formatter: '.fmtStudent'
}" editable="false"/>

<!-- 점수 테이블 -->
<Table id="idTab2" items="{/esTeamScoreSet}" growing="true" growingThreshold="3">
  <columns>
    <Column><header><Text text="과정명"/></header></Column>
    <Column><header><Text text="점수"/></header></Column>
  </columns>
  <items>
    <ColumnListItem type="Inactive">
      <cells>
        <Text text="{UNIT}"/>
        <Text text="{SCORE}"/>
      </cells>
    </ColumnListItem>
  </items>
</Table>

```

---

### Controller (전체 흐름 보이는 최소 구현)

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sap/m/MessageToast"
], (Controller, JSONModel, Filter, FilterOperator, MessageToast) => {
  "use strict";

  return Controller.extend("code.zn0102last.controller.Main", {
    onInit() {
      // 콤보박스용 로컬 모델
      this.getView().setModel(new JSONModel({
        stu: [
          { gCode: "001", gName: "1조" },
          { gCode: "002", gName: "2조" },
          { gCode: "003", gName: "3조" },
          { gCode: "004", gName: "4조" },
          { gCode: "005", gName: "5조" },
          { gCode: "006", gName: "6조" } // ← 중복코드 수정
        ]
      }), "gData");

      // 화면 상태 모델(UI)
      this.getView().setModel(new JSONModel({
        selected: {},         // { TEAMNO, STDNO, STDNM, ... }
        selectedSTDNO: null   // 라디오 selected 동기화
      }), "ui");
    },

    onSearch() {
      const key = this.byId("idComboBox").getSelectedKey();
      if (!key) { MessageToast.show("조를 선택하세요"); return; }

      // 조원 테이블 필터
      const memberBind = this.byId("idTab1").getBinding("items");
      memberBind && memberBind.filter([ new Filter("TEAMNO", FilterOperator.EQ, key) ]);

      // 점수 테이블, 선택 상태 초기화
      const scoreBind = this.byId("idTab2").getBinding("items");
      scoreBind && scoreBind.filter([]);
      this.getView().getModel("ui").setData({ selected:{}, selectedSTDNO:null });
    },

    onMemberPicked(oEvent) {
      // 기본 모델 컨텍스트(모델명 지정 X)
      const ctx = oEvent.getSource().getBindingContext();
      if (!ctx) return;

      const TEAMNO = ctx.getProperty("TEAMNO");
      const STDNO  = ctx.getProperty("STDNO");
      const STDNM  = ctx.getProperty("STDNM");

      // 1) UI 상태 갱신 → 하단 인풋 & 라디오 selected 동기화
      const ui = this.getView().getModel("ui");
      ui.setProperty("/selected", { TEAMNO, STDNO, STDNM });
      ui.setProperty("/selectedSTDNO", STDNO);

      // 2) 점수 테이블 필터링(STDNO 기준)
      const scoreBind = this.byId("idTab2").getBinding("items");
      scoreBind && scoreBind.filter([ new Filter("STDNO", FilterOperator.EQ, STDNO) ]);
    },

    // 학번/이름 표기
    fmtStudent(no, nm) {
      if (!no && !nm) return "null / null";
      return (no || "") + " / " + (nm || "");
    }
  });
});

```

---
