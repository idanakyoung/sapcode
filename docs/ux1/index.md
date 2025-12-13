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

  /* Progress gradient */
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

/* Layout */
.uxwrap{ max-width:1100px; margin:2rem auto 3rem; padding:0 1.1rem; font-family:system-ui,-apple-system,"Segoe UI","Noto Sans KR",sans-serif; color:var(--text); }
.uxhead{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:18px;
  box-shadow:var(--shadow);
  padding:1.5rem 1.7rem;
  margin-bottom:1.2rem;
}
.uxhead h1{ margin:.2rem 0 .35rem; font-size:1.85rem; font-weight:850; letter-spacing:-.02em; }
.uxhead p{ margin:.2rem 0; color:var(--sub); }
.topnav{ font-size:.9rem; color:var(--muted); margin-bottom:.6rem; }
.topnav a{ color:var(--link); text-decoration:none; }
.topnav a:hover{ text-decoration:underline; }

.grid{
  display:grid;
  grid-template-columns: 2.2fr 1fr;
  gap:1rem;
}
@media (max-width: 920px){
  .grid{ grid-template-columns: 1fr; }
}

.card{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:16px;
  box-shadow: 0 10px 26px rgba(0,0,0,.04);
  padding:1.2rem 1.3rem;
}
.card h2{
  margin:0 0 .7rem;
  font-size:1.12rem;
  font-weight:800;
  display:flex;
  align-items:center;
  gap:.45rem;
}
.badge{
  display:inline-block;
  font-size:.78rem;
  padding:.16rem .5rem;
  border-radius:999px;
  border:1px solid var(--border);
  background:#fff7fb;
  color:var(--sub);
}

.small{ color:var(--muted); font-size:.88rem; margin:.25rem 0 .8rem; }

/* Table */
.tbl{
  width:100%;
  border-collapse:separate;
  border-spacing:0;
  overflow:hidden;
  border-radius:14px;
  border:1px solid rgba(255, 214, 236, .9);
}
.tbl th, .tbl td{
  padding:.72rem .75rem;
  border-bottom:1px solid rgba(255, 214, 236, .65);
  vertical-align:top;
}
.tbl th{
  background:#fff4fa;
  font-size:.88rem;
  text-align:left;
  color:#3b3f50;
}
.tbl tr:last-child td{ border-bottom:none; }
.tbl .col-tag{ width:92px; white-space:nowrap; font-weight:800; color:#2b2f3b; }
.tbl a{ color:var(--link); text-decoration:none; }
.tbl a:hover{ text-decoration:underline; }
.kicker{ font-size:.86rem; color:var(--sub); font-weight:700; margin:.2rem 0 .7rem; }

/* Progress / Understanding */
.meter{
  height:14px;
  border-radius:999px;
  background:#eef0f6;
  border:1px solid rgba(0,0,0,.06);
  overflow:hidden;
}
.meter > span{
  display:block;
  height:100%;
  width:0%;
  background:var(--grad);
}
.prow{
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:.7rem;
  margin:.55rem 0 .8rem;
}
.pct{
  font-variant-numeric: tabular-nums;
  font-weight:850;
  color:#2b2f3b;
}
.note{
  padding:.8rem .9rem;
  border-radius:14px;
  border:1px dashed rgba(255, 214, 236, .95);
  background:#fff9fc;
  color:var(--sub);
  font-size:.9rem;
}
.list{
  margin:.3rem 0 0;
  padding-left:1.1rem;
  color:var(--sub);
}
.list li{ margin:.22rem 0; }
</style>

<div class="uxwrap">

  <div class="uxhead">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← 홈</a>
      &nbsp;·&nbsp;
      <a href="{{ '/ux1/' | relative_url }}">UX1</a>
    </div>
    <h1>🎨 UX1 — UI5 Programming (HTML/JS)</h1>
    <p>HTML/CSS/JavaScript 기초부터 SAP UI5까지 한 번에 정리하는 과정입니다.</p>
    <p>실습 중심으로 UI 개발 감각을 다지는 것을 목표로 합니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2> 학습 구성 <span class="badge">Lesson Index</span></h2>
      <p class="small">아래 표에서 레슨을 클릭하면 바로 이동합니다.</p>

      <div class="kicker">① JavaScript Track</div>
      <table class="tbl">
        <thead>
          <tr>
            <th class="col-tag">구분</th>
            <th>레슨</th>
            <th>주제</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="col-tag">JS 1</td>
            <td><a href="{{ '/ux1/JavaScript/Lesson1' | relative_url }}">Lesson 1</a></td>
            <td>기본 문법</td>
          </tr>
          <tr>
            <td class="col-tag">JS 2</td>
            <td><a href="{{ '/ux1/JavaScript/Lesson2' | relative_url }}">Lesson 2</a></td>
            <td>조건문 / 반복문</td>
          </tr>
          <tr>
            <td class="col-tag">JS 3</td>
            <td><a href="{{ '/ux1/JavaScript/Lesson3' | relative_url }}">Lesson 3</a></td>
            <td>함수</td>
          </tr>
          <tr>
            <td class="col-tag">JS 4</td>
            <td><a href="{{ '/ux1/JavaScript/Lesson4' | relative_url }}">Lesson 4</a></td>
            <td>객체</td>
          </tr>
          <tr>
            <td class="col-tag">JS 5</td>
            <td><a href="{{ '/ux1/JavaScript/Lesson5' | relative_url }}">Lesson 5</a></td>
            <td>DOM / 이벤트</td>
          </tr>
        </tbody>
      </table>

      <br>

      <div class="kicker">② SAP UI5 Track</div>
      <table class="tbl">
        <thead>
          <tr>
            <th class="col-tag">구분</th>
            <th>레슨</th>
            <th>주제</th>
          </tr>
        </thead>
        <tbody>
          <tr><td class="col-tag">UI5 1</td><td><a href="{{ '/ux1/UI5/Lesson1' | relative_url }}">Lesson 1</a></td><td>View / Controller</td></tr>
          <tr><td class="col-tag">UI5 2</td><td><a href="{{ '/ux1/UI5/Lesson2' | relative_url }}">Lesson 2</a></td><td>데이터 바인딩</td></tr>
          <tr><td class="col-tag">UI5 3</td><td><a href="{{ '/ux1/UI5/Lesson3' | relative_url }}">Lesson 3</a></td><td>Routing</td></tr>
          <tr><td class="col-tag">UI5 4</td><td><a href="{{ '/ux1/UI5/Lesson4' | relative_url }}">Lesson 4</a></td><td>모델(Model)</td></tr>
          <tr><td class="col-tag">UI5 5</td><td><a href="{{ '/ux1/UI5/Lesson5' | relative_url }}">Lesson 5</a></td><td>JSONModel</td></tr>
          <tr><td class="col-tag">UI5 6</td><td><a href="{{ '/ux1/UI5/Lesson6' | relative_url }}">Lesson 6</a></td><td>XML View</td></tr>
          <tr><td class="col-tag">UI5 7</td><td><a href="{{ '/ux1/UI5/Lesson7' | relative_url }}">Lesson 7</a></td><td>Table Control</td></tr>
          <tr><td class="col-tag">UI5 8</td><td><a href="{{ '/ux1/UI5/Lesson8' | relative_url }}">Lesson 8</a></td><td>Formatter</td></tr>
          <tr><td class="col-tag">UI5 9</td><td><a href="{{ '/ux1/UI5/Lesson9' | relative_url }}">Lesson 9</a></td><td>Fragment</td></tr>

          <tr><td class="col-tag">UI5 10</td><td><a href="{{ '/ux1/UI5/Lesson_10' | relative_url }}">Lesson 10</a></td><td>심화</td></tr>
          <tr><td class="col-tag">UI5 11</td><td><a href="{{ '/ux1/UI5/Lesson_11' | relative_url }}">Lesson 11</a></td><td>심화</td></tr>
          <tr><td class="col-tag">UI5 12</td><td><a href="{{ '/ux1/UI5/Lesson_12' | relative_url }}">Lesson 12</a></td><td>심화</td></tr>
          <tr><td class="col-tag">UI5 13</td><td><a href="{{ '/ux1/UI5/Lesson_13' | relative_url }}">Lesson 13</a></td><td>심화</td></tr>
          <tr><td class="col-tag">UI5 14</td><td><a href="{{ '/ux1/UI5/Lesson_14' | relative_url }}">Lesson 14</a></td><td>심화</td></tr>
          <tr><td class="col-tag">UI5 15</td><td><a href="{{ '/ux1/UI5/Lesson_15' | relative_url }}">Lesson 15</a></td><td>심화</td></tr>
          <tr><td class="col-tag">UI5 16</td><td><a href="{{ '/ux1/UI5/Lesson_16' | relative_url }}">Lesson 16</a></td><td>심화</td></tr>
        </tbody>
      </table>
    </div>

    <!-- RIGHT -->
    <aside class="card">
      <h2>📊 이해도 진행도 <span class="badge">0% → 100%</span></h2>
      <p class="small">원하는 값으로 숫자와 width만 바꾸면 돼요.</p>

      <!-- JS Progress -->
      <div class="prow">
        <div style="font-weight:800;">JavaScript</div>
        <div class="pct">35%</div>
      </div>
      <div class="meter"><span style="width:35%"></span></div>

      <!-- UI5 Progress -->
      <div class="prow" style="margin-top:1rem;">
        <div style="font-weight:800;">SAP UI5</div>
        <div class="pct">20%</div>
      </div>
      <div class="meter"><span style="width:20%"></span></div>

      <!-- Total Progress -->
      <div class="prow" style="margin-top:1rem;">
        <div style="font-weight:800;">전체</div>
        <div class="pct">27%</div>
      </div>
      <div class="meter"><span style="width:27%"></span></div>

      <br>

      <h2>🧩 이 과정에서 다루는 내용</h2>
      <ul class="list">
        <li>HTML / CSS / JavaScript 기본 문법 복습</li>
        <li>UI5 View / Controller 구조 이해</li>
        <li>JSONModel / ODataModel 데이터 바인딩</li>
        <li>Routing / Fragment / Table Control 실무 컴포넌트</li>
        <li>실습 기반으로 UI 하나 완성</li>
      </ul>

      <br>

      <div class="note">
        <strong>Tip)</strong> 레슨 페이지에도 “← UX1로” 버튼을 넣고 싶으면,
        각 Lesson 상단에 아래 한 줄만 추가하면 돼요.<br><br>
        <code>[← UX1로]({{ '/ux1/' | relative_url }}) · [홈]({{ '/' | relative_url }})</code>
      </div>
    </aside>

  </div>
</div>
