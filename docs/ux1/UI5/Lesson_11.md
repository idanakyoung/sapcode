# ✨ Lesson 11 — UI5 Open Data Protocol (oData)
## 데이터베이스 기초

1. 추상화
    1. 현실 세계의 복잡한 데이터를 단순화하여 데이터베이스에 표현
    2. 중요 정보만 추출하고 불필요한 정보는 제거
    3. 3단계 수준:
    - 개념적 수준 (Conceptual)
    - 논리적 수준 (Logical)
    - 물리적 수준 (Physical)
2. 스키마 (Schema)
    1. 데이터베이스의 구조와 설계를 정의
    2. 예: 테이블 이름, 속성, 관계, 제약조건 등 포함
    
3. 개체 관계 모델
    1. 개체
        1. 현실 세계에 존재하는 독립적으로 식별 가능한 객체
        - 예: 학생, 도서, 사원 등
    2. 개체 타입 (Entity Type)
        1. 동일한 속성을 가지는 개체들의 집합을 정의하는 틀
        2. 개체의 고유한 이름과 속성을 아울러 말하는 것
    3. 개체 인스턴스 (Entity Instance)
        1. 개체 타입에 따라 생성된 실제 데이터 한 개
        2. 테이블의 한 행(Row)에 해당
        3. 개체가 가지는 실제 하나의 데이터 값
    4. 개체 집합 (Entity Set)
        1. 동일 개체 타입의 모든 개체 인스턴스들의 모임
        
4. REST (Representational State Transfer)
    1. REST는 **웹 기반 분산 시스템**을 위한 **소프트웨어 아키텍처 스타일**
    2. REST의 구성 요소: 자원(Resource) + 행위(Verb) ( HTTP 메소드 )
    3. 자원 Resource : 자원을 중심을 설계하며 여기서 자원은 웹 상에서의 데이터나 개체를 의미하며 각 자원은 고유한 URI로 식별한다.
    4. HTTP Method : 웹 서비스는 주로 해당 메소드를 사용하여 자원에 대한 다양한 작업을 수행한다.
    5. REST 시스템을 통해서 서비스를 이루는 것을 REST TOOL이라고 한다.
    
5. OData Service의 두 가지 Document
    1. Service Document : URI를 이용해서 최상위 리소스 목록(엔터티 세트 목록)을 보여주는 문서, 즉 **어떤 종류의 데이터**를 제공하는지 알려주는 “목차”
        1. Service Root URI
            1. **Service Root URI** = OData 서비스의 **기본 주소 / 시작점**
            2. 이 URI를 기준으로 다양한 OData기능(조회, 등록, 수정 등)이 이루어짐
    2. Service Metadata Document : 서비스가 어떤 데이터 구조를 갖고 있는지 **정확하게 기술**하는 "청사진"
        - 강사님 : odata 서비스가 이루어지기 위해서 자원이나 구조를 표시하는 것
    3. OData 전체 URL 구성 요소
        1. [전체 URL] = [Service Root URI] + [리소스 경로(Resource Path)] + [쿼리 옵션(Query Options)]
        2. /sap/opu/odata/sap/UX_TRAVEL_SRV/UX_C_Carrier_TP
            1. Service Root URI : /sap/opu/odata/sap/UX_TRAVEL_SRV , 
            2. Service Root URI (기본 URI)  :  OData 서비스의 시작점
            3. 리소스 경로 (Resource Path) : 어떤 리소스(데이터)를 요청할지 지정하는 경로
            4. 쿼리 옵션 (Query Options) : 데이터를 **필터링, 정렬, 선택, 페이지 처리**하기 위한 **추가 옵션, 물음표 `?`로 시작**하며, 하나 이상의 옵션을 `&`로 연결할 수 있음
            
    4. CRUD
        
        
        | 항목 | 의미 | HTTP 메서드 | 설명 | OData 예시 |
        | --- | --- | --- | --- | --- |
        | **C** | Create (생성) | `POST` | 새로운 데이터를 생성 | `POST /ProductSet` |
        | **R** | Read (조회) | `GET` | 데이터를 조회 | `GET /ProductSet` 또는 `GET /ProductSet('P001')` |
        | **U** | Update (수정) | `PUT` / `PATCH` | 기존 데이터 수정- `PUT`: 전체 수정- `PATCH`: 일부 수정 | `PUT /ProductSet('P001')PATCH /ProductSet('P001')` |
        | **D** | Delete (삭제) | `DELETE` | 기존 데이터 삭제 | `DELETE /ProductSet('P001')` |
    5. 리스트 바인딩은 엔티티 셋을 갖고 바인딩을 하는 것, 프로퍼티 바인딩은 특정 프로퍼티를 갖고 바인딩을 하는 것, 인스턴스 ?
6. zux_ui_customer_o2 ‘개체’ 고르기
    
    ![image.png](attachment:b8159358-2d5c-4ddf-9411-2055b1b3400a:image.png)
    
7. 개체
8. 고른 개체에서 Entity Set 버튼을 통해 개체 집합에서 인스턴스 고르기
    
    ![image.png](attachment:cebbc797-1848-45dd-b1c1-62918e1bef97:image.png)
    

      열면 다음 사진과 코드와 같음 (사진은 여객기 개체,  코드는 customer개체)

![image.png](attachment:f187e0b8-eb61-4d23-847c-4d3755fbf7d5:image.png)

```jsx
```json
{
"d": {
"EntitySets": [
"SAP__Currencies",
"SAP__UnitsOfMeasure",
"SAP__MyDocumentDescriptions",
"SAP__FormatSet",
"SAP__PDFStandardSet",
"SAP__TableColumnsSet",
"SAP__CoverPageSet",
"SAP__SignatureSet",
"SAP__HierarchySet",
"SAP__PDFHeaderSet",
"SAP__PDFFooterSet",
"SAP__ValueHelpSet",
"UX_Booking",
"UX_Customer"
]
}
}
```
```

8.  "UX_Customer" 인스턴스를 골랐다면 → 아래 코드 참고 

```jsx
"__metadata" : {
          "id" : "http://bgissap3.bgissap.co.kr:8000/sap/opu/odata/sap/UX_UI_CUSTOMER_O2/UX_Customer(guid'59f2a963-b5b4-1fe0-a9f2-8663fced588b')",
          "uri" : "http://bgissap3.bgissap.co.kr:8000/sap/opu/odata/sap/UX_UI_CUSTOMER_O2/UX_Customer(guid'59f2a963-b5b4-1fe0-a9f2-8663fced588b')",
          "type" : "cds_ux_ui_customer.UX_CustomerType"
        },
        "Delete_mc" : true,
        "Update_mc" : true,
        "to_Bookings_oc" : true,
        "CustomerGuid" : "59f2a963-b5b4-1fe0-a9f2-8663fced588b",
        "CustomerNumber" : "1",
        "Form" : "Firma",
        "CustomerName" : "SAP AG",
        "Street" : "Dietmar-Hopp-Allee 16",
        "PostCode" : "69190",
        "City" : "Walldorf",
        "Country" : "DE",
        "Email" : "info@sap.de",
        "Telephone" : "06227-34-0",
        "Discount" : "10",
        "changed_at" : null,
        "to_Bookings" : {
          "__deferred" : {
            "uri" : "http://bgissap3.bgissap.co.kr:8000/sap/opu/odata/sap/UX_UI_CUSTOMER_O2/UX_Customer(guid'59f2a963-b5b4-1fe0-a9f2-8663fced588b')/to_Bookings"
          }
        }
      },
      {
```

                                             

→ 위 코드 내에서 각 Key 이름과 각 Operator를 활용해서 Value 값 찾기 + 정렬 + 필터 + 연산 수행 가능 

→ 여기서 SAP GUI DataSet Entity의 활용은 원래 controller에서 data model을 설정해서 데이터 불러오기 대신에 SAP UI5 내 manifest.json에 설정된 mainService경로 값으로 해당 Association을 상대경로나 절대경로로 지정해 데이터를 불러올 수 있다는 것!

1. 만약 여객기 데이터셋이 아닌 다른 OData를 쓰고 싶다면? - manifest.js에 다음과 같이 추가 

```
  "mainService": {
"uri": "/sap/opu/odata/sap/UX_TRAVEL_SRV/",
"type": "OData",
"settings": {
"annotations": [
"UX_TRAVEL_ANNO_MDL"
],
"localUri": "localService/mainService/metadata.xml",
"odataVersion": "2.0"
}
},

// ▼▼▼ [ADD] 커스터머 OData 서비스 dataSource 추가 ▼▼▼
  "custService": {
    "uri": "/sap/opu/odata/sap/ZUX_UI_CUSTOMER_O2/",
    "type": "OData",
    "settings": {
      "odataVersion": "2.0",
      // (선택) MockServer/오프라인 테스트 시 메타데이터 로컬 경로
      "localUri": "localService/custService/metadata.xml"
    }
  }
  // ▲▲▲ [ADD] 끝 ▲▲▲
  
}
},
"sap.ui": {

```

```
  {
"dataSource": "mainService",
"preload": true,
"settings": {}
},

// ▼▼▼ [ADD] 커스터머 서비스용 이름있는 모델 추가 (custModel) ▼▼▼
  "custModel": {
    "dataSource": "custService",
    "preload": true,
    "settings": {}
  }
  // ▲▲▲ [ADD] 끝 ▲▲▲
  
},
"resources": {
  "css": [
    {
      "uri": "css/style.css"
    }
  ]
},
"routing": {

```

unit12/1-1 , quiz 6 - sap gui data set 을 활용한 데이터 바인딩 및 검색 활성화 + 메소드

![image.png](attachment:c901fb63-57a4-4b8c-8eda-55b0e7f864fa:image.png)
