# 🎓JavaScript  Lesson 3

# Lesson 3. Reference Data Type & Built-in Objects

> 🗓️ 학습 주제: 참조형 데이터(Object/Array/Map/Function/Math/Date)와 메서드 활용
> 
> 
> ✏️ 작성자: **구나경**
> 

---

## 🧠 **개념 정리**

### 🔸 Reference 데이터타입 개요

- **참조형(Reference)**: 값 자체가 아니라 **참조(주소)**를 변수에 담는 타입.
- 대표 객체(내장/호스트 포함): **Object, Array, Map, Function, Math, Date**.
- **객체(Object)** = **프로퍼티(Property)** + **메서드(Method)**의 결합체.

---

### 🔸 Object

### 1) 선언

- 리터럴: `var obj = {};`
- 생성자: `var obj = new Object();`

### 2) 프로퍼티/메서드 추가·삭제·변경

- 점 표기: `obj.key = 1`
- 대괄호 표기: `obj["key"] = 1` *(동적 키에 유용)*
- 삭제: `delete obj.key`

### 3) 중첩 객체 & 속성 서술자(writable)

- `Object.defineProperty(target, key, { value, writable, ... })`
- `writable: false`면 **대입을 무시**(값 변경되지 않음).

---

### 🔸 Map

- **Key–Value** 저장. **모든 타입**을 키로 사용 가능.
- 순회가 간편(`for..of`), 크기: `myMap.size`, 존재여부: `myMap.has(k)`.

```jsx
const m = new Map();
m.set("name", "나경");
m.set(1, "숫자키");
console.log(m.get("name")); // "나경"
for (const [k, v] of m) console.log(k, v);

```

---

### 🔸 Array

- 순서(index) 있는 컬렉션. 유용한 메서드 다수.

| 메서드 | 효과 | 비고 |
| --- | --- | --- |
| `push(v)` | 끝에 추가 | 길이 증가 |
| `pop()` | 끝에서 제거 | 제거값 반환 |
| `shift()` | 앞에서 제거 |  |
| `unshift(v)` | 앞에 추가 |  |
| `splice(i, n, ...v)` | i부터 n개 삭제·추가 | 다목적 편집 |
| `sort()` | 기본 오름차순 정렬 | 문자열 기준; 숫자는 비교함수 권장 |
| `reverse()` | 순서 뒤집기 | **정렬 아님** (보통 `sort().reverse()`) |
| `join(sep)` | 배열→문자열 | `arr.join("-")` |

---

### 🔸 Function

- **일급 객체**: 변수에 할당, 인자로 전달, 반환값으로 사용 가능.
- 객체의 value가 함수면 **메서드**라 부름.
- 축약 메서드 정의(ES6+): `say(){...}` 형태로 `function` 키워드 생략 가능.

---

### 🔸 Math (대소문자 주의: **M**ath)

- `Math.min/max/ceil/floor/round/random/PI` 등 제공.
- 음수 처리 시 `ceil`/`floor` 방향 차이 주의.

---

### 🔸 Date

- `new Date()`로 현재 시각.
- 주요 메서드:
    
    `getFullYear()`, `getMonth()`(0~11 → **+1 필요**), `getDate()`,
    
    `getDay()`(0=일), `getHours()`, `getMinutes()`, `getSeconds()`, `getTime()`(ms)
    

---

### 🔎 디버깅 팁

- **개발자도구 → Sources/Console**: 중단점, Step-Into/Over, 변수 관찰.
- `console.log`, `console.table`, `debugger;` 적극 활용.

---

## 💻 **코드 예제 정리**

### 🧩 1) `defineProperty`와 `writable:false`

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Reference type</title></head>
<body>
<script>
  // Object 생성
  var obj = {};
  // 프로퍼티 정의 (writable: false)
  Object.defineProperty(obj, 'key', {
    value: 100,
    writable: false
  });

  alert(obj.key); // 100
  obj.key = 200;  // 무시됨
  alert(obj.key); // 여전히 100
</script>
</body>
</html>

```

**포인트**: `writable:false` → 값 대입이 **무시**, 오류는 없음(비엄격 모드).

---

### 🧩 2) Object 리터럴 & 접근 (점/대괄호)

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Object Access</title></head>
<body>
<script>
  var oName = {
    "FName": "길동",
    "LName": "홍",
    "Age": 25,
    "Gender": "M"
  };
  alert(oName["LName"] + "." + oName.FName); // 홍.길동
  alert(oName.Age);      // 25
  alert(oName["Gender"]); // M
</script>
</body>
</html>

```

**포인트**: **동적 키**가 필요하면 대괄호 표기 활용.

---

### 🧩 3) Array 조작·정렬

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Array Ops</title></head>
<body>
<script>
  var aFruits = ["Banana","Orange","Apple","Pear","Mango"];

  alert(aFruits.length);
  console.log(aFruits);

  alert(aFruits.indexOf("Pear"));
  alert(aFruits.join("-")); // "Banana-Orange-Apple-Pear-Mango"

  aFruits.push("Kiwi");   console.log(aFruits);
  aFruits.pop();          console.log(aFruits);
  aFruits.shift();        console.log(aFruits);
  aFruits.unshift("Lemon"); console.log(aFruits);

  // 편집: 인덱스2에 삽입
  aFruits.splice(2, 0, "Melon","Strawberry");
  console.log(aFruits);

  // 인덱스1부터 2개 삭제
  aFruits.splice(1, 2);
  console.log(aFruits);

  // 정렬
  aFruits.sort();    // 오름차순
  aFruits.reverse(); // 내림차순(정렬 뒤 뒤집기)
  console.log(aFruits);
</script>
</body>
</html>

```

**포인트**: 숫자 정렬은 `arr.sort((a,b)=>a-b)` 권장.

---

### 🧩 4) Function: 기본/반환값

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Function Basic</title></head>
<body>
<script>
  function calcu_perc(p_max, p_act) {
    return p_act * 100 / p_max;
  }
  var result = calcu_perc(300, 250);
  alert(result); // 83.333...
</script>
</body>
</html>

```

---

### 🧩 5) Function: 변수에 할당(일급 함수)

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Function as Value</title></head>
<body>
<script>
  function calcu_perc(p_max, p_act) {
    return p_act * 100 / p_max;
  }
  var operation = calcu_perc;           // 함수 참조를 변수에 저장
  var percentage = operation(300,150);  // 50
  alert(percentage);
  console.log(operation);               // 함수 자체 출력
</script>
</body>
</html>

```

---

### 🧩 6) Function: 고계함수(HOF, 함수를 인자로)

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Higher-Order Function</title></head>
<body>
<script>
  function calcu_perc(p_max, p_act) {
    return p_act * 100 / p_max;
  }
  var operation = calcu_perc;

  function otherFunction(op, p_max, p_act){
    return op(p_max, p_act);
  }
  var perc = otherFunction(operation, 350, 200); // 57.14...
  alert(perc);
</script>
</body>
</html>

```

---

### 🧩 7) Function: 내부함수(클로저 느낌)로 출력 분리

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Nested Function</title></head>
<body>
<script>
  function calcu_perc(p_max, p_act) {
    function print(result){
      alert("Percentage : " + result + "%");
    }
    var percentage = p_act * 100 / p_max;
    print(percentage);
  }
  calcu_perc(400, 200); // 50%
</script>
</body>
</html>

```

**포인트**: 내부함수는 바깥 스코프 변수 접근(클로저).

---

### 🧩 8) 객체 메서드(ES5/ES6 문법)

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Object Methods</title></head>
<body>
<script>
  var calcObject =  {
    // ES5 방식
    add: function(p1, p2) {
      return p1 + p2;
    },
    discount: function(amt, perc) {
      return amt - (amt * perc / 100);
    },
    tot_amt: function(amt, vat) {
      return amt + (amt * vat / 100);
    }
    // ES6 축약: add(p1,p2){ return p1+p2; } 형태도 가능
  };

  alert(calcObject.add(10,20));
  alert(calcObject.discount(2000,10));
  alert(calcObject.tot_amt(1000,10));
</script>
</body>
</html>

```

**포인트**: 객체의 value가 함수면 **메서드**라 부름.

---

### 🧩 9) Math 기본

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Math</title></head>
<body>
<script>
  console.log(Math.min(100,10,299,2,824)); // 2
  console.log(Math.max(100,10,299,2,824)); // 824
  console.log("Ceil",  Math.ceil(-4.1));   // -4
  console.log("Floor", Math.floor(-4.1));  // -5
  console.log(Math.random());              // 0.xxxxx
  console.log(Math.PI);                    // 3.14159...
</script>
</body>
</html>

```

**포인트**: `Math`는 **대문자 M**!

---

### 🧩 10) Date 기본

```html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Date</title></head>
<body>
<script>
  var day = new Date();
  console.log(day.getDate());     // 1~31
  console.log(day.getMonth());    // 0~11 (→ +1 필요)
  console.log(day.getDay());      // 0=Sun
  console.log(day.getHours());
  console.log(day.getMinutes());
  console.log(day.getSeconds());
  console.log(day.getFullYear());
  console.log(day.getTime());     // ms since 1970-01-01
</script>
</body>
</html>

```

**포인트**: **월은 0부터 시작** → 화면에 보일 땐 `getMonth()+1`.

---

## 🧠 **핵심 요약 정리표**

| 개념 | 키 포인트 | 기억 포인트 |
| --- | --- | --- |
| Object | 프로퍼티/메서드, `defineProperty` | `writable:false` → 대입 무시 |
| Map | 모든 타입 키, 쉬운 순회 | `set/get/has/size` |
| Array | 편집/정렬 메서드 | `splice`, 숫자 정렬은 비교함수 |
| Function | 일급 객체, HOF/클로저 | 변수에 할당/인자 전달/반환 가능 |
| Math | 수학 내장 객체 | 대문자 `Math` |
| Date | 날짜·시간 | `getMonth()+1` |

---

## 🌈 **한 줄 요약**

> 객체는 참조형의 중심이고, 배열·맵·함수·수학·날짜는 이를 기반으로 확장된다.
> 
> 
> 올바른 메서드와 디버깅 흐름을 익히면, 데이터 구조를 **안전하고 유연하게** 다룰 수 있다. 🚀
>
