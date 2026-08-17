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

> **مزامنة الحالة:** 17 أوت 2026. إعادة بناء Erdős #678 عبر Cambie اكتملت رياضياً وتحققت آلياً في Lean ودُمجت في `main` عبر PR #17. merge commit الرياضي هو `8fd1b20541ac7782f52429db3a2cc4c887547372`، وتشغيل التحقق بعد الدمج `32011189766` نجح مع `No update necessary` وبناء كامل من **8806 jobs**. مزامنة الأرشفة في PR #18 اجتازت run `32013917788` ثم دُمجت في `main` كـ`755c9601816fbbd7e2181a2e56c34f28667ceb67`. لذلك صُنفت #678 **COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED**.

- لا توجد حالياً مرحلة رياضية مفتوحة في #678.
- **لا يجوز اختيار أو تفعيل أو استئناف أو بحث أو formalization لأي مسألة أخرى بعد #678 إلا بعد إذن صريح من المستخدم، وفق `DEC-012`.**
- نمط العمل المنجز في #678: **إعادة بناء برهان Cambie (2024) وإعادة تنفيذه في Lean**، لا محاولة اكتشاف مستقلة عمياء.
- Claim 5: **PASSED / MACHINE-CHECKED**.
- Claim 4 / Phase D: **PASSED / MACHINE-CHECKED**.
- Phase E1 — quantitative LCM-ratio estimate: **PASSED**.
- Phase E2 — sharp prime density: **PASSED** باستخدام `AxiomMath/PrimeNumberTheoremAnd` المثبت على revision محدد، بلا prime-density axiom مخصص.
- Phase E3 — strong eventual Cambie theorem: **PASSED**.
- Phase E4 — canonical Erdős #678 translation and infinitude: **PASSED**.
- Integration into `main`: **PASSED** عبر PR #17.
- Post-merge canonical verification: **PASSED** عبر run `32011189766`، **8806 jobs**.
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
| #678 | **مكتملة ومتحققة آلياً ومندمجة ومتحققة بعد الدمج في `main`؛ مؤرشفة** |
| #1125 | المحاولة العمياء فشلت؛ إعادة البناء التاريخية مكتملة |

## ترتيب مصادر الحالة

عند الاستئناف:

1. تحقق من رأس `main` ومن CI للرأس الدقيق.
2. اقرأ `PROJECT_STATE.md`.
3. تعامل مع #678 كـbenchmark مكتمل ومؤرشف ما لم يظهر regression محدد.
4. **توقف عند #678 ولا تختَر أو تبدأ مسألة أخرى حتى يعطي المستخدم إذناً صريحاً بذلك.**
5. تعامل مع أي `HISTORICAL SNAPSHOT` أو `SUPERSEDED` بوصفه سجل منشأ، لا تعليمات تشغيل.

## المبدأ الحاكم

> لا نعتبر مخرجات AI حلاً لمجرد أنها تبدو مقنعة. النتيجة تصبح قابلة للاعتماد فقط بقدر ما تملك من أدلة، ونقد، وتحقيق، وإمكانية إعادة الإنتاج.
