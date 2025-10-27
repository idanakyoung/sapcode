
# ✨✨ Lesson 4 — UI5 실습 기록 템플릿

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

<img width="1917" height="907" alt="image" src="https://github.com/user-attachments/assets/3147a55d-67cd-463c-9691-3e3b317ff1f6" />


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

<img width="1920" height="900" alt="image" src="https://github.com/user-attachments/assets/b68b45a4-b7e3-474c-9897-fd80dbbdc2ea" />


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
## 4-3: 가격 할인 계산기 (SAPUI5)
1. 목표
입력받은 가격과 할인율을 바탕으로 실제 할인된 가격을 계산하고, 결과를 화면에 표시하는 SAPUI5 애플리케이션을 구현합니다.

2. 주요 기능
가격 입력: 사용자가 원본 가격을 입력합니다.

할인율 입력: 사용자가 할인율(0-100 사이의 숫자)을 입력합니다.

계산 버튼: '계산' 버튼을 클릭하면 할인된 가격을 계산합니다.

결과 표시: 계산된 '실가격'을 비활성화된 입력 필드에 표시합니다.

유효성 검사:

가격 또는 할인율이 비어있는지 확인합니다.

입력값이 숫자인지 확인합니다.

할인율이 0과 100 사이의 값인지 확인합니다.

결과 알림: 계산 완료 후 MessageBox를 통해 할인된 가격을 사용자에게 알립니다.

3. 코드 분석
3.1. 뷰 (View - Main.view.xml)
XML 뷰는 사용자 인터페이스(UI)를 정의합니다. sap.m 라이브러리의 컨트롤을 사용합니다.

XML

<mvc:View controllerName="code.quiz03.controller.Main"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns="sap.m">
    <Page id="page" title="{i18n>title}">
        <VBox class="sapUiSmallMargin">
            <Label id="idlblPrice" text="가격" />
            <Input id="idInpPrice" />

            <Label id="idlblDis" text="할인율" />
            <Input id="idInpDis" />

            <Button id="idBtnSubmit"
                    text="계산"
                    press=".onSubmit"  class="sapUiSmallMarginBottom" />

            <Label id="idlblToTal" text="실가격" />
            <Input id="idInpToTal" value="" editable="false" /> </VBox>
    </Page>
</mvc:View>
핵심 포인트:

VBox: 컨트롤을 수직으로 정렬합니다.

Label: 입력 필드에 대한 설명을 제공합니다.

Input: 사용자로부터 값을 입력받거나(가격, 할인율) 결과를 표시(실가격)합니다.

idInpToTal은 editable="false"로 설정되어 사용자가 직접 수정할 수 없습니다.

Button: '계산' 동작을 트리거합니다.

press=".onSubmit": 버튼을 누르면 Main.controller.js의 onSubmit 함수가 실행됨을 의미합니다.

3.2. 컨트롤러 (Controller - Main.controller.js)
컨트롤러는 뷰의 동작과 로직을 처리합니다.

JavaScript

sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox" // MessageBox 사용을 위해 모듈 추가
], function (Controller, MessageBox) {
    "use strict";

    return Controller.extend("code.quiz03.controller.Main", {
        
        onInit() {
            // 뷰가 초기화될 때 실행되는 함수 (현재는 비어있음)
        },

        onSubmit : function() {
            // 1. 뷰에서 ID를 이용해 입력 컨트롤 값을 가져옴
            var price = this.byId("idInpPrice").getValue();
            var DisCountRate = this.byId("idInpDis").getValue();
            var result;

            // 2. 유효성 검사 (입력값이 비었는지 확인)
            if (price === "" || DisCountRate === "") {
                MessageBox.error("가격과 할인율을 모두 입력하세요.");
                return; // 함수 종료
            }

            // 3. 유효성 검사 (숫자 여부 확인)
            // isNaN() : "Is Not a Number?" -> 숫자가 아니면 true 반환
            if (isNaN(price) || isNaN(DisCountRate)) {
                MessageBox.error("가격이나 할인율에 유효한 숫자 값을 입력하세요.");
                return; // 함수 종료
            }

            // 4. 유효성 검사 (할인율 범위: 0 ~ 100)
            if (DisCountRate < 0 || DisCountRate > 100) {
                MessageBox.error("할인율은 0과 100 사이의 값을 입력하세요.");
                return; // 함수 종료
            }

            // 5. 실가격 계산 (JavaScript는 문자열로 값을 가져오므로 계산 시 숫자로 자동 형변환됨)
            // 공식: 실가격 = 원가 * (1 - 할인율/100)
            result = price * (1 - DisCountRate / 100);

            // 6. 결과 표시
            // "idInpToTal" ID를 가진 Input 컨트롤에 계산된 'result' 값을 설정
            this.byId("idInpToTal").setValue(result);

            // 7. MessageBox로 결과 알림
            MessageBox.show("할인 적용 후 가격은 " + result + "원 입니다.", {
                title: "할인 계산 결과",
                icon: MessageBox.Icon.INFORMATION,
                actions: [MessageBox.Action.OK],
                emphasizedAction: MessageBox.Action.OK
            });
        }
    });
});
핵심 포인트:

sap.ui.define: 컨트롤러가 의존하는 모듈(Controller, MessageBox)을 정의합니다.

this.byId("..."): 뷰(XML)에 정의된 컨트롤의 ID를 이용해 해당 컨트롤 객체에 접근합니다.

.getValue(): Input 컨트롤에 입력된 값을 문자열(String) 형태로 가져옵니다.

유효성 검사 (Validation):

빈 값 체크: "" (빈 문자열)인지 확인합니다.

숫자 체크: isNaN() (Is Not a Number) 함수를 사용해 숫자로 변환 가능한 값인지 확인합니다.

범위 체크: 할인율이 0 미만이거나 100 초과인지 확인합니다.

return;: 유효성 검사에 실패하면 MessageBox를 띄우고 onSubmit 함수를 즉시 종료하여 더 이상 계산 로직이 실행되지 않도록 합니다.

계산 로직: result = price * (1 - DisCountRate / 100);

getValue()로 가져온 값은 문자열이지만, 사칙연산(*, /, -)을 만나면 JavaScript가 자동으로 숫자(Number) 타입으로 변환하여 계산합니다.

.setValue(result): Input 컨트롤에 계산된 result 값을 설정하여 화면에 표시합니다.

MessageBox.show(...): 사용자에게 계산 결과를 팝업창으로 보여줍니다.

4. 실행 흐름 (요약)
사용자가 '가격'과 '할인율'을 입력한다.

사용자가 '계산' 버튼을 누른다 (press=".onSubmit").

Main.controller.js의 onSubmit 함수가 실행된다.

컨트롤러가 byId로 '가격'(idInpPrice)과 '할인율'(idInpDis) 입력 필드의 값을 가져온다 (getValue).

[유효성 검사]

값이 비어있으면 MessageBox.error 표시 후 종료.

값이 숫자가 아니면 MessageBox.error 표시 후 종료.

할인율이 0~100 범위 밖이면 MessageBox.error 표시 후 종료.

[계산]

price * (1 - DisCountRate / 100) 공식을 통해 result 값을 계산한다.

[결과 표시]

byId로 '실가격'(idInpToTal) 입력 필드를 찾아 setValue(result)로 값을 설정한다.

MessageBox.show로 계산 결과를 팝업으로 알려준다.
---
