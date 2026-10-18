import Mathlib

/-!
# Every positive integer has a positive multiple written with only 0s and 1s

Natural-language claim: for every positive integer `n` there is a positive integer `m`,
divisible by `n`, whose decimal digits are all `0` or `1`.

`CandidateStatement` is the formalization. `candidateStatement_holds` proves it by the
pigeonhole principle on the repunits `1, 11, 111, …` modulo `n`.
-/

open Finset

def CandidateStatement : Prop :=
  ∀ n : ℕ, 0 < n → ∃ m : ℕ, 0 < m ∧ n ∣ m ∧ ∀ d ∈ Nat.digits 10 m, d = 0 ∨ d = 1

/-! ### A mistranslation this guards against

Dropping `0 < m` makes the statement vacuous: `m = 0` is divisible by everything and
`Nat.digits 10 0 = []`, so the digit condition holds trivially. -/

example : ∀ n : ℕ, ∃ m : ℕ, n ∣ m ∧ ∀ d ∈ Nat.digits 10 m, d = 0 ∨ d = 1 :=
  fun n => ⟨0, dvd_zero n, by simp⟩

/-! ### Proof that the statement holds -/

/-- The repunit with `k` ones: `1 + 10 + ⋯ + 10^(k-1)`. -/
def repunit (k : ℕ) : ℕ := ∑ i ∈ range k, 10 ^ i

lemma repunit_succ (k : ℕ) : repunit (k + 1) = 10 * repunit k + 1 := by
  simp only [repunit, sum_range_succ', pow_succ, mul_sum, pow_zero]
  congr 1
  exact sum_congr rfl fun i _ => mul_comm _ _

lemma repunit_pos {k : ℕ} (hk : 0 < k) : 0 < repunit k := by
  obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_lt hk
  rw [zero_add, repunit_succ]
  omega

lemma repunit_add (i k : ℕ) : repunit (i + k) = repunit i + 10 ^ i * repunit k := by
  simp only [repunit, sum_range_add, pow_add, mul_sum]

/-- A number whose digits are all `0` or `1`. -/
def ZeroOneDigits (m : ℕ) : Prop := ∀ d ∈ Nat.digits 10 m, d = 0 ∨ d = 1

lemma zeroOneDigits_repunit (k : ℕ) : ZeroOneDigits (repunit k) := by
  induction k with
  | zero => simp [ZeroOneDigits, repunit]
  | succ k ih =>
    intro d hd
    rw [repunit_succ, Nat.digits_def' (by norm_num) (by omega)] at hd
    rcases List.mem_cons.mp hd with rfl | hd
    · omega
    · exact ih d (by rwa [show (10 * repunit k + 1) / 10 = repunit k by omega] at hd)

lemma zeroOneDigits_ten_pow_mul {x : ℕ} (hx : 0 < x) (h : ZeroOneDigits x) (i : ℕ) :
    ZeroOneDigits (10 ^ i * x) := by
  induction i with
  | zero => simpa using h
  | succ i ih =>
    have hpos : 0 < 10 ^ i * x := Nat.mul_pos (by positivity) hx
    intro d hd
    rw [pow_succ, mul_comm (10 ^ i) 10, mul_assoc,
      Nat.digits_def' (by norm_num) (by omega)] at hd
    rcases List.mem_cons.mp hd with rfl | hd
    · omega
    · exact ih d (by rwa [show 10 * (10 ^ i * x) / 10 = 10 ^ i * x by omega] at hd)

/-- If two repunits `i < j` agree mod `n`, their difference is a valid witness. -/
lemma witness_of_mod_eq {n i j : ℕ} (hij : i < j)
    (h : repunit i % n = repunit j % n) :
    ∃ m : ℕ, 0 < m ∧ n ∣ m ∧ ZeroOneDigits m := by
  obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_lt hij
  have hk : 0 < k + 1 := Nat.succ_pos k
  have hsplit := repunit_add i (k + 1)
  rw [← add_assoc] at hsplit
  refine ⟨10 ^ i * repunit (k + 1), Nat.mul_pos (by positivity) (repunit_pos hk), ?_,
    zeroOneDigits_ten_pow_mul (repunit_pos hk) (zeroOneDigits_repunit _) i⟩
  have hdvd := (Nat.modEq_iff_dvd' (by omega)).mp (show repunit i ≡ repunit (i + k + 1) [MOD n] from h)
  rwa [hsplit, Nat.add_sub_cancel_left] at hdvd

theorem candidateStatement_holds : CandidateStatement := by
  intro n hn
  have hmaps : ∀ k ∈ range (n + 1), repunit k % n ∈ range n :=
    fun k _ => mem_range.mpr (Nat.mod_lt _ hn)
  obtain ⟨i, -, j, -, hne, heq⟩ :=
    exists_ne_map_eq_of_card_lt_of_maps_to (by simp) hmaps
  rcases Nat.lt_or_gt_of_ne hne with hij | hji
  · exact witness_of_mod_eq hij heq
  · exact witness_of_mod_eq hji heq.symm
