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

## الوثائق الأساسية

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

**Phase 2 — Independent Solving / Validation**

تم تأسيس النموذج المعرفي وقواعد العمل وبروتوكول البحث، ثم بدأ اختبار المعمارية على مسألة محلولة. التجربة الأولى (#447) صُنفت لاحقاً كـ **contaminated challenge** بعد كشف معلومات حل أثناء عملية التحقق، ولذلك لا تُستخدم كاختبار مستقل. التجربة الحالية هي Erdős #18، مع محاولة مستقلة لنتيجة Erdős العليا
\[
h(n!)<n,
\]
ونستهدف برهاناً أقوى هو \(h(n!)\le n-1\) لكل \(n\ge2\).

## المبدأ الحاكم

> لا نعتبر مخرجات AI حلاً لمجرد أنها تبدو مقنعة. النتيجة تصبح قابلة للاعتماد فقط بقدر ما تملك من أدلة، ونقد، وتحقيق، وإمكانية إعادة الإنتاج.
