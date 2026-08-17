# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 17 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا مستقلاً. النتيجتان النهائيتان البارزتان هما `erdos678_unbounded_witnesses` و`erdos678_good_lengths_infinite`. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` مع adapter مباشر من `prime_between`.

### S1 scientific evaluation — COMPLETE

S1 أنجزت independent formal replication / executable differential verification مقابل formalization Aristotle/Alexeev. التجربة الأساسية run `32028006457` بنت graph كاملًا من **8808 jobs** وcompiled المصدر العام المثبت دون تعديل داخل بيئتنا Lean 4.33 / Mathlib / PNT+، مع selected axiom footprint `[propext, Classical.choice, Quot.sound]` على الجانبين.

PR #22 أغلقت artifact S1، وPR #27 أغلقت synchronization الحاكم؛ رأس `main` بعد S1 closure هو `7aff8d8d8680e90b34be64650c68c0fc778749fc` وقد اجتاز post-merge run `32045885504` مع `No update necessary` وبناء 8808 jobs.

### S2 — ACTIVE على #678 فقط

**S2a — dependency-surface baseline** نُفذت بنجاح في run `32047324807`, job `95438118197`, على exact experiment commit `4685fca552ae4a0270dfa3823d46fde48efa5ade`. الـworkflow تحقق من comparator commit/blob الثابتين وأنتج artifact evidence digest `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`.

الـbaseline البنيوية:

| Metric | Erdos_Solving | Public comparator |
|---|---:|---:|
| reachable local modules | 46 | 10 |
| local import edges | 58 | 10 |
| max local depth | 33 | 4 |
| external-frontier modules | 14 | 27 |
| artifact-owned modules | 46 | 1 |
| artifact-owned source lines | 5546 | 2546 |
| third-party repository-local support modules | 0 | 9 |

**النتيجة العلمية الصحيحة في S2a ليست أن أحد التطويرين أفضل.** النتيجة هي أن dependency-surface metrics حساسة جدًا لتعريف boundary: مشروعنا يستهلك PNT+ كـLake dependency خارجية، بينما comparator يحتوي تسع وحدات PNT+ reachable داخل شجرة repository نفسها. لذلك raw file/module count يخلط modularization مع packaging وthird-party ownership.

المنهج في `problems/678/S2_DEPENDENCY_SURFACE_PROTOCOL.md`، والنتيجة في `S2_DEPENDENCY_SURFACE_BASELINE.md/.json`، والأداة القابلة لإعادة التشغيل في `experiments/s2_dependency_surface.py`.

S2a لم تصبح checkpoint مدمجة بعد: يجب أن تمر branch/PR الحالية عبر canonical exact-head Lean Verification ثم post-merge verification. **S2b لا تبدأ قبل ذلك.**

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
