# 🧭 Lesson 3 - Basic ABAP Language Elements (2)

# 🔵 Unit 1.  Using Basic ABAP Statementss (2)

## A.  ABAP 반복문 3종 정리

### 1. `DO. … ENDDO.` (무한 루프 + 조건 탈출형)

### 1-1. 개념 정리

```abap
DO.
  " 반복할 코드
  IF <탈출 조건>.
    EXIT.  " 반복문 종료
  ENDIF.
ENDDO.
```

- `DO.` 만 쓰면 **반복 횟수가 정해져 있지 않은 루프**
- 꼭 안쪽에서 `EXIT` 같은 탈출 조건을 걸어줘야 함
- 현재 몇 번째 반복인지 알고 싶을 때 → `sy-index` 사용 (1부터 시작)

---

### 1-2. 기본 예제 – 1부터 pa_num까지 합 구하기

> 문제
> 
> 
> 화면에서 입력한 숫자 `pa_num`까지의 합(1+2+…+pa_num)을
> 
> `DO. … ENDDO.` 와 `EXIT`를 사용해서 구하시오.
> 

### 코드

```abap
REPORT zdemo_do_basic.

PARAMETERS pa_num TYPE i.
DATA gv_sum TYPE i.

DO.
  " 1. sy-index 값을 더한다.
  gv_sum = gv_sum + sy-index.

  " 2. sy-index 가 pa_num 이상이면 반복 종료
  IF sy-index >= pa_num.
    EXIT.
  ENDIF.

ENDDO.

WRITE: / '1부터', pa_num, '까지의 합:', gv_sum.

```

### 풀이 (생각 흐름)

- `DO.` 는 일단 무한 반복
- `sy-index` 값이 1, 2, 3, … 순서로 증가
- 매번 `gv_sum`에 `sy-index`를 더해 줌
- `sy-index >= pa_num`이 되는 순간 `EXIT`로 탈출

> 예) pa_num = 4일 때
> 
> - 1회전: sy-index = 1 → gv_sum = 1
> - 2회전: sy-index = 2 → gv_sum = 3
> - 3회전: sy-index = 3 → gv_sum = 6
> - 4회전: sy-index = 4 → gv_sum = 10, 조건 만족 → EXIT
>     
>     ⇒ 결과: 1 + 2 + 3 + 4 = 10
>     

---

### 1-3. 고급 예제 – pa_start보다 큰 첫 번째 7의 배수 찾기

> 문제
> 
> 
> 파라미터 `pa_start`를 입력 받는다.
> 
> `pa_start`보다 **큰** 숫자 중에서 **7의 배수인 첫 번째 값**을 찾아 출력하라.
> 
> (반복 횟수는 미리 알 수 없으므로 `DO. … ENDDO.` 사용)
> 

### 코드

```abap
REPORT zdemo_do_advanced.

PARAMETERS pa_start TYPE i.

DATA lv_current TYPE i.
DATA lv_answer  TYPE i.

" 시작 값 바로 다음 값부터 검사
lv_current = pa_start + 1.

DO.
  " 1. 현재 값이 7의 배수인지 체크
  IF lv_current MOD 7 = 0.
    lv_answer = lv_current.
    EXIT.  " 찾았으면 반복 종료
  ENDIF.

  " 2. 아직 못 찾았으면 다음 숫자
  lv_current = lv_current + 1.

ENDDO.

WRITE: / pa_start, '보다 큰 첫 번째 7의 배수:', lv_answer.

```

### 풀이

- `lv_current`를 `pa_start + 1`로 시작
    - “보다 큰” 숫자부터 보기 위해
- `DO.` 안에서
    - `MOD 7 = 0` 이면 7의 배수 → `lv_answer`에 저장 후 `EXIT`
    - 아니면 `lv_current = lv_current + 1` 해서 다음 숫자 검사
- 7의 배수는 무한히 존재하므로, 이론상 **반드시 EXIT에 도달**함

> 예) pa_start = 10
> 
> - lv_current = 11 → 11 MOD 7 = 4 (X)
> - lv_current = 12 → 12 MOD 7 = 5 (X)
> - lv_current = 13 → 13 MOD 7 = 6 (X)
> - lv_current = 14 → 14 MOD 7 = 0 (O) → lv_answer = 14, EXIT
>     
>     ⇒ 결과: 14
>     

---

### 2. `DO n TIMES.` (횟수가 정해진 루프)

### 2-1. 개념 정리

```abap
DO n TIMES.
  " n번 반복할 코드
ENDDO.

```

- 정확히 **n번 반복**되는 루프
- 자동으로 `sy-index`가 1부터 n까지 증가
- 반복 횟수가 명확할 때 제일 깔끔한 문법

---

### 2-2. 기본 예제 – N번 인사 메시지 출력

> 문제
> 
> 
> 파라미터 `pa_cnt`를 입력 받아서
> 
> `"Hello ABAP! (n번째)"` 메시지를 `pa_cnt`번 출력하시오.
> 

### 코드

```abap
REPORT zdemo_do_times_basic.

PARAMETERS pa_cnt TYPE i.

DO pa_cnt TIMES.
  WRITE: / 'Hello ABAP! ', sy-index, '번째'.
ENDDO.
```

### 풀이

- `DO pa_cnt TIMES.` → sy-index가 1 ~ pa_cnt 까지 자동 증가
- 각 회차마다 `sy-index`를 이용해 “n번째” 출력

> 예) pa_cnt = 3
> 
> 
> 출력
> 
> - Hello ABAP! 1번째
> - Hello ABAP! 2번째
> - Hello ABAP! 3번째

---

### 2-3. 고급 예제 – n! (팩토리얼) 계산

> 문제
> 
> 
> 파라미터 `pa_num`을 입력 받고,
> 
> `pa_num!` (팩토리얼: 1×2×…×pa_num)을 `DO pa_num TIMES`를 이용해서 구하시오.
> 
> 단, `pa_num`이 0 또는 1이면 결과는 1로 처리.
> 

### 코드

```abap
REPORT zdemo_do_times_advanced.

PARAMETERS pa_num TYPE i.

DATA gv_fact TYPE i VALUE 1.  " 결과 (팩토리얼)
DATA lv_mul  TYPE i.          " 곱할 값

IF pa_num < 0.
  WRITE: '0 이상의 정수를 입력해주세요.'.
  EXIT.
ENDIF.

" 0! = 1, 1! = 1 이므로 그대로 1 출력 가능
IF pa_num = 0 OR pa_num = 1.
  WRITE: pa_num, '! = ', gv_fact.
  EXIT.
ENDIF.

DO pa_num TIMES.
  " sy-index: 1, 2, 3, ... pa_num
  lv_mul  = sy-index.
  gv_fact = gv_fact * lv_mul.
ENDDO.

WRITE: pa_num, '! = ', gv_fact.
```

### 풀이

- 팩토리얼 정의:
    - `n! = 1 × 2 × 3 × … × n`
- `DO pa_num TIMES.` 안에서
    - 첫 회전 sy-index = 1 → gv_fact = 1 × 1
    - 둘째 sy-index = 2 → gv_fact = (1×1) × 2
    - 셋째 sy-index = 3 → gv_fact = (이전 결과) × 3
    - … 이런 식으로 `pa_num`까지 반복

> 예) pa_num = 4
> 
> - 시작: gv_fact = 1
> - 1회전: sy-index = 1 → gv_fact = 1 × 1 = 1
> - 2회전: sy-index = 2 → gv_fact = 1 × 2 = 2
> - 3회전: sy-index = 3 → gv_fact = 2 × 3 = 6
> - 4회전: sy-index = 4 → gv_fact = 6 × 4 = 24
>     
>     ⇒ 4! = 24
>     

---

### 3. `WHILE … ENDWHILE.` (조건 중심 루프)

### 3-1. 개념 정리

```abap
WHILE <조건>.
  " 조건이 참(true)인 동안 반복
ENDWHILE.
```

- **조건이 참일 때만** 반복
- 루프 안에서 조건에 사용되는 변수 값을 **직접 변경**해줘야 함
    
    (안 그러면 무한 루프 위험)
    
- `DO`와 달리 `sy-index` 자동 증가 개념은 없음
    
    → 인덱스 변수(`lv_idx` 등)를 따로 선언해서 직접 +1 해주는 패턴이 일반적
    

---

### 3-2. 기본 예제 – 1부터 pa_num까지 합 (WHILE 버전)

> 문제
> 
> 
> 파라미터 `pa_num`을 입력 받고,
> 
> 1부터 `pa_num`까지의 합을 `WHILE`문으로 구하시오.
> 

### 코드

```abap
REPORT zdemo_while_basic.

PARAMETERS pa_num TYPE i.

DATA gv_sum TYPE i.
DATA lv_idx TYPE i VALUE 1.

WHILE lv_idx <= pa_num.

  gv_sum = gv_sum + lv_idx.

  " 다음 숫자로 이동
  lv_idx = lv_idx + 1.

ENDWHILE.

WRITE: / '1부터', pa_num, '까지의 합:', gv_sum.
```

### 풀이

- `lv_idx`를 1부터 시작
- `WHILE lv_idx <= pa_num.`
    
    → `lv_idx`가 pa_num보다 작거나 같은 동안 반복
    
- 루프 안에서
    - `gv_sum = gv_sum + lv_idx.`
    - `lv_idx = lv_idx + 1.` 로 한 칸씩 증가

> 예) pa_num = 3
> 
> - 시작: lv_idx = 1, gv_sum = 0
> - 1회전: gv_sum = 0 + 1 = 1, lv_idx = 2
> - 2회전: gv_sum = 1 + 2 = 3, lv_idx = 3
> - 3회전: gv_sum = 3 + 3 = 6, lv_idx = 4
> - 다음 조건: 4 <= 3 ? → false → 종료
>     
>     ⇒ 결과: 6
>     

---

### 3-3. 고급 예제 – Collatz(콜라츠) 수열 단계 수 구하기

> 문제 (조금 난이도↑)
> 
> 
> 파라미터 `pa_num`을 입력 받는다.
> 
> 아래 규칙으로 수열을 만들 때, **1이 될 때까지 몇 단계 걸리는지** 계산하시오.
> 
> - n이 짝수면 → n = n / 2
> - n이 홀수면 → n = 3 * n + 1
> - n이 1이면 종료
> 
> 이 반복을 `WHILE`문으로 작성하시오.
> 

### 코드

```abap
REPORT zdemo_while_advanced.

PARAMETERS pa_num TYPE i.

DATA lv_num   TYPE i.
DATA lv_steps TYPE i. " 단계 수

IF pa_num <= 0.
  WRITE: '1 이상의 정수를 입력해주세요.'.
  EXIT.
ENDIF.

lv_num = pa_num.

WHILE lv_num <> 1.

  " 단계 수 1 증가
  lv_steps = lv_steps + 1.

  " 짝수 / 홀수에 따라 다음 값 계산
  IF lv_num MOD 2 = 0.
    lv_num = lv_num / 2.
  ELSE.
    lv_num = 3 * lv_num + 1.
  ENDIF.

ENDWHILE.

WRITE: / '시작 값:', pa_num.
WRITE: / '1이 될 때까지 걸린 단계 수:', lv_steps.
```

### 풀이

1. 시작 값 `lv_num` = `pa_num`
2. `WHILE lv_num <> 1.`
    - 숫자가 1이 **아닌 동안** 계속 반복
3. 매 반복마다
    - `lv_steps`를 1 증가 (카운터)
    - `lv_num`이 짝수인지 홀수인지 확인 후 다음 값 계산
4. `lv_num`이 결국 1이 되면 반복 종료, 그 때 `lv_steps` 출력

> 예) pa_num = 6일 때
> 
> - 시작: lv_num = 6
> 1. 6 (짝수) → 6 / 2 = 3 (steps = 1)
> 2. 3 (홀수) → 3*3 + 1 = 10 (steps = 2)
> 3. 10 → 10 / 2 = 5 (steps = 3)
> 4. 5 → 3*5 + 1 = 16 (steps = 4)
> 5. 16 → 16 / 2 = 8 (steps = 5)
> 6. 8 → 8 / 2 = 4 (steps = 6)
> 7. 4 → 4 / 2 = 2 (steps = 7)
> 8. 2 → 2 / 2 = 1 (steps = 8)
>     
>     ⇒ 총 8단계
>     

---

### 4. 세 문법 비교 한눈에 정리

| 문법 | 특징 | 인덱스 사용 방식 | 예시 상황 |
| --- | --- | --- | --- |
| `DO. … ENDDO.` | 횟수 미정, 안에서 `EXIT`로 탈출 | `sy-index` 자동 증가 | 조건에 따라 “언제 끝날지 모르는” 반복 |
| `DO n TIMES.` | 정확히 n번 반복 | `sy-index` 1 ~ n | 인사 N번, 팩토리얼, 단순 N회 처리 |
| `WHILE … ENDWHILE.` | 조건이 참인 동안만 반복, 직접 변수 조정 필요 | 별도 변수(`lv_idx`) 선언해서 증가 | Collatz 수열, 입력값 검증, 조건 기반 |

## B. 반복문 실습 (2)

1. 반복문 계산 퀴즈 1 - 구구단 프로그램 만들기 
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_05_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_05_G01.
        
        PARAMETERS pa_dan TYPE i.
        DATA gv_result TYPE i.
        DATA lv_idx TYPE i VALUE 1.
        
        IF pa_dan < 2.
          WRITE: '2 이상의 값을 입력해주세요.'.
        
        ELSEif pa_dan <= 9.
        
          WHILE lv_idx <= 9.
        
            gv_result = pa_dan * lv_idx.
            WRITE:/ pa_dan, ' x ', lv_idx, ' = ', gv_result.
        
            lv_idx = lv_idx + 1.
        
          ENDWHILE.
        
        ELSE.
          WRITE: '9 이하의 값을 입력해주세요.'.
        ENDIF.
        
        * 강사님 풀이
        * 구구단 결과값 변수.
        DATA gv_result TYPE i.
        
        * selection screen - input/output.
        PARAMETERS pa_dan TYPE i.
        
        * 조건문 1단 이하 , 2 ~ 9단 사이, 9단 이상 처리.
        IF pa_dan <= 1.
            WRITE  '2단 이상을 입력하여 주세요.'.
        * ELSEIF pa_dan BETWEEN 2 AND 9.
        ELSEIF pa_dan >= 2 and pa_dan <= 9.
            DO 9 TIMES.
              gv_result = pa_dan * sy-index.
              WRITE:/ pa_dan, ' x ', sy-index, ' = ', gv_result.
            ENDDO.
        ELSE.
          WRITE '9단 이하를 입력하여 주세요.'.
        
        ENDIF.
        ```
        
    2. 실행 화면
    
    ![image.png](attachment:0a6f57eb-29cb-4aca-9c7d-d5b3e193759a:image.png)
    
2. 반복문 계산 실습 1 - 누적 구구단 프로그램 만들기 
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZQUIZ_05_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZQUIZ_06_G01.
        
        PARAMETERS pa_dan TYPE i.
        DATA gv_result TYPE i.
        DATA lv_idx TYPE i VALUE 1.
        DATA lv_danidx TYPE i VALUE 1.
        
        IF pa_dan < 2.
          WRITE: '2 이상의 값을 입력해주세요.'.
        
        ELSEif pa_dan <= 9.
        
          lv_danidx = 1.
        
        WHILE lv_danidx <= pa_dan.
        
            ULINE. 
            WRITE: / lv_danidx,'단'.
              " 몇 단인지 출력
        
            lv_idx = 1.
        
          WHILE lv_idx <= 9.
        
            gv_result = lv_danidx * lv_idx.
            WRITE:/ lv_danidx, ' x ', lv_idx , ' = ', gv_result.
        
            lv_idx = lv_idx + 1.
        
          ENDWHILE.
        
          lv_danidx = lv_danidx + 1.
        
        ENDWHILE.
        ELSE.
          WRITE: '9 이하의 값을 입력해주세요.'.
        ENDIF.
        
        *
        *
        ** 강사님 풀이.
        ** 구구단 결과값 변수.
        *DATA gv_result TYPE i.
        *DATA gv_index TYPE i.
        *
        ** selection screen - input/output.
        *PARAMETERS pa_dan TYPE i.
        *
        ** 조건문 1단 이하 , 2 ~ 9단 사이, 9단 이상 처리.
        *IF pa_dan <= 1.
        *    WRITE  '2단 이상을 입력하여 주세요.'.
        *
        ** ELSEIF pa_dan BETWEEN 2 AND 9.
        *ELSEIF pa_dan >= 2 and pa_dan <= 9.
        *
        *  DO  pa_dan TIMES.
        *
        *    gv_index = sy-index.
        **   1단은 표시되지 않을 경우.
        *    IF gv_index = 1.
        *      CONTINUE.
        *    ENDIF.
        *
        *     DO 9 TIMES.
        *      gv_result = gv_index * sy-index.
        *      WRITE:/ gv_index, ' x ', sy-index, ' = ', gv_result.
        *    ENDDO.
        *
        *    ULINE.
        *  ENDDO.
        *
        *ELSE.
        *  WRITE '9단 이하를 입력하여 주세요.'.
        *ENDIF.
        ```
        
    2. 실행 화면
    
    ![image.png](attachment:acf5bd66-a6a0-4a12-8511-1d7d5285da89:image.png)
    

# 🔵 Unit 2.  내부 테이블(Internal Table) 및 SELECT 문 — 테이블에서 데이터 가져오기

1. SELECT SINGLE + 구조체(Structure) 기본 문법 정리
    1. Structure (구조체)  : 
        - DB 테이블의 **한 행(Row)** 과 동일한 형태의 변수
        - 전체 필드(mandt, carrid …)를 한 번에 담을 수 있음
            
            → 즉, 테이블 한 줄을 통째로 담을 수 있는 **그릇**
            
    2. SELECT SINGLE  :
        - DB 테이블에서 **조건을 만족하는 단 1건** 조회
            - 결과를 Structure 같은 Work Area 에 담음
    3. SELECT SINGLE 동작 구조 그림 및 코드
        
        ```json
        REPORT ZABAP_06_G01.
        
        * Structure variable 선언.
        DATA gs_carr TYPE scarr.
        
        * selection screen
        PARAMETERS pa_car TYPE scarr-CARRID.
        
        * data base table 에서 1건의 데이터 읽어옴.
        select SINGLE *
          INTO gs_carr
          FROM scarr
          WHERE carrid = pa_car.
          
          -----------------------------------------------------------------
          SCARR 테이블
        ───────────────────────────────
        | CARRID | CARRNAME | URL | ... |
        ───────────────────────────────
        |   AA   |   아메리칸항공 | ... |
        |   LH   |   루프트한자 | ... |
        |   SQ   |   싱가폴항공 | ... |
        ───────────────────────────────
        
        입력: pa_car = 'LH'
        
        SELECT SINGLE 로 조건에 맞는 **LH 행 전체가 gs_carr 에 담김**
        
        -----------------------------------------------------------------------
        gs_carr 구조체
        ────────────────────────
        CARRID    = 'LH'
        CARRNAME  = 'LUFTHANSA'
        URL       = 'www.lufthansa.com'
        CURRCODE  = 'EUR'
        ────────────────────────
        
        ```
        
    4. se12 화면 : data browser
        
        ![image.png](attachment:dffe8203-e833-486a-a406-ffe814804ec9:image.png)
        
        ![image.png](attachment:5b7f5742-e93b-4250-a491-43326c6ec927:image.png)
        

1. ABAP Dialog Messages 정리
    1. MESSAGE 구문
        
        ```json
        MESSAGE nnn(message_class) [ WITH v1 [ v2 ] [ v3 ] [ v4 ] ].
        ```
        
    2. Dialog Message Type 정리
    
    | Type | Meaning (의미) | Dialog Behavior (동작 방식) | Message Appears In (표시 위치) |
    | --- | --- | --- | --- |
    | **i** | Info Message | Program continues after breakpoint (OK 누르면 계속) | Modal dialog box (팝업) |
    | **s** | Set Message | Program continues without breakpoint (그냥 계속 진행) | Status bar of next screen (상태바) |
    | **w** | Warning | Context-dependent (선택 화면에서는 입력 반복) | Status bar (상태바) |
    | **e** | Error | Context-dependent (즉시 중단 후 Selection Screen 복귀) | Status bar (상태바) |
    | **a** | Termination | Program terminated (프로그램 종료) | Modal dialog box (팝업) |
    | **x** | Short Dump | Runtime error MESSAGE_TYPE_X triggered | Short dump 화면 |
    
    ---
    

# 🔵 Unit 3. Dialog Messages 실습

## ✨ **실습 1 — 메시지 클래스(Message Class) 생성하기**

1. 좌측 **Repository Browser** 에서 패키지 선택
2. 우클릭 → **Create**
3. 메뉴에서
    
    **Other → Message Class** 선택
    
4. 메시지 클래스 이름 입력
    
    ```
    ZMSG_G01
    ```
    
5. 체크(✓) 눌러 생성

> 메시지 클래스는 프로그램에서 사용할 메시지 텍스트를 저장하는 ‘문자열 저장소’ 역할을 함.
> 

---

### 📌  메시지 텍스트 추가하기

메시지 클래스 화면이 열리면 다음과 같이 설정:

- 각 메시지는 번호 000, 001, 002 … 형태
- 우측에 메시지 내용을 입력

예시 메시지 텍스트:

| 번호 | 메시지 내용 |
| --- | --- |
| 000 | 2단을 입력해 주세요.! |
| 001 | 9단을 입력해 주세요.! |
| 003 | Sorry, no data found |
| 004 | & Airline Code : Sorry, no data found! |

> “&” 는 변수 자리 표시자이며 MESSAGE … WITH 구문에서 값이 들어감
> 

![image.png](attachment:3cffb520-e6c2-4e4e-b37d-7ea5de158c58:image.png)

![image.png](attachment:5f278511-d621-4088-a67b-c7b95e6fe664:image.png)

![image.png](attachment:cec1853f-46f7-4959-934c-c9fa9a73f9da:image.png)

## ✨ **실습 2 — MESSAGE 구문으로 메시지 출력하기**

### 📌 MESSAGE 구문 기본 형식

```abap
MESSAGE i003(zmsg_g01) WITH pa_car.
```

- **i003** → `i` 타입(Information) 메시지 + 메시지번호 003
- **(zmsg_g01)** → 사용할 메시지 클래스
- **WITH pa_car** → 메시지 텍스트 안의 **&** 자리에 변수 값 전달

---

### 📌 실행 화면 예

메시지 클래스에 다음 메시지가 있다고 가정:

```
003 & Airline Code : Sorry, no data found!
```

ABAP 코드:

```abap
MESSAGE i003(zmsg_g01) WITH pa_car.
```

입력값 `pa_car = 'ZZ'` → 실행 시 팝업에 표시:

```
ZZ Airline Code : Sorry, no data found!
```

### 📌 MESSAGE 타입별 동작(참고)

| Type | 의미 | 동작 | 표시 위치 |
| --- | --- | --- | --- |
| **i** | Information | OK 누르면 계속 | 팝업(Modal) |
| **s** | Success | 바로 다음 화면으로 | 상태바 |
| **w** | Warning | 입력 반복 | 상태바 |
| **e** | Error | Selection Screen 복귀 | 상태바 |
| **a** | Termination | 프로그램 종료 | 팝업 |
| **x** | Short Dump | 프로그램 덤프 | 시스템 덤프 |

![image.png](attachment:86b5192f-e531-439f-b33e-c8673c969593:image.png)

# 🔵 Unit 4.  ABAP Debugger

### 📌 ABAP Debugger란?

ABAP 프로그램이 실행될 때

**코드를 한 줄씩 멈춰가며 내부 동작을 확인하고, 변수 값·로직 흐름·DB 조회 결과 등을 검증할 수 있는 SAP 도구**야.

> 버그 찾기, 값 확인, 조건문 테스트, 반복문 검증 등 필수 기능.
> 

---

### 🎯 ABAP Debugger 실행 방법 (3가지)

✔ 1) **Break-point 설정 후 실행**

1. ABAP Editor(SE38)에서 코드 열기
2. 멈추고 싶은 라인에 커서 → **F9** (Break-point 설정)
3. 프로그램 실행(F8)
4. 디버거 화면으로 자동 진입

---

✔ 2) **명령어 입력**

코드 내에 직접 입력:

```abap
BREAK-POINT.
```

또는 나만의 사용자 ID로:

```abap
BREAK idanakyoung.
```

---

✔ 3) **/h 명령어 (가장 많이 씀!!)**

프로그램 실행 중 입력창에:

```
/h
```

→ 다음 화면부터 디버거 진입

(Selection-screen 있는 프로그램에서 최고 편함)

![image.png](attachment:9f0ec823-3d39-4dac-877c-d8d35ebd9be7:image.png)

# 🔵 Unit 5.  Modularization Techniques in ABAP

1. Explaining Modularization
    1. ABAP 프로그램을 **구조화된 단위(Module)**로  나누어 유지 보수성과 재 사용성을 높이는 기법.
    2. 유지 보수성, 재 사용성, 가독성, 간결성의 장점을 가짐
2. 서브루틴(Subroutine) : 프로그램 안에서 자주 쓰는 코드를 묶어서 따로 저장하는 기능
    1. Subroutine 구조
        1. 선언(정의) 및 생성
            
            ![image.png](attachment:c73a5388-d8cd-4c5f-9356-ab87da9aa89a:image.png)
            
            ![image.png](attachment:2d63ec2e-271a-473a-a084-3753947f8b51:image.png)
            
            ```json
            FORM form_name.
              " 여기에 기능 넣기
            ENDFORM.
            ```
            
        2. 호출
            
            ```json
            PERFORM form_name.
            ```
            
        3. 실습
            1. 코드
                
                ```json
                *&---------------------------------------------------------------------*
                *& Report ZABAP_07_G01
                *&---------------------------------------------------------------------*
                *&
                *&---------------------------------------------------------------------*
                REPORT ZABAP_07_G01.
                
                * 변수 선언.
                DATA: gv_result TYPE p LENGTH 16 DECIMALS 2.
                
                * selection screen - input/output field.
                PARAMETERS: pa__int1 TYPE i,
                            pa__int2 TYPE i.
                
                * subroutine 호출(실행).
                PERFORM CALCU.
                
                WRITE: 'Result : ', gv_result.
                *&---------------------------------------------------------------------*
                *& Form Calcu
                *&---------------------------------------------------------------------*
                *& text
                *&---------------------------------------------------------------------*
                *& -->  p1        text
                *& <--  p2        text
                *&---------------------------------------------------------------------*
                FORM CALCU .
                
                    gv_result = pa__int1 + pa__int2.
                
                ENDFORM.
                ```
                
            2. 실행화면 
                
                ![image.png](attachment:6327e5ae-fc73-4179-a41c-c1f0d4f223b9:image.png)
                
3. 서브루틴(Subroutine)의 파라미터 적용의 ３가지 방법
    1. CALL BY VALUE
        - 서브루틴/메서드는 **파라미터 값을 복사본으로 받음**
        - 서브루틴 안에서 값을 변경해도 **원본에 영향을 주지 않음**
        - 안전함 (원본보존)
        
        ```json
        FORM demo USING p_val.
          p_val = p_val + 10.
        ENDFORM.
        
        DATA lv TYPE i VALUE 5.
        PERFORM demo USING lv.
        WRITE lv.   " 5 그대로 (원본 변화 없음)
        ```
        
    2. CALL BY VALUE AND RESULT
        - 입력 시: “복사본”을 전달 받음
        - 처리 완료 후: 변경된 값을 **원본에 다시 덮어쓰기**
        
        ```json
        FORM add10 CHANGING VALUE(p_val).
          p_val = p_val + 10.
        ENDFORM.
        
        DATA lv TYPE i VALUE 5.
        PERFORM add10 CHANGING lv.
        WRITE lv.   " 15 (결과가 원본에 반영됨)
        ```
        
    3. CALL BY REFERENCE
        - 파라미터가 복사되지 않고 **원본의 주소(Reference)**를 전달
        - 서브루틴 안에서 값을 바꾸면 **바로 원본이 바뀜**
        - 속도가 제일 빠름
        - 대신 원본 훼손 주의
        
        ```json
        FORM demo CHANGING p_val.
          p_val = p_val + 10.
        ENDFORM.
        
        DATA lv TYPE i VALUE 5.
        PERFORM demo CHANGING lv.
        WRITE lv.   " 15 (원본 수정됨)
        ```
        
    4. 비교
        
        
        | 방식 | 원본 변화 | 속도 | 안전성 | ABAP 키워드 |
        | --- | --- | --- | --- | --- |
        | **Call by Value** | ❌ | 보통 | 가장 안전 | USING, IMPORTING VALUE |
        | **Call by Value and Result** | ⭕ (끝난 후 반영) | 보통 | 보통 | CHANGING VALUE() |
        | **Call by Reference** | ⭕ (즉시 반영) | 가장 빠름 | 위험할 수도 | CHANGING, TABLES |
        
        | 파라미터 유형 | copy-in | copy-out |
        | --- | --- | --- |
        | **USING VALUE(x)** | O | ❌ |
        | **CHANGING VALUE(x)** | O | O ← 이 경우만 결과가 돌아옴 |
        | **CHANGING x** (call by ref) | O | O |
4. 서브루틴(Subroutine)의 파라미터 적용 실습
    1. 코드
        
        ```json
        *&---------------------------------------------------------------------*
        *& Report ZABAP_08_G01
        *&---------------------------------------------------------------------*
        *&
        *&---------------------------------------------------------------------*
        REPORT ZABAP_08_G01.
        
        * 파라미터.
        TYPES tv_result TYPE p LENGTH 16 DECIMALS 2.
        * 변수 선언.
        DATA gv_result TYPE p LENGTH 16 DECIMALS 2.
        
        * selection screen - 인풋/아웃풋 필드.
        PARAMETERS: pa_int1 TYPE i,
                    pa_int2 TYPE i.
        
        PERFORM CALL_BY_VALUE USING pa_int1
                                    pa_int2
                                    gv_result.
        
        *PERFORM CALL_BY_VALUE_result CHANGING pa_int1
        *                                      pa_int2
        *                                      gv_result.
        
        *PERFORM CALL_BY_REFERENCE CHANGING pa_int1
        *                                   pa_int2
        *                                   gv_result.
        
        WRITE:/ 'PA_INT1 VALUE :', pa_int1,
              / 'PA_INT2 VALUE :', pa_int2,
              / 'Result VALUE :', gv_result.
        *&---------------------------------------------------------------------*
        *& Form CALL_BY_VALUE
        *&---------------------------------------------------------------------*
        *& text
        *&---------------------------------------------------------------------*
        *&      --> PA__INT1
        *&      --> PA__INT2
        *&      --> GV_RESULT
        *&---------------------------------------------------------------------*
        FORM CALL_BY_VALUE  USING VALUE(PV_INT1) TYPE i
                                  VALUE(PV_INT2) TYPE i
        *                         VALUE(PV_RESULT) LIKE GV_RESULT.
                                  VALUE(PV_RESULT) TYPE tv_result.
          pv_result = pv_int1 + pv_int2.
        
          pv_int1 = 100.
          pv_int2 = 200.
        ENDFORM.
        *&---------------------------------------------------------------------*
        *& Form CALL_BY_VALUE_result
        *&---------------------------------------------------------------------*
        *& text
        *&---------------------------------------------------------------------*
        *&      --> PA__INT1
        *&      --> PA__INT2
        *&      --> GV_RESULT
        *&---------------------------------------------------------------------*
        FORM CALL_BY_VALUE_RESULT CHANGING VALUE(PV_INT1) TYPE I
                                           VALUE(PV_INT2) TYPE I
                                           VALUE(PV_RESULT) TYPE TV_RESULT.
        PV_RESULT = PV_INT1 + PV_INT2.
        
            PV_INT1 = 100.
            PV_INT2 = 200.
        
        ENDFORM.
        *&---------------------------------------------------------------------*
        *& Form CALL_BY_REFERENCE
        *&---------------------------------------------------------------------*
        *& text
        *&---------------------------------------------------------------------*
        *&      <-- PA__INT1
        *&      <-- PA__INT2
        *&      <-- GV_RESULT
        *&---------------------------------------------------------------------*
        
        FORM CALL_BY_REFERENCE  CHANGING PV_INT1 TYPE I
                                         PV_INT2 TYPE I
                                         PV_RESULT TYPE TV_RESULT.
        PV_RESULT = PV_INT1 + PV_INT2.
        
            PV_INT1 = 100.
            PV_INT2 = 200.
        
        ENDFORM.
        ```
        
    2. 실습 화면 및 요약
        1. 세 가지 한 번에 비교 요약
            
            
            | 방식 | 선언 형태 | 입력 시 | FORM 내부 변경 | FORM 끝난 후 |
            | --- | --- | --- | --- | --- |
            | **CALL_BY_VALUE** | `USING VALUE(...)` | copy-in만 | 내부 복사본만 변경 | 원본 그대로 (10,20,0) |
            | **CALL_BY_VALUE_RESULT** | `CHANGING VALUE(...)` | copy-in | 내부 복사본 변경 | copy-out → 원본 (100,200,30) |
            | **CALL_BY_REFERENCE** | `CHANGING ...` | 참조 | 내부에서 바꾸면 원본 즉시 변경 | 이미 바뀜 (100,200,30) |
        2. 실습화면
            1. 공통 input field parameter
                
                ![image.png](attachment:a14c8cab-be07-4aec-8e2f-056a0ba7b7c7:image.png)
                
            2. 각각 output field
                1. **CALL_BY_VALUE**
                    
                    ![image.png](attachment:15fb1dd2-2223-43d9-ad04-cadd68eb6be7:image.png)
                    
                    1. 선언 방식의 두 가지 차이
                        1. 코드 예시 
                            
                            ```json
                            FORM CALL_BY_VALUE  USING VALUE(PV_INT1) TYPE i
                                                      VALUE(PV_INT2) TYPE i
                                                      VALUE(PV_RESULT) LIKE GV_RESULT.
                                                      VALUE(PV_RESULT) TYPE tv_result.
                            ```
                            
                        2. 요약
                            
                            
                            | 선언 방식 | 의미 | 타입 변경 영향 |
                            | --- | --- | --- |
                            | **LIKE gv_result** | gv_result의 타입을 “참조” | gv_result 타입이 바뀌면 PV_RESULT도 자동 변경 |
                            | **TYPE tv_result** | tv_result 타입을 “명시적”으로 사용 | tv_result가 바뀌지 않는 한 고정됨 |
                2. **CALL_BY_VALUE_RESULT**
                    
                    ![image.png](attachment:73f90e42-ba53-48d6-a829-67f4fc099df5:image.png)
                    
                3. **CALL_BY_REFERENCE**
                    
                    ![image.png](attachment:0e238a35-d87a-48c3-a013-631f0c28ca08:image.png)
                    
                4. **CALL_BY_VALUE_RESULT 와 CALL_BY_REFERENCE 의 차이점**
                    
                    
                    | 구분 | **CALL_BY_VALUE_RESULT**<br>(CHANGING VALUE) | **CALL_BY_REFERENCE**<br>(CHANGING) |
                    | --- | --- | --- |
                    | **파라미터 선언** | `CHANGING VALUE(pv_var)` | `CHANGING pv_var` |
                    | **전달 방식** | **copy-in / copy-out 방식** | **참조(reference) 전달 방식** |
                    | **진입할 때** | 원본 값을 **복사본**으로 전달 | 원본 주소를 그대로 전달 |
                    | **FORM 내부에서 값 수정** | 복사본만 수정됨 → 원본은 변하지 않음 | 수정 즉시 원본이 바로 바뀜 |
                    | **FORM 종료 시** | 복사본 값이 **원본으로 복사되어 덮어씀** | 이미 원본이 수정된 상태라 추가 작업 없음 |
                    | **메모리 관점** | 원본과 다른 독립된 버퍼 사용 | 원본과 동일 메모리 사용 |
                    | **부작용(side effect)** | 낮음 → FORM 안에서 변경해도 안전 | 높음 → FORM 내부 변경이 즉시 원본 영향 |
                    | **안전성** | 더 안전함 (원본 보호 후 마지막에만 반영) | 위험성 있음 (실수로 원본 훼손 가능) |
                    | **성능** | copy-in/out 오버헤드 있음 | 빠름 (복사 없음) |
                    | **사용 목적** | 값은 전달하되 FORM 내부 영향은 제한하고 싶을 때 | FORM 내부에서 직접 원본 값을 다루고 싶을 때 |
                    | **최종 값** | 동일: 원본 = 내부 복사본 값 | 동일: 원본 = 내부에서 변경된 값 |
