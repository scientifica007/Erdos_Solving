# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 17 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا مستقلاً. المحاولة المستقلة السابقة مرفوضة ومحفوظة ضمن سجل الفشل/regressions.

النتيجتان النهائيتان البارزتان هما `erdos678_unbounded_witnesses` و`erdos678_good_lengths_infinite`. المدخل التحليلي يعتمد على `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` مع adapter مباشر من `prime_between`.

### S1 scientific evaluation — COMPLETE

S1 أنجزت independent formal replication / executable differential verification مقابل formalization Aristotle/Alexeev المثبت عند `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`.

التجربة الأساسية run `32028006457` بنت graph كاملًا من **8808 jobs** وcompiled المصدر العام المثبت دون تعديل داخل بيئتنا Lean 4.33 / Mathlib / PNT+، مع تطابق selected axiom footprint إلى `propext`, `Classical.choice`, `Quot.sound`.

PR #22 اجتازت exact-head gate في run `32043807200` ثم دُمجت، والتحقق بعد الدمج نجح في run `32044314748` attempt 2. PR #27 أغلقت التوثيق الحاكم، ودُمجت كـ`7aff8d8d8680e90b34be64650c68c0fc778749fc` ثم اجتازت post-merge run `32045885504` مع `No update necessary` وبناء 8808 jobs.

### S2 — ACTIVE على #678 فقط

بدأت الآن **S2a — dependency-surface baseline**. الهدف هو قياس بنية modules/imports بصورة قابلة لإعادة الإنتاج قبل أي ادعاء عن أفضلية architecture.

البروتوكول في `problems/678/S2_DEPENDENCY_SURFACE_PROTOCOL.md`، والأداة في `problems/678/experiments/s2_dependency_surface.py`.

S2a تفصل صراحةً بين:

- modules المملوكة للـartifact؛
- support modules المحلية؛
- third-party modules الموجودة ماديًا في مستودع المقارن؛
- external import frontier.

هذا مهم لأن PNT+ dependency خارجية عبر Lake لدينا، بينما comparator يحتوي شجرة `PrimeNumberTheoremAnd` داخل repository نفسه. لذلك raw file count غير صالح كمقياس مباشر للتعقيد.

أول profile يقارن `Formalization.Erdos678.Erdos678Final` مع `ErdosProblems.Erdos678` عند نفس comparator pin المستخدم في S1. لا نستنتج من هذه المرحلة وحدها “أبسط/أفضل/أسرع/أكثر متانة”.

### Public artifact

المستودع **Public** ومرخص Apache-2.0. الـworkflow يستخدم read-only token، لا يحتفظ ببيانات checkout الاعتمادية، ويسجل commit المبني فعليًا.

لم تكن هناك repository rulesets عند فحص الانتقال إلى Public. يجب ضبط حماية `main` من واجهة GitHub قبل قبول مساهمات خارجية، بحيث يبقى المسار الطبيعي PR + required Lean Verification ومنع force-push/deletion.

## وثائق التشغيل الأساسية

- `PROJECT_STATE.md` — checkpoint التشغيل الحاكم؛
- `DECISIONS.md` — القرارات، ومنها `DEC-012`؛
- `RESEARCH_STATE_PROTOCOL.md` — بوابات المراحل؛
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md` — خارطة القيمة العلمية الحالية؛
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml` — سجل الأدلة.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، الاختبار، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة بدقة.
