# frozen_string_literal: true

class Scorecard
  attr_reader :frames, :regular_total, :current_frame

  def initialize
    @frames = []
    @regular_total = 0
    @bonus_total = 0
    @current_frame = []
  end

  def roll(pins)
    @current_frame << pins
    if final_frame?
      final_frame_actions(pins)
    elsif second_roll_or_strike
      second_roll_or_strike_actions
    end
  end

  def second_roll_or_strike_actions
    first_frame? ? first_frame_actions : other_frame_actions
  end

  def first_frame_actions
    add_current_frame_to_frames
    add_sum_to_regular
    reset_frame
  end

  def final_frame_actions(pins)
    final_frame << pins
    bonus_add(pins)
    bonus_add(pins) if two_rolls_in(final_frame) && strike?(last_frame)
  end

  def other_frame_actions
    second_roll_actions
    reset_frame
  end

  def second_roll_actions
    add_current_frame_to_frames
    add_sum_to_regular
    strike_or_spare_bonus
  end

  def total
    @regular_total + @bonus_total
  end

  private

  def strike_or_spare_bonus
    if strike?(last_frame)
      strike_bonus
    elsif spare?(last_frame)
      bonus_add(first_roll)
    end
  end

  def strike_bonus
    add_sum_to_bonus
    bonus_first_roll_if_second_last_strike
  end

  def sum(frame)
    frame.inject(:+)
  end

  def bonus_first_roll_if_second_last_strike
    bonus_add(first_roll) if not_second_frame? && strike?(second_last_frame)
  end

  def last_two_frames_strikes?
    strike?(last_frame) && strike?(second_last_frame)
  end

  def first_roll
    @current_frame[0]
  end

  def bonus_add(points)
    @bonus_total += points
  end

  def last_frame
    @frames[-2]
  end

  def second_last_frame
    @frames[-3]
  end

  def add_current_frame_to_frames
    @frames << @current_frame
  end

  def strike?(frame)
    frame[0] == 10
  end

  def spare?(frame)
    sum(frame) == 10
  end

  def reset_frame
    @current_frame = []
  end

  def final_frame?
    @frames.length == 10
  end

  def first_frame?
    @frames.empty?
  end

  def final_frame
    @frames[-1]
  end

  def two_rolls_in(frame)
    frame.length == 2
  end

  def add_sum_to_regular
    @regular_total += sum(@current_frame)
  end

  def add_sum_to_bonus
    @bonus_total += sum(@current_frame)
  end

  def not_first_frame?
    @frames.length > 1
  end

  def not_second_frame?
    @frames.length > 2
  end

  def second_roll_or_strike
    strike?(@current_frame) || two_rolls_in(@current_frame)
  end
end
