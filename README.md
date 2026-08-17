# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 17 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا مستقلاً. النتيجتان النهائيتان البارزتان هما `erdos678_unbounded_witnesses` و`erdos678_good_lengths_infinite`. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` مع adapter مباشر من `prime_between`.

### S1 scientific evaluation — COMPLETE

S1 أنجزت independent formal replication / executable differential verification مقابل formalization Aristotle/Alexeev. التجربة الأساسية run `32028006457` بنت graph كاملًا من **8808 jobs** وcompiled المصدر العام المثبت دون تعديل داخل بيئتنا Lean 4.33 / Mathlib / PNT+، مع selected axiom footprint `[propext, Classical.choice, Quot.sound]` على الجانبين. S1 أُغلقت رسميًا عبر PR #22 وPR #27 والتحقق بعد الدمج.

### S2 — ACTIVE على #678 فقط

**S2a — dependency surface: COMPLETE / VERIFIED / CLOSED.** النتيجة الحاكمة هي أن raw module/file metrics حساسة لتعريف dependency/ownership boundary؛ لذلك لا يجوز تحويل `46 modules vs 1 artifact module` إلى حكم على proof complexity أو architecture quality.

**S2b — controlled build behavior: EXECUTED / VALIDATED / PENDING PR INTEGRATION.** البروتوكول في `problems/678/S2_BUILD_BEHAVIOR_PROTOCOL.md`، والأداة في `problems/678/experiments/s2_build_behavior.py`، والـbaseline في `S2_BUILD_BEHAVIOR_BASELINE.md/.json`.

الجولة التجريبية الأولى run `32052134207` استُبعدت **كاملة** رغم نجاح 6/6 jobs لأن `runner_version` لم يكن مسجلًا في result evidence، وهو شرط provenance محدد مسبقًا. بعد إصلاح apparatus لتفشل مغلقة عند غياب الهوية، run `32053575928` على exact apparatus commit `c2ef703c954e462096162a3b4a59a5e0f8d48488` نجحت في **6/6 replicates، بلا retries أو exclusions**. كل النتائج تحمل runner `2.336.0`, image `ubuntu24/20260810.271.1`, Lean 4.33.0، ونفس Mathlib/PNT+/comparator pins.

النتيجة المقارنة الأساسية:

| cold metric | Erdos_Solving | public comparator |
|---|---:|---:|
| wall-time median | 159.575 s | 156.280 s |
| user CPU median | 176.105 s | 480.580 s |
| system CPU median | 64.840 s | 5.990 s |
| total CPU median | 241.155 s | 486.475 s |
| max RSS median | 7,183,766 KiB | 7,828,930 KiB |
| Lake `Built` lines | 46 | 1 |

**لا يوجد wall-clock winner ثابت**: الفروق الزوجية `internal − comparator` تتغير إشارتها وتمتد من `-10.68` إلى `+11.73 s`. لكن resource profile مختلف بصورة متسقة: comparator يستخدم user CPU أعلى كثيرًا وRSS أعلى قليلًا، بينما التطوير المعياري الداخلي يستخدم system CPU أعلى كثيرًا. هذا دليل وصفي على اختلاف execution profile تحت بيئة واحدة مثبتة، وليس ادعاء تفوق عام.

Warm rebuild medians (`4.42 s` مقابل `4.34 s`) هي no-change incremental checks وليست compilation-speed measurements.

**S2c — repair locality: NOT STARTED.** لن تبدأ قبل أن يمر S2b عبر PR exact-head CI ثم merge ثم post-merge verification على `main`.

### Public artifact

المستودع **Public** ومرخص Apache-2.0. لم تكن هناك repository rulesets عند فحص الانتقال إلى Public؛ يجب ضبط حماية `main` قبل قبول مساهمات خارجية.

## وثائق التشغيل الأساسية

- `PROJECT_STATE.md` — checkpoint التشغيل الحاكم؛
- `DECISIONS.md` — القرارات، ومنها `DEC-012`؛
- `RESEARCH_STATE_PROTOCOL.md` — بوابات المراحل؛
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md` — خارطة القيمة العلمية؛
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml` — سجل الأدلة.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، الاختبار، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة بدقة.
