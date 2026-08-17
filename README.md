# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 17 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا مستقلاً ولا أول formalization. النتيجتان النهائيتان البارزتان هما `erdos678_unbounded_witnesses` و`erdos678_good_lengths_infinite`. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` مع adapter مباشر من `prime_between`.

### S1 — COMPLETE

S1 أنجزت executable differential verification مقابل formalization Aristotle/Alexeev. run `32028006457` بنت canonical graph من **8808 jobs** وcompiled المصدر العام المثبت دون تعديل داخل بيئتنا Lean 4.33 / Mathlib / PNT+، مع selected axiom footprint `[propext, Classical.choice, Quot.sound]` على الجانبين. S1 أُغلقت عبر PR #22 وPR #27 والتحقق بعد الدمج.

### S2 — ACTIVE على #678 فقط

**S2a — dependency surface: COMPLETE / CLOSED.** النتيجة الحاكمة: raw module/file metrics حساسة لتعريف dependency/ownership boundary، ولذلك لا يجوز تحويل raw module/file counts إلى حكم على proof complexity أو architecture quality.

**S2b — controlled build behavior: COMPLETE / CLOSED.** الجولة المعتمدة run `32053575928` نجحت في 6/6 paired replicates تحت نفس Lean/Mathlib/PNT+ والـrunner image. لا يوجد wall-clock winner ثابت: cold medians `159.575 s` داخليًا مقابل `156.280 s` للمقارن، والفروق الزوجية تتغير إشارتها بين `-10.68` و`+11.73 s`. لكن resource profile مختلف: median total CPU `241.155 s` مقابل `486.475 s`، وmax RSS `7,183,766` مقابل `7,828,930 KiB`. هذه execution-profile evidence وليست ادعاء تفوق عام. S2b أُغلقت بعد PR #30 وclosure PR #31.

**S2c — repair locality: COMPLETE / INTEGRATED / CLOSURE VERIFIED.**

قبل أي observation جُمّد البروتوكول والـmutation manifest في commit `a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1`. ثم نُفذت ثلاث matched declaration-rename mutations غير دلالية عند طبقات R1 analytic closure وR2 eventual construction وR3 strong endpoint في run `32062501296`, job `95486770197`, apparatus commit `00d340d3ccdc13418615b6526e9b736d9f9e03e7`.

كل الحالات الست artifact×mutation أحدثت الكسر المرجعي المتوقع ثم عادت إلى green بعد identifier-only repair، دون لمس أي third-party/dependency file. النتيجة كانت **مختلطة وتعتمد على طبقة الواجهة**: R1/R2 أوسع داخليًا من حيث static references، بينما R3 تنعكس عند production surface. لذلك لا تدعم S2c ادعاء repair-locality أو maintainability superiority لأي طرف.

PR #32 دمجت الدليل الموضوعي، ثم closure PR #33 أغلقت المزامنة رسميًا. final head للـclosure كان `3439b58f1e05e2cb21ee1c9374857eb3b4197163` واجتاز run `32070637072`, job `95512851767`. دُمجت closure كـ`47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`، وهذا الـcommit نفسه اجتاز post-merge run `32071325525`, job `95514986697`, مع `verified_commit` مطابق، `No update necessary`، وبناء **8808 jobs**.

**S2d — semantic/index mutation resistance: PREDECLARED / NOT EXECUTED.**

S2d تنطلق من الخطأ التاريخي الذي عامل `M(t,k+1)` كما لو كانت كتلته `[t,t+k]` بدل `[t+1,t+k+1]`. جُمّد تصميم ثلاث perturbations صغيرة، type-correct، ومتكافئة دلاليًا قدر الإمكان بين artifact الداخلي والمقارن:

1. `I1` — shift لبداية الكتلة القانونية خطوة إلى اليسار مع الحفاظ على الطول؛
2. `I2` — حذف الحد الأخير من الكتلة الأطول ذات `k+1` حدًا عند strong endpoint؛
3. `I3` — تشديد شرط الفصل من `n+k≤m` إلى `n+(k+1)≤m` كـsemantic-survival control يختبر الفرق بين proof checking وstatement fidelity.

البروتوكول والـmanifest هما:

- `problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`;
- `problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml`.

**لم يُنشأ harness ولم تُنفذ أي mutation.** لن يسمح البروتوكول بذلك إلا بعد أن تمر predeclaration الحالية عبر exact-head canonical CI، ثم الدمج، ثم post-merge verification على exact `main` commit. بعد ذلك فقط تبدأ الملاحظات الست المجمدة.

### Public artifact

المستودع **Public** ومرخص Apache-2.0. comparator يبقى external pinned fetch وغير vendored. يجب ضبط حماية `main` قبل قبول مساهمات خارجية.

## وثائق التشغيل الأساسية

- `PROJECT_STATE.md` — checkpoint التشغيل الحاكم؛
- `DECISIONS.md` — القرارات، ومنها `DEC-012`؛
- `RESEARCH_STATE_PROTOCOL.md` — بوابات المراحل؛
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md` — خارطة القيمة العلمية؛
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml` — سجل الأدلة؛
- `problems/678/S2_REPAIR_LOCALITY_PROTOCOL.md` و`S2_REPAIR_LOCALITY_MUTATIONS.yaml` — تعريف S2c؛
- `problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md` و`S2_SEMANTIC_INDEX_MUTATIONS.yaml` — تعريف S2d المجمد قبل التنفيذ.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، predeclared controls، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة وحدود الاستنتاج بدقة.
