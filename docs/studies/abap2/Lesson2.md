# 🧭 Lesson 2 – Screen Program (2)

## 🔵 Unit 1. Designing Screen Sequence

### 🌳 SAPMZSCR_G01 – Screen 이동 & Insert Screen 실습

## 1️⃣ Screen 기본 구성 및 흐름 설계

### 📌 생성한 Screen 목록

| Screen No | 설명 | Next Dynpro |
| --- | --- | --- |
| 100 | 메인 화면 | 200 |
| 200 | 중간 화면 | 300 |
| 300 | 종료 화면 | 0 |
| 150 | Popup(Dialog) 화면 | 0 |

---

### 📌 Screen 속성 설정 요약

| 항목 | 설정 |
| --- | --- |
| Short Description | 필수 입력 |
| Layout | 활성화 |
| Next Dynpro | 화면 흐름에 맞게 설정 |
| Screen Type (150) | Dialog Box |

---

## 2️⃣ Screen 이동 방식 정리

### 🔹 1. SET SCREEN + LEAVE SCREEN

```abap
SET SCREEN 300.
LEAVE SCREEN.
```

- 현재 화면 종료 후 지정 Screen으로 이동
- Next Dynpro 설정과 함께 자주 사용

---

### 🔹 2. LEAVE TO SCREEN (단축형)

```abap
LEAVE TO SCREEN 300.
```

- 위 두 줄을 한 줄로 처리
- 가장 많이 쓰는 방식

---

### 🔹 3. CALL SCREEN (Insert Screen)

```abap
CALL SCREEN 300.
```

- 현재 화면 위에 **삽입**
- 종료 시 원래 화면으로 복귀

---

## 3️⃣ Cursor 제어 & 기본값 설정 (PBO)

### 📌 Screen 100 – PBO 모듈

```abap
MODULE SET_CURSOR.
```

```abap
MODULE SET_CURSOR OUTPUT.
  SDYN_CONN-CARRID = 'UA'.
  SET CURSOR FIELD 'SDYN_CONN-CONNID'.
ENDMODULE.
```

✔ 기능

- 화면 로딩 시 기본값 설정
- 입력 커서 위치 지정

---

## 4️⃣ Popup Screen (150) 구성

### 📌 Screen 150 – 필드 설정

| 설정 항목 | 값 |
| --- | --- |
| Input | ❌ |
| Output | ⭕ |
| Purpose | 조회 전용 |

---

### 📌 데이터 조회 (PBO)

```abap
MODULE GET_CARRIER OUTPUT.
  SELECT SINGLE *
    FROM scarr
    WHERE carrid = sdyn_conn-carrid.
ENDMODULE.
```

---

### 📌 Popup 호출 (Screen 100 – PAI)

```abap
WHEN 'P'.
  CALL SCREEN 150
    STARTING AT 5 5.
```

✔ 위치 조절 가능

✔ 크기 조절 시 스크롤 발생 주의

---

## 🔵 Unit 2. SAP GUI User Interface 구성 요소

---

## 1️⃣ GUI Title

### 역할

- 화면 상단 제목 표시
- 현재 화면 상태 전달

### 개발

```abap
SET TITLEBAR 'T100' WITH sdyn_conn-connid.
```

- Title Object에서 텍스트 관리
- `&` 최대 9개 사용 가능

---

## 2️⃣ GUI Status

### 역할

- 메뉴 / 버튼 / 기능 전체 집합
- **없는 기능은 실행 불가**

### 중요 포인트

- Screen마다 Status 다름
- 프로그램 흐름 제어 핵심

---

## 3️⃣ Menu Bar

| 항목 | 설명 |
| --- | --- |
| 최대 메뉴 수 | 15 |
| Depth | 최대 3단계 |
| 텍스트 | 정적 / 동적 가능 |
| 재사용 | 가능 |

---

## 4️⃣ Standard Toolbar

- SAP 공통 기능 (Back, Exit, Save 등)
- 상황별 활성/비활성 가능

---

## 5️⃣ Application Toolbar

- 프로그램 전용 기능
- Function Code(F-code)와 연결
- 사용자 작업 속도 향상

---

## 6️⃣ Function Key (F1~F12)

| 구분 | 설명 |
| --- | --- |
| Standard | SAP 기본 |
| Reserved | 시스템 예약 |
| Free | 개발자 지정 |

화면마다 다른 F-Key 매핑 가능

---

## 7️⃣ Function Code (F Code)

### 역할

- 실행 가능한 기능의 식별자
- PAI 처리 기준

### F Type 예시

- Normal
- Exit
- System
- Transaction
- Help

---

## 8️⃣ Menu Attributes

- 메뉴 텍스트
- Fastpath
- 동적 텍스트 설정

```
예) 선택 항목 수: &1
```

---

## 🔵 GUI 실습 요약 (SAPMZSCR_G01)

---

### 📌 Screen 100 – Title 설정

```abap
MODULE STATUS_0100 OUTPUT.
  SET TITLEBAR 'T100' WITH sdyn_conn-connid.
ENDMODULE.
```

---

### 📌 Screen 150 – Title 설정

```abap
MODULE STATUS_0150 OUTPUT.
  SET TITLEBAR 'T150' WITH sdyn_conn-carrid.
ENDMODULE.
```

---

### 📌 Screen 150 – OK_CODE 처리 (PAI)

```abap
MODULE USER_COMMAND_0150 INPUT.
  CASE ok_code.
    WHEN 'OKAY'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
```

---

### 📌 Screen 100 – 기능 처리 예시

```abap
CASE ok_code.
  WHEN 'BACK'.
    LEAVE TO SCREEN 0.
  WHEN 'POPUP'.
    CALL SCREEN 150
      STARTING AT 5 5.
ENDCASE.
```

---

### ⚠️ 반드시 해야 할 것

```abap
CLEAR ok_code.
```

안 하면 버튼 중복 실행 발생

---

## 🔵 SAPMZQUIZ_S01_G01

### 🌟 DB → 화면 데이터 조회 방식 2가지

---

## 방법 ① DB → Screen 구조 (간단)

```abap
SELECT SINGLE *
  INTO scustom
  FROM scustom
 WHERE id = scustom-id.
```

### 특징

- 코드 간단
- 즉시 화면 반영
- 역할 분리 ❌

---

## 방법 ② DB → WA → Screen (정석)

```abap
* PAI
SELECT SINGLE *
  INTO wa_scustom
  FROM scustom
 WHERE id = scustom-id.

* PBO
MOVE-CORRESPONDING wa_scustom TO scustom.
```

### 특징

- DB / 화면 역할 분리
- PAI / PBO 흐름 명확
- **실무 · 시험 권장**

---

## ✅ 한 줄 요약
