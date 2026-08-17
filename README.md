# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الهدف

يحفظ المشروع لكل benchmark، بحسب الحاجة:

- نص المسألة ومصدره وحالته الرياضية؛
- المحاولات والـcounterexamples والمسارات المرفوضة؛
- الأدبيات والمقارنة التاريخية؛
- formalization في Lean؛
- dependency وCI provenance؛
- state/roadmap/decision artifacts؛
- lessons learned والمواد القابلة للتحويل إلى مساهمة علمية.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`. حدود الطرف الثالث والنَّسب العلمي موثقة بصورة مستقلة في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## وثائق التشغيل الأساسية

- `PROJECT_STATE.md` — نقطة الاستئناف الحالية والمرجع التشغيلي الحاكم.
- `DECISIONS.md` — سجل القرارات، بما فيها `DEC-012`.
- `RESEARCH_STATE_PROTOCOL.md` — بروتوكول المراحل والبوابات.
- `PROJECT_CONTEXT.md`
- `CONSTITUTION.md`
- `ARCHITECTURE.md`
- `WORKFLOW.md`
- `RESEARCH_RECORD_SCHEMA.md`
- `AI_AGENT_GUIDE.md`
- `docs/STATUS_MODEL.md`
- `docs/RESEARCH_PROTOCOL.md`
- `problems/README.md`

## الحالة التشغيلية الحالية — 17 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا مستقلاً. المحاولة المستقلة السابقة في المستودع مرفوضة ومحفوظة في سجل الفشل/regressions.

أهم نقاط التحقق:

- final synchronized E4 head: `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`, run `31977861568` — **SUCCESS**, 8806 jobs؛
- mathematical merge: `8fd1b20541ac7782f52429db3a2cc4c887547372`؛
- post-merge run `32011189766` — **SUCCESS**, `No update necessary`, 8806 jobs؛
- scientific-dossier baseline on `main`: `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`, post-merge run `32026434043` — **SUCCESS**.

النتيجتان النهائيتان البارزتان هما:

- `erdos678_unbounded_witnesses` — شاهد قانوني فوق أي lower bound على `k`؛
- `erdos678_good_lengths_infinite` — مجموعة أطوال الكتل الصالحة لا نهائية.

المدخل التحليلي يعتمد على `AxiomMath/PrimeNumberTheoremAnd` المثبت عند revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`، مع adapter مباشر من theorem `prime_between` إلى الواجهة المطلوبة في Claim 4.

### Scientific evaluation of archived #678

المستخدم فوّض الاستفادة القصوى من #678 كمادة علمية وكحالة دراسة لإنتاج المادة العلمية بالذكاء الاصطناعي. هذا لا يعيد فتح الرياضيات ولا يسمح بالانتقال إلى benchmark آخر.

Stage S1 نفذت تجربة differential verification ناجحة:

- run `32028006457`, job `95381414710`؛
- exact push-triggered experiment head `b1e3fc60f6dc4f125a125121a2abbcf3610ed749`؛
- canonical graph: `No update necessary`, **8808 jobs**؛
- public comparator pinned at `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`؛
- المصدر العام `Erdos678.lean` جرى compile له **دون تعديل** داخل بيئتنا Lean 4.33 / Mathlib / PNT+؛
- selected endpoints في التطويرين أعطت نفس axiom footprint: `propext`, `Classical.choice`, `Quot.sound`؛
- لدينا Lean bridge إلى `Finset.Ioc` semantics، وإلى صيغة Formal Conjectures eventual-nonempty، وإلى unbounded/infinite good-length semantics، وإلى عامل حقيقي عام `C ≥ 1`.

هذا يبرر وصف العمل بأنه **independent formal replication / differential verification**، لا بأنه حل جديد أو أول formalization.

### Public transition and CI provenance

المستودع أصبح الآن **Public**. GitHub API أكد `visibility: public` وتعرّف على الرخصة كـ`Apache-2.0`. ملف `LICENSE` موجود على `main`، والـLean Verification workflow ما زال active.

قبل الانتقال أُنجز public-release preflight شمل secret hygiene، `.gitignore` وقائي، `THIRD_PARTY_NOTICES.md`، وصقل workflow بحيث:

- يcheckout رأس PR الحرفي؛
- يسجل `git rev-parse HEAD`؛
- يستخدم `contents: read` فقط؛
- يعطل `persist-credentials`؛
- يثبت Actions الخارجية عند commit SHAs.

التحويل إلى Public أزال الحظر العملي الذي كان يمنع GitHub-hosted Actions أثناء كون المستودع Private. بعد إعادة فتح PR #22 بدأ run `32043331012` فعليًا ووصل إلى canonical Lean build، بخلاف التشغيلات السابقة التي توقفت قبل أي خطوة Lean بسبب billing/spending condition.

هذا التشغيل تشخيص لعودة الـrunner؛ بعد مزامنة وثائق الحالة سيُطلب run جديد على **الرأس النهائي الفعلي لـPR #22** قبل الدمج.

لا توجد repository rulesets مكتشفة في checkpoint ما بعد التحويل، لذا ينبغي إعداد حماية `main` من واجهة GitHub قبل قبول مساهمات خارجية.

## المساران العلميان لـ#678

1. **Formal verification / proof engineering:** مقارنة التطوير modular/regression-heavy والـ`prime_between` boundary مع formalization Aristotle/Alexeev، ثم قياس dependency graphs، mutation resistance، repair locality، upgrade robustness، وbuild behavior قبل أي claim عن التفوق.
2. **AI-assisted scientific production:** دراسة السجل القابل للتدقيق من false generalization إلى formal rejection ثم reference-proof reconstruction، مع failure memory، state externalization، dependency closure، interface repair، attribution control، verification-credit correction، وpublic-release controls.

المواد الحاكمة موجودة في `problems/678/`, خصوصًا:

- `SCIENTIFIC_COMPARATIVE_STUDY.md`
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md`
- `AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md`
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md`
- `S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`
- `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`
- `PUBLICATION_READINESS_LICENSE_AUDIT.md`
- `PUBLIC_RELEASE_AUDIT_2026-08-17.md`

وفي الجذر:

- `LICENSE`
- `THIRD_PARTY_NOTICES.md`

## ترتيب الاستئناف

1. تحقق من رأس `main` ومن PR S1 النشط.
2. اقرأ `PROJECT_STATE.md`.
3. تعامل مع #678 mathematics على أنها frozen/archived.
4. شغّل exact-head canonical CI على الرأس النهائي لـPR #22.
5. ادمج فقط إذا نجح CI، ثم تحقق من `main` وأغلق S1؛ لا تبدأ S2 قبل ذلك.
6. اضبط حماية `main`/ruleset من واجهة GitHub للمستودع العام.
7. **لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

## المبدأ الحاكم

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، الاختبار، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة بدقة.
