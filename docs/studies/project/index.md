---
title: Project — 통합 실무 프로젝트
---

<style>
:root{
  --portal-bg:#fffaf2;--portal-card-bg:#ffffff;--portal-border:#ffe2b8;
  --portal-shadow:0 12px 30px rgba(255,181,92,0.22);
  --text-main:#222431;--text-sub:#5f6472;--text-muted:#9a9fb0;
  --link:#d35400;--link-hover:#a84300;
}
body{background:radial-gradient(circle at top left,#ffe6bf 0,#fffaf2 45%,#ffffff 100%);}
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
    <h1 class="portal-title">🚀 Project — 통합 실무 프로젝트</h1>
    <p class="portal-sub"><strong>목표</strong> ABAP 백엔드와 UI5/Fiori 프론트엔드를 모두 활용해,
      실제 업무 시나리오를 풀어낼 수 있는 통합 애플리케이션 구축.</p>
  </header>

  <section class="portal-grid">

    <div>

      <section class="portal-card">
        <h2>📚 프로젝트 개요</h2>
        <ul class="portal-list">
          <li>주제: 항공 예약 / 재고 / 주문 / 기타 도메인 중 택1 (예시)</li>
          <li>백엔드: ABAP · Open SQL · CDS (필요 시)</li>
          <li>프론트엔드: SAP UI5 또는 Fiori 요소</li>
          <li>연동: OData Service (Gateway)</li>
        </ul>

        <h3>주요 산출물</h3>
        <ul class="portal-list">
          <li>기능 정의서 / 화면 설계서</li>
          <li>테이블 설계 (DDIC 오브젝트)</li>
          <li>ABAP 구현 코드 (Report, Module Pool, Class 등)</li>
          <li>UI5/Fiori 화면, 라우팅 구조</li>
          <li>테스트 시나리오 및 결과</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>📌 역할 분담 (예시)</h2>
        <ul class="portal-list">
          <li>Backend 담당: 테이블 설계, 비즈니스 로직, OData 구현</li>
          <li>Frontend 담당: 화면 UX 설계, UI5 앱 구현</li>
          <li>테스트/문서 담당: 테스트케이스, 발표 자료 정리</li>
        </ul>
      </section>

    </div>

    <aside>

      <section class="portal-card">
        <h2>✅ 진행 체크리스트</h2>
        <ul class="portal-checklist">
          <li>[ ] 요구사항 정의 및 범위 확정</li>
          <li>[ ] 테이블/구조 설계 및 생성</li>
          <li>[ ] 핵심 비즈니스 로직(ABAP) 개발</li>
          <li>[ ] OData Service 구현 및 테스트</li>
          <li>[ ] UI5/Fiori 화면 구현</li>
          <li>[ ] 통합 테스트 및 버그 수정</li>
          <li>[ ] 발표 자료 / 포트폴리오 정리</li>
        </ul>
      </section>

      <section class="portal-card">
        <h2>🔗 참고</h2>
        <p class="portal-small">
          이 페이지에는 실제 프로젝트 결과 링크(스크린샷, 데모 URL, GitHub 소스 링크)를
          추후 추가해 두면 포트폴리오로 활용하기 좋습니다.
        </p>
      </section>

    </aside>

  </section>

</div>


[↩ 홈으로](./)
