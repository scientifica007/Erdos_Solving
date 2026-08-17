# Erdos_Solving

مستودع بحثي لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الهدف

يحفظ المشروع لكل benchmark، بحسب الحاجة:

- نص المسألة ومصدره وحالته الرياضية؛
- المحاولات والـcounterexamples والمسارات المرفوضة؛
- الأدبيات والمقارنة التاريخية؛
- formalization في Lean؛
- dependency وCI provenance؛
- state/roadmap/decision artifacts؛
- lessons learned والمواد القابلة للتحويل إلى مساهمة علمية.

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

Stage S1 نفذت بالفعل تجربة differential verification ناجحة:

- run `32028006457`, job `95381414710`؛
- exact push-triggered experiment head `b1e3fc60f6dc4f125a125121a2abbcf3610ed749`؛
- canonical graph: `No update necessary`, **8808 jobs**؛
- public comparator pinned at `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`؛
- المصدر العام `Erdos678.lean` جرى compile له **دون تعديل** داخل بيئتنا Lean 4.33 / Mathlib / PNT+؛
- selected endpoints في التطويرين أعطت نفس axiom footprint: `propext`, `Classical.choice`, `Quot.sound`؛
- لدينا Lean bridge إلى `Finset.Ioc` semantics، وإلى صيغة Formal Conjectures eventual-nonempty، وإلى عامل حقيقي عام `C ≥ 1`.

هذا يبرر وصف العمل بأنه **independent formal replication / differential verification**، لا بأنه حل جديد أو أول formalization.

### CI provenance correction and current blocker

مراجعة لاحقة كشفت أن الـPR workflow التاريخي كان يستخدم default `actions/checkout`؛ لذلك run metadata التي تعرض PR `head_sha` لا تكفي وحدها لإثبات أن الـjob بنى الرأس الحرفي. في run `32033822601` بُني synthetic integration-tree commit `5983f901...` رغم أن metadata أشارت إلى PR head `610d525...`.

تم توثيق التصحيح في `problems/678/CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`، وتم تعديل الـworkflow النشط ليcheckout رأس PR صراحةً ويسجل `git rev-parse HEAD`.

حاليًا لا تستطيع GitHub Actions بدء jobs جديدة بسبب account billing/spending-limit condition. المحاولتان `32036454657` و`32036454660` توقفتا **قبل أي خطوة Lean**؛ لذلك التصنيف هو **CI infrastructure blocker** وليس proof failure.

لا يبدأ S2 ولا يُدمج S1 persistent artifact حتى تعود Actions ويجتاز الرأس النهائي البوابة المصححة ثم ينجح تحقق `main` بعد الدمج.

## المساران العلميان لـ#678

1. **Formal verification / proof engineering:** مقارنة التطوير modular/regression-heavy والـ`prime_between` boundary مع formalization Aristotle/Alexeev، ثم قياس dependency graphs، mutation resistance، repair locality، upgrade robustness، وbuild behavior قبل أي claim عن التفوق.
2. **AI-assisted scientific production:** دراسة السجل القابل للتدقيق من false generalization إلى formal rejection ثم reference-proof reconstruction، مع failure memory، state externalization، dependency closure، interface repair، attribution control، وverification-credit correction.

المواد الحاكمة موجودة في `problems/678/`, خصوصًا:

- `SCIENTIFIC_COMPARATIVE_STUDY.md`
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md`
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md`
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md`
- `S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`
- `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`

## ترتيب الاستئناف

1. تحقق من رأس `main` ومن PR S1 النشط.
2. اقرأ `PROJECT_STATE.md`.
3. تعامل مع #678 mathematics على أنها frozen/archived.
4. إذا استمر blocker المالي في GitHub Actions، لا تضعف gate ولا تصفه بفشل Lean.
5. أغلق S1 integration أولًا؛ لا تبدأ S2 قبل ذلك.
6. **لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

## المبدأ الحاكم

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، الاختبار، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة بدقة.
