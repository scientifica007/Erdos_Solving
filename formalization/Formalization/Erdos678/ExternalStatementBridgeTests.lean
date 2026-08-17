import Formalization.Erdos678.ExternalStatementBridge

/-!
Kernel-facing audit hooks for the S1a external-statement bridge.

These commands make the axiom footprint of the normalized representation and endpoint
visible in canonical build logs.  No custom mathematical axiom is expected.
-/

#print axioms Erdos678.intervalFinset_succ_eq_Ioc
#print axioms Erdos678.erdosM_eq_externalLCMInterval
#print axioms Erdos678.erdos678_external_eventual_witnesses
#print axioms Erdos678.erdos678_formalConjectures_eventually_nonempty
