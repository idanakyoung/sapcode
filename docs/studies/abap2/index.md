---
title: ABAP2 — Screen Program & ALV Grid
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
    <h1>🧱 ABAP2 — Screen Program & ALV Grid</h1>
    <p>Screen Program 실습부터 전공 리포트 개발, ALV Screen, ALV Grid, Multiple Database Tables까지 이어지는 과정을 정리한 페이지입니다.</p>
    <p class="small">기간: 2025.12.15 ~ 2025.12.31</p>
  </div>

  <div class="grid">

    <!-- LEFT -->
    <div class="card">
  
      <h2>🖥️ 학습 구성 <span class="badge">Lesson Index</span></h2>
      <table class="tbl">
        <tr>
          <td class="col-tag">12/15</td>
          <td><a href="{{ '/studies/abap2/Lesson1' | relative_url }}">Lesson 1</a></td>
          <td>Screen Program (1)</td>
        </tr>
        <tr>
          <td class="col-tag">12/16</td>
          <td><a href="{{ '/studies/abap2/Lesson2' | relative_url }}">Lesson 2</a></td>
          <td>Screen Program (2)</td>
        </tr>
        <tr>
          <td class="col-tag">12/17</td>
          <td><a href="{{ '/studies/abap2/Lesson3' | relative_url }}">Lesson 3</a></td>
          <td>Screen Program (3)</td>
        </tr>
        <tr>
          <td class="col-tag">12/18</td>
          <td><a href="{{ '/studies/abap2/Lesson4' | relative_url }}">Lesson 4</a></td>
          <td>Screen Program (4)</td>
        </tr>
        <tr>
          <td class="col-tag">12/19</td>
          <td><a href="{{ '/studies/abap2/Lesson5' | relative_url }}">Lesson 5</a></td>
          <td>프로그래밍 전공 리포트 개발 (1)</td>
        </tr>
        <tr>
          <td class="col-tag">12/22</td>
          <td><a href="{{ '/studies/abap2/Lesson6' | relative_url }}">Lesson 6</a></td>
          <td>프로그래밍 전공 리포트 개발 (2)</td>
        </tr>
        <tr>
          <td class="col-tag">12/23</td>
          <td><a href="{{ '/studies/abap2/Lesson7' | relative_url }}">Lesson 7</a></td>
          <td>ALV Screen 생성 & ALV Functionality</td>
        </tr>
        <tr>
          <td class="col-tag">12/24</td>
          <td><a href="{{ '/studies/abap2/Lesson8' | relative_url }}">Lesson 8</a></td>
          <td>ALV Grid (1)</td>
        </tr>
        <tr>
          <td class="col-tag">12/26</td>
          <td><a href="{{ '/studies/abap2/Lesson9' | relative_url }}">Lesson 9</a></td>
          <td>ALV Grid (2)</td>
        </tr>
        <tr>
          <td class="col-tag">12/29</td>
          <td><a href="{{ '/studies/abap2/Lesson_10' | relative_url }}">Lesson 10</a></td>
          <td>ALV Grid (3)</td>
        </tr>
        <tr>
          <td class="col-tag">12/30</td>
          <td><a href="{{ '/studies/abap2/Lesson_11' | relative_url }}">Lesson 11</a></td>
          <td>ALV Grid (4)</td>
        </tr>
        <tr>
          <td class="col-tag">12/31</td>
          <td><a href="{{ '/studies/abap2/Lesson_12' | relative_url }}">Lesson 12</a></td>
          <td>Multiple Database Tables (1)</td>
        </tr>
        <tr>
          <td class="col-tag">12/31</td>
          <td><a href="{{ '/studies/abap2/Lesson_13' | relative_url }}">Lesson 13</a></td>
          <td>Multiple Database Tables (2)</td>
        </tr>
      </table>
      
      <br>

      <h2>📈 주요 개념</h2>

      <div class="kicker">① Screen Program</div>
      <ul class="list">
        <li>Screen Program의 기본 구조와 흐름</li>
        <li>입력/출력 화면과 프로그램 로직 연결</li>
        <li>실습을 통한 화면 중심 ABAP 프로그램 구성</li>
      </ul>

      <div class="kicker">② 리포트 개발</div>
      <ul class="list">
        <li>전공 리포트 형식의 프로그램 개발</li>
        <li>조회 로직과 출력 구조 설계</li>
        <li>실습형 과제를 통해 프로그램 완성도 높이기</li>
      </ul>

      <div class="kicker">③ ALV Screen / ALV Grid</div>
      <ul class="list">
        <li>ALV Screen 생성과 기본 기능 이해</li>
        <li>ALV Grid를 이용한 데이터 출력과 제어</li>
        <li>실무형 리스트 화면 구성 방식 학습</li>
      </ul>

      <div class="kicker">④ Multiple Database Tables</div>
      <ul class="list">
        <li>여러 데이터베이스 테이블을 함께 다루는 방법</li>
        <li>복합 조회와 데이터 연결 구조 이해</li>
        <li>프로그램 확장 시 필요한 다중 테이블 처리 감각 익히기</li>
      </ul>
    </div>

    <!-- RIGHT -->
    <aside style="display:flex; flex-direction:column; gap:1rem;">

      <div class="card">
        <h2>📶 이해도 진행도</h2>

        <div class="prow"><span>Screen Program</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>리포트 개발</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>ALV Screen / Grid</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>

        <div class="prow"><span>Multiple DB Tables</span><span class="pct">100%</span></div>
        <div class="meter"><span style="width:100%"></span></div>
      </div>

      <div class="card">
        <h2>🔵 이 과정에서 다루는 내용</h2>
        <ul class="list">
          <li>Screen Program 기반 화면 개발</li>
          <li>리포트 프로그램 설계와 구현</li>
          <li>ALV Screen / ALV Grid 활용</li>
          <li>다중 테이블 기반 조회 프로그램 확장</li>
        </ul>

        <div class="note">
          <code>기초 문법과 조회 중심 학습 이후, 실제 화면과 출력 프로그램을 본격적으로 만드는 단계</code>
        </div>
      </div>

      <div class="card">
        <h2>🌐 개념 / 용어</h2>
        <ul class="list">
          <li><strong>Screen Program</strong>: 화면과 ABAP 로직이 결합된 전통적 SAP 프로그램 방식</li>
          <li><strong>ALV</strong>: 표준 리스트 출력 도구로, 조회 결과를 효율적으로 표시하는 방식</li>
          <li><strong>ALV Grid</strong>: 사용자가 다루기 쉬운 형태의 인터랙티브 리스트 출력</li>
          <li><strong>Multiple Database Tables</strong>: 여러 테이블을 연결해 데이터를 조회하는 구조</li>
        </ul>
      </div>

      <div class="card">
        <h2>📎 참고 자료</h2>
        <ul class="list">
          <li>ABAP Screen Program 실습 자료</li>
          <li>ALV Screen / Grid 관련 강의 노트</li>
          <li>다중 테이블 조회 예제 및 전공 리포트 개발 자료</li>
        </ul>
      </div>

    </aside>
  </div>
</div>
