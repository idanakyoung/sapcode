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
body{background:radial-gradient(circle at top left,#d9fff1 0,#f5fffb 45%,#ffffff 100%);}
.portal{max-width:1100px;margin:2.2rem auto 3rem;padding:0 1.2rem;font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI","Noto Sans KR",sans-serif;}
.portal-header{background:var(--portal-card-bg);border-radius:18px;padding:1.8rem 2rem;box-shadow:var(--portal-shadow);border:1px solid var(--portal-border);margin-bottom:1.6rem;}
.portal-title{font-size:1.9rem;font-weight:800;margin:0 0 .4rem;}
.portal-sub{font-size:.95rem;color:var(--text-sub);margin:.1rem 0;}
.portal-grid{display:grid;grid-template-columns:2.1fr 1fr;gap:1.2rem;}
.portal-card{background:var(--portal-card-bg);border-radius:16px;border:1px solid var(--portal-border);padding:1.4rem 1.6rem;box-shadow:0 8px 22px rgba(0,0,0,.03);}
.portal-card h2{font-size:1.2rem;margin:0 0 .6rem;display:flex;align-items:center;gap:.4rem;}
.portal-card h3{font-size:1rem;margin:.9rem 0 .4rem;}
.portal-list{margin:.2rem 0 .4rem;padding-left:1rem;}
.portal-list li{margin:.18rem 0;}
.portal-small{font-size:.85rem;color:var(--text-muted);}
.portal a{color:var(--link);text-decoration:none;}
.portal a:hover{color:var(--link-hover);text-decoration:underline;}
.portal-checklist{list-style:none;padding-left:0;font-size:.9rem;margin:.3rem 0 0;}
.portal-checklist li{margin:.18rem 0;}
@media(max-width:820px){.portal-grid{grid-template-columns:1fr;}}
</style>

<div class="portal">

  <header class="portal-header">
    <p class="portal-small"><a href="https://idanakyoung.github.io/sapcode/">← SAP CODE 메인으로</a></p>
    <h1 class="portal-title">🧱 ABAP2 — Report / Database / OO</h1>
    <p class="portal-sub"><strong>목표</strong> Report 프로그램으로 데이터를 조회·출력하고, DB 업데이트와 ABAP OO의 기본을 이해하는 것.</p>
  </header>

  <section class="portal-grid">

    <div>

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
        <h2>✅ 실습 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] SELECT 결과를 Internal Table에 담아 리스트 출력</li>
          <li>[ ] 조건에 따라 UPDATE / DELETE 처리하는 Report 작성</li>
          <li>[ ] 단순 비즈니스 로직을 Class로 분리해 보기</li>
        </ul>
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


[↩ 홈으로](./)
