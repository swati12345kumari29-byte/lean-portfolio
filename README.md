# Lean Portfolio: four Turing-style Lean tasks

Four Lean 4 + Mathlib tasks in the Project Turing format: three proof-writing tasks and one
formalization task. Each has a prompt, a compiling golden answer, a step-by-step explanation,
and a binary +1 rubric.

> **Authorship.** This repository was generated with an AI assistant (Claude),
> with the project lead's approval for AI-generated work. All proofs were checked by Lean;
> see "Verification" below.

| # | Task | Type | Lean file | Task sheet |
|---|------|------|-----------|------------|
| 1 | `Σ Fᵢ² = Fₙ·Fₙ₊₁` | Proof | [FibSquares.lean](LeanPortfolio/FibSquares.lean) | [01](tasks/01-fib-squares.md) |
| 2 | `Σ i·i! = n! − 1` over `ℕ` | Proof | [FactorialSum.lean](LeanPortfolio/FactorialSum.lean) | [02](tasks/02-factorial-sum.md) |
| 3 | Nicomachus: `Σ i³ = (Σ i)²` | Proof | [Nicomachus.lean](LeanPortfolio/Nicomachus.lean) | [03](tasks/03-nicomachus.md) |
| 4 | Every `n > 0` has a positive multiple with only 0/1 digits | Formalization (+ proof) | [ZeroOneMultiple.lean](LeanPortfolio/ZeroOneMultiple.lean) | [04](tasks/04-zero-one-multiple.md) |

Each statement was searched for in the pinned Mathlib source before it was written; the
task sheets record what related results do exist.

## Environment

| | |
|---|---|
| Lean toolchain | `leanprover/lean4:v4.33.0-rc1` |
| Mathlib4 commit | `9944fe2973b8dc0b86949101ed98232c07cd54a0` |

## Verification

```sh
lake exe cache get                      # prebuilt Mathlib
lake build                              # builds all four files
lake env lean scripts/CheckAxioms.lean  # axiom report
```

Expected axiom report (no `sorryAx`):

```
'sum_fib_sq' depends on axioms: [propext, Classical.choice, Quot.sound]
'sum_mul_factorial' depends on axioms: [propext, Classical.choice, Quot.sound]
'sum_cubes_eq_sq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'candidateStatement_holds' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## What is not included

The task-flow steps that run on the platform (three model outputs, the confirmed model
failure, judge-model grading) are not part of this repository. No model outputs or rubric
scores are claimed here.
