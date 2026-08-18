# Erdos_Solving

مستودع بحثي عام لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي، مع إعطاء الأولوية لصحة المعرفة، وقابلية التدقيق، وإعادة الإنتاج، والفصل الصريح بين الاكتشاف الرياضي وإعادة بناء الأدلة والتحقق الرسمي.

## الترخيص

المادة المملوكة لهذا المشروع مرخصة بموجب **Apache License 2.0** ما لم يُذكر خلاف ذلك. النص الكامل في `LICENSE`، وحدود الطرف الثالث والنَّسب العلمي في `THIRD_PARTY_NOTICES.md` ووثائق المسائل.

## الحالة الحالية — 18 أوت 2026

### Erdős #678 mathematics

#678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

المسار الناجح هو إعادة بناء برهان Stijn Cambie (2024) وإعادة تنفيذه بصورة مستقلة في Lean، وليس برهانًا رياضيًا جديدًا ولا أول formalization. المدخل التحليلي يعتمد على PNT+ المثبت عند `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### S1 / S2a / S2b / S2c / S2d

- **S1:** differential verification executable مقابل Aristotle/Alexeev؛ مغلقة ومتحقق منها آليًا.
- **S2a:** dependency-surface metrics حساسة لحدود ownership؛ لا ranking معماري من raw counts.
- **S2b:** لا stable wall-clock winner في الجولة المعتمدة، مع اختلاف CPU/memory profile؛ pilot خضراء استُبعدت بسبب provenance ناقصة.
- **S2c:** repair-locality mixed/interface-dependent؛ لا uniform maintainability winner.
- **S2d:** مغلقة وclosure-verified؛ الجولة المعتمدة `32076614547` أعطت 6/6 semantic rejections، 0 survivors، 0 proof repairs، و0 dependency-source touches. Closure merge `5039d464f6196e6e4ede2b600723b8616aeeee4` اجتاز exact-main run `32103947182` / job `95609642835` مع `No update necessary` و8808 jobs.

### S2e — upgrade robustness: DETECTION EXECUTED / ARTIFACT VALIDATED / PENDING EVIDENCE INTEGRATION

S2e تختبر **مرشحين محددين ومجمّدين مسبقًا** للترقية، ولا تقيس maintainability عامة ولا تقارن architecture بأخرى.

الباسلاين المجمد:

- source `5039d464f6196e6e4ede2b600723b8616aeeee4`؛
- Lean `v4.33.0`؛
- Mathlib input `v4.33.0`, resolved `db584cd6d46c92f209a44c0f1c829460d327499d`؛
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`؛
- canonical build: **8808 jobs**.

المرشحان المجمدان:

1. **U1 compiler-only:** Lean `v4.34.0-rc1` مع Mathlib/PNT والـmanifest الحالية ثابتة، ولا `lake update`.
2. **U2 root Lean+Mathlib RC:** Lean `v4.34.0-rc1` + Mathlib exact `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` مع PNT+ ثابتة عند `2667e414...`.

بعد عدة جولات استُبعدت بالكامل لأسباب instrumentation/provenance محددة ومعلنة، أصبحت الجولة **`32170243744`** أول complete-set detection صالحة للـcredit. U1 job `95819384522`، U2 job `95819384599`، والـaggregate job `95822552072` نجحت جميعًا.

الـcomplete artifact هي `9337321640`، بحجم 58,933 بايت وSHA-256:

`90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`

أُعيد تنزيلها والتحقق من digest بصورة مستقلة؛ تحتوي 40 ملفًا، و`COMBINE_AUDIT` وownership/provenance validations كلها PASS، بلا apparatus failures وبلا repair outputs.

النتيجة المحدودة:

- **U1:** D0 وD1 green؛ ثم تفشل D2 الثلاث وD3 أولًا داخل Mathlib/transitive dependencies. deepest green = `D1`، primary owner = `mathlib_or_transitive_dependency`. لم نصل إلى project-owned proof failure.
- **U2:** D0 green؛ ثم D1 package resolution تفشل بعد اختيار Mathlib المرشحة بالضبط، مع dependency-version mismatch warnings ثم `error: mathlib: failed to fetch cache`. deepest green = `D0`، primary owner = `package_resolution`.
- **Repair phase:** `not_applicable`. لم يصل أي مرشح إلى failure project-owned مؤهلة وفق البروتوكول، ولذلك لا توجد repair run ناقصة ولا repair-surface metric يجوز اختراعها.

هذه النتيجة تصف **version/dependency boundary لهذين المرشحين فقط**. لا تعني general Lean/Mathlib incompatibility، ولا general maintainability، ولا expected future upgrade cost، ولا proof-quality defect في dependencies، ولا architecture superiority. Timing metadata فقط.

الأدلة الدائمة:

- `problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_BASELINE.md`؛
- `problems/678/S2_UPGRADE_ROBUSTNESS_BASELINE.json`.

Evidence integration نفسها ما تزال خاضعة لـexact-head canonical CI ثم merge ثم exact-main post-merge verification. بعد ذلك فقط تُنفذ documentation-only closure لـS2e.

## بوابة الانتقال

**لا تختَر أو تبدأ أو تستأنف أي مسألة Erdős أخرى حتى يعطي المستخدم إذنًا صريحًا وفق `DEC-012`.**

> مخرجات AI لا تكتسب قيمة علمية من الإقناع اللغوي. قيمتها تأتي من statement fidelity، provenance، predeclared controls، النقد، machine checking، وإمكانية إعادة الإنتاج، مع تسمية مستوى الأصالة وحدود الاستنتاج بدقة.
