# Task 1 — Sum of squares of Fibonacci numbers (proof writing)

**Golden:** [`LeanPortfolio/FibSquares.lean`](../LeanPortfolio/FibSquares.lean)
**Novelty check:** Mathlib at the pinned commit has `Nat.fib_two_mul_add_one`
(`F(2n+1) = F(n+1)² + F(n)²`) but no statement about the *sum* of squares.

## Prompt

````
Create a Lean project and prove the following theorem in `LeanPortfolio/FibSquares.lean`.

import Mathlib

open Finset

theorem sum_fib_sq (n : ℕ) :
    ∑ i ∈ range (n + 1), Nat.fib i ^ 2 = Nat.fib n * Nat.fib (n + 1) := by
  sorry

Replace `sorry` with a complete proof. You may introduce helper lemmas and use any
kernel-checkable proof strategy. Do not use `sorry`, add axioms, or change the theorem
statement. Toolchain: leanprover/lean4:v4.33.0-rc1, Mathlib at commit
9944fe2973b8dc0b86949101ed98232c07cd54a0. Verify with `lake build`.
````

## Golden answer: step-by-step explanation

1. Induction on `n`.
2. Base case `n = 0`: the sum is `F₀² = 0` and the right side is `F₀ · F₁ = 0`; `simp` closes it.
3. Step: `sum_range_succ` splits off the last term, giving `Σ_{i ≤ n} Fᵢ² + F_{n+1}²`.
   The induction hypothesis rewrites the sum to `Fₙ · Fₙ₊₁`.
4. The right side `F_{n+1} · F_{n+2}` is unfolded with `F_{n+2} = Fₙ + F_{n+1}`
   (`Nat.fib_add_two`); the index `n + 1 + 1` is first restated as `n + 2` so the rewrite fires.
5. Both sides are now `Fₙ·F_{n+1} + F_{n+1}²` up to commutative-ring normalisation; `ring` closes it.

Any induction, closed-form, or library-based proof is equally acceptable.

## Rubric (each +1)

1. A theorem named `sum_fib_sq` is declared in `LeanPortfolio/FibSquares.lean`.
2. The elaborated type of `sum_fib_sq` is `∀ n : ℕ, ∑ i ∈ Finset.range (n + 1), Nat.fib i ^ 2 = Nat.fib n * Nat.fib (n + 1)`.
3. `lake build` completes without errors in the pinned environment.
4. The project source contains no `sorry` or `admit`.
5. `#print axioms sum_fib_sq` lists no axioms other than `propext`, `Classical.choice`, and `Quot.sound`.
6. The project's `lean-toolchain` file specifies `leanprover/lean4:v4.33.0-rc1`.
7. The project's Lake configuration requires Mathlib at commit `9944fe2973b8dc0b86949101ed98232c07cd54a0`.
