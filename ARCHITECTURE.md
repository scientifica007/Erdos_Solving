# ARCHITECTURE

## 1. المبدأ

البنية الأساسية للمشروع معرفية قبل أن تكون برمجية. الهدف هو أن تكون كل مسألة كياناً بحثياً له هوية وحالة وأدلة ومحاولات وتاريخ.

## 2. النموذج الطبقي

```text
External Sources
    │
    ├── erdosproblems.com
    ├── literature
    ├── OEIS
    ├── teorth/erdosproblems
    └── formal-conjectures
             │
             ▼
      Problem Knowledge Base
             │
      ┌──────┼────────┐
      ▼      ▼        ▼
 Literature  Computation  AI Attempts
      │      │        │
      └──────┼────────┘
             ▼
       Research Record
             │
      ┌──────┼────────┐
      ▼      ▼        ▼
   Human   Formal     Reproduction
   Review  Verification  Evidence
             │
             ▼
       Verified Outcome
```

## 3. الكيانات الأساسية

### Problem
هوية المسألة ونصها ومصدرها وحالتها ووسومها.

### Research Record
سجل محاولة أو نشاط بحثي محدد: سؤال، منهج، مدخلات، مخرجات، أدلة، نقد، ونتيجة.

### Evidence
مصدر يدعم ادعاءً محدداً: ورقة، رابط، حساب، ملف Lean، counterexample، أو سجل تجربة.

### Claim
ادعاء رياضي منفصل يمكن تقييمه: true / false / unsupported / unresolved.

### Attempt
محاولة حل، نفي، تبسيط، بحث أدبي، حساب، أو formalization.

## 4. الحالات

حالة المسألة لا تختزل في قيمة واحدة. يجب فصل:

- `informal_status`: الحالة الرياضية بحسب الأدبيات/الفهم البشري.
- `formal_status`: هل الحل formalized في proof assistant.
- `statement_formalized`: هل نص المسألة formalized.
- `research_state`: حالة العمل داخل هذا المستودع.

## 5. مبدأ الأثر الكامل

يجب أن نستطيع الانتقال من النتيجة النهائية إلى:

`Outcome → Claims → Evidence → Research Records → Sources/Experiments`

## 6. فصل البيانات عن العرض

لا ينبغي أن يكون README أو Markdown هو المصدر الوحيد لبيانات المسألة. عند توسيع المشروع ستصبح البيانات المهيكلة هي مصدر الحقيقة، وتُولد منها التقارير والجداول.

## 7. مستقبل البرمجيات

لن يبدأ بناء solver كبير قبل تثبيت نموذج البيانات وبروتوكول البحث. الأدوات البرمجية ستخدم دورة البحث بدلاً من أن تفرضها.
