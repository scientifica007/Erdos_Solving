# Erdos_Solving

مستودع بحثي مخصص لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي، مع التركيز على **المعرفة أولاً، والبرمجيات ثانياً** وعلى قابلية التحقق وتتبع الأدلة.
Erdos_Solving = مختبر مفتوح لدراسة عملية البحث الرياضي البشري–الآلي على مسائل Erdős، من المحاولة الأولية إلى البرهان الرسمي.

## الهدف

بناء بيئة بحثية لكل مسألة تحفظ بصورة منظمة:

- نص المسألة ومصدره وسياقه.
- الحالة الرياضية الرسمية وغير الرسمية.
- الأدبيات والنتائج السابقة.
- محاولات الذكاء الاصطناعي والباحثين.
- الحسابات وcounterexamples.
- المتتاليات المرتبطة في OEIS.
- formalization في Lean عند الإمكان.
- أثر التحقق والنقد والقرارات.

## المصادر المرجعية

- [Erdős Problems](https://www.erdosproblems.com/)
- [teorth/erdosproblems](https://github.com/teorth/erdosproblems)
- [Google DeepMind Formal Conjectures](https://github.com/google-deepmind/formal-conjectures)
- [OEIS](https://oeis.org/)

## وثائق التشغيل الأساسية

- [PROJECT_STATE.md](PROJECT_STATE.md) — نقطة الاستئناف الحالية وذاكرة التشغيل.
- [DECISIONS.md](DECISIONS.md) — سجل القرارات الحاكم.
- [RESEARCH_STATE_PROTOCOL.md](RESEARCH_STATE_PROTOCOL.md) — بروتوكول المراحل والبوابات.
- [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md)
- [CONSTITUTION.md](CONSTITUTION.md)
- [ARCHITECTURE.md](ARCHITECTURE.md)
- [WORKFLOW.md](WORKFLOW.md)
- [RESEARCH_RECORD_SCHEMA.md](RESEARCH_RECORD_SCHEMA.md)
- [AI_AGENT_GUIDE.md](AI_AGENT_GUIDE.md)
- [docs/STATUS_MODEL.md](docs/STATUS_MODEL.md)
- [docs/RESEARCH_PROTOCOL.md](docs/RESEARCH_PROTOCOL.md)
- [problems/README.md](problems/README.md)

## الحالة التشغيلية الحالية

> **مزامنة الحالة:** 17 أوت 2026. إعادة بناء Erdős #678 عبر Cambie اكتملت رياضياً وتحققت آلياً في Lean ثم دُمجت في `main` عبر PR #17. الرأس النهائي المزامن قبل الدمج `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f` اجتاز التشغيل `31977861568` ببناء كامل من **8806 jobs**، والدمج تم في commit `8fd1b20541ac7782f52429db3a2cc4c887547372`. تشغيل التحقق بعد الدمج على `main` هو `32011189766` ويجب اعتماد نتيجته النهائية قبل أرشفة المسألة.

- المسألة النشطة تشغيلياً: **Erdős #678** في بوابة التحقق الختامية بعد الدمج.
- نمط العمل المنجز: **إعادة بناء برهان Cambie (2024) وإعادة تنفيذه في Lean**، لا محاولة اكتشاف مستقلة عمياء.
- Claim 5: **PASSED / MACHINE-CHECKED**.
- Claim 4 / Phase D: **PASSED / MACHINE-CHECKED**.
- Phase E1 — quantitative LCM-ratio estimate: **PASSED**.
- Phase E2 — sharp prime density: **PASSED** باستخدام `AxiomMath/PrimeNumberTheoremAnd` المثبت على revision محدد، بلا prime-density axiom مخصص.
- Phase E3 — strong eventual Cambie theorem: **PASSED**.
- Phase E4 — canonical Erdős #678 translation and infinitude: **PASSED**.
- Integration into `main`: **PASSED** عبر PR #17.
- theorem النهائي `erdos678_unbounded_witnesses` يعطي شاهداً قانونياً فوق كل lower bound على `k`.
- theorem `erdos678_good_lengths_infinite` يثبت أن مجموعة أطوال الكتل الصالحة لا نهائية.

## حصيلة التجارب

| المسألة | حالة عمل هذا المستودع |
|---|---|
| #18 | إعادة بناء نتيجة جزئية معروفة؛ المسألة الأصلية غير محلولة بحسب السجل المحلي |
| #214 | محاولة مرفوضة، إعادة تشغيل غير مكتملة، ثم تلوث أنهى الاختبار الأعمى |
| #225 | تجربة خاملة؛ لا يوجد برهان مرشح؛ حاجز العمى محفوظ إن استؤنفت |
| #246 | موقوفة بسبب خلل في النص المنقول للمعيار |
| #275 | دورة ناجحة: برهان مستقل مدقق ومجمد، ثم مقارنة تاريخية |
| #303 | المحاولة العمياء غير مكتملة؛ المقارنة المرجعية مكتملة |
| #447 | معيار ملوث؛ لا يجوز وصفه بتجربة عمياء نشطة |
| #678 | **إعادة بناء Cambie مكتملة ومتحققة آلياً ومندمجة في `main`**؛ theorem قانوني غير محدود + لا نهائية أطوال جيدة؛ التحقق الختامي بعد الدمج هو آخر بوابة تشغيلية |
| #1125 | المحاولة العمياء فشلت؛ إعادة البناء التاريخية مكتملة |

## ترتيب مصادر الحالة

عند الاستئناف:

1. تحقق من رأس `main` ومن CI للرأس الدقيق.
2. اقرأ `PROJECT_STATE.md`.
3. اقرأ `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
4. تعامل مع أي `HISTORICAL SNAPSHOT` أو `SUPERSEDED` بوصفه سجل منشأ، لا تعليمات تشغيل.

## المبدأ الحاكم

> لا نعتبر مخرجات AI حلاً لمجرد أنها تبدو مقنعة. النتيجة تصبح قابلة للاعتماد فقط بقدر ما تملك من أدلة، ونقد، وتحقيق، وإمكانية إعادة الإنتاج.
