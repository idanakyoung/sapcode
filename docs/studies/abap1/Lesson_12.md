# 🧭 Lesson 12 – Views / View Cluster / Search Help / Screen

---

## 0) 전체 흐름(공통 뼈대)

```
Dictionary 기반 조회/유지보수
  1) View / Join 이해
  2) Maintenance View 생성 및 유지보수
  3) View Cluster로 계층형 유지보수
  4) Search Help 생성 및 연결
  5) Screen / Dynpro / Module Pool 기초 이해
```

---

## 1) Unit 1. Views & Joins Review

### 핵심

- Open SQL에서 직접 JOIN을 쓰는 방법과, SE11에서 View를 정의해서 사용하는 방법이 있다.
- 정적으로 정의된 **DB View**는 재사용성과 코드 단순화 측면에서 유리하다.
- Maintenance View는 SE11에서 생성 후 **Table Maintenance Generator**와 연결해서 실제 유지보수 화면까지 만든다.

---

### 1-1) OPEN SQL JOIN vs DB View

### 핵심

- ABAP 프로그램에서 직접 `JOIN`을 작성할 수 있다.
- 하지만 ABAP Dictionary(SE11)에 **정적으로 View**를 만들어두면
    - 재사용 가능
    - 코드가 단순해짐
    - DB 레벨 최적화에 유리할 수 있음

### 비교

| 항목 | OPEN SQL JOIN | DB View |
| --- | --- | --- |
| 작성 위치 | 프로그램 내부 | SE11(Dictionary) |
| 재사용성 | 낮음 | 높음 |
| 코드 길이 | 길어질 수 있음 | 짧아짐 |
| 유지보수 | 프로그램별 수정 | View 한 곳 수정 |
| 성능 | 상황에 따라 다름 | 정적 정의라 유리할 수 있음 |

### 포인트

- 시험에서는 “무조건 DB View가 빠르다”보다
    
    **재사용성과 정적 정의의 장점**을 중심으로 이해하는 게 좋음
    
- 실무에서는 상황 따라 Open SQL JOIN도 많이 사용함

---

### 1-2) Maintenance View 생성하는 두 번째 방법

### 생성 흐름

```
SE11 → View 생성
  → View Type 선택 (Maintenance View)
  → 기본 속성 입력
  → Base Table / Related Table 설정
  → 필드 선택
  → Maintenance Status 설정
  → 정의 점검
  → Utilities → Table Maintenance Generator
  → 저장 및 활성화
  → SM30 또는 유지보수 화면 진입
```

---

### 1-3) Maintenance View 생성 순서

### 1) 시작 화면

```
SE11 / ABAP Dictionary
Object Type : View
View Name   : Zxxxxxxxx
[Create]
```

### 2) View Type 선택

```
Database View
Projection View
Maintenance View   ← 선택
Help View
```

### 3) 기본 정보 입력

- Short Description
- Maintenance Status
- Package / Transport Request

### 4) 기초 테이블 지정

- Base Table 선택
- Related Table 연결
- 필요한 관계 설정

### 5) 필드 선택

- Key Fields
- Display Fields
- Maintenance 대상 필드

### 6) 유지보수 속성 설정

- Display / Maintenance 허용 여부
- Maintenance Dialog 생성 준비

### 7) 최종 점검

- Tables
- Fields
- Selection Conditions
- Maintenance 가능 여부 확인

### 8) Maintenance Dialog 생성

```
Utilities → Table Maintenance Generator
```

- Function Group
- Authorization Group
- Recording Routine 설정

### 9) 저장 후 실행

- 저장
- `New Entries`
- `Change / Delete / Display`
- 저장 필수

### 포인트

- Maintenance View만 만들고 끝나는 게 아니라
    
    **Table Maintenance Generator까지 연결해야 실제 유지보수 화면 사용 가능**
    
- 생성 후 패키지에서 객체가 안 보이면 Refresh / Object Directory 확인

---

## 2) Unit 2. View Cluster

### 핵심

- **View Cluster(SE54)** 는 여러 테이블/뷰를 **계층 구조**로 묶어서 한 화면에서 유지보수하는 오브젝트
- Header–Item 같은 관계를 한 번에 관리할 때 유용하다

---

### 2-1) View Cluster란?

- 여러 개의 View / Table을 하나의 유지보수 단위로 묶음
- 계층 구조로 탐색 가능
- 관련 데이터를 하나의 흐름에서 수정 가능

### 예시 구조

```
SCARR
  ↓
SPFLI
  ↓
SFLIGHT
```

---

### 2-2) View Cluster 구성 요소

- View / Table
- Hierarchy(계층 구조)
- Maintenance Dialog
- Events(Optional)

---

### 2-3) View Cluster의 핵심 장점

### 1) Navigation

- 부모–자식 관계를 계층적으로 보여줌
- 관련 데이터로 자연스럽게 이동 가능

예:

- 항공사 → 노선 → 비행편

### 2) Consistency

- 연관 테이블을 하나의 유지보수 프로세스로 관리
- 데이터 일관성 유지에 유리
- 헤더 없는 아이템 같은 비정상 구조 방지에 도움

### 포인트

- Maintenance View가 “한 개 유지보수 단위”라면
- View Cluster는 “여러 유지보수 단위를 묶은 상위 구조”로 보면 이해가 쉬움

---

## 3) Unit 3. Search Helps

### 핵심

- Search Help는 SAP의 표준 **F4 검색 팝업**
- 사용자가 코드를 외우지 않아도 값을 쉽게 찾고 선택할 수 있게 해준다
- Elementary / Collective 형태로 만들 수 있고, Data Element에 연결하는 방식이 가장 권장된다

---

### 3-1) Search Help란?

- 필드 값 검색을 도와주는 표준 팝업 기능
- 고객번호, 자재번호, 사번 등 입력 편의성 제공
- 재사용 가능
- 입력 정확성 향상

### 포인트

- 단순 편의 기능이 아니라
    
    **데이터 품질과 UX를 동시에 높이는 Dictionary 기능**
    

---

### 3-2) Search Help 생성 시작

```
SE11 / Search Help
Search Help Name : ZSHXXXX
[Create]
Type : Elementary / Collective
```

---

### 3-3) Search Help를 연결할 수 있는 위치

### 1) Data Element — 가장 권장

```
Data Element
Search Help = ZSHXXXX
```

### 2) Table Field / Structure Field

- 필드 속성에 직접 지정 가능

### 3) Check Table

- 체크 테이블 기반으로도 검색 도움 가능

### 4) Screen Painter 직접 연결 — 비추천

- Dynpro에 직접 연결 가능하긴 함
- 하지만 재사용성 낮음
- Dictionary와 동기화 이슈 가능

### 포인트

- **가장 권장되는 방식은 Data Element 연결**
- 한 번 연결하면 여러 화면/프로그램에서 재사용 가능

---

### 3-4) Selection Method란?

### 정의

- Search Help가 어떤 테이블 또는 View에서 데이터를 가져올지 정하는 핵심 속성

### 역할

- F4 팝업의 데이터 출처 결정
- Parameters의 기준 결정
- 어떤 필드를 보여주고 반환할지 결정하는 기반

### 포인트

- Search Help의 “조회 원본”을 정하는 개념
- 보통 테이블이나 View를 Selection Method로 사용

---

### 3-5) Search Help 기본 정의 화면

### 설정 항목

- Short Text
- Selection Method
- Dialog Type

### Parameter 설정

- Import / Export
- LPos (List Position)
- SPos (Selection Position)
- Display Field 지정

---

### 3-6) Search Help 생성 방법

### 방법 1) SE11에서 직접 생성

```
SE11 → Search Help Create
  → Elementary Search Help 설정
  → Selection Method 지정
  → Parameters 설정
  → Activate
```

### 방법 2) Table / Data Element에서 진입

- 관련 객체에서 Search Help 속성 기반으로 생성/연결

### 방법 3) 기존 Dictionary 객체 기반 생성

- 기존 구조를 바탕으로 Search Help를 구성
- 파라미터와 Selection Method 조정

### 포인트

- 실습에서는 보통 방법 1이 가장 이해하기 쉬움
- 실무에서는 기존 Data Element / Field와 연결하며 작업하는 경우도 많음

---

### 3-7) LPos / SPos 의미

### LPos (List Position)

- F4 결과 리스트에서 컬럼 표시 순서

### LPos가 없으면

- 리스트 컬럼이 보이지 않거나
- 원하는 순서대로 안 나올 수 있음

### LPos가 커지면

- 해당 컬럼이 뒤쪽 순서로 표시됨

---

### SPos (Selection Position)

- 검색 조건 입력 화면에서 필드 표시 순서

### SPos가 없으면

- 검색 조건 입력 필드에 잘 안 보이거나
- 조건 창에 안 나타날 수 있음

### 포인트

- **LPos = 결과 리스트용**
- **SPos = 검색 조건 입력용**
- 시험에서 자주 헷갈리는 포인트

---

### 3-8) Search Help 실습 2 – Structure 연계

### 구조체 예시

```
ZSEMPLOY_G01
  EMP_NUM
  NAME
  ...
```

### 프로그램 예시

```
REPORT ZABAP_22_G01.

PARAMETERS: PA_CLS TYPE S_CLASS VALUE CHECK.

PARAMETERS PA_CAR  TYPE BC400_S_FLIGHT-CARRID.
PARAMETERS PA_EMP  TYPE ZEMPLOYG01-EMP_NUM.
PARAMETERS PA_EMP2 TYPE ZSEMPLOY_G01-EMP_NUM.
PARAMETERS PA_ID   TYPE ZSCUSTOMER_G01-ID
                   MATCHCODE OBJECT ZSHCUSTOM_G01.
PARAMETERS PA_EMP3 TYPE ZEMPNUMG01.

WRITE: 'Class : ', PA_CLS.
```

### 포인트

- Data Element나 Structure Field에 Search Help가 연결되어 있으면
    
    PARAMETERS에서 자동으로 F4 Help가 동작할 수 있음
    
- `MATCHCODE OBJECT`로 직접 연결하는 방식도 가능

---

### 3-9) SAP HANA 이후 고급 검색 기능

### 핵심

- 입력하면서 즉시 제안 목록이 뜨는 기능 지원
- 여러 컬럼을 대상으로 **Full Text Search** 가능

### 기능

- Type-ahead / Suggestion
- Multi-column full text search

### 포인트

- 최신 UX 개선 기능
- SE11 Search Help 설정에서 지정 가능
- 단순 F4보다 사용자 경험이 더 좋아짐

---

## 4) Unit 4. Screen

### 핵심

- SAP 전통 UI는 **Dynpro(Screen)** 기반
- 스크린은 REPORT, Function Group, Module Pool 등에서 사용할 수 있지만
- SAP는 재사용성과 캡슐화를 위해 **Function Group 기반**을 더 선호한다

---

### 4-1) Screens and Program Types

### 1) Executable Program (REPORT)

- REPORT에서도 `CALL SCREEN` 사용 가능
- 리스트 대신 혹은 추가 상세화면으로 사용 가능
- 하지만 재사용성이 낮음

### 2) Function Group

- Function Module + Screen + Screen Sequence를 함께 구성 가능
- Dialog Transaction에서 접근 가능
- 재사용성과 캡슐화가 좋음
- SAP 권장 방식

### 3) Module Pool

- Dialog Transaction에서 호출
- 이름은 보통 `SAPMZ*`, `SAPMY*`
- Screen 개발 가능
- Function Group만큼 재사용 구조가 좋지는 않음

### 4) 기타(Include, Class Pool 등)

- 스크린 생성 목적 아님
- 직접적인 스크린 오브젝트 사용 불가

---

### 4-2) Program Type 비교

| Program Type | 스크린 사용 가능 여부 | 특징 요약 | SAP 권장도 |
| --- | --- | --- | --- |
| Executable Program (REPORT) | 가능하지만 제한적 | CALL SCREEN 가능, 재사용성 낮음 | ⚠️ 낮음 |
| Function Group (FG) | 가능 | FM + Screen + Sequence 캡슐화 | ✅ 높음 |
| Module Pool (Type M) | 가능 | 전통적 Dynpro 프로그램 | ⚠️ FG보다 낮음 |
| 기타 Include / Class Pool | 불가 | UI 목적 아님 | ❌ 불가 |

---

### 4-3) Screen Painter란?

### 정의

- Dynpro(Screen)를 만들고 편집하는 SAP GUI 도구
- `SE51` 또는 프로그램 내부 Screen Editing에서 접근

### 주요 구성

- Properties
- Layout Editor
- Element List
- Flow Logic

### 포인트

- 화면 모양은 Layout Editor
- 동작 흐름은 Flow Logic
- 실제 MODULE 구현은 Include에서 함

---

### 4-4) Module Pool 실습

### 핵심

- Module Pool은 **TOP Include 필요**
- 보통 `TOP / O01 / I01` 구조로 나눠서 작성
- Screen 번호별로 PBO / PAI 로직을 연결한다

---

### 4-5) Module Pool 생성 흐름

```
Module Pool 생성
  → TOP Include 생성
  → O01 / I01 Include 구성
  → Screen 100 생성
  → Layout 작성
  → Flow Logic 연결
  → Screen 200 생성
  → 버튼별 Function Code 처리
```

---

### 4-6) 명명 규칙

### 예시

```
Main Program : SAPMZSCR_G01
TOP Include  : MZSCR_G01TOP
```

### 포인트

- 실습에서는 보통 메인 프로그램명에서 `SAP`를 제외하고 Include 이름을 만듦
- `TOP`, `O01`, `I01` 패턴 자주 사용

---

### 4-7) Screen 구성

### Screen 100

- 입력 화면
- GO 버튼

### Screen 200

- 결과 화면
- BACK / EXIT 버튼

---

### 4-8) PAI 모듈 예시

```
*&---------------------------------------------------------------------*
*& Include          MZSCR_G01I01
*&---------------------------------------------------------------------*

MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'GO'.
      SET SCREEN 200.
  ENDCASE.
ENDMODULE.

MODULE USER_COMMAND_0200 INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      SET SCREEN 100.
    WHEN 'EXIT'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
```

### 포인트

- 버튼 클릭 시 Function Code가 `OK_CODE`에 들어감
- `SET SCREEN 200` → 다음 화면 이동
- `SET SCREEN 0` → 호출 이전 화면/종료로 복귀

---

## 5) Lesson 12 전체 비교(한 눈에)

| 항목 | 핵심 | 장점 | 주의점 |
| --- | --- | --- | --- |
| DB View | Dictionary에 정적 View 정의 | 재사용성, 코드 단순화 | 상황 따라 JOIN과 비교 필요 |
| Maintenance View | 유지보수용 View | SM30 스타일 관리 가능 | Generator까지 필요 |
| View Cluster | 여러 View/Table 계층 관리 | Navigation, Consistency | 구조 설계 필요 |
| Search Help | F4 검색 지원 | 입력 편의, 정확성 향상 | Data Element 연결 권장 |
| LPos / SPos | 리스트/검색 조건 위치 제어 | UI 제어 가능 | 서로 역할 혼동 주의 |
| Screen / Dynpro | SAP 전통 화면 | 상세 UI 구현 가능 | 구조 분리 중요 |
| Function Group | 재사용 가능한 스크린 구성 | 캡슐화, 재사용성 우수 | 구성 이해 필요 |
| Module Pool | 전통적인 대화형 프로그램 | 화면 제어 명확 | FG보다 재사용성 낮음 |

---

## 6) 시험 포인트 / 실무 포인트

### 6-1) 시험 포인트

- **OPEN SQL JOIN vs DB View 차이**
- **Maintenance View 생성 절차**
- **View Cluster의 목적**
- **Search Help의 Selection Method 의미**
- **LPos / SPos 차이**
- **Search Help 연결 위치 중 Data Element가 가장 권장**
- **REPORT / FG / Module Pool의 스크린 사용 차이**
- **Module Pool에서 TOP Include 필요**

### 6-2) 실무 포인트

- 단순 조회 반복이면 View로 공통화하면 관리가 편함
- 유지보수 목적이면 Maintenance View + Generator까지 연결
- 관련 테이블이 많으면 View Cluster 고려
- Search Help는 Data Element에 걸어야 재사용성이 좋음
- 스크린 로직은 TOP / O01 / I01 등으로 분리해서 관리

---

## 7) Lesson 12에서 제일 중요한 결론

- **조회 재사용**이 목적이면 View를 잘 설계하는 것이 중요하다
- **유지보수 화면**이 목적이면 Maintenance View와 View Cluster를 구분해서 써야 한다
- **검색 편의성**은 Search Help가 담당하며, Data Element 연결이 가장 깔끔하다
- **SAP 전통 화면 개발**은 Dynpro 기반이며, Function Group / Module Pool 구조 이해가 중요하다
- **LPos와 SPos, OK_CODE, SET SCREEN** 같은 키워드는 시험에서 매우 자주 헷갈리는 핵심 포인트다
