---
title: ABAP3 — HANA & CDS
---

<style>
:root{
  --portal-bg:#f7f9ff;--portal-card-bg:#ffffff;--portal-border:#d1d8ff;
  --portal-shadow:0 12px 30px rgba(112,128,255,0.18);
  --text-main:#222431;--text-sub:#5f6472;--text-muted:#9a9fb0;
  --link:#3949ab;--link-hover:#283593;
}
body{background:radial-gradient(circle at top left,#e3e7ff 0,#f7f9ff 45%,#ffffff 100%);}
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
    <h1 class="portal-title">💾 ABAP3 — HANA / CDS / New Syntax</h1>
    <p class="portal-sub"><strong>목표</strong> HANA 최적화된 ABAP 코드와 CDS View 개념을 이해하고, New Syntax 중심의 현대 ABAP 스타일에 익숙해지는 것.</p>
  </header>

  <section class="portal-grid">

    <div>

      <section class="portal-card">
        <h2>📚 학습 구성</h2>

        <h3>① New ABAP Syntax</h3>
        <ul class="portal-list">
          <li>INLINE 선언: <code>DATA(ls_data) = ...</code>, <code>SELECT ... INTO @DATA()</code></li>
          <li>FILTER, REDUCE, LOOP AT GROUP 등 최신 구문</li>
        </ul>

        <h3>② CDS View</h3>
        <ul class="portal-list">
          <li>View 정의, Annotation(@AbapCatalog, @OData.publish 등)</li>
          <li>Association, Projection View 개념</li>
          <li>CDS + Consumption View → UI에서 사용</li>
        </ul>

        <h3>③ HANA 기반 처리</h3>
        <ul class="portal-list">
          <li>코드 푸시다운(Code Pushdown) 개념</li>
          <li>가능하면 CDS로, 안 되면 Open SQL로</li>
        </ul>
      </section>

    </div>

    <aside>

      <section class="portal-card">
        <h2>✅ 실습 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] 기존 SELECT 구문을 New Syntax로 변환해 보기</li>
          <li>[ ] SFLIGHT / SPFLI 기반 CDS View 정의</li>
          <li>[ ] CDS를 사용해서 Report 또는 UI5 앱에서 데이터 읽기</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🔗 Project와 연계</h2>
        <p class="portal-small">
          Project 단계에서 <strong>조회 성능이 중요한 부분</strong>은 CDS View로 구현하고,<br>
          Fiori 혹은 UI5 화면에서 해당 CDS를 직접 소비하도록 설계할 수 있습니다.
        </p>
      </section>

    </aside>

  </section>

</div>


[↩ 홈으로](./)
