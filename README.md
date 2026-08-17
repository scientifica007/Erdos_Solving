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

**S2a — dependency surface: COMPLETE / CLOSED.** النتيجة الحاكمة: raw module/file metrics حساسة لتعريف dependency/ownership boundary، ولذلك لا يجوز تحويل `46 modules vs 1 artifact module` إلى حكم على proof complexity أو architecture quality.

**S2b — controlled build behavior: COMPLETE / CLOSED.** الجولة المعتمدة run `32053575928` نجحت في 6/6 paired replicates تحت نفس Lean/Mathlib/PNT+ والـrunner image. لا يوجد wall-clock winner ثابت: cold medians `159.575 s` داخليًا مقابل `156.280 s` للمقارن، والفروق الزوجية تتغير إشارتها بين `-10.68` و`+11.73 s`. لكن resource profile مختلف: median total CPU `241.155 s` مقابل `486.475 s`، وmax RSS `7,183,766` مقابل `7,828,930 KiB`. هذه execution-profile evidence وليست ادعاء تفوق عام. PR #30 والـclosure PR #31 اجتازتا exact-head/post-merge verification؛ آخر closure merge هو `cc55073fceddb51e3fa2c1854f797fe989523985` وrun `32060186755` نجحت بـ`No update necessary` و8808 jobs.

**S2c — repair locality: EXECUTED / ARTIFACT VALIDATED / PENDING PR INTEGRATION.**

قبل أي observation جُمّد البروتوكول والـmutation manifest في commit `a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1`. ثم نُفذت ثلاث matched declaration-rename mutations غير دلالية عند طبقات R1 analytic closure وR2 eventual construction وR3 strong endpoint في run `32062501296`, job `95486770197`, apparatus commit `00d340d3ccdc13418615b6526e9b736d9f9e03e7`.

كل الحالات الست artifact×mutation:

- أحدثت compile break متوقعًا؛
- أُصلحت فقط بتبديل downstream identifier references؛
- عادت إلى green؛
- لم تلمس أي third-party/dependency file؛
- وفي الحالات الداخلية الثلاث عاد `mk_all` إلى `No update necessary` والبناء الكامل إلى **8808 jobs**.

| matched layer | internal repaired refs | comparator repaired refs |
|---|---:|---:|
| R1 analytic closure | 3 = 2 production + 1 verification | 1 production |
| R2 eventual construction | 2 = 1 production + 1 verification | 1 production |
| R3 strong endpoint | 2 verification, **0 production** | 3 production |

النتيجة **مختلطة وتعتمد على طبقة الواجهة**: R1/R2 أوسع داخليًا من حيث static references، بينما R3 تنعكس عند production surface. لذلك لا تدعم S2c ادعاء أن أحد التصميمين يمتلك repair locality أفضل بصورة عامة. كما أن مجموع references الخام (`7` داخليًا مقابل `5`) ليس maintainability metric؛ الاختبارات لدينا تضيف API coupling متعمدًا، والمقارن يجمع معظم البرهان في ملف واحد.

الـartifact ID `9299556049`، وSHA-256 المبلغ من GitHub والمعاد حسابه بعد التنزيل هو نفسه: `0369ec66c689572307660765b0c84cd86b6339f4f4d26a788c560ca11f7b7f4b`. التفاصيل في `problems/678/S2_REPAIR_LOCALITY_BASELINE.md/.json`.

**S2d — semantic/index mutation resistance: NOT STARTED.** لن تبدأ قبل دمج S2c والتحقق من `main`.

### Public artifact

المستودع **Public** ومرخص Apache-2.0. comparator يبقى external pinned fetch وغير vendored. يجب ضبط حماية `main` قبل قبول مساهمات خارجية.

## وثائق التشغيل الأساسية

- `PROJECT_STATE.md` — checkpoint التشغيل الحاكم؛
- `DECISIONS.md` — القرارات، ومنها `DEC-012`؛
- `RESEARCH_STATE_PROTOCOL.md` — بوابات المراحل؛
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md` — خارطة القيمة العلمية؛
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml` — سجل الأدلة؛
- `problems/678/S2_REPAIR_LOCALITY_PROTOCOL.md` و`S2_REPAIR_LOCALITY_MUTATIONS.yaml` — تعريف S2c المجمد قبل التنفيذ.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، predeclared controls، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة وحدود الاستنتاج بدقة.
