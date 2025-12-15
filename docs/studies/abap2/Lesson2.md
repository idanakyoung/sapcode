# 🧭 Lesson 2 -  **Screen Program (2)**

# 🔵 **Unit 1.  Designing Screen Squence**

## 🌳 SAPMZSCR_G01 - 스크린 이동 + Insert 스크린 삽입 실습

![image.png](attachment:affc9495-5ed9-418b-ac36-09841b6a192a:image.png)

→ 스크린 200 생성

![image.png](attachment:a0b7e3a1-5385-4248-b9de-845cee5e70f6:image.png)

→ 200 짧은 설명 적고 레이아웃 켜기

![image.png](attachment:90788d30-334c-413a-a1e8-db5ae8904a67:image.png)

→ 이런 식으로 스크린 200, 300 저장

![image.png](attachment:627974d2-a382-477c-ad20-796a9c0bb304:image.png)

→ Next Dynpro : 100은 200 / 200은 300 / 300은 0으로 설정 

![image.png](attachment:ac22ecd7-13e2-4a7b-989b-222b93530efe:image.png)

→ 스크린 100에서 PAI 코드 추가 

```jsx
  SET SCREEN 300.
  LEAVE SCREEN.
  
  * 또는 
  
  LEAVE TO SCREEN 300.
```

![image.png](attachment:c316d057-e202-436d-976d-c6a95e493508:image.png)

→ Insertiong Screen

```jsx
  CALL SCREEN 300.
```

→ 실습 한 거 원래대로 주석하고 본인 다음 스크린 본인 걸로 지정

![image.png](attachment:ad25efc3-4779-4b8e-bb42-d2f6ebe3cd31:image.png)

→ 스크린 100에 코드 추가 

```jsx
  MODULE SET_CURSOR.
```

→ 더블 클릭 후 PBO 전용으로 모듈 클릭 후 생성

![image.png](attachment:087f88c0-d944-4a98-b169-49cfa998f71a:image.png)

→  CURSOR 지정 및 디폴드 값 설정 가능 

```jsx
  SDYN_CONN-CARRID = 'UA'.
  SET CURSOR FIELD 'SDYN_CONN-CONNID'.
```

![image.png](attachment:e8c9e1d2-5d25-40af-a77d-03e4b0b0c4bc:image.png)

→ 스크린 150 생성

![image.png](attachment:fcee5145-9e2f-4ee4-8cfa-cc0d4113601e:image.png)

→ 속성 상세 참고해서 입력

→ 레이아웃 열기

![image.png](attachment:d617e54d-fed5-421f-aa0f-4da3f6f0a930:image.png)

→ 해당 화면 클릭

![image.png](attachment:7c2de466-bb98-4575-ac79-40baa759ae29:image.png)

→ 행 선택하고 엔터

![image.png](attachment:4fae6623-313c-4043-a2b4-63ca4be07c85:image.png)

→ 전부 다 Output만 가능하게 설정

![image.png](attachment:1decfe9c-a659-437e-a33b-93e65c230889:image.png)

→ 코드 작성 후 PBO로 생성 

```jsx
  MODULE GET_CARRIER.
```

→ 더블 클릭 후 코드 작성

![image.png](attachment:ef7d226d-d00a-4cfc-8a64-e9d749bfb060:image.png)

```jsx
MODULE GET_CARRIER OUTPUT.
  SELECT SINGLE *
    FROM SCARR
    WHERE CARRID = SDYN_CONN-CARRID.
ENDMODULE.
```

→ 100번 스크린에 P를 입력하면 150스크린으로 이동하는 실습 START

![image.png](attachment:53a765fb-1315-4040-862e-23208e68d6b6:image.png)

→ 추가 

```jsx
    WHEN 'P'.
      CALL SCREEN 150
      STARTING AT 5 5.
  ENDCASE.
```

![image.png](attachment:ac11b32c-f77e-4957-aed6-eef6f16f0214:image.png)

→ 150 스크린 가서 레이아웃 들어가서 크기 수동 변경하면 UI 크기 수정 가능 

→ 저장 필수 

![image.png](attachment:29d98a30-acbb-48bd-8ffe-66dedcb2f2fc:image.png)

→ 크기 줄어듬

![image.png](attachment:afc67e8a-3821-46b0-bd05-59b3f36064f6:image.png)

→ 끝점 수정

→ 너무 작게 주면 내용 이동 스크롤 생김

# 🔵 **Unit 2.  SAP GUI User Interface 구성 요소별 역할 정리**

## 📘  **SAP GUI User Interface 구성 요소 이론**

### 1. GUI Title

1. 역할
- 화면 상단 제목줄을 설정하는 요소
- 사용자에게 “지금 어떤 화면인지” 알려줌
- 화면 전환 시 타이틀 변환으로 프로그램 흐름 이해를 도와줌

 b.  개발 관점

- `SET TITLEBAR 'TITLE'.` 로 ABAP에서 호출
- Title 객체 안에 실제 표시되는 문구를 저장
- 동일한 타이틀을 여러 화면에서 재사용 가능

### 2. GUI Status

1. 역할
- 특정 화면(Screen)에 필요한 모든 UI 요소를 하나로 묶은 구조
- 메뉴, 버튼, 단축키 등 “사용 가능한 기능 전체”를 정의함
- 화면에서 사용할 수 있는 기능을 제한하거나 확장하는 핵심 요소

b.  중요한 이유

- Status에 없는 기능은 화면에서 호출할 수 없음
- 화면(Screen)마다 필요한 기능 구성이 다르므로, Status도 화면마다 따로 설정
- 프로그램 흐름 제어의 중심이 되는 요소

### 3. Menu Bar

### 역할

- 화면 상단에서 제공되는 메뉴 그룹
- 기능을 체계적으로 구분하여 사용자가 기능을 계층적으로 찾을 수 있게 함

### 특징

- 하나의 메뉴에 최대 15개 항목
- 최대 3단계까지 하위 메뉴 구성
- 정적 텍스트 또는 동적 텍스트(변수 연결) 사용 가능

### 개발 의미

- 프로그램의 기능 구조를 설계하는 단계
- 메뉴를 다른 프로그램에서 재사용 가능

### 4. Standard Toolbar

### 역할

- SAP 시스템 전체에서 공통으로 제공되는 기본 기능 버튼
- 뒤로, 종료, 저장, 인쇄와 같은 SAP 공통 기능 제공

### 특징

- 기능 고정
- 현재 화면 상황에 따라 활성/비활성 조절 가능

### 5. Application Toolbar

### 역할

- 해당 화면에서 가장 많이 사용하는 기능들을 아이콘 형태로 배치
- 표준 툴바에 없는 “프로그램 자체 기능”을 제공

### 특징

- GUI Status 안에서 개발자가 직접 구성
- F code(기능 코드)와 연결되어 실제 기능 수행
- 사용자 작업 속도를 높이는 UI 요소

### 6. Function Key Settings (F1~F12)

### 역할

- 특정 기능을 단축키로 빠르게 실행할 수 있도록 기능을 매핑
- 버튼 없이도 기능을 호출 가능하게 하는 구조

### 종류

- Standard function key
- Reserved function key
- Freely assigned key

### 개발 활용

- 반복 사용 기능을 단축키에 배정해 효율성을 높임
- 같은 기능도 화면 종류(Screen/Dialog)에 따라 다른 F키 매핑 가능

### 7. Function List (F Code)

### 역할

- 프로그램에서 수행 가능한 모든 기능을 정의한 목록
- 버튼, 메뉴, 단축키가 어떤 기능을 실행할지 결정하는 핵심 코드

### 왜 중요한가

- 개발자가 PAI 모듈에서 기능 처리를 할 때 기준이 됨
- F code가 없으면 기능 처리가 불가능

### F Type 기능 구분

- Normal
- Exit
- System
- Transaction
- Tabstrip control
- Help 등

### 8. Menu Attributes / Menu Bar Attributes

### 역할

- 메뉴에 표시될 텍스트, 단축키(Fastpath), 동적/정적 여부 등 세부 설정
- 메뉴 표시 방식과 기능 설명을 세밀하게 관리

### 동적 텍스트 필요성

- 화면 데이터에 따라 메뉴 이름을 변경해야 할 때 사용
    
    예: “선택한 항목 수: 10”
    

## 🌳 SAPMZSCR_G01 - **GUI User Interface 실습**

![image.png](attachment:3c89a9a5-7e6c-41eb-af54-22e415f5947d:image.png)

→ STATUS 주석 풀고 더블 클릭

![image.png](attachment:6650598e-d9af-444a-860a-6fe40f5b2b0b:image.png)

→ 주석 풀어주고 제목 바 이름은 소문자 X

![image.png](attachment:de774eb9-f8b6-46c8-a221-d20880db7fb8:image.png)

→ 타이틀 이름 더블 클릭 후 생성

![image.png](attachment:a1265792-1449-425b-ba2d-962484e1ecd2:image.png)

→ 타이틀 바에 표시하고자 하는 타이틀 텍스트 입력 

→ ALL Title 클릭

→ 액티브

![image.png](attachment:95ed75e6-ba9a-463e-a649-f74dc8d29895:image.png)

→ &기호는 총 9개까지 올 수 있음 

→ ALL Title 클릭

→ 액티브

![image.png](attachment:009d5f3c-17b4-4029-a773-0726b0c3c012:image.png)

→ 코드 추가 

```jsx
MODULE STATUS_0100 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
  SET TITLEBAR 'T100' WITH SDYN_CONN-CONNID. "TEXT-T01. "SY-UNAME. "'AA'.
ENDMODULE.
```

![image.png](attachment:b7babc95-b489-4235-87dc-cbd78e8b1342:image.png)

→ 결과 화면 

![image.png](attachment:0020be9c-971f-448a-b947-2bd64548c458:image.png)

→ 스크린 150 주석 풀고 액티브 및 더블 클릭 저장

![image.png](attachment:0661bd2b-b2cd-467f-ad6a-1b580b1883f5:image.png)

→ O01가서 더블 클릭 후 생성

![image.png](attachment:8ae24353-870b-4255-9579-2821d17646d3:image.png)

→ 타이틀 바 → ALL Title → 액티브 

![image.png](attachment:fa3c666c-225b-4d2e-a354-7a406d5c3691:image.png)

→ 코드 작성

```jsx
MODULE STATUS_0150 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
  SET TITLEBAR 'T150' WITH SDYN_CONN-CARRID.
ENDMODULE.
```

![image.png](attachment:da3c0561-7a02-4bf8-a220-933995ab3a4f:image.png)

→ 결과 화면

![image.png](attachment:158c5042-bdfc-44a7-8d07-46f4f5c16354:image.png)

→ 스크린 100에서 상태 주석 풀기

![image.png](attachment:01b059b4-0769-4ae4-bbe1-c3de1327ea0b:image.png)

→ 더블 클릭 후 

![image.png](attachment:cc5c8b45-e1da-4141-ad2a-1004dcb60c11:image.png)

→ 다음과 같이 입력 

![image.png](attachment:b65a05da-86e9-4a9d-ba35-c4cdf88c8276:image.png)

→ Function Key 열고 Back Key 지정

![image.png](attachment:c8c85c8d-da48-4479-ad46-74de443936d2:image.png)

→ 해당 기입

![image.png](attachment:df89f923-938c-436f-84d4-d1e13d4bf83a:image.png)

→ Application Toolbar 상세 누르고 첫 번째 칸 F4

→ 해당 값 더블 클릭

→ 액티브 

→ F3

→ 액티브

![image.png](attachment:567efa00-ae67-4b07-b313-063b437d88aa:image.png)

→ 스크린 150 상태 주석 풀기 

→ 원하는 이름으로 상태 이름 지정

![image.png](attachment:35c5ed73-036e-476e-b090-d3d916bcfdc8:image.png)

→ 더블 클릭 후 생성 

![image.png](attachment:7fc73b58-5be9-487c-b9f4-f1c05ab6620a:image.png)

→ Dialog Box 이기에 때문에 해당 두 번째 라디오 버튼 클릭 

![image.png](attachment:34dc8853-21db-4eea-8c16-5f12f9ac1c27:image.png)

→ Function key 지정

![image.png](attachment:89c65e87-49f7-4c46-a7a5-f44ab27713fa:image.png)

→ Application Toolbar  더블클릭

![image.png](attachment:551a72d9-80a1-4175-8b47-bb2a435a06bb:image.png)

→ 스크린 150 의 Element list 에 와서 마지막 행에 OK_CODE 작성

![image.png](attachment:fb28aaa9-d6c3-41ea-83da-6fa03d15bcec:image.png)

→ 스크린 150 의 커멘드 주석 풀기 

![image.png](attachment:cb47962d-c7ae-4cf1-b90b-1b934fff66ad:image.png)

→ 더블 클릭 후 

![image.png](attachment:9c40ed11-1ec3-4b05-8a03-45d0812db3a5:image.png)

→ PAI 이므로 I01에 지정

![image.png](attachment:68a5f97c-f5ba-49f2-a7c1-44880f5ee28d:image.png)

→ 코드 작성 

```jsx
MODULE USER_COMMAND_0150 INPUT.
  CASE OK_CODE.
      WHEN 'OKAY'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
```

![image.png](attachment:c2afbec3-4cce-468f-8a72-8c711183dff9:image.png)

→ 코드 작성

```jsx
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'POPUP'.
      CALL SCREEN 150
        STARTING AT  5 5.
```

![image.png](attachment:87db9aa2-7d00-4993-bc5f-309c51130ab0:image.png)

→ 결과 화면 (BACK icon, Popup Button, 다이얼로그 박스 안 확인 처리)

![image.png](attachment:5de62d08-f8d9-42a8-bb5a-276b7a5ccf70:image.png)

→ 상태 이름 더블 클릭 

![image.png](attachment:32c28493-e0ec-4d70-904f-024712d4d9ea:image.png)

→ Popup 글자 더블 클릭 

![image.png](attachment:b1f239a8-6b04-44ff-ac3b-2e94a2681760:image.png)

→ F4

![image.png](attachment:5eb8d08f-3fa6-44ca-bf78-b468ede65492:image.png)

→ Icon Name 이랑 Icon Text  같이 노출 가능 

![image.png](attachment:55b7d824-5ac8-490e-a2ec-1e7471c526a7:image.png)

→ 결과 화면

![image.png](attachment:9bdbf650-4fa3-430b-b6e3-e26c46124a61:image.png)

→ 메뉴 바에서 메뉴 이름 작성 후 더블 클릭 

→ code 와 Text나옴

![image.png](attachment:5bab7084-d5c2-4216-ba80-24006daa9cf9:image.png)

→ 코드와 상세 직접 입력 혹은 F4키 눌러서 클릭 해도 됨 

![image.png](attachment:d450fd6b-f4ae-4b39-958f-71e37dbfe0dd:image.png)

![image.png](attachment:82fd9686-1c6e-4a61-84ac-318ad6712191:image.png)

→ 결과 화면

![image.png](attachment:b0f6f822-9be0-48c2-ade6-65059fd1f6ea:image.png)

→ PBO 모듈 추가 

![image.png](attachment:7b4bef58-9f12-4de3-8136-280daf56e38b:image.png)

→ O01에 할당

![image.png](attachment:a7673592-f6fd-40b2-9873-1cb67fc538df:image.png)

→ clear code 모듈 생성

![image.png](attachment:cef242bc-2719-489c-88ec-b406299a8ad2:image.png)

→ 까먹지 말기

![image.png](attachment:fee73f91-e6a9-41db-9915-342e3cdca8c0:image.png)

→ 까먹지 말기 2

## 🌳 SAPMZQUIZ_S01_G01

![image.png](attachment:90ed643d-7ec9-4c3e-a23d-b4a9da47ba63:image.png)

🌟 데이터를 읽어오는 두 가지 방법

① DB → 화면(SCUSTOM)에 바로 넣는 방식 (간단)

```abap
*--------------------------------------------------------------------*
* [방법 1] DB에서 읽은 데이터를 화면 구조(SCUSTOM)에 바로 넣기
*--------------------------------------------------------------------*
SELECT SINGLE *
  INTO scustom          "← 화면과 연결된 구조
  FROM scustom
 WHERE id = scustom-id.

* 결과:
* - SELECT 끝나자마자 화면에 값이 바로 보임
* - MOVE-CORRESPONDING 필요 없음
* - 구조는 단순하지만 화면/DB 역할이 섞임

```

② DB → WA → 화면 (정석 / 실무·시험용)

```abap
*--------------------------------------------------------------------*
* [방법 2] DB → Work Area → 화면 구조 (역할 분리)
*--------------------------------------------------------------------*

* 1) PAI : DB에서 데이터 읽기
SELECT SINGLE *
  INTO wa_scustom        "← DB 조회 결과를 임시로 보관
  FROM scustom
 WHERE id = scustom-id.

* 2) PBO : 화면에 보여주기
MOVE-CORRESPONDING wa_scustom TO scustom.

* 결과:
* - DB용(WA) / 화면용(SCUSTOM) 역할 분리
* - PAI / PBO 흐름 명확
* - 실무, 시험에서 가장 권장되는 구조

```

→ 한 줄 요약 

```
방법 1 : DB → SCUSTOM (바로 화면)
방법 2 : DB → WA → SCUSTOM (정석)
```
