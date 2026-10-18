# Task 3 — Nicomachus's theorem (proof writing)

**Golden:** [`LeanPortfolio/Nicomachus.lean`](../LeanPortfolio/Nicomachus.lean)
**Novelty check:** Mathlib at the pinned commit has the general Faulhaber formula via
Bernoulli numbers (`sum_range_pow`) but not this identity. Deriving it from `sum_range_pow`
requires evaluating Bernoulli numbers over `ℚ`, so a direct proof is the natural route.

Source of the mathematics: Nicomachus of Gerasa, *Introduction to Arithmetic* (c. 100 CE).

## Prompt

````
Create a Lean project and prove the following theorem in `LeanPortfolio/Nicomachus.lean`.

import Mathlib

open Finset

theorem sum_cubes_eq_sq_sum (n : ℕ) :
    ∑ i ∈ range n, i ^ 3 = (∑ i ∈ range n, i) ^ 2 := by
  sorry

Replace `sorry` with a complete proof. You may introduce helper lemmas and use any
kernel-checkable proof strategy. Do not use `sorry`, add axioms, or change the theorem
statement. Toolchain: leanprover/lean4:v4.33.0-rc1, Mathlib at commit
9944fe2973b8dc0b86949101ed98232c07cd54a0. Verify with `lake build`.
````

## Golden answer: step-by-step explanation

1. `two_mul_sum_id`: `2 · Σ_{i ≤ n} i = n(n+1)`, by induction (`sum_range_succ`, the
   hypothesis, `ring`). Multiplying by 2 avoids natural-number division.
2. `four_mul_sum_cubes`: `4 · Σ_{i ≤ n} i³ = (n(n+1))²`, by the same induction pattern.
3. Main theorem, by cases on `n`:
   - `n = 0`: both sides are `0`; `simp`.
   - `n = m + 1`: rewrite `4 · Σ i³` with step 2, then replace `n(n+1)` by `2 · Σ i`
     (step 1 read right-to-left), so `4 · Σ i³ = (2 · Σ i)² = 4 · (Σ i)²`.
     Cancel the factor 4 (`Nat.eq_of_mul_eq_mul_left`).

## Rubric (each +1)

1. A theorem named `sum_cubes_eq_sq_sum` is declared in `LeanPortfolio/Nicomachus.lean`.
2. The elaborated type of `sum_cubes_eq_sq_sum` is `∀ n : ℕ, ∑ i ∈ Finset.range n, i ^ 3 = (∑ i ∈ Finset.range n, i) ^ 2`.
3. `lake build` completes without errors in the pinned environment.
4. The project source contains no `sorry` or `admit`.
5. `#print axioms sum_cubes_eq_sq_sum` lists no axioms other than `propext`, `Classical.choice`, and `Quot.sound`.
6. The project's `lean-toolchain` file specifies `leanprover/lean4:v4.33.0-rc1`.
7. The project's Lake configuration requires Mathlib at commit `9944fe2973b8dc0b86949101ed98232c07cd54a0`.
