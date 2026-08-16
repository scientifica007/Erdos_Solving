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

> **مزامنة الحالة:** 16 أوت 2026. بوابة D4 الرياضية اجتازت التشغيل `31959479154` على الالتزام `0696e6474ebaf6deec2303f38c862842da3b28e2`، وبوابة مزامنة وثائق الخروج اجتازت التشغيل `31960707971` على الرأس `c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893`. كلا التشغيلين أعادا `mk_all --check = No update necessary` وبناءً كاملاً من **8766 jobs**. **Phase E1 هي المرحلة التشغيلية الحالية.**

- المسألة النشطة: **Erdős #678**.
- نمط العمل: **إعادة بناء برهان Cambie (2024) وإعادة تنفيذه في Lean**، لا محاولة اكتشاف مستقلة عمياء.
- Claim 5: النطاقات الثلاثة والهوية الطبيعية النهائية متحققة آلياً تحت واجهتي البواقي الصريحتين.
- Claim 4 / Phase D: **PASSED** حتى theorem sharp Cambie النهائي:
  - المقاييس الفعلية `Nx,Ny` ودعمها ووحداتها؛
  - `claim4FullScale = lcm(1,...,k)` وfactorizations الدقيقة؛
  - اختيار `y` ثم `x` في نافذة متحركة وإثبات `x+k<y<x+gap`؛
  - صيغ Cambie الفعلية `gap`, `yLower`, `yUpper` بصياغة `Nat.div`؛
  - الفجوة العامة للمقياس الصغير لكل `k≥9`؛
  - عقدة large-`k` صريحة؛
  - عقدة أوليات حادة تعتمد على `C` وتنتج ميزانيتي البحث؛
  - theorem النهائي الذي يبني ممثلين داخل نطاق Cambie الفعلي ويحملهم إلى هوية Claim 5 الكاملة.
- **وجود الأوليات الخمس داخل الأشرطة الحادة لكل `k` كبير لم يُثبت بعد**؛ يبقى dependency صريحاً في **E2** ولا يُفترض axiomatically.
- **E1 الحالي:** اشتقاق تقدير نسبة الـLCM من Claim 5 والحدود الكمية المتحققة، مع عزل divisibility/cancellation في `ℕ` قبل أي تبسيط للقسمة.
- E2: prime-density للأشرطة الحادة.
- E3: theorem Cambie القوي.
- E4: Erdős #678 عند `C=1`.

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
| #678 | Claim 5 وPhase D متحققتان حتى sharp Cambie representatives تحت large-`k` وsharp-prime-window data صريحة؛ **E1 LCM-ratio algebra CURRENT**؛ prime-density يبقى E2 |
| #1125 | المحاولة العمياء فشلت؛ إعادة البناء التاريخية مكتملة |

## ترتيب مصادر الحالة

عند الاستئناف:

1. تحقق من رأس `main`/الفرع النشط ومن CI للرأس الدقيق.
2. اقرأ `PROJECT_STATE.md`.
3. اقرأ `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
4. تعامل مع أي `HISTORICAL SNAPSHOT` أو `SUPERSEDED` بوصفه سجل منشأ، لا تعليمات تشغيل.

## المبدأ الحاكم

> لا نعتبر مخرجات AI حلاً لمجرد أنها تبدو مقنعة. النتيجة تصبح قابلة للاعتماد فقط بقدر ما تملك من أدلة، ونقد، وتحقيق، وإمكانية إعادة الإنتاج.
