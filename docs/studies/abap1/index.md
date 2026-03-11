---
title: ABAP1 — Foundation & Modularization
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

.badge {
  font-size: 0.78rem;
  padding: 0.16rem 0.5rem;
  border-radius: 999px;
  border: 1px solid var(--border);
  background: #fff7fb;
  color: var(--sub);
}

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
    <h1>⚙️ ABAP1 — Foundation & Modularization</h1>
    <p>ABAP 입문 단계에서 다룬 기본 문법, 구조화 기법, Function Module, BAPI, Internal Table 중심의 내용을 정리한 과정입니다.</p>
    <p class="small">기간: 2025.11.14 ~ 2025.11.24</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">

      <h2>✏️ 학습 구성 <span class="badge">Lesson Index</span></h2>
      <table class="tbl">
        <tr>
          <td class="col-tag">11/14</td>
          <td><a href="{{ '/studies/abap1/Lesson1' | relative_url }}">Lesson 1</a></td>
          <td>ABAP Overview</td>
        </tr>
        <tr>
          <td class="col-tag">11/17</td>
          <td><a href="{{ '/studies/abap1/Lesson2' | relative_url }}">Lesson 2</a></td>
          <td>Basic ABAP Language Elements (1)</td>
        </tr>
        <tr>
          <td class="col-tag">11/18</td>
          <td><a href="{{ '/studies/abap1/Lesson3' | relative_url }}">Lesson 3</a></td>
          <td>Basic ABAP Language Elements (2) & Modularization Techniques in ABAP (1)</td>
        </tr>
        <tr>
          <td class="col-tag">11/19</td>
          <td><a href="{{ '/studies/abap1/Lesson4' | relative_url }}">Lesson 4</a></td>
          <td>Modularization Techniques in ABAP (2)</td>
        </tr>
        <tr>
          <td class="col-tag">11/20</td>
          <td><a href="{{ '/studies/abap1/Lesson5' | relative_url }}">Lesson 5</a></td>
          <td>Calling Function Module & Describing BAPI</td>
        </tr>
        <tr>
          <td class="col-tag">11/21</td>
          <td><a href="{{ '/studies/abap1/Lesson6' | relative_url }}">Lesson 6</a></td>
          <td>ABAP Internal Table</td>
        </tr>
        <tr>
          <td class="col-tag">11/24</td>
          <td><a href="{{ '/studies/abap1/dev-note' | relative_url }}">개발 패턴 노트</a></td>
          <td>기초 SAP ABAP 개발 패턴 정리</td>
        </tr>
      </table>

      <br>

      <h2>📈 주요 개념</h2>

      <div class="kicker">① ABAP 기초 문법</div>
      <ul class="list">
        <li>ABAP Overview와 기본 실행 구조</li>
        <li>DATA 선언, 타입, 조건문, 반복문 등 기본 문법</li>
        <li>기초적인 프로그램 흐름과 문장 구조 이해</li>
      </ul>

      <div class="kicker">② Modularization</div>
      <ul class="list">
        <li>FORM / PERFORM 기반 구조화</li>
        <li>기능 단위 분리와 재사용 가능한 코드 작성 방식</li>
        <li>프로그램을 읽기 쉽게 나누는 기본 설계 감각</li>
      </ul>

      <div class="kicker">③ Function Module / BAPI</div>
      <ul class="list">
        <li>Function Module 호출 방식</li>
        <li>BAPI 개념과 SAP 표준 비즈니스 인터페이스 이해</li>
        <li>재사용 가능한 기능 단위와 비즈니스 로직 연결</li>
      </ul>

      <div class="kicker">④ Internal Table</div>
      <ul class="list">
        <li>ABAP Internal Table의 개념</li>
        <li>반복 처리와 데이터 임시 저장 구조</li>
        <li>실습 중심의 기본 데이터 처리 패턴</li>
      </ul>

    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>💎 이해도 진행도</h2>

        <div class="prow"><span>기초 문법</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>구조화 기법</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>FM / BAPI</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>Internal Table</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>
      </div>

      <div class="card">
        <h2>💙 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>ABAP Overview와 기초 문법 이해</li>
          <li>프로그램 구조화와 Modularization 기법</li>
          <li>Function Module과 BAPI의 역할</li>
          <li>Internal Table을 활용한 기본 데이터 처리</li>
        </ul>

        <div class="note">
          <code>ABAP 언어 자체를 익히고, 이후 SQL / DDIC / Screen / OO / CDS로 넘어가기 위한 기초 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🌐 개념 / 용어 정리</h2>
        <ul class="list">
          <li><strong>Modularization</strong>: 프로그램을 기능 단위로 분리하는 기법</li>
          <li><strong>Function Module</strong>: SAP에서 재사용 가능한 기능 블록</li>
          <li><strong>BAPI</strong>: SAP 비즈니스 객체를 다루는 표준 인터페이스</li>
          <li><strong>Internal Table</strong>: 메모리상에서 데이터를 처리하는 ABAP 테이블</li>
        </ul>
      </div>

      <div class="card">
        <h2>📎 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com" target="_blank">SAP ABAP 공식 문서</a></li>
          <li><a href="https://learning.sap.com" target="_blank">SAP Learning</a></li>
          <li>ABAP 기초 강의 노트 및 개발 패턴 정리</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
