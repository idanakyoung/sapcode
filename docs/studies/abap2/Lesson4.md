# 🧭 Lesson 4 - Screen Program (4)

## 1) 원하는 요소들 HIDDEN 처리 (PF-STATUS EXCLUDING)

### 개념

- **숨기고 싶은 Function Code**들을 Internal Table에 모아두고
- `SET PF-STATUS ... EXCLUDING itab`으로 해당 기능을 UI에서 제거

### 목표

유지보수 모드면 버튼 전부 비활성화를 위해서 **숨기고 싶은 FUNCTION CODE 모을** 변수 선언

- PBO에서 버튼(기능)을 상황에 따라 숨기기(Disable) 처리
- Subscreen / Tabstrip 핵심 흐름 이해
- Local Scrolling vs PAI Scrolling 구분

### 왜 Internal Table을 쓰나?

- PBO는 화면을 다시 그릴 때마다 반복 실행되므로
- `APPEND`를 계속하면 중복이 쌓임 → **초기 1회만 채우기**

### 흐름 시각화

```
PBO(화면 그리기)
  ├─ (1회만) 숨길 버튼 목록 gt_status 채움
  └─ SET PF-STATUS 'STATUS_0100' EXCLUDING gt_status
       -> 해당 Function Code 버튼/메뉴가 숨겨짐
```

# 🔵 Unit 1. Subscreen

## 2) Subscreen 개념

- **메인 화면**: 틀(컨테이너)
- **Subscreen**: 꽂아 넣는 부품(교체 가능한 화면)

### 핵심 규칙

- Subscreen을 쓰려면 **PBO / PAI 둘 다 `CALL SUBSCREEN` 필수**

```abap
PROCESS BEFORE OUTPUT.
  CALL SUBSCREEN sub1 INCLUDING sy-cprog '0101'.

PROCESS AFTER INPUT.
  CALL SUBSCREEN sub1.
```

### Function Group Subscreen (외부 Subscreen)

- 메인 프로그램의 전역 데이터가 **바로 공유되지 않음**
- 따라서 데이터는 **FUNCTION MODULE로 export/import**해서 넘김

```
메인 프로그램 전역데이터  <---(FM로 전달)--->  Function Group 전역데이터
```

---

## 3) Subscreen 실습 요약 (SAPMZSCREEN_G01 스타일)

### 구성 (예시)

- 메인: Screen 0100
- 서브: Screen 0110 / 0120 / 0130 (type = Subscreen)

### 작업 순서

1. 0110 생성 → Dynpro type: Subscreen → 필드 배치 → Output only 설정
2. 0120 생성 → 동일
3. 0130 생성 → 텍스트/필드 배치
4. 0100에 **Subscreen Area** 배치 (예: 이름 `SUB`)
5. 0100 Flow Logic에 `CALL SUBSCREEN SUB INCLUDING ... dynnr` 추가
6. PBO에서 `dynnr`를 모드에 따라 채우는 모듈 작성
7. PAI에도 `CALL SUBSCREEN SUB.` 추가

### Subscreen 호출 구조 시각화

```
[Screen 0100]
  ┌──────────────────────────────┐
  │  Subscreen Area: SUB          │
  │   ┌────────────────────────┐ │
  │   │ (여기에 0110/0120/0130) │ │  <- 런타임에 교체됨
  │   └────────────────────────┘ │
  └──────────────────────────────┘
```

---

## 4) DYNNR (Dynpro Number) 개념

- `DYNNR` = “어떤 화면을 끼울지” 결정하는 **화면 번호 변수**
- `CALL SUBSCREEN ... dynnr`에서 dynnr이 비면(0000) **DYNPRO_NOT_FOUND 덤프**

### 안전 패턴(중요)

```
PBO
  ├─ (1) dynnr 먼저 세팅
  └─ (2) 그 다음 CALL SUBSCREEN
```

---

## 5) Exercise 7: Subscreen (SAPMZBC410_SOLUTION_G01)

### 화면 구성

- 메인 Screen 0100 + Subscreen Area
- Subscreen Screen 0110 / 0120 / 0130 생성

### PBO 핵심 흐름

```
MOVE DB workarea -> SDYN_CONN (화면값 준비)
  ↓
FILL_DYNNR (모드에 따라 0110/0120/0130 선택)
  ↓
CALL SUBSCREEN SUB INCLUDING sy-cprog dynnr (선택된 화면 끼우기)
```

### dynnr 선택 로직(개념)

```
VIEW               -> 0110
MAINTAIN_FLIGHTS   -> 0120
MAINTAIN_BOOKINGS  -> 0130
(기본값/OTHERS)     -> 0110  (덤프 방지)
```

---

## 6) ON CHANGE OF 모듈(조회 화면 보조 데이터 채우기)

### 예: 항공편 키 변경 시 노선 정보(SPFLI) 읽어서 SDYN_CONN에 채움

```abap
ON CHANGE OF wa_sflight-carrid OR wa_sflight-connid.
  SELECT SINGLE ...
    INTO CORRESPONDING FIELDS OF sdyn_conn
    FROM spfli
    WHERE carrid = wa_sflight-carrid
      AND connid = wa_sflight-connid.
ENDON.
```

### 왜 WA_SFLIGHT 기준이냐?

- 이 모듈은 **PBO(OUTPUT)** 에서 실행되는 경우가 많고
- PBO의 정본 흐름은 `DB -> WA_* -> SDYN_* -> Screen`
- 따라서 변경 감지는 *WA_ 기준이 안정적*

---

# 🟧 Tabstrip 이론

## 7) Tabstrip = Subscreen 스위칭 UI

### 한 줄 요약

- Tabstrip은 “탭 UI”
- 내부적으로는 “**Subscreen을 갈아 끼우는 장치**”

### 기술 구조(중요)

```
[ Tabstrip ]
  ├─ Tab1 (Title=Pushbutton처럼 동작)
  ├─ Tab2
  ├─ Tab3
       ↓
[ Subscreen Area ]  (보통 1개 공유)
       ↓
[ Subscreen Screen ] (0110/0120/0130 등)
```

### 동작 흐름(핵심)

```
PAI: 탭 클릭 -> OK_CODE = 'TAB2'
  ↓
PAI: activetab = OK_CODE  (탭 상태 저장)
  ↓
PBO: activetab 보고 dynnr 결정
  ↓
PBO: CALL SUBSCREEN ... dynnr  (화면 교체)
```

---

## 8) Tabstrip 템플릿

```
(탭 상태) activetab
   ├─ 'TAB1' -> dynnr='0110' -> Subscreen 0110 표시
   ├─ 'TAB2' -> dynnr='0120' -> Subscreen 0120 표시
   └─ 'TAB3' -> dynnr='0130' -> Subscreen 0130 표시
```

> 포인트: Tabstrip은 “dynnr를 자동으로 바꿔주는 UI”일 뿐
> 
> 
> 실제 화면 전환은 `CALL SUBSCREEN`이 수행
> 

---

# 🟩 Local Scrolling vs PAI Scrolling

## 9) Local Scrolling (탭마다 Subscreen Area가 각각 있는 형태)

### 특징

- 탭 페이지마다 **자기 Subscreen Area**를 가짐
- 탭 타이틀의 Function Type이 `P`처럼 설정된 케이스로 소개되기도 함(실습 예제에 따라 다름)

### 시각화

```
Tab1 -> SubArea1 -> Subscreen 0110
Tab2 -> SubArea2 -> Subscreen 0120
Tab3 -> SubArea3 -> Subscreen 0130
```

---

## 10) PAI Scrolling (탭들이 Subscreen Area 1개를 공유)

### 특징(슬라이드 핵심)

- 탭 페이지들이 **공통 Subscreen Area**를 공유
- 탭 타이틀 Function type = **Normal(space)**
- 탭 클릭은 “명령 실행”이 아니라 “활성 탭 상태 저장”

### 시각화

```
(Tab1/Tab2/Tab3)
   ↓ (activetab만 바뀜)
[공통 Subscreen Area 1개]
   ↓ (dynnr로 교체)
Subscreen 0110/0120/0130
```

### 덤프 방지 포인트

- activetab이 비거나 매핑이 실패하면 dynnr가 초기값(0000)될 수 있음
- 따라서 **OTHERS 기본값 + activetab 기본값** 필수

---

# 최종 요약

## Subscreen

Subscreen 화면 type = Subscreen

0100에 Subscreen Area 존재(이름 확인)

PBO에 `CALL SUBSCREEN ... INCLUDING ... dynnr`

PAI에도 `CALL SUBSCREEN sub_area.`

PBO에서 dynnr는 항상 값이 들어가도록(OTHERS 처리)

## Tabstrip

탭 FCODE 값과 코드의 WHEN 값 일치

activetab 기본값 지정

activetab -> dynnr 매핑 + OTHERS 기본값

PBO에서만 화면 교체가 일어남(= CALL SUBSCREEN)
