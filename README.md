Bowling Challenge in Ruby
=================

* Feel free to use google, your notes, books, etc. but work on your own
* If you refer to the solution of another coach or student, please put a link to that in your README
* If you have a partial solution, **still check in a partial solution**
* You must submit a pull request to this repo with your code by 9am Monday week

## The Task

**THIS IS NOT A BOWLING GAME, IT IS A BOWLING SCORECARD PROGRAM. DO NOT GENERATE RANDOM ROLLS. THE USER INPUTS THE ROLLS.**

Count and sum the scores of a bowling game for one player. For this challenge, you do _not_ need to build a web app with a UI, instead, just focus on the logic for bowling (you also don't need a database). Next end-of-unit challenge, you will have the chance to translate the logic to Javascript and build a user interface.

A bowling game consists of 10 frames in which the player tries to knock down the 10 pins. In every frame the player can roll one or two times. The actual number depends on strikes and spares. The score of a frame is the number of knocked down pins plus bonuses for strikes and spares. After every frame the 10 pins are reset.

As usual please start by

* Forking this repo

* Finally submit a pull request before Monday week at 9am with your solution or partial solution.  However much or little amount of code you wrote please please please submit a pull request before Monday week at 9am.  And since next week is lab week you have a full extra week to work on this.

___STRONG HINT, IGNORE AT YOUR PERIL:___ Bowling is a deceptively complex game. Careful thought and thorough diagramming — both before and throughout — will save you literal hours of your life.

## Focus for this challenge
The focus for this challenge is to write high-quality code.

In order to do this, you may pay particular attention to the following:
* Using diagramming to plan your approach to the challenge
* TDD your code
* Focus on testing behaviour rather than state
* Commit often, with good commit messages
* Single Responsibility Principle and encapsulation
* Clear and readable code

## Bowling — how does it work?

### Strikes

The player has a strike if he knocks down all 10 pins with the first roll in a frame. The frame ends immediately (since there are no pins left for a second roll). The bonus for that frame is the number of pins knocked down by the next two rolls. That would be the next frame, unless the player rolls another strike.

### Spares

The player has a spare if the knocks down all 10 pins with the two rolls of a frame. The bonus for that frame is the number of pins knocked down by the next roll (first roll of next frame).

### 10th frame

If the player rolls a strike or spare in the 10th frame they can roll the additional balls for the bonus. But they can never roll more than 3 balls in the 10th frame. The additional rolls only count for the bonus not for the regular frame count.

    10, 10, 10 in the 10th frame gives 30 points (10 points for the regular first strike and 20 points for the bonus).
    1, 9, 10 in the 10th frame gives 20 points (10 points for the regular spare and 10 points for the bonus).

### Gutter Game

A Gutter Game is when the player never hits a pin (20 zero scores).

### Perfect Game

A Perfect Game is when the player rolls 12 strikes (10 regular strikes and 2 strikes for the bonus in the 10th frame). The Perfect Game scores 300 points.

In the image below you can find some score examples.

More about ten pin bowling here: http://en.wikipedia.org/wiki/Ten-pin_bowling

![Ten Pin Score Example](images/example_ten_pin_scoring.png)

### Notes

FIRST ROLL
- Strike or Non-strike
- succeeding spare or not succeeding spare
- succeeding 2 strikes, 1 strike, no strikes

SECOND ROLL
- Spare or non-spare
- succeeding spare or not succeeding spare
- succeeding 2 strikes, 1 strikes or no strikes

10 frames (21 possible throws)
300 possible points

As a bowler
So that I can keep track of my game
I want to be able to enter my points into a scorecard

As a bowler
So that I don't have to calculate my own game
I want the scorecard to calculate my score

As a bowler
So that my score goes into the correct place
I want the scorecard to know which frame and roll I am on

As a bowler
So that I know how well I did
I want to be able to see my total points at the end

| Nouns | Owner/Property |
| ---------- | ---------- |
| game | owner |
| scorecard | owner |
| regular points | property |
| bonus points | property |
| frame | property |
| roll | property |

| Actions | Owned by? |
| ---------- | ---------- |
| enter points | Scorecard |
| calculate score | Scorecard |
| see total | Scorecard |
| strike | Scorecard |
| spare | Scorecard |

| Actions | Property it reads or changes |
| --------- | ---------- |
| enter points | Regular points |
| calculate score | frame, roll, points |
| see total | Regular & bonus points |
| strike | Bonus points |
| spare | Bonus points |

| Class | Game |
| --------- | ---------- |
| Properties | frame, roll,  |
|

| Class | Scorecard |
| ---------- | ---------- |
| Properties | regular points, bonus points |
| Actions | enter, calculate, total, strike, spare |

10
5
5
10
4
3

10 5 5
5 5 10
10 4 3
4 3
