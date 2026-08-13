# RESEARCH_RECORD_SCHEMA

هذا توصيف أولي لسجل بحث قابل للتوسيع إلى JSON/YAML لاحقاً.

```yaml
record_id: "ERDOS-XXXX-ATTEMPT-YYYYMMDD-NN"
problem_number: "XXXX"
record_type: "ai_attempt | literature | computation | human_review | formalization"
created_at: "YYYY-MM-DD"
agent_or_researcher: ""
model: ""

objective: ""
input_claims: []
assumptions: []
methods: []

sources:
  - type: "website | paper | book | dataset | code | formalization"
    url: ""
    accessed_at: ""
    relevance: ""

evidence:
  - id: "E1"
    type: "proof | calculation | counterexample | quotation | formal_check | literature"
    description: ""
    location: ""

outputs:
  claims: []
  computations: []
  candidate_proof: ""
  candidate_counterexample: ""

critique:
  reviewer: ""
  objections: []
  unresolved_gaps: []
  circularity_check: ""
  novelty_check: ""

outcome:
  class: "no-progress | insight | conjecture | partial-result | counterexample | disproof | proof-sketch | rigorous-proof | machine-checked-proof | literature-match"
  confidence: "low | medium | high"
  rationale: ""

next_action: ""
```

## قواعد

- لا تُملأ خانة `confidence` لتعبير عن شعور النموذج؛ بل عن قوة الأدلة.
- `candidate_proof` يبقى مرشحاً حتى يجتاز النقد والتحقق.
- `machine-checked-proof` يتطلب تحديد الأداة والإصدار والملفات ونتيجة البناء.
- `literature-match` مهم حتى لا ننسب إلى AI نتيجة كانت معروفة مسبقاً.
- كل سجل يجب أن يجيب عن سؤال: "كيف يمكن لباحث مستقل مراجعة هذه النتيجة؟"
