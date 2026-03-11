# 🔵 **Unit 1. Views & Joins Review**

1. **Views & Joins**
    1. 성능 관점: OPEN SQL JOIN vs DB View
        
        → ABAP 프로그램에서 JOIN을 직접 작성하는 것보다, ABAP Dictionary(SE11)에서 정적으로 정의한 View를 사용하면 데이터베이스 옵티마이저가 더 효율적으로 처리할 수 있어 성능이 유리할 수 있다. 또한 View는 테이블처럼 바로 SELECT할 수 있어 코드가 단순해지고 재사용성이 높아진다.
        
    2. Maintenance View 생성하는 두 번째 방법
        1. 실습 진행 화면

```
Maintenance View 생성 시작 화면

┌──────────────────────────────────────┐
│ SE11 / ABAP Dictionary                │
│                                      │
│ Object Type : View                   │
│ View Name   : Zxxxxxxxx              │
│                                      │
│ [Create]                              │
└──────────────────────────────────────┘
```

```
View Type 선택 화면

┌──────────────────────────────────────┐
│ View Type Selection                  │
│                                      │
│ ( ) Database View                    │
│ ( ) Projection View                  │
│ (•) Maintenance View                 │
│ ( ) Help View                        │
└──────────────────────────────────────┘
```

```
기본 정보 입력 화면

┌──────────────────────────────────────┐
│ Short Description                    │
│ Maintenance Status                   │
│ Package / Transport Request          │
│                                      │
│ View 기본 속성 입력                  │
└──────────────────────────────────────┘
```

```
기초 테이블 지정 화면

┌──────────────────────────────────────┐
│ Maintenance View Tables              │
│                                      │
│ Table/Join Conditions                │
│ Base Table 선택                      │
│ Related Table 연결                   │
└──────────────────────────────────────┘
```

```
필드 선택 화면

┌──────────────────────────────────────┐
│ View Fields                          │
│                                      │
│ [x] Key Fields                       │
│ [x] Display Fields                   │
│ [x] Maintenance 대상 필드            │
└──────────────────────────────────────┘
```

```
유지보수 속성 설정 화면

┌──────────────────────────────────────┐
│ Maintenance Status / Dialog          │
│                                      │
│ Display/Maintenance Allowed          │
│ Generate Maintenance Dialog 준비     │
└──────────────────────────────────────┘
```

```
생성 전 최종 점검 화면

┌──────────────────────────────────────┐
│ View Definition Check                │
│                                      │
│ Tables                               │
│ Fields                               │
│ Selection Conditions                 │
│ Maintenance 가능 여부 확인            │
└──────────────────────────────────────┘
```

```
Maintenance Dialog 생성 연결 화면

┌──────────────────────────────────────┐
│ Utilities → Table Maintenance        │
│ Generator                            │
│                                      │
│ Function Group / Authorization       │
│ Recording Routine 설정               │
└──────────────────────────────────────┘
```

```
        → 저장 버튼 클릭
```

```
저장 버튼 클릭 화면

┌──────────────────────────────────────┐
│ [Save]                               │
│                                      │
│ View / Maintenance Dialog 저장        │
└──────────────────────────────────────┘
```

```
        → New Enties 클릭해서 display에서 새로운 데이터 추가 및 제거 등 수정 가능(저장 필수)
```

```
유지보수 화면 진입

┌──────────────────────────────────────┐
│ Table/View Maintenance               │
│                                      │
│ [New Entries]                        │
│ [Change] [Delete] [Display]          │
└──────────────────────────────────────┘
```

```
새 데이터 추가 / 수정 화면

┌──────────────────────────────────────┐
│ New Entries                          │
│                                      │
│ Key Field     : ______               │
│ Description   : ______               │
│ Other Fields   : ______              │
│                                      │
│ [Save] 필수                           │
└──────────────────────────────────────┘
```

```
        → 생성 완료

    2. 오류 발생 시 : 패키지 내에 객체 안보일 때 클릭
```

```
패키지 내 객체 표시 문제 해결 화면

┌──────────────────────────────────────┐
│ Package Explorer / Object List       │
│                                      │
│ Object not visible in package        │
│ → Refresh / Display Object List      │
│ → Object Directory Entry 확인         │
└──────────────────────────────────────┘
```

---

# 🔵 **Unit 2. View Cluster**

1. View Cluster란?
    1. **View Cluster(트랜잭션: SE54)는 여러 개의 테이블/뷰를 ‘계층 구조’로 묶어서 한 화면에서 편집할 수 있게 해주는 유지보수(Maintenance) 오브젝트**이다. 예를 들어, **헤더 테이블 + 아이템 테이블**을 함께 관리해야 할 때 하나의 유지보수 화면으로 처리할 수 있게 해준다.
2. View Cluster 구성 요소
    1. View/테이블
    2. Hierarchy(계층 구조)
    3. Maintenance Dialog
    4. Events (Optional)
3. View Cluster의 두 가지 핵심 장점
    1. Navigation(네비게이션)
        1. View Cluster는 테이블 간 **부모–자식 관계를 계층 구조로 보여주기 때문에**, 사용자가 데이터를 탐색할 때 자연스럽게 이동할 수 있다. 예를 들어 SCARR(항공사) → SPFLI(노선) → SFLIGHT(비행편) 같은 구조를 한 화면에서 손쉽게 위아래로 이동하며 조회・수정할 수 있다.
    2. Consistency(일관성)
        1. View Cluster는 관련된 모든 테이블을 하나의 유지보수 프로세스에서 처리하므로, **데이터 간의 관계(Referential Integrity)와 입력 규칙이 일관되게 유지된다.** 헤더를 저장하면 아이템도 올바르게 종속되도록 관리되고, 잘못된 구조(헤더 없는 아이템 등)가 발생하지 않는다.

---

# 🔵 **Unit 3. Search Helps**

1. Search Help란?
    1. **Search Help는 사용자가 필드 값을 쉽게 찾도록 도와주는 검색 창(Popup) 기능**이다. 예: 고객 번호, 자재 코드, 공장 코드처럼 직접 기억하기 어려운 값을 리스트로 검색하여 선택하게 해주는 SAP 표준 UX 요소
    2. Search Help는 사용자가 필드 값을 쉽게 찾도록 도와주는 **표준 검색 팝업 기능**이며, Elementary/Collective 형태로 만들어 재사용할 수 있다. 데이터 요소에 연결하면 여러 프로그램에서 동일한 검색 UX를 적용할 수 있어 **입력 편의성과 데이터 정확성이 크게 향상**된다.
    3. 실습 화면

```
Search Help 생성 시작 화면

┌──────────────────────────────────────┐
│ SE11 / Search Help                   │
│                                      │
│ Search Help Name : ZSHXXXX           │
│ [Create]                              │
│ Type : Elementary / Collective       │
└──────────────────────────────────────┘
```

```
4. 스크린에서 레이아웃 ( Screen Painter )
    1. Screen Painter에 직접 Search Help 연결하는 방식 (비추천 ❌)

    그림 오른쪽의 Screen Painter는 Dynpro 화면을 의미합니다.

    - Screen Painter에서도 Search Help를 **직접 연결하는 기능은 있음**
    - 그러나 이 방식은 재사용성이 떨어지고, Dictionary 변경 시 동기화 문제가 생길 수 있어 **SAP에서 권장하지 않음**
```

```
Screen Painter 직접 연결 방식

┌──────────────────────────────────────┐
│ Dynpro Field Properties              │
│                                      │
│ Search Help 직접 지정                 │
│                                      │
│ 재사용성 낮음                         │
│ Dictionary 변경 시 동기화 이슈 가능    │
└──────────────────────────────────────┘
```

```
5. Search Help를 연결할 수 있는 위치
    1. Data Element (데이터 요소) — 가장 권장
```

```
Data Element에 Search Help 연결

┌──────────────────────────────────────┐
│ Data Element                         │
│                                      │
│ Search Help = ZSHXXXX                │
│                                      │
│ 가장 권장되는 연결 방식               │
└──────────────────────────────────────┘
```

```
    2. Table 필드 / Structure 필드
```

```
Table Field / Structure Field 연결

┌──────────────────────────────────────┐
│ Table / Structure Field              │
│                                      │
│ Search Help 속성 직접 지정            │
└──────────────────────────────────────┘
```

```
    3. **Check Table(체크 테이블)**
```

2. Selection Method란?

1. Search Help가 어떤 테이블 또는 View에서 데이터를 가져와서 F4 검색 팝업을 구성할지 결정하는 핵심 속성

2. Selection Method의 역할

1. F4 팝업에서 보여줄 데이터의 “출처” 결정

2. Search Help Parameter(입력/출력 필드)의 기준이 됨

1. Search Help 생성 실습1
    1. 실습 진행 화면

```
Search Help 기본 정의 화면

┌──────────────────────────────────────┐
│ Search Help Definition               │
│                                      │
│ Short Text                           │
│ Selection Method                     │
│ Dialog Type                          │
└──────────────────────────────────────┘
```

```
파라미터 설정 화면

┌──────────────────────────────────────┐
│ Parameters                           │
│                                      │
│ Import / Export                      │
│ LPos / SPos 설정                     │
│ Display Field 지정                   │
└──────────────────────────────────────┘
```

```
    1) 방법 1
```

```
방법 1 - 생성 경로 화면 1

┌──────────────────────────────────────┐
│ SE11 → Search Help Create            │
│                                      │
│ 직접 Search Help 생성                 │
└──────────────────────────────────────┘
```

```
방법 1 - 생성 경로 화면 2

┌──────────────────────────────────────┐
│ Elementary Search Help 설정          │
│                                      │
│ Selection Method 지정                 │
│ Parameters 설정                       │
└──────────────────────────────────────┘
```

```
    → 생성 완료
```

```
생성 완료 후 화면

┌──────────────────────────────────────┐
│ Search Help Active                   │
│                                      │
│ 활성화 완료                           │
└──────────────────────────────────────┘
```

```
    → 생성 완료 후 Search Help 확인

    2) 방법 2
```

```
방법 2 - 생성 경로 화면 1

┌──────────────────────────────────────┐
│ Table / Data Element에서              │
│ Search Help로 진입                    │
└──────────────────────────────────────┘
```

```
방법 2 - 생성 경로 화면 2

┌──────────────────────────────────────┐
│ 관련 객체에서 Search Help 연결        │
│                                      │
│ 속성 기반 생성/연결                   │
└──────────────────────────────────────┘
```

```
    3) 방법 3
```

```
방법 3 - 생성 경로 화면 1

┌──────────────────────────────────────┐
│ 기존 Dictionary 객체 기반             │
│ Search Help 생성                      │
└──────────────────────────────────────┘
```

```
방법 3 - 생성 경로 화면 2

┌──────────────────────────────────────┐
│ Parameter/Selection Method 조정       │
│                                      │
│ 다양한 방식으로 Search Help 구성       │
└──────────────────────────────────────┘
```

```
    - List Position 숫자가 없다면 Display Ui는 ?
```

```
List Position 없음 - 설정 화면

┌──────────────────────────────────────┐
│ Parameters                           │
│                                      │
│ List Pos 값 미입력                    │
└──────────────────────────────────────┘
```

```
List Position 없음 - Display UI

┌──────────────────────────────────────┐
│ F4 Help Display                      │
│                                      │
│ 리스트 컬럼 표시가 제한되거나          │
│ 원하는 순서로 보이지 않음              │
└──────────────────────────────────────┘
```

```
    - List Position 숫자가 더 높아지면?
```

```
List Position 증가 - 설정 화면

┌──────────────────────────────────────┐
│ Parameters                           │
│                                      │
│ LPos 값 증가                          │
└──────────────────────────────────────┘
```

```
List Position 증가 - Display UI

┌──────────────────────────────────────┐
│ F4 Help Display                      │
│                                      │
│ 해당 컬럼이 더 뒤쪽 순서로 표시됨      │
└──────────────────────────────────────┘
```

```
    - Selection Position 숫자가 없다면 Display Ui는 ?
```

```
Selection Position 없음 - 설정 화면

┌──────────────────────────────────────┐
│ Parameters                           │
│                                      │
│ SPos 값 미입력                        │
└──────────────────────────────────────┘
```

```
Selection Position 없음 - Display UI

┌──────────────────────────────────────┐
│ F4 Search Dialog                     │
│                                      │
│ 검색 조건 입력 필드로 잘 안 보이거나   │
│ 선택 조건 창에 나타나지 않을 수 있음   │
└──────────────────────────────────────┘
```

1. Search Help 생성 실습 2
    1. 실습 진행 화면

```
실습 2 시작 화면

┌──────────────────────────────────────┐
│ Search Help / Structure 연계 실습     │
└──────────────────────────────────────┘
```

```
    → 구조체 만들기 (ZSEMPLOY_G01)
```

```
구조체 생성 화면 (ZSEMPLOY_G01)

┌──────────────────────────────────────┐
│ Structure : ZSEMPLOY_G01             │
│                                      │
│ EMP_NUM                              │
│ NAME                                 │
│ ...                                  │
└──────────────────────────────────────┘
```

```
구조체 필드 정의 화면

┌──────────────────────────────────────┐
│ Components                           │
│                                      │
│ EMP_NUM / Data Element               │
│ Field Attributes                     │
└──────────────────────────────────────┘
```

```
Search Help 연결 버튼 사용 화면

┌──────────────────────────────────────┐
│ Field Properties                     │
│                                      │
│ [Search Help] 버튼                    │
│ 저장 후 연결 완료                     │
└──────────────────────────────────────┘
```

```
REPORT ZABAP_22_G01.

PARAMETERS: PA_CLS TYPE S_CLASS VALUE CHECK.

PARAMETERS PA_CAR TYPE BC400_S_FLIGHT-CARRID.
PARAMETERS PA_EMP TYPE ZEMPLOYG01-EMP_NUM.
PARAMETERS PA_EMP2 TYPE ZSEMPLOY_G01-EMP_NUM.
PARAMETERS PA_ID TYPE ZSCUSTOMER_G01-ID
    MATCHCODE OBJECT ZSHCUSTOM_G01.
PARAMETERS PA_EMP3 TYPE ZEMPNUMG01.

WRITE: 'Class : ', PA_CLS.
```

```
    → 프로그램 내 코드
```

```
프로그램 실행/입력 화면

┌──────────────────────────────────────┐
│ PARAMETERS                           │
│                                      │
│ PA_CLS                              │
│ PA_CAR                              │
│ PA_EMP                              │
│ PA_EMP2                             │
│ PA_ID                               │
│ PA_EMP3                             │
└──────────────────────────────────────┘
```

```
    → 결과
```

5. SAP HANA 이후에 추가된 *고급 검색 기능*

1. **입력창에 글자를 치는 순간 즉시 제안 목록이 자동으로 뜨는 기능 → se11내에서 지정!**

2. Multi-column full text search (database-specific)

```
    **: 서치헬프의 여러 필드(컬럼) 전체를 “풀 텍스트 검색”하는 기능**
```

```
고급 검색 기능 설정 화면

┌──────────────────────────────────────┐
│ Search Help / HANA Search Options    │
│                                      │
│ Type-ahead / Suggestion Enabled      │
│ Multi-column Full Text Search        │
└──────────────────────────────────────┘
```

```
고급 검색 결과 화면

┌──────────────────────────────────────┐
│ 사용자가 일부 글자 입력               │
│                                      │
│ 즉시 제안 목록 자동 표시              │
│ 여러 컬럼 기준 풀텍스트 검색 가능      │
└──────────────────────────────────────┘
```

---

# 🔵 **Unit 4. Screen**

1. Screens and Program Types
    1. Executable program (Report)
        1. REPORT 타입 프로그램에서도 스크린을 사용할 수 있다.
        - 용도
            - 리스트 대신(또는 리스트 위에) 별도의 스크린을 띄워 데이터를 보여주거나
            - 리스트의 일부를 더 상세히 보여주기 위해 스크린을 사용할 수 있다.
        - 하지만 재사용성과 캡슐화를 위해, SAP에서는
            - 리포트에서 직접 스크린을 많이 만드는 것보다
            - 스크린은 따로 Function Group에 두고, 리포트에서 그 스크린을 사용하는 방식을 더 권장한다.
    2. Function group
        1. Function group 안에는 Function module들과 이들과 연결된 screens / screen sequence를 함께 넣을 수 있다. 스크린은 Dialog Transaction을 통해 접근할 수 있고, Function module 코드 안에서 `CALL SCREEN` 문으로 시작할 수도 있다.
        - SAP 권장사항
            - 재사용성과 캡슐화를 위해 스크린과 스크린 시퀀스를 Function Group에 만들어두고,
            - 필요할 때마다 다양한 프로그램/트랜잭션에서 기능모듈을 통해 재사용하는 방식이 좋다고 한다.
    3. Module pool
        1. Module pool 프로그램도 Dialog Transaction에서만 호출된다.
        2. 이름은 SAPMZ 또는 SAPMY로 시작
            - Function group과 달리,
                - Module pool 안의 스크린은 “외부 인터페이스”가 잘 정리된 형태로 사용되기 어렵다.
                - 스크린들을 별도의 기능 모듈로 캡슐화하는 구조가 아니기 때문
            - 그래서 SAP는 새로운 스크린 개발 시 직접 module pool을 늘리기보다는, Function group을 활용해 재사용 가능한 스크린 시퀀스를 만드는 것을 좀 더 선호한다고 설명한다
    4. Screens 가능 Program Type 비교 표

| Program Type | 스크린 사용 가능 여부 | 특징 요약 | SAP 권장도 |
| --- | --- | --- | --- |
| **Executable Program (REPORT)** | 가능하지만 제한적 | 리스트 출력 기반 프로그램에서 스크린을 띄울 수 있음. `CALL SCREEN` 사용 가능. 하지만 직접 스크린을 넣으면 재사용성이 떨어짐. | ⚠️ 권장하지 않음 |
| **Function Group (FG)** | 가능 (권장) | Function Module + Screen + Screen Sequence를 하나로 묶어 캡슐화 가능. 재사용성이 매우 높고 화면 로직을 기능 모듈로 감싸는 구조가 명확함. | ✅ SAP 권장 |
| **Module Pool (Type M)** | 가능 | 이름은 SAPMZ 또는 SAPMY로 시작 | ⚠️ 완전 비추천은 아니나 FG보다 낮음 |
| **기타(Include, Class Pool 등)** | 불가 | UI 적용 목적 아님. 스크린 생성 불가. | ❌ 해당 없음 |
1. Screen Painter란?
    1. Screen Painter는 SAP GUI에서 **Dynpro(Screen)** 을 만들고 편집하기 위한 UI 개발 도구이다. SE51 또는 프로그램 내부의 Screen Editing 기능을 통해 접근한다. (SAP 전통 UI 개발 도구)
    2. Screen Painter의 주요 구성
        1. Properties (스크린 속성)
        2. Layout Editor (그래픽 레이아웃 화면)
        3. Element List
        4. Flow Logic
    3. 프로그램 includes(예: TOP, O01, I01)에 MODULE 구현
2. Components of a Screen (스크린 구성 요소)
3. Graphical Layout Editor
4. **Module Pool** 실습
    1. **Module Pool 은 TOP Include 해야 함**
        1. 실습 진행 화면

```
Module Pool 생성 시작 화면

┌──────────────────────────────────────┐
│ Program Type : Module Pool           │
│ Program Name : SAPMZxxxx / SAPMYxxxx │
│                                      │
│ TOP Include 필요                     │
└──────────────────────────────────────┘
```

```
        → 명명 규칙 : 실습코드에서 SAP 글자만 지우고 뒤 붙여 넣기 + TOP
```

```
명명 규칙 설명 화면

┌──────────────────────────────────────┐
│ 예: SAPMZSCR_G01                     │
│ Include : MZSCR_G01TOP               │
│                                      │
│ SAP 제거 후 + TOP 규칙 적용          │
└──────────────────────────────────────┘
```

```
TOP Include 생성 화면

┌──────────────────────────────────────┐
│ Create Include                       │
│                                      │
│ MZSCR_G01TOP                         │
└──────────────────────────────────────┘
```

```
프로그램 속성/Include 연결 화면

┌──────────────────────────────────────┐
│ Main Program + Includes              │
│                                      │
│ TOP / O01 / I01 구성                 │
└──────────────────────────────────────┘
```

```
스크린 100 생성 화면

┌──────────────────────────────────────┐
│ Screen Number : 100                  │
│                                      │
│ Layout / Flow Logic                  │
└──────────────────────────────────────┘
```

```
스크린 100 레이아웃 편집 화면

┌──────────────────────────────────────┐
│ Input Fields                         │
│ Pushbutton                           │
│ Function Code 설정                    │
└──────────────────────────────────────┘
```

```
Flow Logic 연결 화면

┌──────────────────────────────────────┐
│ PROCESS BEFORE OUTPUT                │
│ PROCESS AFTER INPUT                  │
│ MODULE 호출 연결                      │
└──────────────────────────────────────┘
```

```
        → 번호 200의 스크린도 만들기
```

```
스크린 200 생성 화면

┌──────────────────────────────────────┐
│ Screen Number : 200                  │
│                                      │
│ 결과 표시 / BACK / EXIT 버튼          │
└──────────────────────────────────────┘
```

```
*&---------------------------------------------------------------------*
*& Include          MZSCR_G01I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
* 버튼 클릭시 버튼에 설정된 Function code가
* ok_code에 전달됨.
  CASE OK_CODE.
    WHEN 'GO'.
* Function Code가 GO이면 200번 스크린으로 이동.
      SET SCREEN 200.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.
* 버튼 클릭시 버튼에 설정된 Function code가
* ok_code에 전달됨.
  CASE OK_CODE.
    WHEN 'BACK'.
* Function Code가 BACK이면 100번 스크린으로 이동.
      SET SCREEN 100.
    WHEN 'EXIT'.
* Function Code가 BACK이면 프로그램 시작한 곳으로 이동.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
```

```
스크린 100 실행 화면

┌──────────────────────────────────────┐
│ 입력 화면                             │
│                                      │
│ [ GO ] 버튼                          │
└──────────────────────────────────────┘
```

```
스크린 200 실행 화면

┌──────────────────────────────────────┐
│ 결과 화면                             │
│                                      │
│ [ BACK ]   [ EXIT ]                  │
└──────────────────────────────────────┘
```

```
        → 실행 화면
```
