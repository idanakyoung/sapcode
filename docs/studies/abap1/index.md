---
title: ABAP1 — Foundation, Open SQL & Screen Basics
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
    <h1>⚙️ ABAP1 — Foundation, Open SQL & Screen Basics</h1>
    <p>ABAP 입문 단계부터 Open SQL, Dictionary, View, Search Help, Screen, ALV, 1차 시험 정리까지 이어지는 기초 과정을 정리한 페이지입니다.</p>
    <p class="small">기간: 2025.11.14 ~ 2025.12.12</p>
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
          <td>기초 SAP ABAP 개발 패턴 노트</td>
        </tr>
        <tr>
          <td class="col-tag">11/25</td>
          <td><a href="{{ '/studies/abap1/Lesson7' | relative_url }}">Lesson 7</a></td>
          <td>ABAP Internal Table & Data Modeling and Data Retrieval</td>
        </tr>
        <tr>
          <td class="col-tag">11/26</td>
          <td><a href="{{ '/studies/abap1/Lesson8' | relative_url }}">Lesson 8</a></td>
          <td>Open SQL & Inner Join</td>
        </tr>
        <tr>
          <td class="col-tag">11/27</td>
          <td><a href="{{ '/studies/abap1/Lesson9' | relative_url }}">Lesson 9</a></td>
          <td>ABAP Dictionary: 프로그래밍 데이터 타입과 활용</td>
        </tr>
        <tr>
          <td class="col-tag">11/28</td>
          <td><a href="{{ '/studies/abap1/Lesson10' | relative_url }}">Lesson 10</a></td>
          <td>Performance During Table Access</td>
        </tr>
        <tr>
          <td class="col-tag">12/01</td>
          <td><a href="{{ '/studies/abap1/Lesson11' | relative_url }}">Lesson 11</a></td>
          <td>Dictionary Object Dependencies & Table Changes & Views and Maintenance Views</td>
        </tr>
        <tr>
          <td class="col-tag">12/02</td>
          <td><a href="{{ '/studies/abap1/Lesson12' | relative_url }}">Lesson 12</a></td>
          <td>Views & Joins & View Cluster & Search Helps & Screen</td>
        </tr>
        <tr>
          <td class="col-tag">12/03</td>
          <td><a href="{{ '/studies/abap1/Lesson13' | relative_url }}">Lesson 13</a></td>
          <td>Screen Painter & SAP List Viewer (ALV)</td>
        </tr>
        <tr>
          <td class="col-tag">12/04~12/12</td>
          <td><a href="{{ '/studies/abap1/ABAP_1st_Exam' | relative_url }}">ABAP 1st Exam 추가 정리 및 POU</a></td>
          <td>1차 시험 보충 정리 및 POU</td>
        </tr>
        <tr>
          <td class="col-tag">12/04~12/12</td>
          <td><a href="{{ '/studies/abap1/summary' | relative_url }}">ABAP 실습 파일 요약 및 정리</a></td>
          <td>실습 파일 요약, 전체 흐름 정리</td>
        </tr>
      </table>

      <br>

      <h2>📈 주요 개념</h2>

      <div class="kicker">① ABAP Foundation</div>
      <ul class="list">
        <li>ABAP Overview와 기본 문법</li>
        <li>Modularization, Function Module, BAPI</li>
        <li>Internal Table을 활용한 기초 데이터 처리</li>
      </ul>

      <div class="kicker">② Open SQL & Data Retrieval</div>
      <ul class="list">
        <li>Open SQL 문법과 데이터 조회</li>
        <li>Inner Join과 데이터 모델링 기초</li>
        <li>DB 테이블과 프로그램 로직 연결</li>
      </ul>

      <div class="kicker">③ ABAP Dictionary</div>
      <ul class="list">
        <li>프로그래밍 데이터 타입과 DDIC 객체</li>
        <li>Dictionary Object Dependencies</li>
        <li>Views, Maintenance Views, View Cluster 이해</li>
      </ul>

      <div class="kicker">④ Search Help / Screen / ALV</div>
      <ul class="list">
        <li>Search Help를 통한 입력 지원</li>
        <li>Screen Painter 기반 화면 구성</li>
        <li>SAP List Viewer(ALV)를 이용한 리스트 출력</li>
      </ul>

    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>💎 이해도 진행도</h2>

        <div class="prow"><span>기초 문법 / 구조화</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>Open SQL / Data Retrieval</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>DDIC / View / Search Help</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>Screen / ALV</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>
      </div>

      <div class="card">
        <h2>💙 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>ABAP 기본 문법과 구조화 기법</li>
          <li>Function Module, BAPI, Internal Table</li>
          <li>Open SQL, Dictionary, View, Search Help</li>
          <li>Screen Painter와 ALV 기반 기초 화면 구성</li>
        </ul>

        <div class="note">
          <code>ABAP 언어 기초부터 데이터 조회, DDIC, 화면 출력까지 한 번에 이어지는 첫 번째 핵심 기초 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🌐 개념 / 용어 정리</h2>
        <ul class="list">
          <li><strong>Modularization</strong>: 프로그램을 기능 단위로 분리하는 기법</li>
          <li><strong>Open SQL</strong>: SAP ABAP에서 사용하는 데이터베이스 접근 SQL</li>
          <li><strong>DDIC</strong>: SAP 데이터 사전으로, 데이터 구조를 정의하는 저장소</li>
          <li><strong>ALV</strong>: SAP 표준 리스트 출력 도구</li>
        </ul>
      </div>

      <div class="card">
        <h2>📎 참고 자료</h2>
        <ul class="list">
          <li><a href="https://help.sap.com" target="_blank">SAP ABAP 공식 문서</a></li>
          <li><a href="https://learning.sap.com" target="_blank">SAP Learning</a></li>
          <li>ABAP 기초 강의 노트, 1차 시험 정리, 실습 요약 자료</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
