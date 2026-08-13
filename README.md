# Erdos_Solving

مستودع بحثي مخصص لدراسة مسائل Erdős بمساعدة الذكاء الاصطناعي، مع التركيز على **المعرفة أولاً، والبرمجيات ثانياً** وعلى قابلية التحقق وتتبع الأدلة.

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

## الحالة الحالية

**Phase 2 — Blind Independent Solving**

التجربة الحالية هي Erdős #1125. نصها canonical هو النص الذي زوّد به المستخدم، وتجربة الحل ما تزال في مرحلة **Structural Analysis**. لم يتم تجميد أي برهان، ولم يتم فتح الحل التاريخي خلال المرحلة العمياء.

التجارب السابقة:

- #447: **contaminated challenge**؛ أُوقف الاختبار المستقل بعد كشف معلومات من الحل أثناء التحقق.
- #18: مسألة **OPEN** وليست محلولة؛ أُعيد تصنيف النتيجة \(h(n!)<n\) بوصفها **known sub-result**، والبرهان المستقل الذي أعدناه لهذه النتيجة محفوظ كاختبار فرعي فقط.

## المبدأ الحاكم

> لا نعتبر مخرجات AI حلاً لمجرد أنها تبدو مقنعة. النتيجة تصبح قابلة للاعتماد فقط بقدر ما تملك من أدلة، ونقد، وتحقيق، وإمكانية إعادة الإنتاج.
