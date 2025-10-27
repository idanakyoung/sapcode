✨ Lesson 4 — UI5 실습 기록 템플릿
---

## 🗂 목차

- 4-1. 원의 둘레 구하기
    - 학습 목표 / 핵심 포인트 / 코드 / 동작 순서 / **예상 화면** / 테스트 시나리오 / 확장 아이디어
- 4-2. 사칙연산 프로그램 만들기
    - 학습 목표 / 핵심 포인트 / 코드 / 동작 순서 / **예상 화면** / 테스트 시나리오 / 확장 아이디어

---

## 🔵 4-1. 원의 둘레 구하기 (Calculate Circle Circumference)

### 🎯 학습 목표

- 사용자 입력을 받아 **원의 둘레(2πr)** 계산
- Controller ↔ View 이벤트 바인딩 이해
- `sap.m.MessageBox`로 결과 표시

### 🧠 핵심 포인트 (요약표)

| 항목 | 내용 |
| --- | --- |
| 입력 | `sap.m.Input`으로 반지름 값 입력 (`idInpidradius`) |
| 처리 | Controller `onSubmit()`에서 `parseFloat` 변환, 유효성 검사, 계산 |
| 출력 | `MessageBox.show()`로 결과 표시 |
| 검증 | `isNaN(r)`인 경우 에러 메시지 |
| 연결 | View `press=".onSubmit"` → Controller 함수 호출 |

### 🧩 코드 (복습용 원본)

**Controller — `code.quiz01.controller.Main`**

```jsx
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/m/MessageBox"
], function (Controller, MessageBox) {
  "use strict";

  return Controller.extend("code.quiz01.controller.Main", {
    onInit: function () {},

    onSubmit: function () {
      var r = parseFloat(this.byId("idInpidradius").getValue());
      if (isNaN(r)) {
        MessageBox.error("반지름 값을 올바르게 입력하세요.");
        return;
      }
      var circumference = 2 * Math.PI * r;
      var total = "원의 둘레는 " + circumference.toFixed(2) + " 입니다.";
      MessageBox.show(total, {
        title: "Total Display Message Box",
        icon: MessageBox.Icon.INFORMATION,
        actions: [MessageBox.Action.OK],
        emphasizedAction: MessageBox.Action.OK
      });
    }
  });
});

```

**View — `Main.view.xml`**

```xml
<mvc:View controllerName="code.quiz01.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
      <Label id="idlblradius" text="반지름의 길이" />
      <Input id="idInpidradius" />
      <Button id="idBtnSubmit" text="원의 둘레 계산" press=".onSubmit" />
    </Page>
</mvc:View>

```

### 🧭 동작 순서

1. 사용자가 반지름 입력 → 2) 버튼 클릭 → 3) 숫자 유효성 검사 → 4) `2 * Math.PI * r` 계산 → 5) MessageBox 표시

### 🖥 예상 화면 (와이어프레임)

> 실제 UI5 런타임에서 보이는 구조를 텍스트로 그린 모형입니다. 노션에서 이미지 블록으로 캡처 추가해도 좋습니다.
> 

```
┌──────────────────────────────────────────────┐
│  Lesson 4-1: 원의 둘레 구하기                │  (Page title)
├──────────────────────────────────────────────┤
│  반지름의 길이                                │  (Label)
│  [          10           ]                    │  (Input: idInpidradius)
│                                              │
│  [   원의 둘레 계산   ]                       │  (Button: press=.onSubmit)
└──────────────────────────────────────────────┘

(버튼 클릭 후)
┌──────────────── MessageBox ────────────────┐
│  ℹ Total Display Message Box               │
│  원의 둘레는 62.83 입니다.                 │
│                                            │
│                    [   OK   ]              │
└────────────────────────────────────────────┘

```

### ✅ 테스트 시나리오

| 케이스 | 입력 r | 기대 결과 |
| --- | --- | --- |
| 정상 | 10 | "원의 둘레는 62.83 입니다." |
| 경계 | 0 | "원의 둘레는 0.00 입니다." |
| 소수 | 2.5 | "15.71" (소수점 2자리 반올림) |
| 오류 | 공백/문자 | MessageBox.error("반지름 값을 올바르게 입력하세요.") |

### 🛠 확장 아이디어

- `Input type="Number" min="0" placeholder="예: 10"`로 UX 개선
- 결과를 `MessageToast.show()`로 간단히 표시하는 옵션 추가
- 둘레/면적 토글 스위치(둘레=2πr, 면적=πr²) 탭 구성

---

## 🟣 4-2. 사칙연산 프로그램 만들기 (Basic Arithmetic Calculator)

### 🎯 학습 목표

- 숫자 2개 + 연산자 입력으로 **사칙연산** 수행
- 유효성 검사(숫자/연산자/0으로 나누기)와 예외 처리
- MessageBox로 결과 표시

### 🧠 핵심 포인트 (요약표)

| 항목 | 내용 |
| --- | --- |
| 입력 | `idInpFInt`, `idInpOp`, `idInpSInt` |
| 처리 | `parseFloat` 변환 후 `switch`로 연산 분기 |
| 검증 | `isNaN`, 연산자 포함 여부(`['+','-','*','/'].includes(op)`), 분모 0 |
| 출력 | `MessageBox.show("최종 값은 X 입니다.")` |

### 🧩 코드 (복습용 원본)

**Controller — `quiz02.controller.Main`**

```jsx
sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], function (Controller,MessageBox) {
    "use strict";

    return Controller.extend("quiz02.controller.Main", {
        onInit() {},
        onSubmit : function () {
           var firstValue = this.byId("idInpFInt").getValue();
            var operation = this.byId("idInpOp").getValue().trim();
            var secondValue = this.byId("idInpSInt").getValue();
            var first = parseFloat(firstValue);
            var second = parseFloat(secondValue);
            var result;

            if (isNaN(first) || isNaN(second)) {
                MessageBox.error("숫자1과 숫자2에 유효한 숫자 값을 입력하세요.");
                return;
            }
            if (!['+', '-', '*', '/'].includes(operation)) {
                MessageBox.error("연산자 기호(+, -, *, /)를 올바르게 입력하세요.");
                return;
            }
            switch (operation) {
                case '+': result = first + second; break;
                case '-': result = first - second; break;
                case '*': result = first * second; break;
                case '/':
                    if (second === 0) {
                        MessageBox.error("0으로 나눌 수 없습니다.");
                        return;
                    }
                    result = first / second; break;
                default:
                    MessageBox.error("올바르지 않은 연산자입니다.");
                    return;
            }

            var total = "최종 값은 " + result + " 입니다.";
            MessageBox.show(total, {
                title: "Total Display Message Box",
                icon: MessageBox.Icon.INFORMATION,
                actions: [MessageBox.Action.OK],
                emphasizedAction: MessageBox.Action.OK
            });
        }
    });
});

```

**View — `Main.view.xml`**

```xml
<mvc:View controllerName="code.quiz0201.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
        <Label id="idlblFInt" text="숫자1" />
        <Input id="idInpFInt" />
        <Label id="idlblOp" text="연산자(+,-,*,/)" />
        <Input id="idInpOp" />
        <Label id="idlbSInt" text="숫자2" />
        <Input id="idInpSInt" />
        <Button id="idBtnSubmit" text="계산" press=".onSubmit" />
    </Page>
</mvc:View>

```

### 🧭 동작 순서

1. 숫자1/연산자/숫자2 입력 → 2) 버튼 클릭 → 3) 숫자/연산자 유효성 검사 → 4) `switch` 연산 → 5) MessageBox 표시

### 🖥 예상 화면 (와이어프레임)

```
┌──────────────────────────────────────────────┐
│  Lesson 4-2: 사칙연산 계산기                  │
├──────────────────────────────────────────────┤
│  숫자1                                        │
│  [         12           ]  (idInpFInt)        │
│                                               │
│  연산자(+,-,*,/)                               │
│  [     +     ]           (idInpOp)             │
│                                               │
│  숫자2                                        │
│  [          8           ]  (idInpSInt)         │
│                                               │
│  [        계산         ]  (press=.onSubmit)    │
└──────────────────────────────────────────────┘

(버튼 클릭 후)
┌──────────────── MessageBox ────────────────┐
│  ℹ Total Display Message Box               │
│  최종 값은 20 입니다.                      │
│                                            │
│                    [   OK   ]              │
└────────────────────────────────────────────┘

```

### ✅ 테스트 시나리오

| 케이스 | 숫자1 | 연산자 | 숫자2 | 기대 결과 |
| --- | --- | --- | --- | --- |
| 더하기 | 12 | + | 8 | 20 |
| 빼기 | 10 | - | 30 | -20 |
| 곱하기 | 2.5 | * | 4 | 10 |
| 나누기 | 7 | / | 2 | 3.5 |
| 오류 — 숫자 | 공백 | + | 1 | 숫자 유효성 오류 |
| 오류 — 연산자 | 1 | x | 1 | 연산자 유효성 오류 |
| 오류 — 0 나누기 | 9 | / | 0 | "0으로 나눌 수 없습니다." |

### 🛠 확장 아이디어

- `Input type="Number"`와 `placeholder`로 안내 강화 (예: "예: 12")
- 연산자 입력을 `Select`/`SegmentedButton` 으로 변경하여 오타 제거
- 결과를 화면 내 `Text` 컨트롤로도 표시(이력 리스트 형태로 누적)

---

## 🧪 공통 품질 체크리스트

- [ ]  컨트롤러 네임스페이스와 View `controllerName` 일치 확인
- [ ]  이벤트 바인딩: `press=".onSubmit"` 오타 여부 확인
- [ ]  숫자 입력은 `parseFloat` 사용, `isNaN` 검사
- [ ]  에러 메시지는 한국어로 명확하게 안내
- [ ]  계산 결과는 반올림/표시 형식(toFixed 등) 일관성 유지

## 🧠 자주 틀리는 포인트 메모

```
- Input 값은 문자열로 들어오므로 숫자 변환 필수
- 공백 제거: 연산자는 `.trim()` 사용
- 나눗셈 분모는 0 검증 필수
- MessageBox와 MessageToast 용도 차이 숙지

```

## ✨ 보너스: UX 개선 예시 스니펫

```xml
<!-- 숫자 전용 + 안내문 + 최소값 예시 -->
<Input id="idInpidradius" type="Number" min="0" placeholder="예: 10" />
<Input id="idInpFInt" type="Number" placeholder="예: 12" />
<Input id="idInpOp" placeholder="+, -, *, / 중 선택" />
<Input id="idInpSInt" type="Number" placeholder="예: 8" />

```

```jsx
// 결과를 화면의 Text로도 표시하고 싶을 때 (예: 히스토리 누적)
var s = this.byId("idResultText");
if (s) {
  s.setText(total);
}

```

---
