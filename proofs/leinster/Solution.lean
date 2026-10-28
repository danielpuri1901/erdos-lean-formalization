import FormalConjectures.Wikipedia.LeinsterGroup
import Solution.Leinster

/-! Solution for the leinster target. See `TASK.md` and `NOTES.md`. -/

theorem leinster_nonabelian_exists : type_of% @LeinsterGroup.exists_nonabelian_leinster_group :=
  LeinsterS3C5.exists_nonabelian
