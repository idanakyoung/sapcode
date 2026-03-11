# 🧭 Lesson 11 – ABAP Dictionary Object / Dependency / Table Change / View

---

## 0) 전체 흐름(공통 뼈대)

```
ABAP Dictionary Object 확인
  1) Active / Inactive Version 이해
  2) Domain → Data Element → Structure/Table → Program 의존관계 파악
  3) Table 변경 시 DB 반영 방식 이해
  4) Append Structure로 표준 테이블 확장
  5) View / Maintenance View 차이 정리
```

---

## 1) Unit 1. ABAP Dictionary Object

### 핵심

- SAP Dictionary 오브젝트(SE11)는 항상 **두 가지 버전**을 가진다.
- **Active Version** = 시스템에서 실제 사용되는 버전
- **Inactive Version** = 개발자가 수정했지만 아직 Activate 하지 않은 버전

### 개념 정리

### 1-1) Active Version

- 현재 시스템에서 실제로 동작하는 버전
- ABAP 프로그램은 항상 **Active Version 기준**으로 동작
- DB 테이블도 Active 상태 기준으로 사용됨

### 1-2) Inactive Version

- 수정 중인 임시 변경본
- 아직 시스템 운영에는 반영되지 않음
- Activate 해야 Active Version으로 전환됨

### 포인트

- SE11에서 수정했다고 바로 반영되는 것이 아님
- **저장(Save)** 과 **활성화(Activate)** 는 다름
- 운영 반영 기준은 항상 **Active Version**

---

## 2) Unit 2. Identifying Dependencies with ABAP Dictionary Objects

### 핵심

- DDIC 오브젝트는 서로 **계층 구조로 연결**되어 있다.
- 하위 오브젝트를 바꾸면 상위 오브젝트에 영향이 갈 수 있다.
- 대표 흐름은 아래와 같다.

```
Program
   ↓
Table / Structure
   ↓
Data Element
   ↓
Domain
```

---

### 2-1) Domain

- DDIC 오브젝트 중 가장 기초 정의
- 데이터 타입, 길이, 값 범위(Value Range)를 정의
- 예:
    - `CHAR 10`
    - `NUMC 3`
    - `DEC 11(2)`

### 포인트

- 기술적 속성의 출발점
- 길이, 타입, 허용값 같은 “기본 규칙” 담당

---

### 2-2) Data Element

- Domain을 기반으로 필드의 **의미(semantic)** 를 정의
- 필드 레이블, 검색 도움(Search Help) 등 추가 정보 포함
- 여러 Data Element가 하나의 Domain을 공유할 수 있음

### 포인트

- Domain이 “기술 타입”이라면
    
    Data Element는 “업무적 의미”를 붙이는 역할
    
- 같은 타입이라도 의미가 다르면 Data Element를 따로 둘 수 있음

---

### 2-3) Structure / Table

### Structure

- Data Element들로 구성되는 논리 구조
- DB에 실제 생성되지 않음
- 프로그램에서 타입 정의, work area 등에 사용

### Table

- 실제 데이터가 저장되는 물리 테이블
- 각 필드는 Data Element를 참조
- 변경 시 DB 구조에도 영향 발생

### 포인트

- **Structure = 논리형**
- **Table = 물리형(DB 저장)**
- 테이블 수정은 단순 코드 수정이 아니라 DB 변경까지 연결될 수 있음

---

### 2-4) Table 간 관계

- 테이블은 다른 구조나 테이블의 필드를 포함할 수 있음
- 대표 예시
    - Include Structure
    - Foreign Key
    - View / Join을 통한 논리 연결

### 포인트

- DDIC 오브젝트는 독립적이지 않고 연결되어 있음
- 그래서 수정 전 **Where-Used List** 확인이 중요함

---

### 2-5) Program 레벨

- ABAP 프로그램은 Table / Structure를 참조해 데이터 처리
- 예:
    - `SELECT`
    - 변수 타입 선언
    - 내부 테이블 타입 정의

### 의존 흐름

```
Program → Table/Structure → Data Element → Domain
```

### 포인트

- 아래쪽(Domain) 수정이 위쪽(Program)까지 연쇄 영향 가능
- 특히 길이/타입 변경은 영향 범위가 큼

---

### 2-6) Where-Used List

### 핵심

- 특정 오브젝트가 어디에서 사용되는지 추적하는 기능
- DDIC 오브젝트에서 **F7** 또는 메뉴로 확인 가능

### 역추적 흐름

```
Where-Used List

Domain
  ↓
Data Element
  ↓
Table Field
  ↓
ABAP Program
```

### 예시

- Domain 기준 → 어떤 Data Element가 참조하는지
- Data Element 기준 → 어떤 테이블 필드가 사용하는지
- Table 기준 → 어떤 프로그램이 사용하는지

### 포인트

- 수정 전에 반드시 영향도 확인
- 시험에서도 **의존관계 추적 도구**로 자주 나옴

---

## 3) Unit 3. Table Changes

---

## 3-1) Topic A. Performing a Table Conversion

### 핵심

- 테이블을 변경하고 Activate 하면 시스템은 DB 반영 방식을 판단한다.
- 반영 방식은 보통 아래 3가지다.
    - 삭제 후 재생성
    - `ALTER TABLE`
    - Table Conversion

---

### 3-1-1) Changes to Database Tables

- ABAP 프로그램은 항상 **Active Version 기준**으로 테이블을 읽음
- 테이블 구조 변경 후 Activate 시
    - DB에 단순 조정 가능한지
    - 변환이 필요한지
        
        시스템이 판단함
        

---

### 3-1-2) Structure Adjustment 방식

### 1) 테이블 삭제 후 재생성

- DB 테이블 삭제
- Dictionary Active Version 기준으로 다시 생성
- **기존 데이터 모두 삭제**

### 2) ALTER TABLE

- DB 구조를 직접 변경
- 기존 데이터 유지 가능
- 경우에 따라 인덱스 재생성 필요

### 3) Table Conversion

- 가장 시간이 오래 걸리는 방식
- DB 시스템이 단순 ALTER를 지원하지 않거나
- 구조 변경 영향이 클 때 수행
- 대량 데이터가 있으면 오래 걸릴 수 있음

---

### 3-1-3) 데이터 존재 여부에 따른 처리

- **데이터 없음**
    - 삭제 후 새 구조로 바로 생성 가능
- **데이터 있음**
    - `ALTER TABLE` 또는 Conversion 필요

### 포인트

- 데이터 유무가 처리 방식에 큰 영향
- 운영 테이블은 변환 전에 영향도 꼭 확인

---

### 3-1-4) Table Conversion 판단 기준

테이블 변환 방식은 다음 요소에 따라 달라진다.

- 구조 변경 종류
- 사용 중인 DB 시스템
- 테이블에 데이터가 있는지 여부

### 예시 상황

```
Inactive Version
Field 3 length = 30

Active Version
Field 3 length = 60

DB Table
Field 3 length = 60
```

- 현재 DB는 Active Version과 동일
- 이 상태에서 Activate 하면
- 시스템이 길이 축소(60 → 30)를 바로 반영 가능한지 판단함

### 포인트

- 길이 축소는 데이터 손실 가능성이 있어 더 주의해야 함
- 단순 Activate로 끝나는 게 아니라 DB 조정 단계가 따라옴

---

### 3-1-5) Adjust / Convert 관련 버튼 의미

```
Adjust Database
Convert Data
Activate and Adjust
```

### 주의

- **Delete data 눌러서 조정하지 말기**
- 모든 Client 데이터가 삭제될 수 있음

### 포인트

- 실무에서 가장 위험한 실수 포인트
- “조정”과 “데이터 삭제”는 완전히 다름

---

## 3-2) Topic B. Enhancing Tables with Append Structures

### 핵심

- 표준 테이블을 직접 수정하지 않고 **필드를 추가 확장**하는 방식
- SAP 표준 객체 확장 시 가장 안전한 방법
- Append Structure의 필드는 원본 필드 뒤 **마지막 위치**에 붙음

---

### 3-2-1) Append Structure란?

- 기존 테이블/구조를 확장하기 위해
- 추가 필드를 별도 구조로 정의하는 방식

### 필드 명명 규칙

- 보통 **ZZ**또는 **YY**로 시작
- 고객 확장 필드임을 의미

### 내부 동작

1. SAP 표준 테이블 기본 필드 로드
2. Append Structure 검색
3. Append 필드를 표준 필드 뒤에 병합
4. 최종 구조를 DB / 프로그램에 제공
5. Activate 수행

### 포인트

- SAP 표준 수정 없이 확장 가능
- Upgrade 시에도 비교적 안전

---

### 3-2-2) Append Structure 주의사항

- 기존 필드 길이/타입 변경 불가
- 중간 삽입 불가, 항상 마지막에 추가
- 동일 필드명 중복 불가
- 대량 데이터 테이블은 조정 시간이 길어질 수 있음

### 포인트

- Append는 “추가”만 가능
- “기존 필드 수정”은 Append로 해결 불가

---

### 3-2-3) 실습 1 – Structure 사용 예시

### 예시 구조체

```
Structure ZDEPMENTG01

CARRIER
DEPARTMENT
TELNR
FAXNR
LAST_CHANGED_BY
CHANGED_ON
```

### 코드

```
*&---------------------------------------------------------------------*
*& Report ZABAP_23_G01
*&---------------------------------------------------------------------*
REPORT ZABAP_23_G01.

* Structure Variable.
DATA GS_DEPT TYPE ZDEPMENTG01.

GS_DEPT-CARRIER         = 'AA'.
GS_DEPT-DEPARTMENT      = 'ADMI'.
GS_DEPT-TELNR           = '02-2445-8743'.
GS_DEPT-FAXNR           = '02-2445-8743'.
GS_DEPT-LAST_CHANGED_BY = '010001'.
GS_DEPT-CHANGED_ON      = SY-DATUM.

WRITE : GS_DEPT-CARRIER,
        GS_DEPT-DEPARTMENT,
        GS_DEPT-TELNR,
        GS_DEPT-FAXNR,
        GS_DEPT-LAST_CHANGED_BY,
        GS_DEPT-CHANGED_ON.
```

### 포인트

- Structure는 DB 저장 없이 프로그램 타입으로 바로 활용 가능
- DDIC 구조를 만들어두면 프로그램 선언이 편해짐

---

### 3-2-4) 실습 2 – SCARR Copy 구조에 Append 추가

### 예시 결과

```
SCARR

CARRID
CARRNAME
CURRCODE
URL

Append Structure

ZZ_DEPT
ZZ_MANAGER
ZZ_LOCATION
```

### 정리

- Append Structure는 항상 마지막 위치에 붙음
- 필드명은 `ZZ*`, `YY*` 형태 권장
- 원본 구조를 직접 건드리지 않음
- 여러 번 활성화해도 비교적 안전
- Upgrade 시 자동 병합됨

---

## 4) Topic C. Views and Maintenance Views

### 핵심

- View는 실제 데이터를 저장하지 않는 **논리적 테이블**
- 여러 테이블을 결합하거나 필요한 필드만 보여주는 데 사용
- View 종류에 따라 Join / Projection / Selection 지원 범위가 다름

---

### 4-1) Database View란?

- 실제 데이터를 저장하지 않음
- 여러 테이블 데이터를 Join해 하나의 구조처럼 보여줌
- Projection(필드 선택), Selection(조건) 가능
- Open SQL에서 일반 테이블처럼 사용 가능(제약 있음)

### 역할

- 여러 테이블 데이터 결합
- 특정 필드만 표시
- 조건에 맞는 데이터만 조회
- 유지보수 화면용 기반 제공

---

### 4-2) View 종류 비교

| View 종류 | Join | Projection | Selection | 목적 | DB에 생성? |
| --- | --- | --- | --- | --- | --- |
| Database View | O | O | O | 여러 테이블 결합 조회 | O |
| Projection View | X | O | X | 단일 테이블 필드 제한 | X |
| Help View | O | O | O | Search Help(F4) | 경우에 따라 다름 |
| Maintenance View | X(논리적 연결) | O | O | SM30 유지보수 | X |

---

### 4-3) Database View

### 핵심

- 여러 테이블을 **Inner Join**
- DB 레벨에 실제 View 생성
- Open SQL 사용 가능
- Join 조건 필요

### 사용 목적

- 논리적으로 연결된 데이터를 하나처럼 조회할 때

### 포인트

- Join 조건 없으면 의미 없는 데이터 조합 발생
- 실무 조회용으로 자주 사용

---

### 4-4) Projection View

### 핵심

- 단일 테이블에서 필요한 필드만 선택
- Join 불가
- Projection만 가능

### 특징

- 불필요한 필드 제거
- 구조를 단순화
- 유지보수 화면(SM30) 생성 불가

### 사용 목적

- 간단한 조회 전용 View

---

### 4-5) Help View

### 핵심

- F4 Search Help용 View
- 여러 테이블을 Outer Join 가능
- Selection 조건 사용 가능

### 사용 목적

- 검색 도움 값 목록 제공

### 포인트

- 일반 조회보다 **Search Help 연결 목적**이 강함

---

### 4-6) Maintenance View

### 핵심

- 여러 테이블을 하나의 유지보수 객체처럼 관리
- Foreign Key 기반 Parent–Child 관계 사용
- SM30에서 유지보수 화면 제공

### 특징

- Join이 아니라 **logical table grouping**
- DB에 실제 View 생성 안 됨
- INSERT / UPDATE / DELETE 화면 자동 제공 가능

### 사용 목적

- 여러 관련 테이블을 동시에 관리할 때

### 포인트

- 조회용보다는 **유지보수 화면용** 개념으로 이해해야 함

---

## 5) Projection / Selection / Join Condition 정리

---

### 5-1) Projection (Field Selection)

### 정의

- 원본 테이블의 필드 중 필요한 필드만 View에 포함시키는 것

### 목적

- 구조 단순화
- 성능 개선
- 불필요한 정보 숨김
- 업무 화면 맞춤형 필드 구성

### 예시

원본 `SFLIGHT`

```
CARRID / CONNID / PRICE / CURRENCY / PLANETYPE
```

View에서는 `PLANETYPE` 제외

```
CARRID / CONNID / PRICE / CURRENCY
```

### 포인트

- 원본 데이터가 삭제되는 것이 아님
- 보여주는 필드만 제한하는 개념

---

### 5-2) Selection Condition

### 정의

- View에 WHERE 조건처럼 고정 필터를 두는 것

### 목적

- 특정 데이터만 표시
- 필터링된 결과만 제공
- 특정 고객/통화/기간 데이터만 보여줄 때 사용

### 특징

- 조건을 만족하지 않는 데이터는 View에 보이지 않음
- Maintenance View에서도 관계 제어용으로 중요

### 포인트

- “필드 선택”이 아니라 “행 필터링”

---

### 5-3) Join Condition

### 정의

- 여러 테이블을 어떤 기준으로 연결할지 정하는 조건

### 특징

- Database View는 반드시 Join 조건 필요
- Help View는 Outer Join 가능
- Join 조건이 없으면 Cross Product 발생 가능

### 포인트

- View 설계의 핵심
- 잘못 걸면 데이터가 폭증하거나 의미 없어짐

---

## 6) Unit 3 전체 비교(한 눈에)

| 항목 | 핵심 | 특징 | 주의점 |
| --- | --- | --- | --- |
| Active / Inactive Version | 활성/비활성 버전 구분 | 시스템 반영 여부 차이 | Save ≠ Activate |
| Dependency | Domain부터 Program까지 연결 | 수정 영향 전파 가능 | Where-Used 확인 필수 |
| Table Conversion | DB 구조 조정 방식 | 삭제/ALTER/Conversion | 데이터 유실 주의 |
| Append Structure | 표준 테이블 확장 | 마지막 필드 뒤에 추가 | 기존 필드 수정 불가 |
| Database View | 여러 테이블 Join 조회 | DB View 생성 | Join 조건 필수 |
| Projection View | 단일 테이블 일부 필드만 | 단순 조회용 | Join 불가 |
| Help View | Search Help용 | Outer Join 가능 | F4 목적 |
| Maintenance View | SM30 유지보수용 | 논리적 테이블 그룹 | 조회용 View와 다름 |

---

## 7) 시험 포인트 / 실무 포인트

### 7-1) 시험 포인트

- **Active Version / Inactive Version 차이**
- **Domain → Data Element → Table → Program 의존관계**
- **Where-Used List 역할**
- **Table Conversion / Adjust Database 차이**
- **Append Structure는 마지막에만 붙는다**
- **Database View / Projection View / Help View / Maintenance View 차이**

### 7-2) 실무 포인트

- DDIC 수정 전 반드시 **Where-Used List 확인**
- 운영 테이블 변경 시 데이터 유실 여부 먼저 확인
- 표준 테이블 확장은 직접 수정 말고 **Append Structure**
- 조회용 View와 유지보수용 View를 구분해서 사용

---

## 8) Lesson 11에서 제일 중요한 결론

- **SE11 수정은 저장만으로 끝나지 않고 Activate가 핵심**
- **DDIC는 Domain → Data Element → Table/Structure → Program으로 연결됨**
- **테이블 변경은 DB 구조 변화까지 연결되므로 신중해야 함**
- **표준 테이블 확장은 Append Structure가 정석**
- **View는 목적에 따라 Database / Projection / Help / Maintenance로 구분해서 이해해야 함**
