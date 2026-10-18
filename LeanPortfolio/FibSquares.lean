import Mathlib

/-!
# Sum of squares of Fibonacci numbers

`F₀² + F₁² + ⋯ + Fₙ² = Fₙ · Fₙ₊₁`, with Mathlib's convention `fib 0 = 0`, `fib 1 = 1`.
-/

open Finset

theorem sum_fib_sq (n : ℕ) :
    ∑ i ∈ range (n + 1), Nat.fib i ^ 2 = Nat.fib n * Nat.fib (n + 1) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [sum_range_succ, ih, show n + 1 + 1 = n + 2 from rfl, Nat.fib_add_two]
    ring
