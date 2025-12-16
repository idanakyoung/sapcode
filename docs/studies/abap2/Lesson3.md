# 🧭 Lesson 3 – Screen Program (3)

---

## 🔵 Unit 1. Simple Screen Elements

---

## 1. Icons

### 1-1. Screen Painter 설정 흐름

```
Screen Layout
 → Icon 생성
 → Icon Field 이름 지정 (예: ICON_1, ICON_2, ICON_3)
 → Output Only 설정

```

---

### 1-2. TOP Include – 아이콘 변수 선언

```abap
DATA: icon_1 TYPE icons-text,
      icon_2 TYPE icons-text,
      icon_3 TYPE icons-text.

```

- Screen Icon Field 이름과 **변수 이름 동일**해야 자동 연결됨
- 타입은 반드시 `icons-text`
- 길이는 132 권장 (아이콘 + 텍스트용)

---

### 1-3. PBO Flow Logic

```abap
PROCESS BEFORE OUTPUT.
  MODULE set_icon.

```

---

### 1-4. Icon 생성 모듈 (PBO)

```abap
MODULE set_icon OUTPUT.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = 'ICON_GREEN_LIGHT'
      text   = 'Status_1'
    IMPORTING
      result = icon_1.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = 'ICON_YELLOW_LIGHT'
      text   = 'Status_2'
    IMPORTING
      result = icon_2.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = 'ICON_RED_LIGHT'
      text   = 'Status_3'
    IMPORTING
      result = icon_3.

ENDMODULE.

```

---

### 1-5. 동작 요약

```
- PBO 때 아이콘 생성
- 아이콘 + 텍스트 함께 표시 가능
- 조건에 따라 ICON 이름만 바꾸면 상태 표현 가능

```

---

## 2. Group Box

### 특징 요약

```
- 화면 요소를 시각적으로 묶는 레이아웃 요소
- 프로그래밍 로직에는 영향 없음
- 기존 요소 위에 덮어도 되고, 먼저 만들고 안에 배치해도 됨

```

---

## 3. Input / Output Field

---

### 3-1. List Box (Drop Down)

```
- Input Field 속성에서 List Box 선택
- 반드시 Search Help 연결 필요

```

### List Box with Key

```
- Key + Text 같이 표시
- PK 기반 선택에 적합

```

---

## 4. Check Box & Radio Button

---

### 핵심 규칙 요약

```
- Check Box : 다중 선택 가능
- Radio Button : 단일 선택 (그룹 필수)
- 선택된 항목만 'X' 값
- Radio Button은 그룹당 Fct Code 1개
- Check Box는 각각 Fct Code 가질 수 있음

```

---

### Screen Painter 설정 흐름

```
1) Check Box / Radio Button 생성
2) Radio Button → 여러 개 선택 후 Group 정의
3) Variable에 TOP 변수 연결
4) 기본 선택값 'X' 설정

```

⚠️ **Radio Button 그룹에 기본값 여러 개 주면 DUMP 발생**

---

### TOP Include 변수 선언

```abap
DATA: chk_all TYPE c LENGTH 1,
      rbg_dis TYPE c LENGTH 1 VALUE 'X',
      rbg_chg TYPE c LENGTH 1,
      rbg_crt TYPE c LENGTH 1.

```

---

### PAI가 안 타는 이유 (중요)

```
Fct Code 미지정 시
→ 클릭해도 OK_CODE 세팅 안 됨
→ PAI 실행 안 됨

```

---

### Fct Code 설정

```
Radio Button 중 하나에 Fct Code = 'RBTN'
(Check Box는 각자 가능)

```

---

### PAI – User Command 처리

```abap
CASE ok_code.

  WHEN 'ALL'.
    IF chk_all = 'X'.
      " 전체 선택 처리
    ENDIF.

  WHEN 'RBTN'.
    CASE 'X'.
      WHEN rbg_dis.
        " Display 모드
      WHEN rbg_chg.
        " Change 모드
      WHEN rbg_crt.
        " Create 모드
    ENDCASE.

ENDCASE.

```

---

## Exercise 5. Radio Button (SAPMZBC410_SOLUTION_G01)

---

### 목표

```
라디오 버튼 선택에 따라
- Title 변경
- 입력 필드 활성/비활성 제어

```

---

### Screen 설정

```
Radio Button 3개 생성
 → VIEW / Maintain Flight / Maintain Bookings
 → Group으로 묶기
 → Fct Code = MODE

```

---

### TOP Include

```abap
DATA: view TYPE c LENGTH 1 VALUE 'X',
      maintain_flights TYPE c LENGTH 1,
      maintain_bookings TYPE c LENGTH 1.

```

---

### STATUS_0100 (PBO) – Title 제어

```abap
CASE 'X'.
  WHEN view.
    SET TITLEBAR 'TITLE_0100' WITH 'DISPLAY'.
  WHEN maintain_flights.
    SET TITLEBAR 'TITLE_0100' WITH 'Maintain Flight'.
  WHEN maintain_bookings.
    SET TITLEBAR 'TITLE_0100' WITH 'Maintain Bookings'.
ENDCASE.

```

---

### MODIFY_SCREEN (PBO) – 입력 필드 제어

```abap
MODULE modify_screen OUTPUT.

  IF maintain_flights = 'X'.
    LOOP AT screen.
      IF screen-name = 'SDYN_CONN-PLANETYPE'.
        screen-input = 1.
        MODIFY screen.
      ENDIF.
    ENDLOOP.
  ENDIF.

ENDMODULE.

```

📌 PBO는 매번 실행되므로

다른 모드 선택 시 **기본 Screen Painter 속성으로 자동 복귀**

---

## 🔵 Unit 2. Screen Error Handling

---

## 1. Message Type = Screen Flow Control

| Type | 의미 | 화면 동작 |
| --- | --- | --- |
| A | Termination | 프로그램 종료 |
| X | Exit | Dump |
| E | Error | 화면 유지 + 재입력 |
| W | Warning | 경고 후 계속 |
| I | Information | 확인 후 계속 |
| S | Success | 정상 진행 |

---

## 2. Automatic Field Input Checks

```
PAI 실행 전에 SAP가 자동 검사

```

### 종류

```
- Mandatory (필수)
- Field Format
- Fixed Values
- Foreign Key

```

→ 실패 시 **PAI 진입 안 됨**

---

## 3. FIELD 단위 에러 처리

### Flow Logic

```abap
PROCESS AFTER INPUT.
  FIELD sdyn_conn-airpfrom MODULE check_airpfrom.

```

### Module

```abap
MODULE check_airpfrom INPUT.
  IF sdyn_conn-airpfrom IS INITIAL.
    MESSAGE e001(zmsg).
  ENDIF.
ENDMODULE.

```

---

## 4. CHAIN / ENDCHAIN

### Flow Logic

```abap
CHAIN.
  FIELD sdyn_conn-airpfrom.
  FIELD sdyn_conn-airpto.
  MODULE check_airport ON CHAIN-REQUEST.
ENDCHAIN.

```

### 규칙

```
- 묶인 필드 중 하나라도 변경 → MODULE 실행
- 조합 검증에 사용

```

---

## 5. ON INPUT vs ON REQUEST

```
ON INPUT   : PAI 때마다 실행
ON REQUEST : 해당 필드가 실제로 변경됐을 때만 실행

```

---

## 6. AT EXIT-COMMAND

### PAI Flow Logic

```abap
MODULE exit AT EXIT-COMMAND.

```

### 특징

```
- Mandatory Field 무시
- Cancel / Exit 버튼 처리 전용

```

---

### EXIT Module 예시

```abap
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'CANCEL'.
      CLEAR wa_sflight.
      SET PARAMETER ID 'CAR' FIELD sdyn_conn-carrid.
      SET PARAMETER ID 'CON' FIELD sdyn_conn-connid.
      SET PARAMETER ID 'DAY' FIELD sdyn_conn-fldate.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

```

---

## 7. Confirm Popup

```abap
CALL FUNCTION 'POPUP_TO_CONFIRM'
  EXPORTING
    titlebar = '프로그램 종료'
    text_question = '종료하시겠습니까?'
  IMPORTING
    answer = gv_answer.

IF gv_answer = '1'.
  LEAVE PROGRAM.
ENDIF.

```

---

## Exercise 6. Error Handling

---

### LOAD-OF-PROGRAM

```abap
LOAD-OF-PROGRAM.

GET PARAMETER ID:
  'CAR' FIELD sdyn_conn-carrid,
  'CON' FIELD sdyn_conn-connid,
  'DAY' FIELD sdyn_conn-fldate.

SELECT SINGLE *
  FROM sflight
  INTO wa_sflight
  WHERE carrid = sdyn_conn-carrid
    AND connid = sdyn_conn-connid
    AND fldate = sdyn_conn-fldate.

```

---

### CHECK_SFLIGHT (PAI)

```abap
CHECK sy-subrc = 0.

CLEAR wa_sflight.
MESSAGE e001(zmsg).

```

---

### CHAIN 1 – Key 필드 검증

```abap
CHAIN.
  FIELD sdyn_conn-carrid.
  FIELD sdyn_conn-connid.
  FIELD sdyn_conn-fldate.
  MODULE check_sflight ON CHAIN-REQUEST.
ENDCHAIN.

```

---

### CHAIN 2 – 기종 / 좌석 검증

```abap
CHAIN.
  FIELD sdyn_conn-planetype.
  FIELD sdyn_conn-seatsmax.
  MODULE check_planetype.
ENDCHAIN.

```

```abap
MODULE check_planetype INPUT.

  IF sdyn_conn-planetype IS INITIAL.
    MESSAGE e109(zmsg).
  ENDIF.

  SELECT SINGLE seatsmax
    FROM saplane
    INTO sdyn_conn-seatsmax
    WHERE planetype = sdyn_conn-planetype.

  IF sdyn_conn-seatsocc > sdyn_conn-seatsmax.
    MESSAGE e109(zmsg).
  ENDIF.

  MOVE-CORRESPONDING sdyn_conn TO wa_sflight.

ENDMODULE.

```

---

## 최종 한 줄 요약
```abap
Lesson 3는
“화면 요소 제어 + 사용자 입력 오류를 친절하게 막는 법”이다.
```
