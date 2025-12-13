---
title: UX2+3 — Gateway & Fiori
---

<style>
:root{
  --portal-bg:#f2fbff;--portal-card-bg:#ffffff;--portal-border:#ccecff;
  --portal-shadow:0 12px 30px rgba(64,196,255,0.18);
  --text-main:#222431;--text-sub:#5f6472;--text-muted:#9a9fb0;
  --link:#0078b8;--link-hover:#00527e;
}
body{background:radial-gradient(circle at top left,#e1f5ff 0,#f2fbff 45%,#ffffff 100%);}
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
    <h1 class="portal-title">🌐 UX2+3 — Gateway & Fiori</h1>
    <p class="portal-sub"><strong>목표</strong> SAP Gateway로 OData Service를 만들고, Fiori Launchpad에 등록하여 실제 업무용에 가까운 앱을 띄워보는 것.</p>
  </header>

  <section class="portal-grid">

    <div>

      <section class="portal-card">
        <h2>📚 학습 구성</h2>

        <h3>① OData Service</h3>
        <ul class="portal-list">
          <li>RFC / Function Module → OData 노출</li>
          <li>SEGW 프로젝트 생성, Entity / Association 정의</li>
          <li>GET_ENTITY / GET_ENTITYSET 구현</li>
        </ul>

        <h3>② Fiori 앱</h3>
        <ul class="portal-list">
          <li>템플릿 기반 List-Report / Object Page 앱</li>
          <li>Launchpad Designer를 통한 타일 등록</li>
          <li>롤/권한과 연계 (간단 개념만)</li>
        </ul>
      </section>

    </div>

    <aside>

      <section class="portal-card">
        <h2>✅ 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] 테스트용 OData Service 하나 완성</li>
          <li>[ ] 해당 Service를 사용하는 UI5 또는 Fiori 앱 구동</li>
          <li>[ ] Launchpad에서 타일 클릭 → 앱 실행까지 확인</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🔗 Project와 연계</h2>
        <p class="portal-small">
          최종 프로젝트에서 <strong>백엔드 ABAP + OData + Fiori</strong> 조합으로
          실제 업무 시나리오를 구현할 예정입니다. 여기서 실습한 구조가 뼈대가 됩니다.
        </p>
      </section>

    </aside>

  </section>

</div>


[↩ 홈으로](./)
