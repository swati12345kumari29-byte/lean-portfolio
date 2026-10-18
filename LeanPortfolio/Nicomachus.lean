import Mathlib

/-!
# Nicomachus's theorem

`0³ + 1³ + ⋯ + (n-1)³ = (0 + 1 + ⋯ + (n-1))²`.

Both sides are compared through the closed forms `2 · Σ i = n(n+1)` and
`4 · Σ i³ = (n(n+1))²` over `range (n + 1)`, which avoid natural-number division.
-/

open Finset

lemma two_mul_sum_id (n : ℕ) : 2 * ∑ i ∈ range (n + 1), i = n * (n + 1) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [sum_range_succ, mul_add, ih]
    ring

lemma four_mul_sum_cubes (n : ℕ) :
    4 * ∑ i ∈ range (n + 1), i ^ 3 = (n * (n + 1)) ^ 2 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [sum_range_succ, mul_add, ih]
    ring

theorem sum_cubes_eq_sq_sum (n : ℕ) :
    ∑ i ∈ range n, i ^ 3 = (∑ i ∈ range n, i) ^ 2 := by
  cases n with
  | zero => simp
  | succ m =>
    have h4 : 4 * ∑ i ∈ range (m + 1), i ^ 3 = 4 * (∑ i ∈ range (m + 1), i) ^ 2 := by
      rw [four_mul_sum_cubes, ← two_mul_sum_id]
      ring
    exact Nat.eq_of_mul_eq_mul_left (by norm_num) h4
