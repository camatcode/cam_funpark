# FunPark

Cam's version of FunPark -
from [Advanced Functional Programming with Elixir by Joseph Koski](https://pragprog.com/titles/jkelixir/advanced-functional-programming-with-elixir/)

# Progress Tracker / Initial Notes

- [x] Introduction
    - [x] How This Book Works
    - [x] Who This Book Is For
    - [x] Online Resources
    - [x] Conventions Used In This Book
- [x] Chapeter 1: Build FunPark: Model Real-World
  Data ([work/chapter-1](https://github.com/camatcode/cam_funpark/tree/work/chapter-1))
    - [x] Define the Ride Model
    - [x] Implement Fast Passes for Priority Access
    - [x] Model the Patrons
    - [x] Speak the Language
    - [x] What We’ve Learned
- [x] Chapter 2: Implement Domain-Specific Equality with
  Protocols ([work/chapter-2](https://github.com/camatcode/cam_funpark/tree/work/chapter-2))
    - [x] Polymorphic Equality
    - [x] Implement Equality for FunPark Contexts
    - [x] Equality Is Contextual
    - [x] Transform Inputs Before Matching
    - [x] Harness Equality for Collections
    - [x] What We’ve Learned
- [x] Chapter 3: Create Flexible Ordering with
  Protocols ([work/chapter-3](https://github.com/camatcode/cam_funpark/tree/work/chapter-3))
    - [x] Define Order with a Protocol
    - [x] Implement Order for FunPark Contexts
    - [x] Transform Inputs Before Comparison
    - [x] Harness Order for Collections
    - [x] Reverse the Order
    - [x] Reduce Repetitive Code with Macros
        - 📝: It's unwise to drop folks into meta-programming without more detail
    - [x] What We’ve Learned
        - 📝: "Do you fully understand `contramap/1`?" No, in fact, it seems to be an unnecessary complication, but I'm
          pressing forward until I recognize why its useful, or what I can replace it with
- [x] Chapter 4: Combine with Monoids ([work/chapter-4](https://github.com/camatcode/cam_funpark/tree/work/chapter-4))
    - [x] Define the Protocol
    - [x] Combine Numbers with Sum
    - [x] Combine Equality
        - ❓ Had to implement `eq_ride` ; did I miss that?
        - 📝: It's at this exact point where it's clear im re-implementing Haskel in Elixir.
    - [x] Combine Order
        - 📝: pg 59: missing a space "default sort forPatrons"
        - ❓ Had to implement `ord_by_reward_points` ; did I miss that?
    - [x] Generalize Maximum
        - ❓ Had to implement `Ord.Utils.max/3`: did I miss that?
    - [x] Manage Complexity
    - [x] What We’ve Learned
- [ ] Chapter 5: Define Logic with Predicates
    - [ ] Simple Predicates
    - [ ] Combine Predicates
    - [ ] Predicates That Span Contexts
    - [ ] Compose Multi-Arity Functions with Curry
    - [ ] Harness Predicates for Collections
    - [ ] Model the FastPass
    - [ ] Fold Conditional Logic
    - [ ] What We’ve Learned
- [ ] Chapter 6: Compose in Context with Monads
    - [ ] Build the Monad
    - [ ] Model Neutrality with Identity
    - [ ] What We’ve Learned
- [ ] Chapter 7: Access Shared Environment with Reader
    - [ ] Build the Structures
    - [ ] Monad Behaviors
    - [ ] Avoid Prop Drilling
    - [ ] Dependency Injection
    - [ ] Shared Configuration
    - [ ] What We Learned
- [ ] Chapter 8: Manage Absence with Maybe
    - [ ] Build the Structures
    - [ ] Fold Branches
    - [ ] Lift Other Contexts
    - [ ] Bridge Elixir Patterns
    - [ ] Define Equality
    - [ ] Establish Order
    - [ ] Lift Custom Comparisons
    - [ ] Model Absence in a Monoid
    - [ ] Implement the Monadic Behaviors
    - [ ] Refine Lists
    - [ ] Filter Within Composition
    - [ ] What We’ve Learned
- [ ] Chapter 9: Model Outcomes with Either
    - [ ] Structure of Either
    - [ ] Validation
    - [ ] From Bind to Combine
    - [ ] Make Errors Explicit
    - [ ] What We’ve Learned
- [ ] Chapter 10: Coordinate Tasks with Effect
    - [ ] Build the Effect
    - [ ] Deferred Transformation
    - [ ] Effectful Store
    - [ ] Maintenance Repository
    - [ ] Inject Behavior, Not Configuration
    - [ ] Flip the Logic
    - [ ] What We’ve Learned


