# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 18 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا ولا أول formalization. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### S1 / S2a / S2b / S2c — CLOSED

- **S1:** executable differential verification مقابل Aristotle/Alexeev؛ closed and machine-verified.
- **S2a:** dependency-surface metrics boundary-sensitive؛ لا ranking معماري من raw counts.
- **S2b:** لا stable wall-clock winner في الجولة المعتمدة، مع اختلاف CPU/memory profile؛ pilot خضراء استُبعدت بسبب provenance ناقصة.
- **S2c:** repair-locality mixed/interface-dependent؛ لا uniform maintainability winner.

### S2d — CLOSED / CLOSURE VERIFIED

S2d اختبرت ثلاث perturbations دلالية/فهرسية صغيرة جُمّدت قبل التنفيذ. أول run `32074822049` استُبعدت بالكامل بسبب خطأ instrumentation في تصنيف `main_theorem`; لم تتغير mutations أو البروتوكول، وصُحح classifier فقط ثم أُعيدت الحالات الست كاملة.

الجولة المعتمدة `32076614547` / `95531085803` على apparatus head `a82ae53b57a9f97844013a9b2e96a9182cee241d` أعطت:

- **6/6 semantic rejections**؛
- **0 survivors**؛
- **0 proof repairs**؛
- **0 dependency-source touches**؛
- artifact `9303987121`، SHA-256 `29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881` مع independent digest match.

I1 الداخلية مهمة منهجيًا: تعريف `erdosM` المتحوّر بقي type-correct، لكن independent concrete numerical oracle رفض الانزياح الدلالي. لا يُستنتج من ذلك general semantic-robustness أو architecture superiority.

PR #35 دمجت الدليل ونجحت exact-head/post-merge verification. ثم closure PR #36 final head `46b52c2c8ed1c4dd0623974c82c367071618f71b` نجحت في run `32103456742`, job `95608318715`، ودُمجت كـ`5039d464f6196e6b47494f0a6fae869e3362d082`. هذا exact `main` commit اجتاز run `32103947182`, job `95609642835` مع `verified_commit` مطابق، `No update necessary`، و**8808 jobs**. بذلك S2d **closure-verified**.

### S2e — upgrade robustness: PREDECLARED / NOT EXECUTED

S2e تقيس compatibility مع ترقية محددة وبسطح إصلاح project-owned محدود، وليس “maintainability” عامة ولا مقارنة جديدة مع comparator.

الباسلاين المجمد هو S2d closure merge `5039d464f6196e6b47494f0a6fae869e3362d082`:

- Lean `v4.33.0`؛
- Mathlib input `v4.33.0`, resolved `db584cd6d46c92f209a44c0f1c829460d327499d`؛
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

الـcandidateان المجمدان:

1. **U1 compiler-only:** Lean `v4.34.0-rc1` مع Mathlib/PNT والـmanifest الحالية ثابتة، ولا `lake update`.
2. **U2 root Lean+Mathlib RC:** Lean `v4.34.0-rc1` + Mathlib exact `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` (tag provenance `v4.34.0-rc1`) مع PNT+ ثابتة عند `2667e414...`.

عند لحظة predeclaration، PNT+ `main` نفسها تساوي `2667e414...`؛ لذلك لا توجد newer coordinated provider revision يمكن تبديلها تلقائيًا. إذا توقفت الترقية عند dependency support فهذه نتيجة supply-chain/version-boundary، وليست proof-quality defect، ولا يسمح S2e بترقيع third-party source.

قبل أي repair ستُنفذ detection pass كاملة: environment identity، package resolution، ثلاث Mathlib-only project sentinels، PNT boundary، project PNT boundary، endpoint النهائي، ثم canonical graph. الإصلاح project-owned فقط وبميزانية ثابتة: **12 batches / 10 files / 250 changed lines**، مع theorem-header fingerprints وregression files غير قابلة للتغيير.

التصميم المجمد في:

- `problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`.

**لم يُنشأ harness ولم تُنفذ U1 أو U2.** يجب أولًا دمج predeclaration والتحقق من exact `main` commit الناتج؛ بعدها فقط يسمح بإنشاء apparatus وتنفيذ المرشحين.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، predeclared controls، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة وحدود الاستنتاج بدقة.
