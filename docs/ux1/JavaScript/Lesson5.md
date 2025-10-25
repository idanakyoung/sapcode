🎓 JavaScript Lesson 5
Lesson 5. Control Flow (조건문 · 반복문)

🗓️ 학습 주제: 자바스크립트의 흐름 제어 (조건문, switch, 반복문, 삼항 연산자)
✏️ 작성자: 구나경

🧠 개념 정리
🔸 제어문(Control Flow)

프로그램의 흐름을 제어하는 문장 구조로,
조건에 따라 분기하거나 반복 동작을 수행하게 한다.

🧩 1️⃣ 조건문 (Conditional Statements)
📌 if / else if / else 문
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>If Statement</title>
</head>
<body>
<script>
  var input = prompt("숫자를 입력하세요")

  if (input % 2 == 0) {
    alert("짝수")     // 조건식이 참일 경우
  } else {
    alert("홀수")     // 조건식이 거짓일 경우
  }

  // 다중 조건
  if (input % 2 == 0) {         // OR(||), AND(&&)
    alert("짝수")
  } else if (input % 2 == 1) {
    alert("홀수")
  } else {
    alert("해당없음")
  }
</script>
</body>
</html>


🧠 포인트

if : 조건식이 true일 때 실행

else if : 다른 조건 확인

else : 위 조건이 모두 거짓일 때 실행

논리 연산자 &&(AND), ||(OR) 조합 가능

📌 실습 – 현재 시간에 따라 오전/오후/저녁 구분
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Time Condition</title>
</head>
<body>
<script>
  var day = new Date()
  var dat = day.getHours()

  if (dat < 12) {
    alert("오전")
  } else if (dat < 18) {
    alert("오후")
  } else {
    alert("저녁")
  }
</script>
</body>
</html>


🧠 포인트

Date() 객체의 getHours()는 0~23 시간 반환

조건 순서 중요! 작은 범위부터 비교

🧭 2️⃣ switch 문 (다중 분기문)
📘 예시 1 — 홀수/짝수 판별
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Switch Example</title>
</head>
<body>
<script>
  var input = prompt("숫자를 입력하세요")

  switch (input % 2) {
    case 0:
      alert("짝수")
      break
    case 1:
      alert("홀수")
      break
    default:
      alert("숫자 아님")
  }
</script>
</body>
</html>


🧠 포인트

break 생략 시 다음 case도 실행됨 (fall-through)

default: 어떤 case에도 해당하지 않을 때 실행

📘 예시 2 — 월별 계절 구분
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Season Check</title>
</head>
<body>
<script>
  var dat = new Date()
  switch (dat.getMonth() + 1) {
    case 12:
    case 1:
    case 2:
      alert("겨울")
      break
    case 3:
    case 4:
    case 5:
      alert("봄")
      break
    case 6:
    case 7:
    case 8:
      alert("여름")
      break
    case 9:
    case 10:
    case 11:
      alert("가을")
      break
  }
</script>
</body>
</html>


🧠 포인트

getMonth()는 0~11 반환 → 반드시 +1

여러 case를 묶으면 범위처럼 활용 가능

📘 예시 3 — 점수에 따른 학점 출력
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Grade Check</title>
</head>
<body>
<script>
  var input = prompt("점수를 입력하세요")

  // switch에서 조건식 사용
  switch (true) {
    case (input < 0 || input > 100 || input == "" || input == " " || input == null):
      alert("입력 오류 발생")
      break
    case (input >= 90):
      alert("A")
      break
    case (input >= 80):
      alert("B")
      break
    case (input >= 70):
      alert("C")
      break
    case (input >= 60):
      alert("D")
      break
    default:
      alert("F")
  }

  // if문으로 동일 구현
  if (input >= 90) {
    alert("A")
  } else if (input >= 80) {
    alert("B")
  } else if (input >= 70) {
    alert("C")
  } else if (input >= 60) {
    alert("D")
  } else if (input < 60 && input >= 0 && input !== null) {
    alert("F")
  } else {
    alert("입력 오류 발생")
  }

  // switch에서 숫자 범위 처리 (parseInt)
  switch (parseInt(input / 10)) {
    case 10:
    case 9:
      alert("A")
      break
    case 8:
      alert("B")
      break
    case 7:
      alert("C")
      break
    case 6:
      alert("D")
      break
    default:
      alert("F")
  }
</script>
</body>
</html>


🧠 포인트

switch(true) 패턴은 조건식을 여러 개 case로 평가할 때 자주 사용됨

parseInt(input / 10) → 90~99: 9, 80~89: 8

🔁 3️⃣ 반복문 (Loop Statements)
📘 while 문
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>While Loop</title></head>
<body>
<script>
  var i = 1;
  var sum = 0;

  while (i <= 10) {   // 조건이 참인 동안 반복
    sum += i;
    i++;
  }
  alert("1부터 10까지의 합: " + sum);
</script>
</body>
</html>


🧠 포인트

반복 전 조건 검사

i++ 증감식 누락 시 무한 루프 발생 가능

📘 do...while 문
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Do While Loop</title></head>
<body>
<script>
  var result = 0;
  var i = 0;

  do {
    i += 1;
    result += 1;
  } while (i > 0 && i < 10);

  alert(result);
</script>
</body>
</html>


🧠 포인트

조건 뒤에서 검사, 최소 1회 실행

while은 “먼저 검사”, do while은 “나중 검사”

📘 for 문
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>For Loop</title></head>
<body>
<script>
  var result = 0;
  for (var i = 0; i <= 10; i++) {
    result += 1;
  }
  alert(result);
</script>
</body>
</html>


🧠 포인트

세 부분 구성: 초기식; 조건식; 증감식

조건식이 false면 반복 종료

📘 for...in 문 (객체/배열 반복)
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>For In Loop</title></head>
<body>
<script>
  var oName = {
    name: "Hong",
    age: "20",
    gender: "M",
    birth: "20001011"
  };

  for (var item in oName) {
    alert(item + " : " + oName[item]);
  }

  var array = ["Hong", "Kim", "Park", "Lee"];
  for (var index in array) {
    alert(index + " : " + array[index]);
  }
</script>
</body>
</html>


🧠 포인트

for...in은 객체의 프로퍼티 이름 또는 배열의 인덱스 순회

값 자체를 순회하려면 for...of (ES6) 사용

🧱 4️⃣ 삼항(조건) 연산자 응용
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>Ternary Operator</title></head>
<body>
<script>
  var x = 100, y = 50;
  var z = x > y ? "x가 y보다 크다" : "x가 y보다 작다";
  alert(z);
</script>
</body>
</html>


🧠 포인트

조건 ? 참일 때 : 거짓일 때

간단한 if문을 한 줄로 축약할 때 유용

중첩 사용 가능하지만 가독성 주의

🧠 핵심 요약 정리표
구문	형태	특징
if / else	if (조건) { } else { }	기본 조건 분기
switch	switch(값) { case n: ... break; }	다중 분기 처리
while	while(조건){}	조건 선검사 반복
do...while	do { } while(조건)	조건 후검사 반복 (최소 1회 실행)
for	for(초기; 조건; 증감)	일반적인 반복 구조
for...in	for (key in obj)	객체 프로퍼티 순회
for...of	for (val of arr)	배열 값 순회 (ES6+)
삼항연산자	조건 ? A : B	한 줄 조건문
🌈 한 줄 요약

💬 조건문은 판단을, 반복문은 실행을 제어한다.
if·switch로 분기 흐름을 만들고, while·for로 반복을 제어하면
프로그램의 “흐름”을 완전히 컨트롤할 수 있다. 🚀
