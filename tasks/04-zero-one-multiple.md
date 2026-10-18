# Task 4 — A multiple written with only 0s and 1s (formalization)

**Golden:** [`LeanPortfolio/ZeroOneMultiple.lean`](../LeanPortfolio/ZeroOneMultiple.lean)
**Novelty check:** no statement about multiples with restricted decimal digits at the pinned
Mathlib commit.

Source of the mathematics: a classical pigeonhole exercise, e.g. A. Engel,
*Problem-Solving Strategies*, Ch. 4 (The Box Principle).

## Prompt

````
In `LeanPortfolio/ZeroOneMultiple.lean`, formalize the following claim as a transparent
proposition definition named `CandidateStatement`.

  For every positive integer n there is a positive integer m such that n divides m
  and every decimal digit of m is 0 or 1.

Quantify all mathematical variables inside the definition body:

import Mathlib

def CandidateStatement : Prop := ...

Do not prove it and do not use `sorry`. Toolchain: leanprover/lean4:v4.33.0-rc1,
Mathlib at commit 9944fe2973b8dc0b86949101ed98232c07cd54a0.
Verify with `lake env lean LeanPortfolio/ZeroOneMultiple.lean`.
````

## Golden answer

```lean
def CandidateStatement : Prop :=
  ∀ n : ℕ, 0 < n → ∃ m : ℕ, 0 < m ∧ n ∣ m ∧ ∀ d ∈ Nat.digits 10 m, d = 0 ∨ d = 1
```

**Plain language.** For each natural number `n`, chosen first and assumed positive, there is a
natural number `m`, which may depend on `n`, that is positive, is divisible by `n`, and
whose base-10 digit list (`Nat.digits 10 m`, least significant first) contains only 0 and 1.

**Equivalent representations.** Any of these are acceptable:
- `n ≠ 0` or `1 ≤ n` in place of `0 < n`;
- `m % n = 0` in place of `n ∣ m`;
- `d ≤ 1` or `d ∈ ({0, 1} : Finset ℕ)` for the digit condition;
- quantifying over `ℕ+` or over positive integers in `ℤ` with the digits of `m.toNat`;
- the digit list in either order.

**The mistranslation this task targets.** Dropping `0 < m` makes the statement vacuous:
`m = 0` is divisible by every `n` and `Nat.digits 10 0 = []`, so the digit condition holds
trivially. The file proves this weakened version in one line to make the gap concrete.

**Beyond the prompt.** The file also proves `candidateStatement_holds : CandidateStatement`.
This was not requested; it shows that the golden statement is not vacuous in the other direction
(it is true and non-trivially so). Proof outline:

1. `repunit k = Σ_{i<k} 10^i` (the number `11…1` with `k` ones), with
   `repunit (k+1) = 10 · repunit k + 1` and `repunit (i+k) = repunit i + 10^i · repunit k`.
2. Repunits have only 0/1 digits (induction via `Nat.digits_def'`), and multiplying by
   `10^i` preserves that (each factor of 10 prepends a `0` digit).
3. Pigeonhole (`Finset.exists_ne_map_eq_of_card_lt_of_maps_to`): the `n + 1` values
   `repunit k % n` for `k ≤ n` fall into `n` residues, so two agree, say for `i < j`.
4. Then `n ∣ repunit j − repunit i = 10^i · repunit (j − i)`, which is positive with 0/1 digits.

## Rubric (each +1)

1. A definition named `CandidateStatement` of type `Prop` is declared in `LeanPortfolio/ZeroOneMultiple.lean`.
2. The file compiles without errors in the pinned environment.
3. The proposition universally quantifies the divisor `n` over the natural numbers or the integers.
4. The proposition includes the hypothesis that `n` is positive.
5. The witness `m` is existentially quantified inside the scope of the binder for `n`, so `m` may depend on `n`.
6. The proposition requires `m` to be strictly positive.
7. The proposition requires `n` to divide `m`.
8. The proposition requires every base-10 digit of `m` to be 0 or 1.
9. The definition body contains no `sorry`.
