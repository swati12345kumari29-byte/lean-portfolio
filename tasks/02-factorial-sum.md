# Task 2 — Telescoping factorial sum (proof writing)

**Golden:** [`LeanPortfolio/FactorialSum.lean`](../LeanPortfolio/FactorialSum.lean)
**Novelty check:** no statement of `Σ i · i! = n! − 1` (in any form) at the pinned Mathlib commit.

The statement uses truncated natural-number subtraction on purpose. The identity is true
because `n! ≥ 1`, but a proof that treats `-` as ordinary integer subtraction will leave
an unsolved goal.

## Prompt

````
Create a Lean project and prove the following theorem in `LeanPortfolio/FactorialSum.lean`.

import Mathlib

open Finset Nat

theorem sum_mul_factorial (n : ℕ) :
    ∑ i ∈ range n, i * i ! = (n !) - 1 := by
  sorry

Subtraction here is natural-number (truncated) subtraction. Replace `sorry` with a
complete proof. You may introduce helper lemmas and use any kernel-checkable proof
strategy. Do not use `sorry`, add axioms, or change the theorem statement.
Toolchain: leanprover/lean4:v4.33.0-rc1, Mathlib at commit
9944fe2973b8dc0b86949101ed98232c07cd54a0. Verify with `lake build`.
````

## Golden answer: step-by-step explanation

1. Helper `sum_mul_factorial_add_one`: the subtraction-free identity `Σ_{i<n} i·i! + 1 = n!`,
   by induction on `n`.
   - Base: empty sum, `0 + 1 = 0! = 1`; `simp`.
   - Step: split off `n · n!` (`sum_range_succ`), move the `+ 1` next to the old sum
     (`add_right_comm`), apply the induction hypothesis, and expand `(n+1)! = (n+1) · n!`
     (`factorial_succ`). Both sides are `n! + n·n!`; `ring` closes it.
2. Main theorem: with `S + 1 = n!` in context, `S = n! - 1` is linear arithmetic over
   `ℕ` (treating `S` and `n!` as atoms), which `omega` decides, including the truncation.

## Rubric (each +1)

1. A theorem named `sum_mul_factorial` is declared in `LeanPortfolio/FactorialSum.lean`.
2. The elaborated type of `sum_mul_factorial` is `∀ n : ℕ, ∑ i ∈ Finset.range n, i * i ! = n ! - 1`, with `-` being subtraction on `ℕ`.
3. `lake build` completes without errors in the pinned environment.
4. The project source contains no `sorry` or `admit`.
5. `#print axioms sum_mul_factorial` lists no axioms other than `propext`, `Classical.choice`, and `Quot.sound`.
6. The project's `lean-toolchain` file specifies `leanprover/lean4:v4.33.0-rc1`.
7. The project's Lake configuration requires Mathlib at commit `9944fe2973b8dc0b86949101ed98232c07cd54a0`.
