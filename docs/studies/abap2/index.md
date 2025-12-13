---
title: ABAP2 — Report / DB / OO
---

<style>
:root {
  --portal-bg:#f5fffb; --portal-card-bg:#ffffff; --portal-border:#c5f2df;
  --portal-shadow:0 12px 30px rgba(70,177,131,0.18);
  --text-main:#222431; --text-sub:#5f6472; --text-muted:#9a9fb0;
  --link:#007a5a; --link-hover:#00533d;
}

body{
  background:radial-gradient(circle at top left,#d9fff1 0,#f5fffb 45%,#ffffff 100%);
}

.portal{
  max-width:1100px;margin:2.2rem auto 3rem;padding:0 1.2rem;
  font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI","Noto Sans KR",sans-serif;
}

.portal-header{
  background:var(--portal-card-bg);border-radius:18px;padding:1.8rem 2rem;
  box-shadow:var(--portal-shadow);border:1px solid var(--portal-border);
  margin-bottom:1.6rem;
}

.portal-title{font-size:1.9rem;font-weight:800;margin:0 0 .4rem;}
.portal-sub{font-size:.95rem;color:var(--text-sub);margin:.1rem 0;}
.portal-grid{display:grid;grid-template-columns:2.1fr 1fr;gap:1.2rem;}

.portal-card{
  background:var(--portal-card-bg);border-radius:16px;border:1px solid var(--portal-border);
  padding:1.4rem 1.6rem;box-shadow:0 8px 22px rgba(0,0,0,.03);
}

.portal-card h2{
  font-size:1.2rem;margin:0 0 .6rem;display:flex;align-items:center;gap:.4rem;
}
.portal-card h3{font-size:1rem;margin:.9rem 0 .4rem;}

.portal-list{margin:.2rem 0 .4rem;padding-left:1rem;}
.portal-list li{margin:.18rem 0;}
.portal-small{font-size:.85rem;color:var(--text-muted);}

.portal a{color:var(--link);text-decoration:none;}
.portal a:hover{color:var(--link-hover);text-decoration:underline;}

/* ===== ABAP2: Lesson Table ===== */
.lesson-table{
  width:100%;
  border-collapse:separate;
  border-spacing:0;
  overflow:hidden;
  border:1px solid rgba(0,0,0,0.06);
  border-radius:12px;
}
.lesson-table th,.lesson-table td{
  padding:.85rem .9rem;
  border-bottom:1px solid rgba(0,0,0,0.06);
  vertical-align:top;
}
.lesson-table th{
  width:170px;
  background:#eafff6;
  font-weight:800;
  color:var(--text-main);
  white-space:nowrap;
}
.lesson-table tr:last-child th,.lesson-table tr:last-child td{border-bottom:none;}
.lesson-links{margin:0;padding-left:1.1rem;}
.lesson-links li{margin:.18rem 0;}

/* ===== ABAP2: Progress Meter (0~100) ===== */
.meter{
  margin-top:.25rem;
}
.meter + .meter{
  margin-top:1rem;
}
.meter-label{
  display:flex;
  justify-content:space-between;
  font-size:.9rem;
  color:var(--text-sub);
  margin-bottom:.35rem;
}
.meter-bar{
  position:relative;
  height:12px;
  border-radius:999px;
  overflow:hidden;
  border:1px solid rgba(0,0,0,0.08);
  background:#ffffff;
}
.meter-bar::before{
  content:"";
  position:absolute;
  inset:0 auto 0 0;
  width:var(--value,0%);
  background:linear-gradient(90deg,#ff5e7a 0%, #ffb000 45%, #2ecc71 100%);
}
.meter-hint{
  font-size:.85rem;
  color:var(--text-muted);
  margin-top:.55rem;
  line-height:1.45;
}

.quick-btn{
  display:inline-flex;
  align-items:center;
  gap:.45rem;
  padding:.55rem .75rem;
  border-radius:12px;
  border:1px solid var(--portal-border);
  background:#fff;
  text-decoration:none;
  color:var(--link);
  font-weight:750;
}
.quick-btn:hover{
  color:var(--link-hover);
  border-color:#9fe7cb;
  text-decoration:none;
}

@media(max-width:820px){
  .portal-grid{grid-template-columns:1fr;}
  .lesson-table th{width:140px;}
}
</style>

<div class="portal">

  <header class="portal-header">
    <p class="portal-small">
      <a href="{{ '/' | relative_url }}">← SAP CODE 메인으로</a>
    </p>
    <h1 class="portal-title">🧱 ABAP2 — Report / Database / OO</h1>
    <p class="portal-sub">
      <strong>목표</strong> Report 프로그램으로 데이터를 조회·출력하고, DB 업데이트와 ABAP OO의 기본을 이해하는 것.
    </p>
  </header>

  <section class="portal-grid">

    <div>

      <section class="portal-card">
        <h2>🗂️ 레슨 링크</h2>
        <p class="portal-small">레슨은 계속 추가될 예정이라 표 형태로 “바로가기”만 먼저 만들어둡니다.</p>

        <table class="lesson-table">
          <tbody>
            <tr>
              <th>Report / DB</th>
              <td>
                <ul class="lesson-links">
                  <li>RDB 1 — <a href="{{ '/abap2/Lesson1' | relative_url }}">Lesson 1</a></li>
                  <li>RDB 2 — <a href="{{ '/abap2/Lesson2' | relative_url }}">Lesson 2</a></li>
                  <li>RDB 3 — <a href="{{ '/abap2/Lesson3' | relative_url }}">Lesson 3</a></li>
                  <li>RDB 4 — <a href="{{ '/abap2/Lesson4' | relative_url }}">Lesson 4</a></li>
                  <li>RDB 5 — <a href="{{ '/abap2/Lesson5' | relative_url }}">Lesson 5</a></li>
                </ul>
                <p class="portal-small" style="margin:.5rem 0 0;">
                  ※ 파일명이 다르면(예: <code>Lesson_10</code>) 링크도 똑같이 맞춰야 해요.
                </p>
              </td>
            </tr>

            <tr>
              <th>ABAP OO</th>
              <td>
                <ul class="lesson-links">
                  <li>OO 1 — <a href="{{ '/abap2/Lesson6' | relative_url }}">Lesson 6</a></li>
                  <li>OO 2 — <a href="{{ '/abap2/Lesson7' | relative_url }}">Lesson 7</a></li>
                  <li>OO 3 — <a href="{{ '/abap2/Lesson8' | relative_url }}">Lesson 8</a></li>
                  <li>OO 4 — <a href="{{ '/abap2/Lesson9' | relative_url }}">Lesson 9</a></li>
                  <li>OO 5 — <a href="{{ '/abap2/Lesson_10' | relative_url }}">Lesson 10</a></li>
                </ul>
              </td>
            </tr>
          </tbody>
        </table>

        <p class="portal-small" style="margin:.9rem 0 0;">
          <a class="quick-btn" href="{{ '/abap2/' | relative_url }}">← ABAP2 목차(현재 페이지)</a>
          <a class="quick-btn" href="{{ '/' | relative_url }}" style="margin-left:.35rem;">🏠 홈</a>
        </p>
      </section>

      <section class="portal-card">
        <h2>📊 Report & DB</h2>

        <h3>① Report Program</h3>
        <ul class="portal-list">
          <li>Selection Screen (PARAMETERS / SELECT-OPTIONS)</li>
          <li>클래식 리스트 / AT LINE-SELECTION 등 이벤트</li>
          <li>ALV 기본 개념(필요 시)</li>
        </ul>

        <h3>② Open SQL & Internal Table</h3>
        <ul class="portal-list">
          <li>SELECT / INSERT / UPDATE / DELETE 기본문</li>
          <li>내부 테이블: APPEND, LOOP, READ, MODIFY</li>
          <li>성능 고려한 WHERE 조건, 키 사용</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🧩 ABAP OO 기초</h2>
        <ul class="portal-list">
          <li>CLASS / METHODS / PUBLIC SECTION / PRIVATE SECTION</li>
          <li>객체 생성: CREATE OBJECT</li>
          <li>간단한 서비스 클래스로 로직 캡슐화</li>
        </ul>
      </section>

    </div>

    <aside>

      <section class="portal-card">
        <h2>📈 학습 진행 상태</h2>

        <div class="meter">
          <div class="meter-label">
            <span>Report / DB</span>
            <span><strong>20%</strong></span>
          </div>
          <div class="meter-bar" style="--value: 20%;"></div>
        </div>

        <div class="meter">
          <div class="meter-label">
            <span>ABAP OO</span>
            <span><strong>10%</strong></span>
          </div>
          <div class="meter-bar" style="--value: 10%;"></div>
        </div>

        <p class="meter-hint">
          %는 여기만 바꾸면 돼요 👉 <code>style="--value: 60%;"</code><br/>
          “20/10” 이런 숫자도 같이 수정하면 더 자연스러워요.
        </p>
      </section>

      <section class="portal-card">
        <h2>🔗 다음 단계</h2>
        <p class="portal-small">
          ABAP2에서 만든 Report와 OO 구조는 이후 <strong>ABAP3 (CDS/HANA)</strong> 및 <strong>Project</strong>의 백엔드 로직 기반이 됩니다.
        </p>
      </section>

    </aside>

  </section>

</div>
