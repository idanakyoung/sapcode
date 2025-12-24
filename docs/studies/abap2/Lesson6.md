Lesson 6 – 프로그래밍 전용 리포트 개발 (2)

주제: Selection Screen 고급 구성 + F4 Help + Pushbutton 제어

0. 전체 구조 한눈에 보기 (사진 대신 구조도)
[ REPORT 실행 ]
      |
      v
[ Selection Screen ]
 ┌─────────────────────────────────────────┐
 │  Tabstrip                               │
 │ ┌────────┬────────┬────────┐           │
 │ │ Carrier│ Option │ Customer│           │
 │ │ 1100   │ 1200   │ 1300    │           │
 │ └────────┴────────┴────────┘           │
 │                                         │
 │ [ Subscreen 1100 ] PARAMETERS            │
 │ [ Subscreen 1200 ] CHECK / RADIO         │
 │ [ Subscreen 1300 ] SELECT-OPTIONS        │
 │                                         │
 │ [ Pushbutton : Display / Change ]        │
 └─────────────────────────────────────────┘
      |
      v
[ START-OF-SELECTION ]

🔵 Unit 1. Selection Screen Parameters
1. Selection Screen 기본 개념
Selection Screen이란?

REPORT 프로그램 실행 시 가장 먼저 표시되는 입력 UI

사용자가 입력한 값은:

PA_... → 단일 값

SO_... → 범위/다중 값

이후 로직에서 자동으로 변수에 반영

2. PARAMETERS vs SELECT-OPTIONS (비교)
구분	PARAMETERS	SELECT-OPTIONS
입력 개수	단일 값	다중/범위
내부 구조	단순 변수	Range Table
내부 필드	값 하나	SIGN / OPTION / LOW / HIGH
사용 예	ID, 체크박스	날짜, 번호 범위
3. Range Table 구조 (SELECT-OPTIONS 내부)
SO_ID[]
 ┌─────┬────────┬─────┬──────┐
 │SIGN │ OPTION │ LOW │ HIGH │
 ├─────┼────────┼─────┼──────┤
 │ I   │  BT    │  1  │ 100  │
 │ I   │  EQ    │ 500 │      │
 │ E   │  EQ    │  50 │      │
 │ E   │  BT    │ 81  │  90  │
 └─────┴────────┴─────┴──────┘

4. 서브스크린(Subscreen)
목적

Selection Screen을 여러 화면 조각으로 분리

탭(Tabstrip)과 함께 UI처럼 구성 가능

Subscreen 1100 – 항공사 코드
SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.
  PARAMETERS: PA_CAR TYPE SBOOK-CARRID
              OBLIGATORY
              MEMORY ID CAR.
SELECTION-SCREEN END OF SCREEN 1100.


포인트

OBLIGATORY : 필수 입력

MEMORY ID CAR : 이전 입력값 자동 복원

Subscreen 1200 – 체크박스 + 라디오버튼
SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
  PARAMETERS: PA_DEL AS CHECKBOX.

  SELECTION-SCREEN SKIP 1.

  PARAMETERS: PA_ALL RADIOBUTTON GROUP RBG1,
              PA_DOM RADIOBUTTON GROUP RBG1,
              PA_INT RADIOBUTTON GROUP RBG1 DEFAULT 'X'.
SELECTION-SCREEN END OF SCREEN 1200.

[ ] Delete
( ) All
( ) Domestic
(o) International   ← 기본 선택

Subscreen 1300 – 고객 ID 범위
SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.
  SELECT-OPTIONS: SO_ID FOR GS_CUSTOMER-ID.
SELECTION-SCREEN END OF SCREEN 1300.

5. Tabstrip으로 Subscreen 연결
SELECTION-SCREEN BEGIN OF TABBED BLOCK TAB_STRIP FOR 5 LINES.
  SELECTION-SCREEN TAB (20) TAB1 USER-COMMAND FC1 DEFAULT SCREEN 1100.
  SELECTION-SCREEN TAB (20) TAB2 USER-COMMAND FC2 DEFAULT SCREEN 1200.
  SELECTION-SCREEN TAB (20) TAB3 USER-COMMAND FC3 DEFAULT SCREEN 1300.
SELECTION-SCREEN END OF BLOCK TAB_STRIP.

[ Carrier ] [ Condition optional ] [ Customer ]
     |              |                 |
   1100           1200               1300

6. INITIALIZATION – 기본값 세팅 핵심
탭 제목/초기 탭
INITIALIZATION.
  TAB1 = 'Carrier'.
  TAB2 = 'Condition optional'.
  TAB3 = 'Customer'.

  TAB_STRIP-ACTIVETAB = 'FC3'.
  TAB_STRIP-DYNNR     = '1300'.

SELECT-OPTIONS 기본 조건 직접 구성
SO_ID-SIGN   = 'I'.
SO_ID-OPTION = 'BT'.
SO_ID-LOW    = 1.
SO_ID-HIGH   = 100.
APPEND SO_ID.

CLEAR SO_ID.
SO_ID-SIGN   = 'I'.
SO_ID-OPTION = 'EQ'.
SO_ID-LOW    = 500.
APPEND SO_ID.

CLEAR SO_ID.
SO_ID-SIGN   = 'E'.
SO_ID-OPTION = 'EQ'.
SO_ID-LOW    = 50.
APPEND SO_ID.

CLEAR SO_ID.
SO_ID-SIGN   = 'E'.
SO_ID-OPTION = 'BT'.
SO_ID-LOW    = 81.
SO_ID-HIGH   = 90.
APPEND SO_ID.

🔵 Unit 2. F4 Search Help on Value Request
1. 개념 요약
사용자 F4 누름
      ↓
AT SELECTION-SCREEN ON VALUE-REQUEST
      ↓
내가 만든 로직으로 값 목록 생성
      ↓
F4 팝업
      ↓
선택 값 → 화면 필드에 자동 입력

2. 파일 경로 F4 (프론트엔드)
AT SELECTION-SCREEN ON VALUE-REQUEST FOR PA_FPATH.
  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG
    CHANGING
      FILE_TABLE = GT_FILE
      RC         = GV_RC.

READ TABLE GT_FILE INTO GS_FILE INDEX 1.
IF sy-subrc = 0.
  PA_FPATH = GS_FILE-filename.
ENDIF.

3. 내부테이블 기반 F4 (연도)
GT_YEAR
┌──────┬──────────┐
│ YEAR │ YEAR_TXT │
├──────┼──────────┤
│ 2025 │ 2025년도 │
│ 2024 │ 2024년도 │
│ ...  │ ...      │
└──────┴──────────┘

CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
  EXPORTING
    RETFIELD    = 'YEAR'
    DYNPROFIELD = 'PA_YEAR'
  TABLES
    VALUE_TAB   = GT_YEAR.

🔵 Unit 3. Selection Screen Pushbutton
1. Pushbutton 동작 흐름
[ 버튼 클릭 ]
      ↓
SSCRFIELDS-UCOMM = 'MODE'
      ↓
AT SELECTION-SCREEN
      ↓
GV_CHK 토글
      ↓
AT SELECTION-SCREEN OUTPUT
      ↓
화면 요소 숨김/비활성

2. Pushbutton 선언
SELECTION-SCREEN PUSHBUTTON /POS_LOW(20) GV_BTN USER-COMMAND MODE.

INITIALIZATION.
  GV_BTN = 'Display/Change'.

3. 화면 제어 (AT SELECTION-SCREEN OUTPUT)
AT SELECTION-SCREEN OUTPUT.
  IF GV_CHK = 'X'.
    LOOP AT SCREEN.
      IF screen-name CS 'PA_CAR'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.

      IF screen-name CS 'SO_COM'.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

4. 버튼 클릭 처리
AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'MODE'.
      IF gv_chk IS INITIAL.
        gv_chk = 'X'.
      ELSE.
        CLEAR gv_chk.
      ENDIF.
  ENDCASE.

최종 핵심 요약 (시험/실무 포인트)

Selection Screen은 UI처럼 설계 가능

INITIALIZATION에서 Range Table 직접 구성 가능

F4 Help는 이벤트 기반 커스터마이징

Pushbutton은 UCOMM + OUTPUT 이벤트 조합

SCREEN-ACTIVE vs SCREEN-INPUT 차이 명확히 구분
