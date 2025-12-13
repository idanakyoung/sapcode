---
title: ABAP2 — Screen & Web Dynpro
---

<style>
:root{
  --bg1:#f0f7ff;
  --bg2:#ffffff;
  --card:#ffffff;
  --border:#cfe3ff;
  --shadow:0 14px 34px rgba(90, 150, 255, .18);
  --text:#1f2230;
  --sub:#5e6475;
  --muted:#9aa0b2;
  --link:#0052a3;

  --grad: linear-gradient(90deg,
    #4dabff 0%,
    #7bc1ff 40%,
    #b3dcff 100%
  );
}

body{
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #f6faff 40%, var(--bg2) 100%);
}

.wrap{
  max-width:1100px;
  margin:2rem auto 3rem;
  padding:0 1.1rem;
  font-family:system-ui,-apple-system,"Segoe UI","Noto Sans KR",sans-serif;
  color:var(--text);
}

.head{
  background:var(--card);
  border:1px solid var(--border);
  border-radius:18px;
  box-shadow:var(--shadow);
  padding:1.5rem 1.7rem;
  margin-bottom:1.2rem;
}

.head h1{
  margin:.2rem 0 .35rem;
  font-size:1.85rem;
  font-weight:850;
}

.head p{ margin:.2rem 0; color:var(--sub); }

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

.small{ color:var(--muted); font-size:.88rem; }

.tbl{
  width:100%;
  border-collapse:separate;
  border-spacing:0;
  border-radius:14px;
  border:1px solid rgba(207,230,255,.9);
  overflow:hidden;
}

.tbl th,.tbl td{
  padding:.72rem .75rem;
  border-bottom:1px solid rgba(207,230,255,.65);
}

.tbl th{
  background:#eef5ff;
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
  border:1px dashed rgba(207,230,255,.9);
  background:#f5f9ff;
  font-size:.9rem;
}

.list{ padding-left:1.1rem; color:var(--sub); }
.list li{ margin:.25rem 0; }
</style>

<div class="wrap">

  <div class="head">
    <div class="topnav">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </div>
    <h1>🧱 ABAP2 — Screen & Web Dynpro</h1>
    <p>Classical Screen 심화부터 Web Dynpro ABAP까지 학습하는 과정입니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
      <h2>📚 학습 구성</h2>

      <div class="kicker">① Screen Programming 심화</div>
      <ul class="list">
        <li>Dynpro 구조 복습 및 심화</li>
        <li>Subscreen / Tabstrip</li>
        <li>Screen Flow Control</li>
      </ul>

      <div class="kicker">② Web Dynpro ABAP</div>
      <ul class="list">
        <li>Component / View / Window 구조</li>
        <li>Context / Data Binding</li>
        <li>Navigation / Event 처리</li>
      </ul>

      <br>

      <h2>🗂️ Lesson Index</h2>
      <table class="tbl">
        <tr><td class="col-tag">L1</td><td><a href="{{ '/studies/abap2/Lesson1' | relative_url }}">Lesson 1</a></td><td>Screen 구조 복습</td></tr>
        <tr><td class="col-tag">L2</td><td><a href="{{ '/studies/abap2/Lesson2' | relative_url }}">Lesson 2</a></td><td>Subscreen</td></tr>
        <tr><td class="col-tag">L3</td><td><a href="{{ '/studies/abap2/Lesson3' | relative_url }}">Lesson 3</a></td><td>Tabstrip Control</td></tr>
        <tr><td class="col-tag">L4</td><td><a href="{{ '/studies/abap2/Lesson4' | relative_url }}">Lesson 4</a></td><td>Screen Flow Logic</td></tr>
        <tr><td class="col-tag">L5</td><td><a href="{{ '/studies/abap2/Lesson5' | relative_url }}">Lesson 5</a></td><td>Web Dynpro 개요</td></tr>
        <tr><td class="col-tag">L6</td><td><a href="{{ '/studies/abap2/Lesson6' | relative_url }}">Lesson 6</a></td><td>Component / View</td></tr>
        <tr><td class="col-tag">L7</td><td><a href="{{ '/studies/abap2/Lesson7' | relative_url }}">Lesson 7</a></td><td>Context / Binding</td></tr>
        <tr><td class="col-tag">L8</td><td><a href="{{ '/studies/abap2/Lesson8' | relative_url }}">Lesson 8</a></td><td>Event Handling</td></tr>
        <tr><td class="col-tag">L9</td><td><a href="{{ '/studies/abap2/Lesson9' | relative_url }}">Lesson 9</a></td><td>Navigation</td></tr>
        <tr><td class="col-tag">L10</td><td><a href="{{ '/studies/abap2/Lesson10' | relative_url }}">Lesson 10</a></td><td>Mini 실습</td></tr>
      </table>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📊 이해도 진행도</h2>

        <div class="prow"><span>Screen</span><span class="pct">40%</span></div>
        <div class="meter"><span style="width:40%"></span></div>

        <div class="prow"><span>Web Dynpro</span><span class="pct">20%</span></div>
        <div class="meter"><span style="width:20%"></span></div>
      </div>

      <div class="card">
        <h2>🧩 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>Classical Screen 심화</li>
          <li>복잡한 화면 흐름 제어</li>
          <li>Web Dynpro ABAP 구조 이해</li>
          <li>Context 기반 데이터 처리</li>
        </ul>

        <div class="note">
          <code>ABAP 기반 GUI → Web 기반 UI로 넘어가는 전환 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🧠 개념 / 용어</h2>
        <ul class="list">
          <li><strong>Subscreen</strong>: 화면 분할 재사용</li>
          <li><strong>Tabstrip</strong>: 탭 기반 UI</li>
          <li><strong>Context</strong>: Web Dynpro 데이터 저장소</li>
          <li><strong>Binding</strong>: Context ↔ UI 연결</li>
        </ul>
      </div>

      <div class="card">
        <h2>📎 참고 자료</h2>
        <ul class="list">
          <li>SAP Help — Web Dynpro ABAP</li>
          <li>BC401 / BC420 교재</li>
          <li>Screen vs Web Dynpro 비교 자료</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
