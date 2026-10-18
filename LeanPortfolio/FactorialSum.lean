import Mathlib

/-!
# A telescoping factorial sum

`0·0! + 1·1! + ⋯ + (n-1)·(n-1)! = n! - 1`, stated over `ℕ` with truncated subtraction.
Since `n! ≥ 1`, the subtraction never truncates, but the proof has to justify that.
-/

open Finset Nat

/-- Subtraction-free form: the sum plus one is `n!`. -/
lemma sum_mul_factorial_add_one (n : ℕ) :
    ∑ i ∈ range n, i * i ! + 1 = n ! := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [sum_range_succ, factorial_succ, add_right_comm, ih]
    ring

theorem sum_mul_factorial (n : ℕ) :
    ∑ i ∈ range n, i * i ! = (n !) - 1 := by
  have h := sum_mul_factorial_add_one n
  omega
