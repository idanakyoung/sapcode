---
title: ABAP1 — Foundation & Screen
---

<style>
:root {
  --portal-bg: #f7fbff;
  --portal-card-bg: #ffffff;
  --portal-border: #cfe6ff;
  --portal-shadow: 0 12px 30px rgba(84, 132, 255, 0.15);
  --text-main: #222431;
  --text-sub: #5f6472;
  --text-muted: #9a9fb0;
  --link: #0052a3;
  --link-hover: #003a73;
}
body { background: radial-gradient(circle at top left,#e3f1ff 0,#f7fbff 45%,#ffffff 100%); }
.portal{max-width:1100px;margin:2.2rem auto 3rem;padding:0 1.2rem;font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI","Noto Sans KR",sans-serif;}
.portal-header{background:var(--portal-card-bg);border-radius:18px;padding:1.8rem 2rem;box-shadow:var(--portal-shadow);border:1px solid:var(--portal-border);margin-bottom:1.6rem;}
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
    <h1 class="portal-title">⚙️ ABAP1 — Foundation / Dictionary / Screen</h1>
    <p class="portal-sub"><strong>목표</strong> ABAP 언어 기초와 Data Dictionary, 그리고 기본 Screen Programming(PBO/PAI)을 이해하는 것.</p>
  </header>

  <section class="portal-grid">

    <div>

      <section class="portal-card">
        <h2>📚 학습 구성</h2>

        <h3>① ABAP 기본 문법</h3>
        <ul class="portal-list">
          <li>DATA 선언, 타입, 구조(Structure)</li>
          <li>제어문 (IF, CASE, LOOP, DO ... ENDDO)</li>
          <li>내부 테이블 기본 개념</li>
        </ul>

        <h3>② ABAP Dictionary(DDIC)</h3>
        <ul class="portal-list">
          <li>Domain / Data Element / Table / View</li>
          <li>키와 외래키, 테이블 하이라키 구조</li>
          <li>검색 도움말(Search Help), Check Table</li>
        </ul>

        <h3>③ Screen Programming (Dynpro)</h3>
        <ul class="portal-list">
          <li>Screen Attributes, Layout, Element Attributes</li>
          <li>PBO / PAI, Flow Logic, MODULE 사용</li>
          <li>TABLES, OK_CODE, SCREEN 구조 활용</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🔎 핵심 키워드</h2>
        <ul class="portal-list">
          <li>ABAP Program Type (Report, Module Pool 등)</li>
          <li>DDIC: Domain / Data Element / Transparent Table</li>
          <li>Screen: 요소명 ↔ ABAP 변수 이름 동일 처리(Identical Names)</li>
          <li>PBO: 화면 출력 전 데이터 세팅 / PAI: 사용자 입력 처리</li>
        </ul>
      </section>

    </div>

    <aside>

      <section class="portal-card">
        <h2>✅ 실습 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] 나만의 Transparent Table 하나 설계</li>
          <li>[ ] Domain / Data Element 각각 1개 이상 생성</li>
          <li>[ ] 간단한 조회 Screen (100번 Dynpro) 만들기</li>
          <li>[ ] PBO 모듈에서 초기값 세팅, PAI에서 LEAVE TO SCREEN 처리</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🔗 참고</h2>
        <p class="portal-small">
          • DDIC 오브젝트 세부 설명은 <strong>ABAP Dictionary</strong> 공식 도움말 참고<br>
          • BC410 교재의 Unit 1, 2 실습 정리와 함께 볼 것
        </p>
      </section>

    </aside>

  </section>

</div>
