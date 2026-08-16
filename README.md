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

> **مزامنة الحالة:** 16 أوت 2026. Phase D متحققة آلياً على الرأس النهائي القابل للوصول `eb5ffebffcb199cc76c83a941da955f4ecfebde5` عبر التشغيل `31963803495` (**8766 jobs**). Phase E1 أُغلقت رياضياً على الرأس `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a` عبر التشغيل `31968714909`، مع `mk_all --check = No update necessary` وبناء كامل من **8770 jobs**. **Phase E2 هي المرحلة التشغيلية الحالية.**

- المسألة النشطة: **Erdős #678**.
- نمط العمل: **إعادة بناء برهان Cambie (2024) وإعادة تنفيذه في Lean**، لا محاولة اكتشاف مستقلة عمياء.
- Claim 5: النطاقات الثلاثة والهوية الطبيعية النهائية متحققة آلياً تحت واجهتي البواقي الصريحتين.
- Claim 4 / Phase D: **PASSED** حتى theorem sharp Cambie النهائي تحت large-`k` وsharp-prime-window data صريحة.
- Phase E1: **PASSED / MACHINE-CHECKED**:
  - exact `intervalLCM ∣ intervalProd` bridge؛
  - cross-multiplication آمن في `ℕ` لهوية Claim 5؛
  - نقل product inequality إلى LCM inequality؛
  - product-ratio estimate من نطاق Cambie والقرب؛
  - endpoint نهائي `claim4_exists_cambie_lcm_ratio_of_sharp_windows` يثبت
    `C * intervalLCM y (k+1) < intervalLCM x k` تحت بيانات D4 الصريحة.
- **E2 الحالي:** formalize/import وجود الأوليات الخمس في الأشرطة الحادة لكل `k` كبير بما يكفي؛ لا يوجد axiom يخفي هذا الاعتماد.
- E3: theorem Cambie القوي بعد دمج E1 وE2.
- E4: Erdős #678 عند `C=1` وترجمة فهارس الفترات.

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
| #678 | Claim 5 وPhase D وPhase E1 machine-checked؛ **E2 sharp prime-density CURRENT**؛ E3/E4 pending |
| #1125 | المحاولة العمياء فشلت؛ إعادة البناء التاريخية مكتملة |

## ترتيب مصادر الحالة

عند الاستئناف:

1. تحقق من رأس `main`/الفرع النشط ومن CI للرأس الدقيق.
2. اقرأ `PROJECT_STATE.md`.
3. اقرأ `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
4. تعامل مع أي `HISTORICAL SNAPSHOT` أو `SUPERSEDED` بوصفه سجل منشأ، لا تعليمات تشغيل.

## المبدأ الحاكم

> لا نعتبر مخرجات AI حلاً لمجرد أنها تبدو مقنعة. النتيجة تصبح قابلة للاعتماد فقط بقدر ما تملك من أدلة، ونقد، وتحقيق، وإمكانية إعادة الإنتاج.
