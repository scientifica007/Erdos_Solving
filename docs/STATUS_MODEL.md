# STATUS_MODEL

## لماذا لا نستخدم حالة واحدة؟

حالة المسألة يمكن أن تكون مختلفة باختلاف المستوى الذي نقيسه. لذلك يحتفظ المشروع بأربع طبقات مستقلة.

### 1. `informal_status`
الحالة الرياضية البشرية: `open`, `proved`, `disproved`, `solved`, `falsifiable`, `verifiable`, `decidable`, `not provable`, `not disprovable`, `independent`.

### 2. `formal_status`
هل يوجد حل formalized في proof assistant، مثل Lean.

### 3. `statement_formalized`
هل تم formalize لتصريح المسألة نفسه في Formal Conjectures أو مستودع مكافئ.

### 4. `research_state`
ما الذي أنجزه هذا المشروع تحديداً، مثل:

- `not_started`
- `triaged`
- `statement_audited`
- `literature_checked`
- `exploration_active`
- `candidate_result`
- `under_review`
- `verified`
- `formalized`
- `published_to_upstream`

## تصنيف نتيجة محاولة AI

لا نستخدم `solved` مباشرة. البدائل:

`no-progress → insight → conjecture → partial-result → counterexample/disproof → proof-sketch → rigorous-proof → machine-checked-proof`

ويمكن إرفاق `literature-match` بأي نتيجة تبيّن أن النتيجة معروفة مسبقاً.

## قاعدة مهمة

`formal_status = Lean` لا يساوي بالضرورة `informal_status = proved`.

وكذلك `statement_formalized = yes` لا يساوي `formal_status = Lean`.

هذه الفروق جزء من تصميم المشروع وليست تفاصيل شكلية.
