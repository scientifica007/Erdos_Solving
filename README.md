# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي، مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## منهج العمل القياسي

أصبحت الدروس الدائمة المستخلصة من تجربة Erdős #678 منهجًا عامًا للمشروع في `ERDOS_PROBLEM_SOLVING_PROTOCOL.md` **v1** وفق `DEC-013`.

البروتوكول ينظم دورة العمل عبر بوابات `G0`–`G10`: إذن التفعيل ومزامنة الحالة، تدقيق النص canonical والحالة الخارجية، فصل أنماط البحث، falsification-first testing، تثبيت بنية البرهان، provenance، formalization، exact-head machine verification، حوكمة التجارب العلمية عند الحاجة، الدمج، ثم الإغلاق والـpostmortem.

هذا التثبيت **لا يفتح مسألة جديدة تلقائيًا** ولا يغيّر بوابة `DEC-012`.

## الحالة الحالية — 20 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا ولا أول formalization. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### Scientific evaluation — S1 / S2 COMPLETE

- **S1:** differential verification executable مقابل Aristotle/Alexeev؛ مغلقة ومتحقق منها آليًا.
- **S2a:** dependency-surface metrics حساسة لحدود ownership؛ لا ranking معماري من raw counts.
- **S2b:** لا stable wall-clock winner في الجولة المعتمدة، مع اختلاف CPU/memory profile؛ pilot خضراء استُبعدت بسبب provenance ناقصة.
- **S2c:** repair-locality mixed/interface-dependent؛ لا uniform maintainability winner.
- **S2d:** 6/6 semantic rejections في مجموعة perturbations المجمدة، مع 0 survivors و0 proof repairs و0 dependency-source touches؛ closure-verified.
- **S2e:** **CLOSED / CLOSURE VERIFIED** بعد تجربة upgrade robustness المجمدة.

### S2e — ماذا وجدنا؟

اختبرنا مرشحين محددين ومجمّدين مسبقًا للترقية:

1. **U1 compiler-only:** Lean `v4.34.0-rc1` مع Mathlib/PNT والـmanifest الحالية ثابتة.
2. **U2 root Lean+Mathlib RC:** Lean `v4.34.0-rc1` + Mathlib exact `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` مع PNT+ ثابتة عند `2667e414...`.

الجولة المعتمدة هي `32170243744`: U1 job `95819384522`، U2 job `95819384599`، والـaggregate job `95822552072` نجحت جميعًا. الـcomplete artifact هي `9337321640`، SHA-256:

`90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`

أُعيد تنزيلها والتحقق من digest بصورة مستقلة؛ `COMBINE_AUDIT` وownership/provenance validations كلها PASS، بلا apparatus failures وبلا repair outputs.

النتيجة المحدودة:

- **U1:** D0 وD1 green، ثم تظهر failures داخل Mathlib/transitive dependencies؛ deepest green = `D1`، primary owner = `mathlib_or_transitive_dependency`. لم نصل إلى project-owned proof failure.
- **U2:** D0 green، ثم D1 package resolution تفشل قبل project compilation؛ deepest green = `D0`، primary owner = `package_resolution`.
- **Repair:** لم تدخل مرحلة project repair لأن أيًا من المرشحين لم يصل إلى failure project-owned مؤهلة وفق البروتوكول.

هذه النتيجة تصف **version/dependency boundary لهذين المرشحين فقط**. لا تعني general Lean/Mathlib incompatibility، ولا general maintainability، ولا expected future upgrade cost، ولا proof-quality defect في dependencies، ولا architecture superiority.

الأدلة الدائمة:

- `problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_RESULT.md`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_RESULT.json`؛
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`.

Evidence PR #55 merged as `a0dffadfbba22325103170a8222d8adb10ffe6e9` and passed exact-main verification `32175057976` / `95834940169`. Closure PR #57 merged as `872be99ac79e3d905dd6d696e626d424331a1faa`; that exact `main` commit passed canonical run `32177665772` / job `95843195690` with `No update necessary` and **8808 jobs**.

## بوابة الانتقال

**S2 مكتملة. بروتوكول العمل العام v1 مثبت، لكن لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، predeclared controls، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة وحدود الاستنتاج بدقة.
