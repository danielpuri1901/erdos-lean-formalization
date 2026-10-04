import FormalConjectures.Wikipedia.SteinerSystem
import Solution.Witt.Main

/-! Solution for the witt24 target. See `TASK.md` and `NOTES.md`. -/

theorem witt_design_exists : type_of% @SteinerSystems.steiner_system_5_8_24 :=
  ⟨Witt.witt⟩
