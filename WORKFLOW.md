# WORKFLOW

## المرحلة 0 — Triage

تحديد المسألة، مصدرها، حالتها الحالية، الجائزة، الوسوم، والروابط المتاحة.

## المرحلة 1 — Statement Audit

مقارنة نص المسألة بين المصدر الأصلي وerdosproblems.com وFormal Conjectures عند وجوده. تسجيل أي ambiguity أو variant.

## المرحلة 2 — Literature Triage

البحث عن النتائج المعروفة، الأسماء البديلة، الأوراق، preprints، والنتائج التي قد تجعل المسألة غير مفتوحة كما تبدو.

## المرحلة 3 — Mathematical Decomposition

تحويل السؤال إلى claims، lemmas، حالات خاصة، bounds، وطرق محتملة للهجوم.

## المرحلة 4 — Exploration

استعمال الحساب، البرمجة، البحث، AI reasoning، OEIS، أو أدوات أخرى لاكتشاف أنماط أو counterexamples أو مسارات إثبات.

## المرحلة 5 — Independent Critique

كل نتيجة مهمة يجب أن تمر بمرحلة نقد مستقلة: البحث عن gap، counterexample، assumptions مخفية، misuse للتعميم، أو اعتماد دائري.

## المرحلة 6 — Verification

اختيار آلية تحقق ملائمة:

- برهان بشري مفصل.
- computation قابل لإعادة الإنتاج.
- proof assistant.
- أكثر من طريقة مستقلة عندما تكون المخاطر عالية.

## المرحلة 7 — Formalization

عندما يكون مناسباً، formalize التصريح ثم الحل في Lean. يجب تسجيل الفرق بين formalized statement وformalized solution.

## المرحلة 8 — Outcome Classification

التصنيفات الأولية:

`no-progress`, `insight`, `conjecture`, `partial-result`, `counterexample`, `disproof`, `proof-sketch`, `rigorous-proof`, `machine-checked-proof`, `literature-match`.

## المرحلة 9 — Research Report

إنتاج تقرير يذكر بوضوح ما تم إثباته، وما بقي افتراضياً، ومصادر الأدلة، والقيود، والخطوة التالية.

## المرحلة 10 — Upstream Synchronization

إذا اكتُشف تغيير جوهري في الحالة، أو OEIS، أو formalization، أو الحل، يُراجع المصدر upstream قبل اعتبار البيانات محلية ونهائية.

## قاعدة عامة

لا تنتقل محاولة إلى مرحلة "حل" لمجرد أن AI أعطى جواباً. الانتقال تحكمه الأدلة لا طول النص أو ثقة النموذج.
