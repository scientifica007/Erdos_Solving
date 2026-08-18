# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 17 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا ولا أول formalization. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` مع adapter مباشر من `prime_between`.

### S1 — COMPLETE

أُنجز executable differential verification مقابل formalization Aristotle/Alexeev، ثم أُغلقت S1 عبر exact-head/post-merge verification.

### S2 — ACTIVE على #678 فقط

**S2a — dependency surface: CLOSED.** raw module/file metrics حساسة لتعريف dependency/ownership boundary؛ لذلك لا يجوز تحويلها إلى حكم على proof complexity أو architecture quality.

**S2b — controlled build behavior: CLOSED.** الجولة المعتمدة run `32053575928` لم تجد wall-clock winner ثابتًا، مع اختلاف مادي في CPU/memory profile تحت البيئة المثبتة. pilot خضراء استُبعدت كليًا لأن provenance المحددة مسبقًا كانت ناقصة.

**S2c — repair locality: CLOSED / CLOSURE VERIFIED.** ثلاث declaration-rename mutations مجمدة مسبقًا أعطت نتيجة mixed/interface-dependent؛ لا يوجد uniform repair-locality أو maintainability winner. أُغلقت S2c نهائيًا عبر closure PR #33 والـpost-merge run `32071325525` على commit `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4` مع `No update necessary` و8808 jobs.

**S2d — semantic/index mutation resistance: EXECUTED / ARTIFACT VALIDATED / PENDING PR INTEGRATION.**

S2d انطلقت من الخطأ التاريخي الذي عامل `M(t,k+1)` كما لو كانت كتلته `[t,t+k]` بدل `[t+1,t+k+1]`. البروتوكول والـmanifest جُمّدا قبل بناء apparatus وقبل أي observation، ثم دُمجا وتحققا بعد الدمج عبر PR #34.

مجموعة perturbations المجمدة:

1. `I1` — shift لبداية الكتلة القانونية خطوة إلى اليسار مع الحفاظ على الطول؛
2. `I2` — حذف الحد الأخير من الكتلة الأطول ذات `k+1` حدًا عند strong endpoint؛
3. `I3` — تشديد شرط الفصل من `n+k≤m` إلى `n+(k+1)≤m` كـsemantic-survival control.

أول run، `32074822049`، نجحت حسابيًا لكنها **مستبعدة بالكامل** لأن post-run audit كشف خطأ instrumentation في تصنيف `main_theorem` بالمقارن. لم تتغير mutations أو البروتوكول؛ صُحح classifier فقط وأُعيدت الحالات الست كلها من pristine baselines.

الجولة المعتمدة هي PR-event exact-head run `32076614547`, job `95531085803`, على commit `a82ae53b57a9f97844013a9b2e96a9182cee241d`. artifact `9303987121` لها SHA-256:

`29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881`

وقد طابق التنزيل المستقل نفس digest حرفيًا.

النتيجة المعتمدة:

| mutation | internal first rejection | comparator first rejection |
|---|---|---|
| I1 start shift | `L1` concrete numerical oracle بعد نجاح source elaboration | `lcmInterval_ge_choose` local invariant |
| I2 drop final term | `L0` source type mismatch | `main_theorem` strong theorem |
| I3 strengthen separation | `L0` source application type mismatch | `erdos_678_kmn_infinite` canonical corollary |

**6/6 semantic mutations رُفضت، 0 survivors، 0 proof repairs، 0 dependency-source touches.** الاستنتاج الصحيح محدود: الضوابط المشفرة كشفت perturbations الثلاثة كلها، لكن موقع أول رفض اعتمد على mutation وبنية artifact. لا يجوز تحويل ذلك إلى general semantic-robustness أو architecture-superiority ranking.

التفاصيل في:

- `problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`؛
- `problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml`؛
- `problems/678/S2_SEMANTIC_INDEX_BASELINE.md/.json`.

PR #35 تحمل apparatus والدليل الحالي. يجب أن يمر **رأسها النهائي بعد مزامنة النتائج** بـcanonical Lean Verification قبل الدمج، ثم يُتحقق من exact merge commit على `main`. لا تبدأ S2e قبل إغلاق S2d توثيقيًا بعد ذلك.

### Public artifact

المستودع **Public** ومرخص Apache-2.0. comparator يبقى external pinned fetch وغير vendored.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، predeclared controls، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة وحدود الاستنتاج بدقة.
