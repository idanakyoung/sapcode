---
title: ABAP1 — Foundation & Screen
---

<style>
:root{
  --bg1:#eef5ff;
  --bg2:#ffffff;
  --card:#ffffff;
  --border:#cfe6ff;
  --shadow:0 14px 34px rgba(84, 132, 255, .18);
  --text:#1f2230;
  --sub:#5e6475;
  --muted:#9aa0b2;
  --link:#0052a3;

  --grad: linear-gradient(90deg,
    #5aa9ff 0%,
    #7bb7ff 40%,
    #9fd3ff 100%
  );
}

body{
  background: radial-gradient(circle at 10% 0%, var(--bg1) 0, #f5f9ff 40%, var(--bg2) 100%);
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
    <h1>⚙️ ABAP1 — Foundation & Screen</h1>
    <p>ABAP 기본 문법부터 Data Dictionary, Screen Programming까지 정리한 과정입니다.</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">

          <h2>✏️ 학습 구성 <span class="badge">Lesson Index</span></h2>
          <table class="tbl">
            <tr><td class="col-tag">1</td><td><a href="{{ '/studies/abap1/Lesson1' | relative_url }}">Lesson 1</a></td><td>기초 문법</td></tr>
            <tr><td class="col-tag">2</td><td><a href="{{ '/studies/abap1/Lesson2' | relative_url }}">Lesson 2</a></td><td>실습</td></tr>
            <tr><td class="col-tag">3</td><td><a href="{{ '/studies/abap1/Lesson3' | relative_url }}">Lesson 3</a></td><td>구조화</td></tr>
            <tr><td class="col-tag">4</td><td><a href="{{ '/studies/abap1/Lesson4' | relative_url }}">Lesson 4</a></td><td>DDIC 기초</td></tr>
            <tr><td class="col-tag">5</td><td><a href="{{ '/studies/abap1/Lesson5' | relative_url }}">Lesson 5</a></td><td>DDIC 심화</td></tr>
            <tr><td class="col-tag">6</td><td><a href="{{ '/studies/abap1/Lesson6' | relative_url }}">Lesson 6</a></td><td>Screen</td></tr>
            <tr><td class="col-tag">7</td><td><a href="{{ '/studies/abap1/Lesson7' | relative_url }}">Lesson 7</a></td><td>PBO / PAI</td></tr>
            <tr><td class="col-tag">8</td><td><a href="{{ '/studies/abap1/Lesson8' | relative_url }}">Lesson 8</a></td><td>Flow Logic</td></tr>
            <tr><td class="col-tag">9</td><td><a href="{{ '/studies/abap1/Lesson9' | relative_url }}">Lesson 9</a></td><td>정리</td></tr>
            <tr><td class="col-tag">10</td><td><a href="{{ '/studies/abap1/Lesson_10' | relative_url }}">Lesson 10</a></td><td>정리</td></tr>
            <tr><td class="col-tag">11</td><td><a href="{{ '/studies/abap1/Lesson_11' | relative_url }}">Lesson 11</a></td><td>정리</td></tr>
            <tr><td class="col-tag">12</td><td><a href="{{ '/studies/abap1/Lesson_12' | relative_url }}">Lesson 12</a></td><td>정리</td></tr>
            <tr><td class="col-tag">13</td><td><a href="{{ '/studies/abap1/Lesson_13' | relative_url }}">Lesson 13</a></td><td>정리</td></tr>
          </table>
      
      <br>
      
          <h2>📈 주요 개념</h2>
    
          <div class="kicker">① ABAP 기본 문법</div>
          <ul class="list">
            <li>DATA 선언, 타입, 구조(Structure)</li>
            <li>IF / CASE / LOOP 제어문</li>
            <li>내부 테이블 개념</li>
          </ul>
    
          <div class="kicker">② ABAP Dictionary (DDIC)</div>
          <ul class="list">
            <li>Domain / Data Element</li>
            <li>Transparent Table / View</li>
            <li>Search Help / Check Table</li>
          </ul>
    
          <div class="kicker">③ Screen Programming</div>
          <ul class="list">
            <li>Screen Layout / Attributes</li>
            <li>PBO / PAI / Flow Logic</li>
            <li>OK_CODE / MODULE 구조</li>
          </ul>
      
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>💎 이해도 진행도</h2>

        <div class="prow"><span>ABAP 문법</span><span class="pct">30%</span></div>
        <div class="meter"><span style="width:30%"></span></div>

        <div class="prow"><span>DDIC</span><span class="pct">20%</span></div>
        <div class="meter"><span style="width:20%"></span></div>

        <div class="prow"><span>Screen</span><span class="pct">10%</span></div>
        <div class="meter"><span style="width:10%"></span></div>
      </div>

      <div class="card">
        <h2>💙 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>ABAP 기본 문법과 구조</li>
          <li>Dictionary 기반 데이터 설계</li>
          <li>Screen 기반 ERP 입력 화면</li>
          <li>PBO / PAI 흐름 이해</li>
        </ul>

        <div class="note">
          <code>SAP ERP 핵심 로직과 화면 구조를 이해하는 첫 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🌐 개념 / 용어 정리</h2>
        <ul class="list">
          <li><strong>DDIC</strong>: SAP 데이터 사전</li>
          <li><strong>PBO</strong>: 화면 출력 전 처리</li>
          <li><strong>PAI</strong>: 사용자 입력 처리</li>
          <li><strong>OK_CODE</strong>: 사용자 액션 식별</li>
        </ul>
      </div>

      <div class="card">
        <h2>📎 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com" target="_blank">SAP ABAP 공식 문서</a></li>
          <li><a href="https://learning.sap.com" target="_blank">SAP Learning</a></li>
          <li>BC410 교재 Unit 1~3</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
