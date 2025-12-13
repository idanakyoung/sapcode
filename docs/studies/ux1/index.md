---
title: UX1 — UI5 Programming (HTML/JS)
---

<style>
:root{
  --bg1:#fff1f8;
  --bg2:#ffffff;
  --card:#ffffff;
  --border:#ffd6ec;
  --shadow:0 14px 34px rgba(255, 143, 180, .18);
  --text:#1f2230;
  --sub:#5e6475;
  --muted:#9aa0b2;
  --link:#0b66d6;
  --grad: linear-gradient(90deg,
    #ff4d6d 0%,
    #ff8fa3 25%,
    #ffd166 55%,
    #7ae582 78%,
    #3ddc97 100%
  );
}

body{
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #fff7fb 40%, var(--bg2) 100%);
}

.uxwrap{
  max-width:1100px;
  margin:2rem auto 3rem;
  padding:0 1.1rem;
  font-family:system-ui,-apple-system,"Segoe UI","Noto Sans KR",sans-serif;
  color:var(--text);
}

.uxhead{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:18px;
  box-shadow:var(--shadow);
  padding:1.5rem 1.7rem;
  margin-bottom:1.2rem;
}

.uxhead h1{
  margin:.2rem 0 .35rem;
  font-size:1.85rem;
  font-weight:850;
}

.uxhead p{ margin:.2rem 0; color:var(--sub); }

.topnav{ font-size:.9rem; color:var(--muted); margin-bottom:.6rem; }
.topnav a{ color:var(--link); text-decoration:none; }
.topnav a:hover{ text-decoration:underline; }

.grid{
  display:grid;
  grid-template-columns:2.2fr 1fr;
  gap:1rem;
}

@media (max-width:920px){
  .grid{ grid-template-columns:1fr; }
}

.card{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:16px;
  box-shadow:0 10px 26px rgba(0,0,0,.04);
  padding:1.2rem 1.3rem;
}

.card h2{
  margin:0 0 .7rem;
  font-size:1.12rem;
  font-weight:800;
  display:flex;
  gap:.45rem;
}

.badge{
  font-size:.78rem;
  padding:.16rem .5rem;
  border-radius:999px;
  border:1px solid var(--border);
  background:#fff7fb;
  color:var(--sub);
}

.small{ color:var(--muted); font-size:.88rem; }

.tbl{
  width:100%;
  border-collapse:separate;
  border-spacing:0;
  border-radius:14px;
  border:1px solid rgba(255,214,236,.9);
  overflow:hidden;
}

.tbl th,.tbl td{
  padding:.72rem .75rem;
  border-bottom:1px solid rgba(255,214,236,.65);
}

.tbl th{
  background:#fff4fa;
  font-size:.88rem;
  text-align:left;
}

.tbl tr:last-child td{ border-bottom:none; }

.tbl .col-tag{
  width:92px;
  font-weight:800;
}

.tbl a{ color:var(--link); text-decoration:none; }
.tbl a:hover{ text-decoration:underline; }

.kicker{
  font-size:.86rem;
  font-weight:700;
  color:var(--sub);
  margin:.4rem 0 .6rem;
}

.meter{
  height:14px;
  border-radius:999px;
  background:#eef0f6;
  border:1px solid rgba(0,0,0,.06);
  overflow:hidden;
}

.meter span{
  display:block;
  height:100%;
  background:var(--grad);
}

.prow{
  display:flex;
  justify-content:space-between;
  margin:.5rem 0;
}

.pct{ font-weight:850; }

.note{
  margin-top:.8rem;
  padding:.8rem;
  border-radius:14px;
  border:1px dashed rgba(255,214,236,.9);
  background:#fff9fc;
  font-size:.9rem;
}

.list{ padding-left:1.1rem; color:var(--sub); }
.list li{ margin:.25rem 0; }
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🎨 UX1 — UI5 Programming (HTML/JS)</h1>
    <p>HTML / JavaScript 기초부터 SAP UI5까지 정리한 과정입니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>📚 학습 구성 <span class="badge">Lesson Index</span></h2>

      <div class="kicker">① JavaScript Track</div>
      <table class="tbl">
        <tr><td class="col-tag">JS 1</td><td><a href="{{ '/studies/ux1/JavaScript/Lesson1' | relative_url }}">Lesson 1</a></td><td>기본 문법</td></tr>
        <tr><td class="col-tag">JS 2</td><td><a href="{{ '/studies/ux1/JavaScript/Lesson2' | relative_url }}">Lesson 2</a></td><td>조건문 / 반복문</td></tr>
        <tr><td class="col-tag">JS 3</td><td><a href="{{ '/studies/ux1/JavaScript/Lesson3' | relative_url }}">Lesson 3</a></td><td>함수</td></tr>
        <tr><td class="col-tag">JS 4</td><td><a href="{{ '/studies/ux1/JavaScript/Lesson4' | relative_url }}">Lesson 4</a></td><td>객체</td></tr>
        <tr><td class="col-tag">JS 5</td><td><a href="{{ '/studies/ux1/JavaScript/Lesson5' | relative_url }}">Lesson 5</a></td><td>DOM / 이벤트</td></tr>
      </table>

      <br>

      <div class="kicker">② SAP UI5 Track</div>
        <table class="tbl">
          <tr><td class="col-tag">UI5 1</td><td><a href="{{ '/studies/ux1/UI5/Lesson1' | relative_url }}">Lesson 1</a></td><td>View / Controller</td></tr>
          <tr><td class="col-tag">UI5 2</td><td><a href="{{ '/studies/ux1/UI5/Lesson2' | relative_url }}">Lesson 2</a></td><td>데이터 바인딩</td></tr>
          <tr><td class="col-tag">UI5 3</td><td><a href="{{ '/studies/ux1/UI5/Lesson3' | relative_url }}">Lesson 3</a></td><td>Routing</td></tr>
          <tr><td class="col-tag">UI5 4</td><td><a href="{{ '/studies/ux1/UI5/Lesson4' | relative_url }}">Lesson 4</a></td><td>Model</td></tr>
          <tr><td class="col-tag">UI5 5</td><td><a href="{{ '/studies/ux1/UI5/Lesson5' | relative_url }}">Lesson 5</a></td><td>JSONModel</td></tr>
          <tr><td class="col-tag">UI5 6</td><td><a href="{{ '/studies/ux1/UI5/Lesson6' | relative_url }}">Lesson 6</a></td><td>XML View</td></tr>
          <tr><td class="col-tag">UI5 7</td><td><a href="{{ '/studies/ux1/UI5/Lesson7' | relative_url }}">Lesson 7</a></td><td>Table Control</td></tr>
          <tr><td class="col-tag">UI5 8</td><td><a href="{{ '/studies/ux1/UI5/Lesson8' | relative_url }}">Lesson 8</a></td><td>Formatter</td></tr>
          <tr><td class="col-tag">UI5 9</td><td><a href="{{ '/studies/ux1/UI5/Lesson9' | relative_url }}">Lesson 9</a></td><td>Fragment</td></tr>
          <tr><td class="col-tag">UI5 10</td><td><a href="{{ '/studies/ux1/UI5/Lesson_10' | relative_url }}">Lesson 10</a></td><td>심화 주제 1</td></tr>
          <tr><td class="col-tag">UI5 11</td><td><a href="{{ '/studies/ux1/UI5/Lesson_11' | relative_url }}">Lesson 11</a></td><td>심화 주제 2</td></tr>
          <tr><td class="col-tag">UI5 12</td><td><a href="{{ '/studies/ux1/UI5/Lesson_12' | relative_url }}">Lesson 12</a></td><td>심화 주제 3</td></tr>
          <tr><td class="col-tag">UI5 13</td><td><a href="{{ '/studies/ux1/UI5/Lesson_13' | relative_url }}">Lesson 13</a></td><td>심화 주제 4</td></tr>
          <tr><td class="col-tag">UI5 14</td><td><a href="{{ '/studies/ux1/UI5/Lesson_14' | relative_url }}">Lesson 14</a></td><td>심화 주제 5</td></tr>
          <tr><td class="col-tag">UI5 15</td><td><a href="{{ '/studies/ux1/UI5/Lesson_15' | relative_url }}">Lesson 15</a></td><td>심화 주제 6</td></tr>
          <tr><td class="col-tag">UI5 16</td><td><a href="{{ '/studies/ux1/UI5/Lesson_16' | relative_url }}">Lesson 16</a></td><td>심화 주제 7</td></tr>
        </table>
        </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📊 이해도 진행도</h2>
        <div class="prow"><span>JavaScript</span><span class="pct">35%</span></div>
        <div class="meter"><span style="width:35%"></span></div>

        <div class="prow"><span>SAP UI5</span><span class="pct">20%</span></div>
        <div class="meter"><span style="width:20%"></span></div>
      </div>

      <div class="card">
        <h2>🧩 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>JavaScript 핵심 문법</li>
          <li>SAP UI5 구조 이해</li>
          <li>데이터 바인딩 / Routing</li>
          <li>실습 기반 UI 구현</li>
        </ul>

        <div class="note">
          <code>[← UX1로]({{ '/studies/ux1/' | relative_url }}) · [홈]({{ '/' | relative_url }})</code>
        </div>
      </div>

    </aside>
  </div>
</div>
